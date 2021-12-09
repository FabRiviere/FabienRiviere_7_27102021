# FabienRiviere_7_27102021
Projet 7 de la formation de développeur web chez OpenClassRooms
Création d'un réseau social pour l'entreprise Groupomania.

# Version 1 de développement permettant un test par un employé du groupe

# Développement du Projet
Backend : NodeJS + express + sequelize
Base de données : MySQL
Frontend : VueJS + Vuex

# Backend 
Depuis le terminal de l'éditeur de code, se rendre sur le dossier "api" et exécuter la commande : 

    npm install
puis
    nodemon server

# Frontend
Depuis le terminal de l'éditeur de code, se rendre sur le dossier "client" et exécuter la commande : 

    npm install
puis
    npm run serve

Ouvrir ensuite votre navigateur et accéder à : http://localhost:8080/

# Base de données
Se connecter au serveur MySQL et exécutez la commande : "CREATE DATABASE socialDB_dev"

Les identifiants sont dans le fichier config.json dans le dossier Backend "api".
Importer ensuite le fichier socialDB_dev en tapant : 
    mysql -u root -p socialDB_dev < socialDB_dev.sql

    socialDB_dev.sql représente le chemin du fichier importé. Remplacer le par le chemin du fichier dans votre machine. 

Un compte administrateur est créé automatiquement au lancement de la base de données. 

# Documentation de l' API 
La documentation pour l'API du réseau social est disponible à cette adresse : 

    https://documenter.getpostman.com/view/18110306/UVJk9sAF

# Utilisation du réseau social : 

Inscription / Création d'un compte utilisateur : 
    - Choisir un pseudo (composé de 3 et 30 caractères)
    - Renseigner une adresse mail valide
    - Rensigner un mot de passe(composé de 8 à 20 caractères- lettres, chiffres acceptés minuscules et majuscules,pas de symboles).

Gestion du profil de compte : 
    - Après création du compte vous pouvez vous rendre sur votre profil en cliquant sur l'avatar de compte (dans le header).
    - Vous pouvez ensuite renseigner ou changer par la suite : votre pseudo, votre photo , votre bio.

Vision de tous les profils utilisateurs : 
    - Vous pouvez accéder à l'ensemble des profils utilisateurs inscrits en cliquant sur les avatars de comptes (dans le header).

Vision et interactions avec tous les posts crées par les utilisateurs :
    - En cliquant sur le fil d'actualité, vous accédez à l'ensemble des publications postées par tous. 
    - Vous avez la possibilité de "liké" les posts en cliquant sur le bouton prévu à cet effet. En cliquant une nouvelle fois sur ce bouton cela aura pour effet de "disliké" la publicaation. 
    - Vous avez la possibilité de commenter une publication en écrivant dans le champ prévu à cet effet et après avoir cliqué sur le bouton pour poster votre commentaire. 
    - Vous pouvez supprimer un commentaire que vous avez publié précedemment. 
     - Seul les commentaires vous appartenant sont accessibles à une suppression. 

Publier un post : 
    - Vous pouvez publier un post avec un message seul, avec un lien vers une image gif, ou avec une image depuis votre ordinateur.

Modifier ou supprimer un post : 
    - Vous pouvez modifier ou supprimer un post que vous avez publié précedemment. 
    - Seul les posts vous appartenant sont accessibles à une modification ou à une suppression. 

Voir les posts les plus aimés et les plus récents : 
    - Vous avez la possibilité en cliquant sur les boutons appropriés de voir les publications les plus aimées (celles ayant le plus de likes seront en premier), ainsi que celles les plus récentes (triées par date de la + récente à la + ancienne), même si ce tri est déjà fait par défault sur la page des posts. 

Surveillance du réseau social : 
    - Un administrateur / modérateur a accès à l'ensemble des comptes utilisateurs, des publications et des commentaires.
    - Tout manquement au réglement pourra être sanctionné, et l'administrateur peut supprimer une publication, un commentaire et même un compte si cela est nécessaire. 

# Page réglement / A propos

Une page dédiée au réglement du réseau social est accessible depuis le bouton de lien présent dans le footer. 