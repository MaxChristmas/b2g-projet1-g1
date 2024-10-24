# Documentation installation
Ce document va préciser l'ensemble de la configuration et du paramétrage de nos environnements de livrables.

______________________________________________________________________________________________________________
______________________________________________________________________________________________________________

## Linux
### Préparation des VM
- sudo apt-get install vim (pas nécessaire mais une préférence de notre équipe)
- sudo apt-get install git (pour permettre le versionnement depuis le terminal)

### Configuration de réseau des VM :
- Configuration de réseau des vm Debian et ubuntu : accès par pont
- Verifaction de l'adresse ip grâce à : 
  > ip addr ou ip a
- Récupération de l'ip dans la section enp0s3 : (inet "ip")
- Tester la communication entre Debian et Ubuntu via ssh : 
  > ssh user@ip-machine

_si ssh non actif ... l'activé_
### Configuration de ssh :
>- sudo apt update
>- sudo apt install openssh-server
>- sudo apt systemctl start ssh
>- sudo systemctl enable ssh :

_( enable pour configurer votre système pour démarrer automatiquement le service SSH à chaque démarrage du système, sans devoir lancer manuellement le service à chaque fois)_

- Vérification si ssh est bien activé :
  > sudo systemctl status ssh
 
### Générer une clé ssh sur la VM serveur :
- Pour générer (par défaut dans "~/.ssh/id_rsa") :
  > ssh-keygen -t rsa -b 4096 
- Copier la clé publique SSH sur la VM client :
  > ssh-copy-id user@ip-client

_(la clé publique sera ajoutée au fichier ~/.ssh/authorized_keys du client.)_

- Tester la connexion SSH sans mot de passe : 
  > "ssh user@ip-client"

_(Si la configuration est correcte, vous devriez être connecté au serveur sans avoir à entrer de mot de passe.)_

_sinon..._
### Désactiver l'authentification par mot de passe
- Sur la machine client, modifiez le fichier de configuration SSH : 
  > sudo nano /etc/ssh/sshd_config
- Cherchez et modifiez ces lignes :
```
PasswordAuthentication no
ChallengeResponseAuthentication no
UsePAM no
```
- Redémarrer le service SSH pour appliquer les changements :
  > sudo systemctl restart ssh
  
 ** Problème d'utilisation de ssh sur Debian après configuration
 - solution utilisée : désinstallation et réinstallation de ssh
   > sudo apt remove --purge openssh-server
   
   > sudo apt install openssh-server

____________________________________
#### Détail du script
### shebang
```
- #!/bin/bash
```
### Bloc des Variables utilisées dans le script
```
- LOG_FILE="/var/log/log_evt.log"  # Chemin du fichier de journalisation
- USER=$(whoami)                   # Utilisateur serveur Debian
- DATE=$(date +"%Y%m%d")           # Affiche la date au format : année, mois, jour
- TIME=$(date +"%H%M%S")           # Affiche la date au format : heure, minute, seconde
- TARGET_IP="192.168.128.46"       # Adresse IP du client Ubuntu
- TARGET_USER="wilder"             # Nom utilisateur client Ubuntu
```

