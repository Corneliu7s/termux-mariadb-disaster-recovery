# Incident: MariaDB Service Failure on Android/Termux

## Executive Summary
Resolved total MariaDB outage on resource-constrained Android environment. Root cause: chained failures across OS, storage engine, and authentication layers. Validated full DR via backup/restore test.

## Environment  
- **Platform**: Android via Termux
- **Database**: MariaDB 12.2.2
- **Date**: 2026-04-20
- **Impact**: 100% service unavailability, package manager corruption

## Timeline & Root Cause Analysis
| Symptom | Root Cause | Resolution |
| --- | --- | --- |
| `dpkg: error processing archive` | Corrupt Termux prefix /var/lib/dpkg | `rm -rf $PREFIX/*` + Termux reinstall |
| `InnoDB registration failed` | Android kernel blocks InnoDB file I/O | `~/.my.cnf`: `skip-innodb`, `default-storage-engine=Aria` |
| `ERROR 1698: Access denied` | `unix_socket` auth requires system user `root` | `mysqld_safe --skip-grant-tables` + `ALTER USER` to `mysql_native_password` |

## Disaster Recovery Validation
```bash
# 1. Create production dataset
CREATE DATABASE ca_licenses; 
USE ca_licenses; 
CREATE TABLE licenses (id INT AUTO_INCREMENT PRIMARY KEY, name VARCHAR(50), expiry DATE) ENGINE=Aria;
INSERT INTO licenses VALUES (1,'Windows Server 2022','2026-12-31'),(2,'SQL Server 2019','2025-06-30'),(3,'Termux Test','2024-01-01');

# 2. Logical backup
mariadb-dump -u root ca_licenses > ca_licenses_backup.sql

# 3. Simulate catastrophic failure  
DROP TABLE licenses;

# 4. Full restore + verification
mariadb -u root ca_licenses < ca_licenses_backup.sql
SELECT * FROM licenses;
