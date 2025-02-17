#!/bin/bash
# Convert SQLite data to MySQL
sqlite3 /tmp/db.sqlite3 .dump | grep -v "sqlite_sequence" > /tmp/dump.sql
sed -i 's/AUTOINCREMENT/AUTO_INCREMENT/g' /tmp/dump.sql
mysql -u$MYSQL_USER -p$MYSQL_PASSWORD $MYSQL_DATABASE < /tmp/dump.sql
