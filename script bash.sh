#!/bin/bash 

if [[ ! -f database.txt ]];then
    touch "database.txt"
fi

FICHIER_DB="database.txt"
LOG_FILE="log.txt"
DATE=$(date +"%Y%m%d")
TIME=$(date +"%H%M%S")

# Fonction pour ajouter une nouvelle IP à la base de données
ajouter_nouvelle_ip() {

    echo "=== Ajout d'une nouvelle IP ==="

    while true; do

        read -p "Donnez un nom pour l'hôte : " nouveau_hostname

        if [ -z "$nouveau_hostname" ]; then
            echo "Veuillez rentrer une valeur"
        else
            break
        fi

    done

    while true; do

        read -p "Entrez l'adresse IP : " nouvelle_ip

        is_valid_number() {

            if [[ $1 -ge 0 && $1 -le 255 ]]; then

                return 0  # valide

            else

                return 1  # non valide

            fi
        }

        # Séparation de la chaîne en utilisant le '.' comme séparateur
        IFS='.' read -r part1 part2 part3 part4 <<< "$nouvelle_ip"

        # Vérification si nous avons exactement 4 parties
        if  [[ -z $part4 || -n $(echo "$nouvelle_ip" | grep -E '[^0-9.]') ]] > /dev/null; then
            echo "Le format n'est pas correct. Veuillez entrer une adresse au format x.x.x.x"
            
        else

            # Vérification de chaque partie
            if ! is_valid_number "$part1" && is_valid_number "$part2" && is_valid_number "$part3" && is_valid_number "$part4"; then

                # Vérifier si l'IP existe déjà dans la base de données
                if grep -q ",$nouvelle_ip," "$FICHIER_DB"; then
        
                    echo "Cette adresse IP existe déjà dans la base de données."
                
                else

                    break

                fi
        
        
            else

                echo "L'adresse IP n'est pas valide."
            fi


        fi

    done


    while true;do
        # Demander les utilisateurs associés
        read -p "Entrez les utilisateurs associés (séparés par des virgules) : " nouveaux_utilisateurs

        if [ -z "$nouveaux_utilisateurs" ]; then
            echo "Veuillez rentrer une valeur"
        else
            break
        fi

    done

    # Ajouter la nouvelle entrée au fichier de base de données
    echo "$nouveau_hostname,$nouvelle_ip,$nouveaux_utilisateurs" >> "$FICHIER_DB"

    if [[ $? = 0 ]];then
        echo "Nouvelle IP ajoutée avec succès à la base de données."
    fi

}

#ajouter_nouvelle_utilisateur_ip() {
    
#}

# Fonction pour afficher le menu de sélection d'IP
afficher_menu_selection_de_ip() {
    while true; do
        echo "
            ==========================
                  Menu Principal       
            -------------------------
                 SELECTION DE IP       
            ==========================
        "

        # Lire les hôtes et IP depuis le fichier de base de données et les afficher
        tableau=()
        i=1
        while IFS=',' read -r hostname ip rest; do
            tableau[$i]="$hostname,$ip"
            echo "$i) $hostname | $ip"
            ((i++))
        done < "$FICHIER_DB"

        echo "NEW. Ajoutez une nouvelle IP"
        echo "QUIT. Quitter"
        echo

        read -p "           Entrez votre option : " choixdeip

        case $choixdeip in
            [1-9]*)
                if [ -n "${tableau[$choixdeip]}" ]; then

                    selected_entry="${tableau[$choixdeip]}"

                    hostname=$(echo "$selected_entry" | cut -d',' -f1)

                    ip=$(echo "$selected_entry" | cut -d',' -f2)

                    echo "Vous avez choisi $hostname ($ip)."

                    choixdeip="$ip"
                    
                    afficher_menu_selection_de_utilisateur "$ip"
                else
                    echo "Choix invalide."
                fi
                ;;
            NEW)
                ajouter_nouvelle_ip
                ;;
            QUIT)
                exit
                ;;
            *)
                echo "Choix invalide. Veuillez entrer un nombre valide ou 'NEW' ou 'QUIT'."
                ;;
        esac
    done
}


# Fonction pour afficher le menu de sélection d'utilisateur
afficher_menu_selection_de_utilisateur() {
    local ip="$1"
    echo "
        ==========================
              Menu Principal
        -------------------------
            IP Sélectionnée: $ip
        -------------------------
         SELECTIONNER UN UTILISATEUR 
        ==========================
    "

    # Lire les utilisateurs associés à l'IP depuis le fichier de base de données
    utilisateurs=()
    i=1
    while IFS=',' read -r hostname ip_addr rest; do
        if [ "$ip_addr" == "$ip" ]; then
            IFS=',' read -ra user_array <<< "$rest"
            for user in "${user_array[@]}"; do
                utilisateurs[$i]="$user"
                echo "$i) $user"
                ((i++))
            done
            break
        fi
    done < "$FICHIER_DB"

    echo "BACK. Retour en arrière"
    echo "QUIT. Quitter"
    echo

    # Boucle principale du menu
    while true; do
        read -p "Entrez votre option : " choixdeutilisateur

        case $choixdeutilisateur in
            [1-9]*)
                if [ -n "${utilisateurs[$choixdeutilisateur]}" ]; then
                    selected_user="${utilisateurs[$choixdeutilisateur]}"
                    echo "Vous avez choisi l'utilisateur: $selected_user"
                    # Appeler la fonction pour sélectionner une commande (à définir)
                    afficher_menu_selectionner_une_commande "$ip" "$selected_user"
                else
                    echo "Choix invalide."
                fi
                ;;
            BACK)
                echo "Retour au menu précédent."
                break
                ;;
            QUIT)
                exit
                ;;
            *)
                echo "Choix invalide. Veuillez entrer une option valide."
                ;;
        esac
    done
}