### Fonctions associées
- Fonction pour créer un utilisateur sur la machine distante :
```
create_user() {
        echo " Création d'un utilisateur "
        read -p " Nom du nouvel utilisateur : " new_user          # demande le nom pour le nouvel utilisateur et stockage dans new_user
        ssh $TARGET_USER@$TARGET_IP "sudo useradd $new_user"      # ssh pour création d'un nouvel utilisateur sur une machine distante
       
       if [ $? -eq 0 ]; then                                     # condition vérifie si la dernière commande s'est excutée avec succès
                echo "Utilisateur $new_user créé avec succès."
        else
                echo "Erreur lors de l'exécution de la commande"
    fi
    log_event "Création de l'utilisateur $new_user"                   # journalisation de la création d'utilisateur dans un fichier log
    read -p "Appuyez sur une touche pour revenir au menu principal..."      # retourner sur le menu principal en appuyant une touche 
}
```
- Fonction pour supprimer un utilisateur sur la machine distante :
```
delete_user() {
        echo " Suppression d'un utilisateur : " 
        read -p " Nom de l'utilisateur à supprimer : " del_user       # demande le nom d'utilisateur à supprimer et stockage dans del_user
        ssh $TARGET_USER@$TARGET_IP "sudo userdel $del_user"          # ssh pour suppression d'un nouvel utilisateur sur une machine distante

        if [ $? -eq 0 ]; then                                         # condition vérifie si la dernière commande s'est excutée avec succès
                echo "Utilisateur $del_user a été supprimé avec succès."
        else
                echo "Erreur lors de l'exécution de la commande"
    fi
    log_event "Suppression de l'utilisateur $del_user"              # journalisation de la suppression d'utilisateur dans un fichier log
    read -p "Appuyez sur une touche pour revenir au menu principal..."        # retourner sur le menu principal en appuyant une touche
    main_menu
}
```
- Fonction pour la dernière connexion d'un utilisateur sur la machine distante :
```
last_login_user() {
        echo " Dernière connexion d'un utilisateur : "
        read -p "Nom de l'utilisateur : " login_user                    # demande le nom d'un utilisateur  et stockage dans login_user
    last_login=$(ssh $TARGET_USER@$TARGET_IP "lastlog -u $login_user")  # affiche la dernière connexion de l'utilisateur défini dans la variable login_user

    if [ $? -eq 0 ]; then                                         # condition vérifie si la dernière commande s'est excutée avec succès
                echo "Dernière connexion : $last_login."
        else
                echo "Erreur lors de l'exécution de la commande"
    fi
    log_event "Affichage de la dernière connexion de $login_user"        # journalisation de la dernière connexion dans un fichier log
    echo "$last_login" > ~/Documents/info_"$login_user"_"$DATE".txt       # enregistrer les informations de la dernière connexion dans un fichier texte en locale
    read -p "Appuyez sur une touche pour revenir au menu principal..."       # retourner sur le menu principal en appuyant une touche
    main_menu
}
```
- Fonction pour arrêter la machine distante : 
```
shutdown_computer() {
        echo " Arrêter la machine : "
        ssh $TARGET_USER@$TARGET_IP "sudo shutdown now"           # ssh pour Arrêter la machine distante

        if [ $? -eq 0 ]; then                                     # condition vérifie si la dernière commande s'est excutée avec succès
                echo "La machine $TARGET_IP est en cours arrêt."
        else
                echo "Erreur lors de l'arrêt..."
    fi
    log_event "Arrêt de la machine $TARGET_IP"                         # journalisation de l'arrêt de la machine distante dans un fichier log
    read -p "Appuyez sur une touche pour revenir au menu principal..."     # retourner sur le menu principal en appuyant une touche
    main_menu
}
```
- Fonction pour redémarrer la machine distante : 
```
reboot_computer() {
        echo "Redémarrer la machine :"                      
        ssh $TARGET_USER@$TARGET_IP "sudo reboot"                  # ssh pour redemarrer la machine distante

        if [ $? -eq 0 ]; then                                      # condition vérifie si la dernière commande s'est excutée avec succès
                echo "La machine $TARGET_IP est en cours de redémarrage."
        else
                echo "Erreur lors du redémarrage..."
    fi
    log_event "Redémarrage de la machine $TARGET_IP"             # journalisation du redémarrage de la machine distante dans un fichier log
    read -p "Appuyez sur une touche pour revenir au menu principal..."      # retourner sur le menu principal en appuyant une touche
    main_menu
}
```
- Fonction pour obtenir la version de l'OS de la machine distante :
```
os_version() {
        echo "Obtenir la version de l'OS :"
    version=$(ssh $TARGET_USER@$TARGET_IP "lsb_release -a")   # obtenir les informations sur la version de l'OS de la machine distante et stockage dans version

    if [ $? -eq 0 ]; then                                     # condition vérifie si la dernière commande s'est excutée avec succès
                echo "Version de l'OS : $version"
        else
                echo "Erreur lors de l'exécution de la commande."
    fi

    log_event "Récupération de la version de l'OS sur la machine $TARGET_IP"    # journalisation de la version Os de la machine distante dans un fichier log
    echo "$version" > /home/wilder/Documents/info_OS_"$TARGET_IP"_"$DATE".txt   # enregistrer les informations de la version Os dans un fichier texte en locale
    read -p "Appuyez sur une touche pour revenir au menu principal..."
    main_menu
}
```
- Fonction pour journaliser les événements :
```
log_event() {
    echo "$DATE-$TIME-$USER-$1" >> $LOG_FILE    # enregistrer des événements importants et détaillés dans un fichier de log
}
```
- Démarrage du script :
```
log_event "********StartScript********"

main_menu
```

______________________________________________________________________________________________________________
______________________________________________________________________________________________________________

## Windows
### Exigences
- Client Windows 10 & Serveur Windows Server 2022
- Il faut exécuter la console PowerShell en mode administrateur
- Éteindre les pare-feus des deux ordinateurs
- Accès SSH du serveur au client. Il faut donc installer ssh avec la commande :
  `Add-WIndowsCapability -Online -Name OpenSSH.Server~~~~0.0.1.0`
  Pour allumer le service, on entre la commande :
  `Start-Service sshd`
  On peut vérifier si le service tourne avec la commande :
  `Get-Service sshd`
  Pour tester la connexion ssh, on utilise une commande de la forme :
  `ssh utilisateur@adresse_ip`
