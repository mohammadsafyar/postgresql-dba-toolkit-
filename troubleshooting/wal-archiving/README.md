# PostgreSQL WAL Archiving Failure

## Incident

PostgreSQL reports archive command failures or WAL files continuously
accumulate in the `pg_wal` directory.

This incident can affect:

- Point-in-Time Recovery (PITR)
- Disaster Recovery (DR)
- Backup consistency
- WAL retention
- Disk space
- Database availability

---

# 1. Symptoms

Common symptoms:

- `archive command failed`
- `WAL file could not be archived`
- Increasing `failed_count` in `pg_stat_archiver`
- `last_archived_time` is old
- WAL files continuously accumulate
- `pg_wal` directory grows rapidly
- Filesystem disk usage increases
- PostgreSQL may eventually stop accepting writes if disk space is exhausted

---

# 2. Impact

If WAL archiving remains broken for a long time:

```text
WAL Generation
      |
      v
pg_wal
      |
      X
Archive Failure
      |
      v
WAL Accumulation
      |
      v
Disk Usage Growth
      |
      v
Disk Full
      |
      v
Database Outage
