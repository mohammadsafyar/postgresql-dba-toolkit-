#!/bin/bash

STANZA="postgres-core-prod"

pgbackrest \
--stanza=${STANZA} \
check
