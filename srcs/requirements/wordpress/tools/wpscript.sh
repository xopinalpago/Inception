#!/bin/sh

# Vérifie si le fichier de configuration de WordPress existe
if [ -f "/var/www/rmeriau/wordpress/wp-config.php" ]
then 
    # Si le fichier existe, attend 5 secondes
    sleep 5
else
    # Si le fichier n'existe pas, attend 20 secondes puis procède à l'installation de WordPress

    sleep 20

    # Télécharge WP-CLI (outil en ligne de commande pour WordPress)
    curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
    chmod +x wp-cli.phar
    mv wp-cli.phar /usr/local/bin/wp

    # Télécharge et installe la version 6.4 de WordPress
    wp core download --allow-root --version=6.4 --path=/var/www/rmeriau/wordpress

    # Crée le fichier de configuration de WordPress
    cd /var/www/rmeriau/wordpress
    wp config create --allow-root --dbname=${SQL_DATABASE} --dbuser=${SQL_USER} --dbpass=${SQL_PASSWORD} --dbhost="mariadb"

    # Installe WordPress
    wp core install --allow-root --url=${DOMAIN_NAME} --title=${WP_TITLE} --admin_user=${WP_ADMIN_USER} --admin_password=${WP_ADMIN_PASSWORD} --admin_email=${WP_ADMIN_EMAIL} --skip-email

    # Crée un utilisateur avec le rôle d'auteur
    wp user create --allow-root ${USER1_LOGIN} ${USER1_MAIL} --role=author --user_pass=${USER1_PASS}
fi

# Exécute PHP-FPM (FastCGI Process Manager) avec la version 7.4 de PHP
exec /usr/sbin/php-fpm7.4 -F
