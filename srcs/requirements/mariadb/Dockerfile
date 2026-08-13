FROM	debian:bookworm

RUN	apt-get update && \
	apt install -y mariadb-server bash && \
	rm -rf /var/lib/mysql/* && \
	rm -rf /var/lib/apt/lists/* 

RUN 	mkdir /run/mysqld 

COPY	conf/50-server.cnf  /etc/mysql/mariadb.conf.d/50-server.cnf
COPY	tools/mariadb-setup.sh /usr/local/bin/mariadb-setup.sh

RUN	chmod +x /usr/local/bin/mariadb-setup.sh

EXPOSE	3306

ENTRYPOINT ["/usr/local/bin/mariadb-setup.sh"]
