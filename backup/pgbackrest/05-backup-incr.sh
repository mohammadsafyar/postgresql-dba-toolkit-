#!/bin/bash

STANZA="postgres-core-prod"

pgbackrest \
--stanza=${STANZA} \
--type=incr \
backup
