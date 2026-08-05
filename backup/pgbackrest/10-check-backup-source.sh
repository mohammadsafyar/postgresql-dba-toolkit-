#!/bin/bash

grep "backup file" \
/var/log/pgbackrest/postgres-core-prod-backup.log \
| tail -20
