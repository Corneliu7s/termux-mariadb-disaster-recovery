# Change file paths in Week 3 table to 
# week3-backup-automation/backup.sh# Termux MariaDB 
# Disaster Recovery
git add README.md **L1 DBA Project: Database 
Recovery on Android** Tested on MariaDB 11.x, 
Termux, Android 13 git commit -m "Docs: Update Week 
3 file paths after folder move"
git push## Week 1: Disaster Recovery - 2026-04-21

**Objective**: Recover MariaDB from InnoDB crash and auth lockout. Validate backup/restore procedures.

### Incident Simulation
Server failed with `ERROR 2002 (HY000): Can't connect to local MySQL server through socket`. 
Root cause: `mariadbd` process not running, socket file missing.

### Resolution Steps
1. **Diagnosed** socket failure using `ps aux | grep mysql` - no process found
2. **Recovered** with `mariadbd-safe --user=mysql &` - bypassed init system issues
3. **Validated** data integrity: `SHOW DATABASES;` confirmed `ca_licenses`, `corruption_lab` intact
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

## Next: Week 2 Query Performance Tuning
`EXPLAIN`, `CREATE INDEX`, `slow_query_log` analysis.

### Results After Index
- `EXPLAIN` now shows `type: ref`, `key: idx_dept`
- Rows examined: 5 → 3 = **40% reduction**
- Query time: 0.011s → 0.005s = **2x faster**
- Profiling confirmed wall time: `0.02219223` sec

### Evidence
- Before/After EXPLAIN: `week2-query-tuning/01-explain-before-after.png`
- Index + Profiling proof: `week2-query-tuning/02-show-index-profiling.png`

### Skills Demonstrated
- Execution plan analysis: `EXPLAIN`, interpreting `type`, `rows`, `key`
- Index strategy: `CREATE INDEX`, choosing columns based on WHERE clauses
- Performance validation: `SET profiling=1`, `SHOW PROFILES`, wall time
- Query tuning: Converting `ALL` scans to `ref` index lookups

## Tools Used
MariaDB 11.x, EXPLAIN, SHOW INDEX, Query Profiler, Termux, Git
## Week 3: Backup Automation & Monitoring

**Objective:** Automate daily MariaDB backups and enable performance monitoring.

### Deliverables
| File | Purpose |
| --- | --- |
| `week3-backup-automation/backup.sh` | Automated `mariadb-dump` with timestamp + 7-day log rotation |
| `week3-backup-automation/cronjob.txt` | Cron schedule: `30 2 * * *` daily backup without manual runs |
| `week3-backup-automation/monitoring.sql` | Enables `slow_query_log`, runs `EXPLAIN` + `SHOW INDEX` |
| `week3-backup-automation/monitoring_output.txt` | Proof: slow log ON, query execution plans, index verification |
| `week3-backup-automation/week3_b15_classic.sql` | Database schema with PK/FK relationships being monitored |

### Key Skills Demonstrated
1. **Backup Automation**: Scripted `mariadb-dump` + cron scheduling
2. **Performance Monitoring**: `slow_query_log`, `EXPLAIN`, index analysis  
3. **Production Ops**: Log rotation, unattended execution, Git versioning

### How to Test
```bash
./week3-backup-automation/backup.sh                    # Manual backup test
crontab -l                                             # Verify cron schedule
mariadb -u root b15_classic < week3-backup-automation/monitoring.sql  # Enable monitoring

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

### Verified Restore Results

```
employee_count: 23
office_count: 7
customer_count: 122
```

###How to Test
```bash
./week4-disaster-recovery/restore.sh




###Evidence

- Successful DR run: `=== RESTORE COMPLETE ===`

- All table counts match source `classicmodels` dataset





