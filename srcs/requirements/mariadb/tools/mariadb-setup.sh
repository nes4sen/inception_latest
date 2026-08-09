#!/bin/sh

set -e

chown -R mysql:mysql /var/lib/mysql /var/run/mysqld

MYSQL_PASSWORD=$(cat /run/secrets/db_password)
MYSQL_ROOT_PASSWORD=$(cat /run/secrets/db_root_password)

if [ ! -d "/var/lib/mysql/mysql" ]; then
    echo "Initializing MariaDB database..."

    mariadb-install-db --user=mysql --datadir=/var/lib/mysql > /dev/null

mariadbd --user=mysql --bootstrap << EOF
	FLUSH PRIVILEGES;

	ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';

	CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;
	CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
	GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO '${MYSQL_USER}'@'%';

	FLUSH PRIVILEGES;
EOF

    echo "MariaDB initialized successfully."
fi

exec mariadbd --user=mysql
