#!/data/data/com.termux/files/usr/bin/bash
DATE=$(date +%F_%H-%M)
DB_NAME="b15_classic"
BACKUP_DIR="$HOME/backups"

mariadb-dump -u root $DB_NAME > $BACKUP_DIR/${DB_NAME}_$DATE.sql

# Keep only last 7 backups
ls -t $BACKUP_DIR/${DB_NAME}_*.sql | tail -n +8 | xargs rm -f

echo "Backup completed: ${DB_NAME}_$DATE.sql"
