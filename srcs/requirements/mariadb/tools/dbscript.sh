#!/bin/sh

# Vérifie si le répertoire /var/lib/mysql/wordpress n'existe pas
if [ ! -d "/var/lib/mysql/wordpress" ]
then 
    # Démarre le service mariadb
    service mariadb start
    
    # Pause de 5 secondes pour laisser le temps au service de démarrer
    sleep 5

    # Crée la base de données si elle n'existe pas déjà
    mysql -e "CREATE DATABASE IF NOT EXISTS \`${SQL_DATABASE}\`;"
    
    # Crée un utilisateur s'il n'existe pas déjà et lui attribue un mot de passe
    mysql -e "CREATE USER IF NOT EXISTS \`${SQL_USER}\`@'%' IDENTIFIED BY '${SQL_PASSWORD}';"
    
    # Accorde tous les privilèges sur la base de données à l'utilisateur
    mysql -e "GRANT ALL PRIVILEGES ON \`${SQL_DATABASE}\`.* TO \`${SQL_USER}\`@'%';"
    
    # Rafraîchit les privilèges MySQL pour les prendre en compte
    mysql -e "FLUSH PRIVILEGES"
    
    # Arrête le service MySQL en utilisant le nouveau mot de passe root
    mysqladmin -u root -p$SQL_ROOT_PASSWORD shutdown
    
    # Pause de 5 secondes pour laisser le temps au service de s'arrêter
    sleep 5
fi

# Exécute le serveur MySQL en tant qu'utilisateur root
exec mysqld -u root
