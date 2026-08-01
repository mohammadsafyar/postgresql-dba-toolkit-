#!/bin/bash

echo "======================================"
echo " PostgreSQL Archive Errors"
echo "======================================"

echo
echo "Archive-related errors from the last hour:"
echo

journalctl -u postgresql --since "1 hour ago" \
    | grep -Ei \
    "archive command failed|archiving failed|archive-push|WAL" \
    | tail -100
