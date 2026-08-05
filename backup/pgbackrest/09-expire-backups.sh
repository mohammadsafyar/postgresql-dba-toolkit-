#!/bin/bash

pgbackrest \
--stanza=postgres-core-prod \
expire
