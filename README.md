# PostgreSQL DBA Toolkit

A practical collection of PostgreSQL DBA scripts, troubleshooting guides, production incident runbooks, monitoring queries, and operational procedures.

## Overview

This repository contains operational resources for PostgreSQL database administrators, focusing on:

* PostgreSQL High Availability (HA)
* Patroni cluster operations
* Streaming replication troubleshooting
* WAL management and archiving
* Backup and recovery procedures
* Performance troubleshooting
* Monitoring and health checks
* Production incident response

## Structure

```text
postgresql-dba-toolkit/
├── README.md
│
├── patroni/
│   ├── README.md
│   ├── 01-cluster-status.sh
│   ├── 02-cluster-topology.sh
│   ├── 03-switchover.md
│   └── 04-failover.md
│
├── replication/
│   └── README.md
│
├── etcd/
│   └── README.md
│
├── monitoring/
│   └── README.md
│
├── backup/
│   └── README.md
│
├── performance/
│   └── README.md
│
├── locks/
│   └── README.md
│
├── vacuum/
│   └── README.md
│
├── security/
│   └── README.md
│
├── incident/
│   └── README.md
│
└── troubleshooting/
    └── wal-archiving/
        ├── README.md
        ├── 01-check-archive-status.sql
        ├── 02-check-archiver-stats.sql
        ├── 03-check-replication-slots.sql
        ├── 04-check-wal-directory.sh
        ├── 05-check-postgresql-logs.sh
        └── 06-check-pgbackrest.sh
```

## Requirements

* PostgreSQL client tools (`psql`)
* Patroni (`patronictl`)
* etcd client (`etcdctl`)
* Linux shell environment

## Usage

Most SQL scripts can be executed with:

```bash
psql -f script_name.sql
```

Shell scripts:

```bash
chmod +x script_name.sh
./script_name.sh
```

## Scope

This toolkit is designed for:

* Daily PostgreSQL administration
* Production troubleshooting
* HA cluster operations
* Incident response
* Operational documentation

## License

This project is provided as a DBA reference toolkit.

