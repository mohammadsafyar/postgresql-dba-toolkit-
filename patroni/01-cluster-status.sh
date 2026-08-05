#!/bin/bash

# Check Patroni cluster status

patronictl -c /etc/patroni/patroni.yaml list
