import 'package:flutter/material.dart';

class AppLocalization {
  // --- 1. Gestion des Symboles Monétaires (DRY) ---
  static String getCurrencySymbol(String currencyCode) {
    switch (currencyCode) {
      case 'EUR':
        return '€';
      case 'USDC':
        return 'USDC ';
      case 'USD':
      default:
        return '\$';
    }
  }

  // --- 2. Dictionnaire des Traductions ---
  static const Map<String, Map<String, String>> _localizedValues = {
    'Français': {
      // Global
      'app_title': 'One Team POS',
      'cancel': 'Annuler',
      'save_back': 'SAUVEGARDER & RETOUR',
      'saved': 'Paramètres sauvegardés',
      
      // Dashboard
      'daily_volume': 'Volume Journalier',
      'quick_actions': 'Actions Rapides',
      'new_payment_btn': 'ENCAISSER (GÉNÉRER QR)',
      'navigation': 'Navigation',
      'history_btn': 'VOIR L\'HISTORIQUE',
      'new_payment_title': 'Nouveau Paiement',
      'amount_label': 'Montant',
      'ngo_label': 'Bénéficiaire du Don (2%)',
      'generate_qr': 'Générer QR',

      // Payment QR
      'waiting_payment_title': 'Attente Paiement',
      'scan_instruction': 'Scannez pour payer',
      'waiting_scan': 'En attente du scan client...',
      'simulate_btn': 'SIMULER SCAN / VALIDATION',
      'payment_confirmed': 'Paiement Confirmé !',
      'ngo': 'ONG',

      // Confirmation
      'receipt_title': 'Reçu Transaction',
      'payment_success': 'Paiement Réussi',
      'amount_paid': 'Montant Payé',
      'merchant': 'Commerçant',
      'donor_ngo': 'Don ONG',
      'new_sale': 'NOUVELLE VENTE',
      'back_menu': 'Retour au Menu Principal',

      // Settings
      'settings_title': 'Paramètres',
      'network_section': 'Réseau & Blockchain',
      'testnet_mode': 'Mode Testnet (Simulation)',
      'contract_addr': 'Adresse Smart Contract',
      'merchant_addr': 'Adresse Commerçant (Wallet)',
      'prefs_section': 'Préférences',
      'lang_label': 'Langue',
      'currency_label': 'Devise Affichage',
      
      // History
      'history_title': 'Historique Transactions',
      'no_transaction': 'Aucune transaction récente',
    },
    'English': {
      // Global
      'app_title': 'One Team POS',
      'cancel': 'Cancel',
      'save_back': 'SAVE & BACK',
      'saved': 'Settings saved',

      // Dashboard
      'daily_volume': 'Daily Volume',
      'quick_actions': 'Quick Actions',
      'new_payment_btn': 'CASH IN (GENERATE QR)',
      'navigation': 'Navigation',
      'history_btn': 'VIEW HISTORY',
      'new_payment_title': 'New Payment',
      'amount_label': 'Amount',
      'ngo_label': 'Donation Beneficiary (2%)',
      'generate_qr': 'Generate QR',

      // Payment QR
      'waiting_payment_title': 'Waiting for Payment',
      'scan_instruction': 'Scan to pay',
      'waiting_scan': 'Waiting for client scan...',
      'simulate_btn': 'SIMULATE SCAN / VALIDATION',
      'payment_confirmed': 'Payment Confirmed!',
      'ngo': 'NGO',

      // Confirmation
      'receipt_title': 'Transaction Receipt',
      'payment_success': 'Payment Successful',
      'amount_paid': 'Amount Paid',
      'merchant': 'Merchant',
      'donor_ngo': 'NGO Donation',
      'new_sale': 'NEW SALE',
      'back_menu': 'Back to Main Menu',

      // Settings
      'settings_title': 'Settings',
      'network_section': 'Network & Blockchain',
      'testnet_mode': 'Testnet Mode (Simulation)',
      'contract_addr': 'Smart Contract Address',
      'merchant_addr': 'Merchant Address (Wallet)',
      'prefs_section': 'Preferences',
      'lang_label': 'Language',
      'currency_label': 'Display Currency',

      // History
      'history_title': 'Transaction History',
      'no_transaction': 'No recent transactions',
    },
  };

  // Méthode helper pour récupérer le texte
  static String get(String language, String key) {
    return _localizedValues[language]?[key] ?? key;
  }
}