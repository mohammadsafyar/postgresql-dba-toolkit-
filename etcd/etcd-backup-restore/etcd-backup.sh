#!/bin/bash

set -euo pipefail

# ==============================
# ETCD Backup Script
# ==============================

ETCDCTL_API=3
export ETCDCTL_API

ETCD_ENDPOINT="http://127.0.0.1:2379"
BACKUP_DIR="/backup/etcd"
SNAPSHOT_NAME="etcd-snapshot-$(date +%F-%H%M).db"

mkdir -p ${BACKUP_DIR}

echo "================================="
echo "Checking ETCD health"
echo "================================="

etcdctl \
--endpoints=${ETCD_ENDPOINT} \
endpoint health


echo "================================="
echo "Checking ETCD status"
echo "================================="

etcdctl \
--endpoints=${ETCD_ENDPOINT} \
endpoint status \
-w table


echo "================================="
echo "Creating snapshot"
echo "================================="

etcdctl \
--endpoints=${ETCD_ENDPOINT} \
snapshot save ${BACKUP_DIR}/${SNAPSHOT_NAME}


echo "================================="
echo "Validating snapshot"
echo "================================="

etcdutl snapshot status \
${BACKUP_DIR}/${SNAPSHOT_NAME} \
-w table


echo "================================="
echo "Creating checksum"
echo "================================="

sha256sum \
${BACKUP_DIR}/${SNAPSHOT_NAME} \
> ${BACKUP_DIR}/${SNAPSHOT_NAME}.sha256


echo "================================="
echo "Backup completed"
echo "================================="

ls -lh ${BACKUP_DIR}/${SNAPSHOT_NAME}
