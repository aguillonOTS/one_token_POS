SmartPOS One Token

Terminal d'encaissement dédié au protocole stablecoin One Token.

SmartPOS One Token est une interface mobile développée sous Flutter, conçue pour interagir avec le contrat intelligent (Smart Contract) du stablecoin "One Token". Cette solution permet aux commerçants d'accepter des paiements numériques tout en exécutant automatiquement le protocole de dons caritatifs intégré au jeton.

L'application opère actuellement en environnement de simulation (Testnet) pour valider les mécanismes de répartition financière avant le déploiement en production.

Contexte du Projet : Protocole One Token

Le "One Token" est un actif numérique stable (Stablecoin) dont l'architecture intègre une fiscalité programmatique destinée au financement d'œuvres caritatives. Contrairement aux systèmes de dons traditionnels, le prélèvement et la redirection des fonds sont garantis par le code du contrat intelligent lors de chaque transaction, assurant une transparence et une exécution sans tiers de confiance.

Modèle de Distribution Économique

Chaque transaction validée via le terminal déclenche la répartition suivante au niveau du Smart Contract :

Entité Bénéficiaire

Allocation (%)

Rôle

Commerçant

97.8%

Revenu net de la vente crédité au portefeuille marchand.

ONG Partenaire

2.0%

Don caritatif automatisé vers l'adresse de l'organisation sélectionnée.

One Team Solutions

0.2%

Frais de maintenance du protocole et développement technique.

Spécifications Fonctionnelles

Terminal de Paiement (POS)

Génération de Factures (Invoice) : Création de codes QR conformes au standard EIP-681, encapsulant les métadonnées nécessaires à l'exécution du Smart Contract One Token (Montant, Adresse contrat, Data ONG).

Sélection du Bénéficiaire : Interface permettant le choix de l'ONG bénéficiaire des 2% de dons (ex: WWF, MSF, Handicap International) pour chaque transaction.

Gestion Multi-devises : Système d'affichage dynamique convertissant la valeur du One Token par rapport aux devises fiduciaires de référence (EUR, USD) via un module de localisation.

Administration et Suivi

Tableau de Bord : Visualisation en temps réel des volumes encaissés et de la contribution caritative générée.

Historique des Transactions : Journalisation locale immuable des opérations effectuées.

Configuration Réseau : Paramétrage des adresses des contrats (Token et Routeur de paiement) pour l'environnement de test.

Architecture Logicielle

Le projet implémente une architecture stricte visant la robustesse, la testabilité et la maintenabilité, basée sur la Clean Architecture et l'Atomic Design.

Structure du Code Source

L'organisation des fichiers respecte une séparation des préoccupations (SoC) :

lib/
├── logic/                  # Couche Logique (Business Logic)
│   ├── wallet_state.dart   # Gestion d'état centralisée (ChangeNotifier)
│   ├── wallet_provider.dart # Injection de dépendances native (InheritedNotifier)
│   └── blockchain_service.dart # Simulation de l'interaction avec le contrat One Token
├── ui/                     # Couche Présentation (Atomic Design)
│   ├── atoms/              # Composants élémentaires (Boutons, Typographie)
│   ├── molecules/          # Composants composites (Tuiles de transaction, Lignes de frais)
│   ├── organisms/          # Modules fonctionnels (Cartes de solde, Listes dynamiques)
│   └── pages/              # Vues applicatives (Dashboard, QR Invoice, Paramètres)
└── utils/                  # Utilitaires Transverses
    ├── app_localization.dart # Gestionnaire de ressources linguistiques et monétaires
    └── constants.dart      # Configuration statique du protocole


Choix Techniques

Gestion d'État Native : Utilisation exclusive des API natives de Flutter (InheritedNotifier, ChangeNotifier) pour garantir une performance optimale et réduire la dette technique liée aux dépendances externes.

Atomic Design : Méthodologie de conception d'interface assurant la cohérence visuelle et la réutilisabilité des composants UI.

Sécurité : L'application agit exclusivement comme un générateur d'instructions de paiement (Trigger). Elle ne stocke aucune clé privée et ne signe aucune transaction, déléguant cette responsabilité critique au portefeuille (Wallet) du client payeur.

Procédure de Déploiement

Prérequis

Environnement d'exécution Flutter (version stable >= 3.2.0).

Gestionnaire de versions Git.

Installation

Clonage du dépôt

git clone [https://github.com/aguillonOTS/one_token_POS.git](https://github.com/aguillonOTS/one_token_POS.git)
cd one_token_pos


Résolution des dépendances

flutter pub get


Compilation et Exécution

flutter run


Stack Technique

Framework : Flutter (Dart)

Génération QR : qr_flutter

Internationalisation : intl & Gestionnaire propriétaire AppLocalization

Auteur : Adrien - One Team Solutions
Licence : MIT