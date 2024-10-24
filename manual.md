# Manuel d'utilisation
Ce document contient des informations sur l'utilisation des livrables
________________________________________________________________________________________________
________________________________________________________________________________________________
# Script Bash

La fonction main_menu() affiche un menu principal avec des options
```
main_menu() {
        clear                                   # efface l'écran du terminal, présentation plus propre
        echo "==== Menu Principal ===="
        echo " * Gérer les utilisateurs * "
        echo " -------------------------- "
        echo " 1. Créer un utilisateur"
        echo " 2. Supprimer un utilisateur"
        echo " 3. Dernière connexion d'un utilisateur"
        echo
        echo " * Gérer les ordinateurs * "
        echo " -------------------------- "
        echo " 4. Arrêter la machine"
        echo " 5. Redémarrer la machine"
        echo " 6. Obtenir la version de l'OS"
        echo
        echo " 7. Quitter"

        read -p "Choisissez une option : " choice
        case $choice in                            # bloc (case ... esac), exécuter des commandes en fonction du choix de l'utilisateur
                1) create_user ;;                  # fonction create_user sera appelée, défini dans le script 
                2) delete_user ;;                  # fonction delete_user sera appelée, défini dans le script
                3) last_login_user ;;              # fonction last_login_user pour obtenir la dernière connexion, défini dans le script
                4) shutdown_computer ;;            # fonction shutdown_computer pour arrêter la machine, défini dans le script
                5) reboot_computer ;;              # fonction reboot_computer pour redémarrer la machine, défini dans le script
                6) os_version ;;                   # fonction os_version pour obtenir la version du système d'exploitation.
                7) log_event "**********EndScript**********"; exit 0 ;;    # fonction pour enregistrer un événement de fin, puis quitter
                *) echo "Choix non valable."; main_menu ;;         # capturer tous les autres choix non valides et relance  du menu principal
        esac

}
```
Chaque option du menu vient avec une description pour définir ce que fait l'option.
Pour choisir une option à exécuter, l'utilisateur rentre le numéro correspondant et tappe sur la touche Entrée.
Pour le détail technique des fonctions, se référer au fichier technique `install.md`.
________________________________________________________________________________________________
________________________________________________________________________________________________
# Script PowerShell
### Objectifs
Ce script permet de contrôller une machine Windows distante et de gérer des utilisateurs via SSH. Par exemple, on peut créer et supprimer des utilisateurs, éteindre l'ordinateur distant ou le redémarrer


### Variables
- Le nom d'utilisateur côté machine serveur
- Le nom d'utilisateur et l'adresse IP de la machine client
![alt text]([image.png](https://files.slack.com/files-pri/T6SG2QGG2-F07SVSQ0XB9/2.png))
# Fonctions
- Affichage d'un menu d'options pour la gestion de la machine client et des utilisateurs de la machine client. Les options disponibles sont :
    - Création d'un nouvel utilisateur
    - Suppression d'un utilisateur
    - Redémarrer la machine client
    - Éteindre la machine client

![alt text]([image-1.png](https://files.slack.com/files-pri/T6SG2QGG2-F07TZ7ABT9N/1.png))
# Exécution
À l'appel du script, la fonction principale s'exécute, affichant un menu avec les différentes options. Pour exécuter les différentes commandes, l'utilisateur fourni l'un des numéros proposés, ce qui va exécuter une sous-fonction pour effectuer l'opération voulue.
![alt text]([image-2.png](https://files.slack.com/files-pri/T6SG2QGG2-F07TP3Z1L49/3.png))
