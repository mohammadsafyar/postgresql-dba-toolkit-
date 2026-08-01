#!/bin/bash

set -e

echo "======================================"
echo " PostgreSQL WAL Directory Check"
echo "======================================"

PGDATA=$(psql -Atc "SHOW data_directory")

echo
echo "PostgreSQL Data Directory:"
echo "$PGDATA"

echo
echo "WAL Directory Usage:"
du -sh "$PGDATA/pg_wal"

echo
echo "Filesystem Usage:"
df -h "$PGDATA"

echo
echo "Inode Usage:"
df -i "$PGDATA"

echo
echo "Last WAL Files:"
ls -ltr "$PGDATA/pg_wal" | tail -20
