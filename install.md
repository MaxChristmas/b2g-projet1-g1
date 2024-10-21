# Documentation installation
Ce document va préciser l'ensemble de la configuration et du paramétrage de nos environnements de livrables.

______________________________________________________________________________________________________________

### Préparation des VM
- sudo apt-get install vim (pas nécessaire mais une préférence de notre équipe)
- sudo apt-get install git (pour permettre le versionnement depuis le terminal)

______________________________________________________________________________________________________________

## Configuration de réseau des VM :
- Configuration de réseau des vm Debian et ubuntu : accès par pont
- Verifaction de l'adresse ip grâce à : 
  > ip addr ou ip a
- Récupération de l'ip dans la section enp0s3 : (inet "ip")
- Tester la communication entre Debian et Ubuntu via ssh : 
  > ssh user@ip-machine

_si ssh non actif ... l'activé_
## Configuration de ssh :
>- sudo apt update
>- sudo apt install openssh-server
>- sudo apt systemctl start ssh
>- sudo systemctl enable ssh :

_( enable pour configurer votre système pour démarrer automatiquement le service SSH à chaque démarrage du système, sans devoir lancer manuellement le service à chaque fois)_

- Vérification si ssh est bien activé :
  > sudo systemctl status ssh
 
## Générer une clé ssh sur la VM serveur :
- Pour générer (par défaut dans "~/.ssh/id_rsa") :
  > ssh-keygen -t rsa -b 4096 
- Copier la clé publique SSH sur la VM client :
  > ssh-copy-id user@ip-client

_(la clé publique sera ajoutée au fichier ~/.ssh/authorized_keys du client.)_

- Tester la connexion SSH sans mot de passe : 
  > "ssh user@ip-client"

_(Si la configuration est correcte, vous devriez être connecté au serveur sans avoir à entrer de mot de passe.)_

_sinon..._
## Désactiver l'authentification par mot de passe
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
