# Termux MariaDB Disaster Recovery

Production-grade backup and disaster recovery automation for MariaDB on Android/Termux.

## Week 1: Environment Setup & Baseline

**Objective:** Set up MariaDB on Termux and load the `classicmodels` dataset.

### Deliverables
| File | Purpose |
| --- | --- |
| `week1-setup/install.sh` | Termux MariaDB installation + secure setup |

### Key Skills Demonstrated
- **Environment Setup**: MariaDB 10.x on Android/Termux 
- **Database Initialization**: `mysql_install_db` and `mysql_secure_installation`
- **Data Import**: Loaded MySQL `classicmodels` sample database

## Week 2: Query Tuning & Indexing

**Objective:** Optimize slow queries on `b15_classic` database using indexes and EXPLAIN.

### Deliverables
| File | Purpose |
| --- | --- |
| `week2-indexing/01_setup_indexes.sql` | Composite indexes on frequently queried columns |
| `week2-indexing/02_explain_queries.sql` | Before/after EXPLAIN analysis |

### Key Skills Demonstrated
- **Performance Tuning**: Reduced query time via composite indexes
- **EXPLAIN Analysis**: Identified full table scans vs index usage
- **Schema Design**: Added indexes on `employee_name`, `department_id`, `salary`

## Week 3: Backup Automation

**Objective:** Automate daily backups of `classicmodels` database.

### Deliverables
| File | Purpose |
| --- | --- |
| `week3-backup-automation/backup.sh` | mysqldump with timestamped files |

### Key Skills Demonstrated
1. **Backup Automation**: `mysqldump` with `--single-transaction` for consistency
2. **Cron Scheduling**: Daily backups to `~/backups/`
3. **Storage Management**: 194KB compressed SQL dumps

## Week 4: Disaster Recovery Testing

**Objective:** Simulate full database loss and restore from backup with data integrity verification.

### Deliverables
| File | Purpose |
| --- | --- |
| `week4-disaster-recovery/restore.sh` | Automated DR test: drop → restore → verify |

### Key Skills Demonstrated
1. **Disaster Recovery**: Full restore workflow from `.sql` backup
2. **Data Integrity**: Verification via row counts on critical tables
3. **Production Debugging**: Fixed 4 real incidents:
   - Empty backups from wrong DB target
   - `USE dbname;` statement overriding restore target
   - Termux bash glob expansion failures in subshells
   - Schema mismatch in verification queries
4. **Script Hardening**: Hardcoded paths for reliability in constrained shells

### Verified Restore Results3. **Validated** data integrity: `SHOW DATABASES;` confirmed `ca_licenses`, `corruption_lab` intact
4. **Backed up** using `mysqldump ca_licenses > backup.sql`
5. **Tested restore**: Dropped and recreated DB from backup successfully

### Evidence
- Initial crash: `screenshots/01_innodb_error.png`
- Recovery success: `screenshots/02_victory_online.png` 
- Backup/restore: `screenshots/03_backup_restore.png`
- Reproduction script: `week1-disaster-recovery/recovery-steps.sh`

### Skills Demonstrated
- Crash diagnosis: `ERROR 2002`, socket analysis
- Manual recovery: `mariadbd-safe`, process management
- Backup strategy: `mysqldump` for logical backups
- Data validation: `SHOW DATABASES`, table checks
- Linux/Termux system administration

## Tools Used
MariaDB 11.x, Termux, Bash, Git
