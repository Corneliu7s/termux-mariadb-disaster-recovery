#!/data/data/com.termux/files/usr/bin/bash

DB_NAME="classicmodels"
BACKUP_DIR="$HOME/backups"
LATEST_BACKUP="$HOME/backups/classicmodels_2026-04-24_15-05.sql"

echo "=== DISASTER RECOVERY TEST ==="
echo "1. Using latest backup: $LATEST_BACKUP"

if [ ! -f "$LATEST_BACKUP" ]; then
    echo "ERROR: Backup file not found: $LATEST_BACKUP"
    exit 1
fi

echo "2. Simulating disaster: Dropping database $DB_NAME"
mariadb -u root -e "DROP DATABASE IF EXISTS $DB_NAME;"

echo "3. Recreating empty database"
mariadb -u root -e "CREATE DATABASE $DB_NAME;"

echo "4. Restoring from backup..."
mariadb -u root $DB_NAME < $LATEST_BACKUP

echo "5. Verifying restore:"
mariadb -u root $DB_NAME -e "SELECT COUNT(*) AS employee_count FROM employees; SELECT COUNT(*) AS office_count FROM offices; SELECT COUNT(*) AS customer_count FROM customers;"

echo "=== RESTORE COMPLETE ==="
