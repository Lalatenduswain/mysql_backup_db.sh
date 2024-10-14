# MySQL Backup Database Script

This script automates the backup process for MySQL/MariaDB databases. It prompts the user to select a database, creates a backup as `.sql.gz`, and verifies the integrity of the backup by comparing it to the original database.

## Repository

You can find the script repository at [GitHub Repository](https://github.com/Lalatenduswain/mysql_backup_db.sh).

## Prerequisites

Before running the script, ensure the following packages are installed:

- **MySQL/MariaDB client**:
  ```bash
  sudo apt-get install mysql-client
  ```
  
- **Gzip**:
  ```bash
  sudo apt-get install gzip
  ```

- **MD5 checksum utility** (usually pre-installed in most Linux distributions):
  ```bash
  sudo apt-get install coreutils
  ```

Additionally, ensure you have the following permissions:
- **Sudo access**: The script needs to be run with sufficient privileges to access the MySQL/MariaDB databases and write files in `/opt/Website-DB-Backup/`.

## Setup Instructions

1. **Clone the Repository**:
   Clone the script repository to your local system:

   ```bash
   git clone https://github.com/Lalatenduswain/mysql_backup_db.sh
   ```

2. **Modify Script Permissions**:
   After cloning, navigate to the script directory and give the script executable permissions:

   ```bash
   cd mysql_backup_db.sh
   chmod +x backup_db.sh
   ```

3. **Edit the Script** (Optional):
   If necessary, update the MySQL credentials or the backup directory in the script to match your environment.

   Open the script in your preferred editor:

   ```bash
   nano /path/to/backup_db.sh
   ```

4. **Run the Script**:
   You can now run the script to back up your database:

   ```bash
   ./backup_db.sh
   ```

## Script Overview

This script performs the following actions:

1. **List Databases**: It lists all the available databases except system ones (e.g., `information_schema`, `performance_schema`, and `sys`).
2. **Database Selection**: The user is prompted to choose the database they wish to back up.
3. **Backup Process**: A `.sql` dump of the selected database is created, which is then compressed into `.gz`.
4. **Verification**: The script extracts the `.gz` backup file and compares its checksum to the original dump for verification.

### Example Output

```
Available databases:
db_1
db_2
db_3
db_4

Enter the name of the database to backup: db_1
Backup successful! File: /opt/Website-DB-Backup/db_1.sql.gz
Verification successful! The backup matches the original database.
```

## Disclaimer | Running the Script

**Author:** Lalatendu Swain | [GitHub](https://github.com/Lalatenduswain) | [Website](https://blog.lalatendu.info/)

This script is provided as-is and may require modifications or updates based on your specific environment and requirements. Use it at your own risk. The author of the script is not liable for any damages or issues caused by its usage.

## Donations

If you find this script useful and want to show your appreciation, you can donate via [Buy Me a Coffee](https://www.buymeacoffee.com/lalatendu.swain).

## Support or Contact

Encountering issues? Don't hesitate to submit an issue on our [GitHub page](https://github.com/Lalatenduswain/mysql_backup_db.sh/issues).
