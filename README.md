# Termux MariaDB Disaster Recovery

Production-grade backup and disaster recovery automation for MariaDB on Android/Termux.

## Week 1: Environment Setup & Baseline

**Objective:** Set up MariaDB on Termux and load the classicmodels dataset.

### Deliverables
| File | Purpose |
| --- | --- |
| [week1-setup/install.sh](week1-setup/install.sh) | Termux MariaDB installation + secure setup |

### Key Skills Demonstrated
- **Environment Setup**: MariaDB 10.x on Android/Termux 
- **Database Initialization**: mysql_install_db and mysql_secure_installation
- **Data Import**: Loaded MySQL classicmodels sample database

## Week 2: Query Tuning & Indexing

**Objective:** Optimize slow queries on b15_classic database using indexes and EXPLAIN.

### Deliverables
| File | Purpose |
| --- | --- |
| [week2-indexing/01_setup_indexes.sql](week2-indexing/01_setup_indexes.sql) | Composite indexes on frequently queried columns |
| [week2-indexing/02_explain_queries.sql](week2-indexing/02_explain_queries.sql) | Before/after EXPLAIN analysis |

### Key Skills Demonstrated
- **Performance Tuning**: Reduced query time via composite indexes
- **EXPLAIN Analysis**: Identified full table scans vs index usage
- **Schema Design**: Added indexes on employee_name, department_id, salary

## Week 3: Backup Automation

**Objective:** Automate daily backups of classicmodels database.

### Deliverables
| File | Purpose |
| --- | --- |
| [week3-backup-automation/backup.sh](week3-backup-automation/backup.sh) | mysqldump with timestamped files |

### Key Skills Demonstrated
1. **Backup Automation**: mysqldump with --single-transaction for consistency
2. **Cron Scheduling**: Daily backups to ~/backups/
3. **Storage Management**: 194KB compressed SQL dumps

## Week 4: Disaster Recovery Testing

**Objective:** Simulate full database loss and restore from backup with data integrity verification.

### Deliverables
| File | Purpose |
| --- | --- |
| [week4-disaster-recovery/restore.sh](week4-disaster-recovery/restore.sh) | Automated DR test: drop → restore → verify |

### Key Skills Demonstrated
1. **Disaster Recovery**: Full restore workflow from .sql backup
2. **Data Integrity**: Verification via row counts on critical tables
3. **Production Debugging**: Fixed 4 real incidents:
   - Empty backups from wrong DB target
   - USE dbname; statement overriding restore target
   - Termux bash glob expansion failures in subshells
   - Schema mismatch in verification queries
4. **Script Hardening**: Hardcoded paths for reliability in constrained shells

### Verified Restore Results
employee_count: 23
office_count: 7
customer_count: 122

### How to Test
Run: ./week4-disaster-recovery/restore.sh

### Evidence
- Successful DR run: === RESTORE COMPLETE ===
- All table counts match source classicmodels dataset

## Repository Structure
termux-mariadb-disaster-recovery/
├── week1-setup/
│   └── install.sh
├── week2-indexing/
│   ├── 01_setup_indexes.sql
│   └── 02_explain_queries.sql
├── week3-backup-automation/
│   └── backup.sh
├── week4-disaster-recovery/
│   └── restore.sh
└── README.md

## Tech Stack
- **Environment**: Android Termux
- **Database**: MariaDB 10.x
- **Scripting**: Bash
- **Dataset**: MySQL classicmodels sample DB

## Next: Week 5
User permissions, GRANT/REVOKE, and MariaDB security hardening.
