#!/bin/bash

# Show Patroni cluster topology

patronictl -c /etc/patroni/patroni.yaml topology
