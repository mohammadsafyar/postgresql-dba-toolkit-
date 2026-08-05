#!/bin/bash

systemctl stop postgresql


pgbackrest \
--stanza=postgres-core-prod \
restore


systemctl start postgresql
