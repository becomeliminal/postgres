#!/bin/bash
set -euo pipefail

# Derive repo root from test dir (plz runs tests in <repo>/plz-out/tmp/...)
REPO_ROOT="${TEST_DIR%%/plz-out/tmp/*}"
PGDIR="$REPO_ROOT/plz-out/gen/binaries/v17.6/ai-${XOS}_${XARCH}/psql"
if [[ ! -d "$PGDIR/bin" ]]; then
    echo "FAIL: Postgres AI binaries not found at $PGDIR"
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

# Configure postgres: unix socket only, preload extensions
cat >> "$PGDATA/postgresql.conf" <<EOF
listen_addresses = ''
unix_socket_directories = '$TMPDIR'
shared_preload_libraries = 'pg_stat_statements,age'
EOF

# Start postgres
pg_ctl -D "$PGDATA" -l "$TMPDIR/postgres.log" start -w

PSQL="psql -h $TMPDIR -d postgres --no-psqlrc"

# ============================================================
# Contrib extension tests
# ============================================================

echo "=== Testing uuid-ossp ==="
$PSQL -c 'CREATE EXTENSION IF NOT EXISTS "uuid-ossp";'
RESULT=$($PSQL -t -A -c "SELECT uuid_generate_v4();")
if [[ -z "$RESULT" ]]; then
    echo "FAIL: uuid_generate_v4() returned empty"
    exit 1
fi
echo "PASS: uuid-ossp works (got $RESULT)"

echo "=== Testing pg_stat_statements ==="
$PSQL -c 'CREATE EXTENSION IF NOT EXISTS pg_stat_statements;'
RESULT=$($PSQL -t -A -c "SELECT count(*) FROM pg_stat_statements;")
echo "PASS: pg_stat_statements works (rows: $RESULT)"

# ============================================================
# AI extension tests
# ============================================================

echo "=== Testing pgvector ==="
$PSQL -c 'CREATE EXTENSION IF NOT EXISTS vector;'
$PSQL -c "CREATE TABLE vec_test (id serial PRIMARY KEY, embedding vector(3));"
$PSQL -c "INSERT INTO vec_test (embedding) VALUES ('[1,2,3]'), ('[4,5,6]');"
RESULT=$($PSQL -t -A -c "SELECT embedding <-> '[1,2,3]' AS distance FROM vec_test ORDER BY distance LIMIT 1;")
if [[ -z "$RESULT" ]]; then
    echo "FAIL: pgvector distance query returned empty"
    exit 1
fi
echo "PASS: pgvector works (nearest distance: $RESULT)"

echo "=== Testing AGE ==="
$PSQL <<SQL
CREATE EXTENSION IF NOT EXISTS age;
LOAD 'age';
SET search_path = ag_catalog, public;
SELECT create_graph('test_graph');
SQL
RESULT=$($PSQL -t -A -c "SELECT name FROM ag_catalog.ag_graph WHERE name = 'test_graph';")
if [[ "$RESULT" != "test_graph" ]]; then
    echo "FAIL: AGE graph not found (got '$RESULT')"
    exit 1
fi
echo "PASS: AGE works (graph: $RESULT)"

echo ""
echo "=== All AI tests passed ==="
