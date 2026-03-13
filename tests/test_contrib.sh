#!/bin/bash
set -euo pipefail

# Derive repo root from test dir (plz runs tests in <repo>/plz-out/tmp/...)
REPO_ROOT="${TEST_DIR%%/plz-out/tmp/*}"
PGDIR="$REPO_ROOT/plz-out/gen/binaries/v17.6/${XOS}_${XARCH}/psql"
if [[ ! -d "$PGDIR/bin" ]]; then
    echo "FAIL: Postgres binaries not found at $PGDIR"
    exit 1
fi

# Setup temp directory with cleanup trap
TMPDIR=$(mktemp -d)
cleanup() {
    pg_ctl -D "$PGDATA" stop -m immediate 2>/dev/null || true
    rm -rf "$TMPDIR"
}
trap cleanup EXIT

# Configure paths
export PATH="$PGDIR/bin:$PATH"
export LD_LIBRARY_PATH="$PGDIR/lib:${LD_LIBRARY_PATH:-}"
export PGDATA="$TMPDIR/data"

# Initialize database cluster
initdb -D "$PGDATA" --no-locale --encoding=UTF8 > /dev/null

# Configure postgres: unix socket only, preload pg_stat_statements
cat >> "$PGDATA/postgresql.conf" <<EOF
listen_addresses = ''
unix_socket_directories = '$TMPDIR'
shared_preload_libraries = 'pg_stat_statements'
EOF

# Start postgres
pg_ctl -D "$PGDATA" -l "$TMPDIR/postgres.log" start -w

PSQL="psql -h $TMPDIR -d postgres --no-psqlrc"

# --- Test uuid-ossp ---
echo "=== Testing uuid-ossp ==="
$PSQL -c 'CREATE EXTENSION IF NOT EXISTS "uuid-ossp";'
RESULT=$($PSQL -t -A -c "SELECT uuid_generate_v4();")
if [[ -z "$RESULT" ]]; then
    echo "FAIL: uuid_generate_v4() returned empty"
    exit 1
fi
echo "PASS: uuid-ossp works (got $RESULT)"

# --- Test pg_stat_statements ---
echo "=== Testing pg_stat_statements ==="
$PSQL -c 'CREATE EXTENSION IF NOT EXISTS pg_stat_statements;'
RESULT=$($PSQL -t -A -c "SELECT count(*) FROM pg_stat_statements;")
echo "PASS: pg_stat_statements works (rows: $RESULT)"

echo ""
echo "=== All contrib tests passed ==="