# Fonction pour afficher le menu de sélection de commande
afficher_menu_selectionner_une_commande() {
        local ip="$1"
        local user="$2"

        if ssh -o BatchMode=yes -o ConnectTimeout=5 "$user@$ip" 'exit'; then
            echo "Connexion SSH réussie"
        else
            echo "Échec de la connexion SSH"
            echo "Retour au menu de sélection utilisateur"
            afficher_menu_selection_de_utilisateur "$ip"
            return  # Ajouter un retour pour éviter de continuer si la connexion échoue
        fi

    while true;do

        echo "
        ==========================
              Menu Principal
        -------------------------
            IP: $ip
            Utilisateur: $user
        -------------------------
         SELECTIONNER UNE COMMANDE 
        =========================="
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
        read -p "Choisissez une option : " choixdecommande 
        case $choixdecommande in
            1) create_user "$ip" "$user";;

            2) delete_user "$ip" "$user";;

            3) last_login_user "$ip" "$user";;

            4) shutdown_computer "$ip" "$user";;

            5) reboot_computer "$ip" "$user";;

            6) os_version "$ip" "$user";;

            BACK)
                echo "Retour au menu précédent."
                break
                ;;
            QUIT)
                log_event; exit 0 
                ;;
            *)
                echo "Choix invalide. Veuillez entrer une option valide."
                ;;
        esac
    done
}

# Fonction pour créer un utilisateur sur la machine distante

create_user() {

	echo " Création d'un utilisateur "

	read -p " Nom du nouvel utilisateur : " new_user

	echo "ssh $2@$1 "sudo useradd $new_user""
	
	if [ $? -eq 0 ]; then
		echo "Utilisateur $new_user créé avec succès."
	else
		echo "Erreur lors de l'exécution de la commande"
    fi

    log_event "Création de l'utilisateur $new_user"

    read -p "Appuyez sur une touche pour revenir au menu principal..."

    afficher_menu_selectionner_une_commande "$1" "$2"
}

# Fonction pour supprimer un utilisateur sur la machine distante

delete_user() {

    local ip="$1"

    local user="$2"

        echo " Suppression d'un utilisateur : " 
	read -p " Nom de l'utilisateur à supprimer : " del_user
        ssh $2@$1 "sudo userdel $del_user"

        if [ $? -eq 0 ]; then
                echo "Utilisateur $del_user a été supprimé avec succès."
        else
                echo "Erreur lors de l'exécution de la commande"
    fi
    log_event "Suppression de l'utilisateur $del_user"
    read -p "Appuyez sur une touche pour revenir au menu principal..."
    afficher_menu_selectionner_une_commande "$1" "$2"
}

# Fonction pour la dernière connexion d'un utilisateur sur la machine distante

last_login_user() {
	echo " Dernière connexion d'un utilisateur : "
    
    last_login=$(ssh $2@$1 "lastlog -u $2")
    
    if [ $? -eq 0 ]; then
                echo "Dernière connexion : $last_login."
        else
                echo "Erreur lors de l'exécution de la commande"
    fi
    log_event "Affichage de la dernière connexion de $login_user"

    echo "$last_login" > ~/Documents/info_$login_user_$DATE.txt

    read -p "Appuyez sur une touche pour revenir au menu principal..."

    afficher_menu_selectionner_une_commande "$1" "$2"
}

# Fonction pour arrêter la machine distante

shutdown_computer() {
	echo " Arrêter la machine : "
	ssh $2@$1 "sudo shutdown now"
	
	if [ $? -eq 0 ]; then
                echo "La machine $1 est en cours arrêt."
        else
                echo "Erreur lors de l'arrêt..."
    fi
    log_event "Arrêt de la machine $1"
    read -p "Appuyez sur une touche pour revenir au menu principal..."
    afficher_menu_selectionner_une_commande "$1" "$2"
}

# Fonction pour redémarrer la machine distante

reboot_computer() {
	echo "Redémarrer la machine :"
	ssh $2@$1 "sudo reboot"

	if [ $? -eq 0 ]; then
                echo "La machine $1 est en cours de redémarrage."
        else
                echo "Erreur lors du redémarrage..."
    fi
    log_event "Redémarrage de la machine $1"
    read -p "Appuyez sur une touche pour revenir au menu principal..."
    afficher_menu_selectionner_une_commande "$1" "$2"
}

# Fonction pour obtenir la version de l'OS de la machine distante

os_version() {

	echo "Obtenir la version de l'OS :"
    
    local version=$(ssh $2@$1 "lsb_release -a")
    
    if [ $? -eq 0 ]; then
                echo "Version de l'OS : $version"
        else
                echo "Erreur lors de l'exécution de la commande."
    fi

    log_event "Récupération de la version de l'OS sur la machine $1"
    echo "$version" > ~/Documents/info_OS_"$1"_"$DATE".txt
    read -p "Appuyez sur une touche pour revenir au menu principal..."
    afficher_menu_selectionner_une_commande "$1" "$2"
}

# Fonction pour journaliser les événements

log_event() {
    echo "$DATE-$TIME-$USERNAME-$1" >> $LOG_FILE
}

# Démarrage du script

log_event "********StartScript********"


# Démarrage du script
afficher_menu_selection_de_ip
