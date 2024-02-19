# Utilisation de l'image Debian Bullseye comme base
FROM debian:bullseye

# Mise à jour des paquets et installation de certains logiciels nécessaires
RUN apt update &&\
    apt upgrade -y &&\
    apt install -y php7.4 \
                    php-fpm \
                    php-mysql \
                    mariadb-client \
                    curl

# Exposition du port 9000 pour accéder à php-fpm
EXPOSE 9000

# Copie du fichier de configuration pour php-fpm
COPY conf/www.conf /etc/php/7.4/fpm/pool.d/

# Création du répertoire pour le site WordPress
RUN mkdir -p /var/www/rmeriau/wordpress

# Création du répertoire pour les fichiers de socket de PHP
RUN mkdir /run/php/

# Copie du script de configuration WordPress
COPY tools/wpscript.sh /

# Attribution des droits appropriés sur le répertoire WordPress
RUN chown -R root:root /var/www/rmeriau/wordpress/

# Définition du point d'entrée pour l'exécution du script de configuration
ENTRYPOINT ["sh", "/wpscript.sh"]
