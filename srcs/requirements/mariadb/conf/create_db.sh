#!/bin/sh

# Installation et initialisation de mySql (si ce n'est pas deja le cas)
if [ ! -d "/var/lib/mysql/mysql" ]; then

        # init database
        mysql_install_db --basedir=/usr --datadir=/var/lib/mysql --user=mysql --rpm
	chown -R mysql:mysql /var/lib/mysql
fi


# Creation d'une base de donnees wordpress (si elle n'existe pas)
# Via commandes SQL dans un script que l'on execute et que l'on supprime apres

if [ ! -d "/var/lib/mysql/wordpress" ]; then

        cat << EOF > /tmp/create_db.sql
USE mysql;
FLUSH PRIVILEGES;
DELETE FROM mysql.user WHERE user='';
DELETE FROM mysql.user WHERE user='root' AND host NOT IN ('localhost', '127.0.0.1', '::1');
ALTER USER 'root'@'localhost' IDENTIFIED BY '${DB_ROOT}';
CREATE DATABASE IF NOT EXISTS ${DB_NAME} CHARACTER SET utf8 COLLATE utf8_general_ci;
CREATE USER '${DB_USER}'@'%' IDENTIFIED by '${DB_PASS}';
GRANT ALL PRIVILEGES ON wordpress.* TO '${DB_USER}'@'%';
FLUSH PRIVILEGES;
EOF
        # run init.sql
	chmod 777 /tmp/create_db.sql
        /usr/bin/mysqld --user=mysql --verbose --bootstrap < /tmp/create_db.sql
        rm -f /tmp/create_db.sql
fi

# Demarre le server de la base de donnee avec ROOT
exec mysqld --user=root
