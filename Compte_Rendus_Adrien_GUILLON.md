Projet Flutter - SmartPOS One Token

Étudiant : Adrien GUILLON
Module : Développement Mobile Flutter

Présentation du Projet

SmartPOS One Token est une application mobile de Point de Vente (POS) développée pour interagir avec le protocole de stablecoin "One Token". Ce protocole se distingue par l'intégration d'une fiscalité programmatique au niveau du Smart Contract, automatisant les dons caritatifs lors des transactions.

L'application permet à un commerçant d'encaisser des paiements en générant des factures dynamiques (QR Codes) tout en assurant l'exécution du modèle de répartition économique suivant :

97.8% crédités au commerçant.

2.0% reversés automatiquement à une ONG sélectionnée lors de la vente.

0.2% alloués aux frais de maintenance du protocole (One Team).

L'application fonctionne actuellement en environnement de simulation (Testnet) et agit comme un initiateur de transaction sécurisé (Trigger), sans stockage de clés privées critiques.

État d'Avancement et Choix Techniques

Le projet rendu est fonctionnel et respecte les contraintes architecturales imposées.

1. Architecture et Structure

L'application implémente une Clean Architecture couplée à l'Atomic Design pour l'interface utilisateur, garantissant une séparation stricte des responsabilités :

ui/ : Découpage en Atoms (boutons), Molecules (tuiles), Organisms (cartes de solde) et Pages.

logic/ : Gestion de la logique métier et de l'état application.

utils/ : Gestionnaires transverses (Localisation, Constantes).

2. Gestion d'État (State Management)

Conformément aux bonnes pratiques pour ce volume de projet, la gestion d'état repose sur les API natives de Flutter :

InheritedNotifier (WalletProvider) pour l'injection de dépendances dans l'arbre des widgets.

ChangeNotifier (WalletState) pour la réactivité et la centralisation des données (Transactions, Préférences, Volumes).

3. Fonctionnalités Implémentées

Routage : Navigation via routes nommées (/, /settings, /history, /payment_qr).

Internationalisation : Système de traduction dynamique (Français/Anglais) et adaptation des symboles monétaires (EUR/USD/USDC) sans redémarrage.

Génération QR : Création de codes conformes au standard EIP-681 incluant les métadonnées du contrat et de l'ONG bénéficiaire.

Tableau de Bord : Visualisation temps réel des métriques financières.

Accès au Code Source

Le code source complet et à jour est disponible sur la branche main du dépôt suivant :

Lien du dépôt GitHub :
https://github.com/aguillonOTS/one_token_POS
