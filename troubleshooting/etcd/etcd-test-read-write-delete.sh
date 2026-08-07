## Write Test

etcdctl \
--endpoints=http://172.23.111.121:2379 \
put restore-validation "OK"

## Read Test

etcdctl \
--endpoints=http://172.23.111.121:2379 \
get restore-validation

##Cleanup

etcdctl \
--endpoints=http://172.23.111.121:2379 \
del restore-validation

## advance command for test read write and delete

#!/bin/bash
set -euo pipefail

# استفاده از متغیر محیطی برای اندپوینت، با یک مقدار پیش‌فرض
ENDPOINT="${ETCD_ENDPOINT:-http://172.23.111.121:2379}"
KEY="restore-validation"
VALUE="OK"

echo "🚀 Starting Restore Validation on ${ENDPOINT} ..."

# 1. Write Test
echo "📝 Writing test key..."
if etcdctl --endpoints="${ENDPOINT}" put "${KEY}" "${VALUE}" | grep -q "OK"; then
    echo "✅ Write test passed."
else
    echo "❌ Write test failed!"
    exit 1
fi

# 2. Read Test
echo "🔍 Reading test key..."
# --print-value-only فقط مقدار را برمی‌گرداند (نیازمند etcdctl v3)
OUTPUT=$(etcdctl --endpoints="${ENDPOINT}" get "${KEY}" --print-value-only)

if [ "${OUTPUT}" == "${VALUE}" ]; then
    echo "✅ Read test passed. Value matches: ${OUTPUT}"
else
    echo "❌ Read test failed! Expected '${VALUE}', got '${OUTPUT}'"
    exit 1
fi

# 3. Cleanup
echo "🧹 Cleaning up test key..."
etcdctl --endpoints="${ENDPOINT}" del "${KEY}" > /dev/null

echo "🎉 Restore validation completed successfully!"
