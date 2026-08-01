#!/bin/bash

set -e

STANZA="stanza1"

echo "======================================"
echo " pgBackRest Health Check"
echo "======================================"

echo
echo "Running pgBackRest check..."
echo

pgbackrest \
    --stanza="$STANZA" \
    check

echo
echo "======================================"
echo " pgBackRest Repository Info"
echo "======================================"

pgbackrest \
    --stanza="$STANZA" \
    info
