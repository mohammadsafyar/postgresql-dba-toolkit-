#!/bin/bash

STANZA="postgres-core-prod"

pgbackrest \
--stanza=${STANZA} \
--type=full \
backup
