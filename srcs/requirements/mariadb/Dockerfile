# Utilisation de l'image de base Debian Bullseye
FROM debian:bullseye

# Mise à jour des paquets et installation du serveur MariaDB
RUN apt update &&\
	apt upgrade -y &&\
	apt install -y mariadb-server

# Copie du fichier de configuration personnalisé dans le répertoire approprié
COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/

# Création du répertoire pour les fichiers temporaires de MySQL et attribution des permissions appropriées
RUN mkdir /run/mysqld \
	&& chown -R mysql:mysql /run/mysqld

# Exposition du port 3306 pour permettre les connexions à la base de données
EXPOSE 3306

# Copie du script dbscript.sh dans la racine du conteneur et configuration de l'entrée principale pour exécuter ce script
COPY tools/dbscript.sh /

ENTRYPOINT ["sh", "/dbscript.sh"]
