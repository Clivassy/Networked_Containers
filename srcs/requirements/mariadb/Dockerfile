FROM alpine:3.16

USER root

RUN apk update && apk add --no-cache mariadb mariadb-client
RUN mkdir /home/lol

# Creation du dossier mysql + modifications des droits sur celui-ci
# Configuration de MariaDB pour etre utilise dans un environnement Docker
RUN mkdir /var/run/mysqld; \
    chmod 777 /var/run/mysqld; \
    { echo '[mysqld]'; \
      echo 'log_error=/var/lib/mysql/mariadb.err'; \
      echo 'skip-host-cache'; \
      echo 'skip-name-resolve'; \
      echo 'bind-address=0.0.0.0'; \
    } | tee  /etc/my.cnf.d/docker.cnf; \
    sed -i "s|skip-networking|skip-networking=0|g" \
      /etc/my.cnf.d/mariadb-server.cnf 

RUN chown -R mysql:root /run/mysqld

EXPOSE 3306
COPY requirements/mariadb/conf/create_db.sh /tmp/create_db.sh
RUN chmod +x /tmp/create_db.sh
CMD ["/tmp/create_db.sh"]
