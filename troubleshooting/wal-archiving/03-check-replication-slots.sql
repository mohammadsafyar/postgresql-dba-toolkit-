SELECT
    slot_name,
    slot_type,
    active,
    restart_lsn,
    confirmed_flush_lsn,
    pg_size_pretty(
        pg_wal_lsn_diff(
            pg_current_wal_lsn(),
            restart_lsn
        )
    ) AS retained_wal
FROM pg_replication_slots
ORDER BY
    pg_wal_lsn_diff(
        pg_current_wal_lsn(),
        restart_lsn
    ) DESC;
