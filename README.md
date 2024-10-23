# Groupe 1:
#### Membres : Axel, Hamissou, Ahmed, Matthew
#### Product Owner : Axel
#### Scrum Master : Matthew
# Objectifs du projet
- Rédaction de deux scripts, un script bash et un script powershell
- Avec une communication établie entre une machine serveur et une machine client, chaque script doit :
	- Effectuer des actions sur les utilisateurs
	- Effectuer des actions sur l'ordinateur client
	- Faire une journalisation sur le serveur de chaque action effectuée
- Le script doit présenter un menu graphique de sorte à orienter l'utilisateur lors de son utilisation
- Dans notre cas, notre script bash doit permettre de communiquer avec soit une machine Linux, soit une machine Windows (objectif primaire et secondaire)
# Organisation
### Organisation d'équipe
- Notre groupe s'est créé un channel slack propre à nous. Ce channel servira pour de la communication en distanciel ainsi que du partage d'information ou de code.
- Nous utilisons ce répositoires github pour la gestion de la documentation et du code de notre projet.
- Chaque plage horaire de Projet commencera avec une réunion d'avancement
- Au début de la semaine, il y a une réunion de planning, avec la discussion de résolution des problèmes à traiter et l'établissement du travail à faire pour la semaine.
- À la fin de la semaine, il y a une rétrospective de groupe, avec la remontée éventuelle des problèmes à corriger pour la semaine suivante
- En dehors des plages de projet, dans notre channel slack, on notifie notre groupe quand on commence à travailler sur une partie du projet, de sorte à éviter les confusions entre les différents membres de l'équipe.
### Planning général du projet
- Un membre a installé les machines virtuelles linux pendant que les autres commençaient le travail. Quand les machines virtuelles linux étaient prêtes, elles ont étés partagées avec le reste du groupe.
- Pour la programmationOn s'est d'abord concentré sur le script bash
- Quand on a bien compris le fonctionnement de ce script, nous avons commencé le script PowerShell
- Intégration des commandes PowerShell dans le script bash final (objectif secondaire)
____________________________________________________________________________________________________
# Référencement de la documentation
### README.md
Ce document comporte une présentation générale de notre projet, nos objectifs, nos rendus, nos difficultés et les améliorations éventuelles
### install.md
Ce fichier détaille les spécifications techniques de notre projet ainsi que les différentes étapes de configuration de nos environnements et le fonctionnement général du projet.
### Fichiers avancements
les fichiers avanceement[n].md, où n est un chiffre, représentent les compte-rendus de nos réunions d'avancement définis dans l'organisation d'équipe.
### Fichiers planning
Les fichiers planning_[date].md, avec [date] comme la date de la réunion au format jj_mm_aaaa, représente,t les compte-rendus des plannings de début de semaine.
### Fichiers rétrospectives
Les fichiers retrospectives[n].md, où n est un chiffre, représentent les compte-rendus des rétrospectives de fin de semaine, avec notamment les retours de notre formateur.
### Fichiers taches
LEs fichiers taches[n].md, où n est un chiffre, représentent les évaluations d'avancement technique produits par le product owner.
____________________________________________________________________________________________________
# Problèmes et difficultés rencontrés
- ### Organisation de l'équipe :
La première proposition était de scinder l'équipe en deux, un binôme travaillant sur linux, l'autre sur Powershell. Après discussion, il a été conclu qu'il serait plus pertinent pour un travail de l'équipe entière sur bash dans un premier temps, de sorte à se familiariser tous ensemble sur les tâches à effectuées, puis si l'avancement est assuré de faire de même sur un environnement Windows.
- ### Rédaction du script :
Il a été décidé que dans un premier temps, nous allons rédiger le script de façon simple (ouverture de connexion distante, ensuite les commandes, puis fermeture de connexion), puis nous allons rédiger des commandes dans des fichiers à part de sorte à factoriser les commandes et simplifier le script.
- ### Installation des machines virtuelles :
	- #### Partage :
   	Au début, il était prévu que chaque personne installe correctement les machines que le projet demande, mais il a été décidé d'installer les machines sur un ordinateur dans un premier temps puis de les partager avec les autres utilisateurs. Ceci permet au reste 	du groupe de travailler sur les scripts en attendant les machines virtuelles.
  	- #### Retards :
  	Suite à plusieurs problèmes avec le partage des machines virtuelles, les environnements de travail ont pris plus de temps que prévu avant d'être partagé avec tout le monde. Il aurait fallu anticiper ce genre de problème en amont en vérifiant quelle est la 	meilleure méthode pour exporter les machines virtuelles.
  	- #### Problème du partage (Linux) :
  	Un des membre du groupe a un ordinateur Linux, et les machines virtuelles partagés ne fonctionnaient pas chez eux. Cette personne a donc installé leurs propres machines virtuelles de sorte à ne pas perdre du temps à chercher une solution à ce problème.
- ### Le rôle Product owner :
La définition précise des tâches ainsi que l'estimation temporelle du travail n'a pas été fait, car le rôle de Product Owner n'était pas entièrement compris par celui-ci. Il aurait fallu un temps pour mieux établir ce rôle pour que le product owner puisse mieux répondre aux tâches demandées par ce rôle.
- ### Difficultés d'apprentissage au sein du projet pour Ahmed :
Suite à la rétrospective, Ahmed a indiqué qu'il n'était pas satisfait avec son apprentissage au sein du projet (une note de 3.5/10). Une part du problème est l'organisation et le manque de communication, donc il faudrait prévoir un temps pour voir avec Ahmed ce qui lui conviendrait, d'après lui il a besoin de plus de temps en autonomie mais il y a très probablement des contraintes d'emploi-temps du temps. Suite à l'adaptation de son travail, il faudra lui redemander un score pour voir si les changements étaient bénéfiques.
- ### Troubles de communication :
L'organisation de l'équipe a souffert à cause d'une communication inadéquate. Il a été décidé collectivement que pour éviter les confusions d'organisation, toute tâche entreprise par un membre de l'équipe doit être signalée sur notre groupe slack de sorte à éviter les confusions potentielles dans l'organisation.
- ### Trello :
Pour le travail de gestion du product backlog du product owner, il avait été décidé qu'il faudrait utiliser trello pour gérer les tâches et avoir une archive du travail. Cependant, par manque de temps, il a été décidé que l'on allait pas l'utiliser au final.
____________________________________________________________________________________________________
# Rendus finaux

# Améliorations

