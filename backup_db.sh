#!/bin/bash

# MySQL credentials
USER="root"
PASSWORD="MySecretPassword"
BACKUP_DIR="/opt/Website-DB-Backup/" # Directory to store the backups
TEMP_RESTORE_DIR="/opt/Website-DB-Backup/restore_temp/" # Temporary directory to extract the backup for verification

# Ensure backup and temporary restore directory exists
mkdir -p "$BACKUP_DIR"
mkdir -p "$TEMP_RESTORE_DIR"

# List databases
DB_LIST=$(mysql -u$USER -p$PASSWORD -e "SHOW DATABASES;" | grep -Ev "(Database|information_schema|performance_schema|sys)")
echo "Available databases:"
echo "$DB_LIST"

# Ask user for the database to backup
echo -n "Enter the name of the database to backup: "
read DB_NAME

# Check if the database exists
if echo "$DB_LIST" | grep -q "^$DB_NAME$"; then
    # Create a backup with current date
    BACKUP_FILE="$BACKUP_DIR/${DB_NAME}_$(date +%F_%T).sql"
    BACKUP_FILE_GZ="$BACKUP_FILE.gz"
    
    # Perform the backup and compress it using gzip
    mysqldump -u$USER -p$PASSWORD $DB_NAME > "$BACKUP_FILE" && gzip "$BACKUP_FILE"

    if [ $? -eq 0 ]; then
        echo "Backup successful! File: $BACKUP_FILE_GZ"
        
        # Extract the backup file for verification
        gunzip -c "$BACKUP_FILE_GZ" > "$TEMP_RESTORE_DIR/${DB_NAME}_restore.sql"
        
        # Perform a checksum comparison
        ORIGINAL_MD5=$(md5sum "$BACKUP_FILE_GZ" | awk '{print $1}')
        RESTORE_MD5=$(md5sum "$TEMP_RESTORE_DIR/${DB_NAME}_restore.sql" | awk '{print $1}')
        
        if [ "$ORIGINAL_MD5" == "$RESTORE_MD5" ]; then
            echo "Verification successful! The backup matches the original database."
        else
            echo "Verification failed! The backup does not match the original database."
        fi

        # Clean up the temporary restore directory
        rm -f "$TEMP_RESTORE_DIR/${DB_NAME}_restore.sql"
    else
        echo "Backup failed!"
    fi
else
    echo "Database '$DB_NAME' does not exist."
fi
