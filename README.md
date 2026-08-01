# PostgreSQL DBA Toolkit

A practical collection of PostgreSQL DBA scripts, troubleshooting guides,
production incident runbooks, monitoring queries, and operational procedures.

## Structure

```text
postgresql-dba-toolkit/
├── README.md
├── troubleshooting/
│   └── wal-archiving/
│       ├── README.md
│       ├── 01-check-archive-status.sql
│       ├── 02-check-archiver-stats.sql
│       ├── 03-check-replication-slots.sql
│       ├── 04-check-wal-directory.sh
│       ├── 05-check-postgresql-logs.sh
│       └── 06-check-pgbackrest.sh
