#!/bin/bash

# Wait for MySQL to be ready
while ! mysqladmin ping -h"localhost" -u"$MYSQL_USER" -p"$MYSQL_PASSWORD" --silent; do
    sleep 1
done

# Create SQL dump from SQLite
echo "Creating dump from SQLite..."
sqlite3 /tmp/db.sqlite3 .schema > /tmp/schema.sql
sqlite3 /tmp/db.sqlite3 .dump > /tmp/data.sql

# Clean up the SQL syntax for MySQL compatibility
sed -i 's/AUTOINCREMENT/AUTO_INCREMENT/g' /tmp/schema.sql
sed -i 's/AUTOINCREMENT/AUTO_INCREMENT/g' /tmp/data.sql
sed -i 's/sqlite_sequence/mysql_sequence/g' /tmp/data.sql

# Import into MySQL
echo "Importing schema..."
mysql -u"$MYSQL_USER" -p"$MYSQL_PASSWORD" "$MYSQL_DATABASE" < /tmp/schema.sql

echo "Importing data..."
mysql -u"$MYSQL_USER" -p"$MYSQL_PASSWORD" "$MYSQL_DATABASE" < /tmp/data.sql

echo "Migration completed!"
