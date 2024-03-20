# TP noté

## Membres

- MARMION Steven
- SIMON Gael

## Contexte

Le but de ce projet est de faire une applciation mobile qui consitite à recoder le jeux du nombre mystèere avec une deadline de 2 semaines.

## Principes

- Page d'accueil :
  - Image du jeu
  - Trois boutons :
    - Play
    - Voir mes scores
    - Explication des règles
- Page de de pré-jeu :
  - Champ de texte pour entrer le prénom de la personne qui joue
  - Bouton de lancement du jeu
- Page de jeu :
  - je rentre un nombre et l’application m’indique si je suis plus petit ou plus grand que le nombre déterminé aléatoirement au préalable, et ainsi de suite...
  - Le tout se fait avec 10 tentatives
- Page de finition du jeu :
  - Nombre trouvé :
    - Bouton enregistrement du score ( avec nom du participant et nombre de tentative )
  - Nombre introuvé :
    - Bouton pour recommencer une partie

Le jeu se base sur un existant : <https://www.clicmaclasse.fr/activites/nm/nm.html>
   
## Contraintes

- BDD sqflite :
  - <https://pub.dev/packages/sqflite>
  - <https://docs.flutter.dev/cookbook/persistence/sqlite>  
