# Manuel d'utilisation
Ce document contient des informations sur l'utilisation des livrables
________________________________________________________________________________________________
________________________________________________________________________________________________
# Script Bash

________________________________________________________________________________________________
________________________________________________________________________________________________
# Script PowerShell
### Objectifs
Ce script permet de contrôller une machine Windows distante et de gérer des utilisateurs via SSH. Par exemple, on peut créer et supprimer des utilisateurs, éteindre l'ordinateur distant ou le redémarrer


### Variables
- Le nom d'utilisateur côté machine serveur
- Le nom d'utilisateur et l'adresse IP de la machine client
![alt text](image.png)
# Fonctions
- Affichage d'un menu d'options pour la gestion de la machine client et des utilisateurs de la machine client. Les options disponibles sont :
    - Création d'un nouvel utilisateur
    - Suppression d'un utilisateur
    - Redémarrer la machine client
    - Éteindre la machine client

![alt text](image-1.png)
# Exécution
À l'appel du script, la fonction principale s'exécute, affichant un menu avec les différentes options. Pour exécuter les différentes commandes, l'utilisateur fourni l'un des numéros proposés, ce qui va exécuter une sous-fonction pour effectuer l'opération voulue.
![alt text](image-2.png)
