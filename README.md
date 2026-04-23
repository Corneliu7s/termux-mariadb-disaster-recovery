# Termux MariaDB Disaster Recovery

**L1 DBA Project: Database Recovery on Android**  
Tested on MariaDB 11.x, Termux, Android 13

## Week 1: Disaster Recovery - 2026-04-21

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
