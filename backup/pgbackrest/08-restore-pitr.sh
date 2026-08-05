#!/bin/bash

TARGET_TIME=$1


systemctl stop postgresql


pgbackrest \
--stanza=postgres-core-prod \
--type=time \
--target="${TARGET_TIME}" \
--target-action=promote \
restore


systemctl start postgresql
