#!/bin/bash
# Proves a release tarball works on the machine it was built for: unpack it,
# start postgres from it, and create the extensions it claims to ship.
#
#   release/smoke_test.sh <tarball> <base|ai>
set -euo pipefail

TARBALL="$1"
VARIANT="$2"

WORK=$(mktemp -d)
PGDATA="$WORK/data"
cleanup() {
    "$WORK/psql/bin/pg_ctl" -D "$PGDATA" stop -m immediate > /dev/null 2>&1 || true
    rm -rf "$WORK"
}
trap cleanup EXIT

mkdir -p "$WORK/psql"
tar -xzf "$TARBALL" -C "$WORK/psql"
BIN="$WORK/psql/bin"
# Linux binaries carry no rpath: consumers point the loader at lib/, as this
# does. (macOS binaries find libpq via @executable_path instead.)
export LD_LIBRARY_PATH="$WORK/psql/lib${LD_LIBRARY_PATH:+:$LD_LIBRARY_PATH}"

# macOS binaries must load nothing outside macOS itself and the tarball:
# a library from Homebrew (or anywhere else) is missing on the next machine,
# or gone after its next upgrade. Checked before anything runs, because the
# runner may have that library installed and hide the problem.
if [[ "$(uname)" == "Darwin" ]]; then
    FOREIGN=$(find "$WORK/psql" -type f \( -perm -u+x -o -name '*.dylib' -o -name '*.so' \) -print0 \
        | xargs -0 otool -L 2> /dev/null \
        | awk -v file= '/:$/ { file = $0; next } /^\t/ { print file " " $1 }' \
        | grep -vE ' (/usr/lib/|/System/Library/|@executable_path/|@loader_path/|@rpath/)' || true)
    if [[ -n "$FOREIGN" ]]; then
        echo "FAIL: $(basename "$TARBALL") loads libraries from outside macOS:"
        echo "$FOREIGN"
        exit 1
    fi
fi

"$BIN/initdb" -D "$PGDATA" --no-locale --encoding=UTF8 > /dev/null
PRELOAD="pg_stat_statements"
if [[ "$VARIANT" == "ai" ]]; then
    PRELOAD="pg_stat_statements,age"
fi
cat >> "$PGDATA/postgresql.conf" <<EOF
listen_addresses = ''
unix_socket_directories = '$WORK'
shared_preload_libraries = '$PRELOAD'
EOF
"$BIN/pg_ctl" -D "$PGDATA" -l "$WORK/postgres.log" start -w > /dev/null || {
    cat "$WORK/postgres.log"
    exit 1
}

psql() { "$BIN/psql" -h "$WORK" -d postgres --no-psqlrc -v ON_ERROR_STOP=1 -t -A "$@"; }

# AI first: with age preloaded, older AGE releases (1.5 on PG13) fail other
# queries until CREATE EXTENSION age has run, as a real consumer does at once.
if [[ "$VARIANT" == "ai" ]]; then
    psql -c 'CREATE EXTENSION age;' -c "LOAD 'age';" \
        -c 'SET search_path = ag_catalog, "$user", public;' \
        -c "SELECT create_graph('smoke');"
    psql -c 'CREATE EXTENSION vector;' -c "SELECT '[1,2,3]'::vector <-> '[1,2,4]'::vector;"
fi

psql -c 'CREATE EXTENSION "uuid-ossp";' -c 'SELECT uuid_generate_v4();'
# ICU, which configure builds in from PostgreSQL 16: an ICU collation that
# ignores case finds 'a' and 'A' equal.
MAJOR=$("$BIN/postgres" --version | sed -E 's/.* ([0-9]+)\..*/\1/')
if (( MAJOR >= 16 )); then
    psql -c "CREATE COLLATION smoke_icu (provider = icu, locale = 'und-u-ks-level2', deterministic = false);" \
        -c "SELECT 'a' = 'A' COLLATE smoke_icu;" | grep -qx t
fi
psql -c 'CREATE EXTENSION pg_stat_statements;' -c 'SELECT count(*) FROM pg_stat_statements;'

echo "PASS: $(basename "$TARBALL")"
