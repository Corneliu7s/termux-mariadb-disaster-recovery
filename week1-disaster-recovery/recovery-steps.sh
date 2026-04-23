#!/bin/bash
# Week 1: Disaster Recovery on MariaDB/Termux
mariadb -e "SELECT 'DB is up';"  # Expected: ERROR 2002
mariadbd-safe --user=mysql &
sleep 5
mariadb -e "SELECT 'DB is up';"  # Expected: DB is up
mariadb -e "SHOW DATABASES;"
mysqldump ca_licenses > ca_licenses-backup.sql
mariadb -e "DROP DATABASE ca_licenses; CREATE DATABASE ca_licenses;"
mariadb ca_licenses < ca_licenses-backup.sql
