import 'package:flutter/foundation.dart';
import 'blockchain_service.dart'; // Vérifiez que ce fichier existe aussi dans lib/logic/

class WalletState extends ChangeNotifier {
  final BlockchainService _service = BlockchainService();
  
  double _dailyVolume = 12450.00;
  bool _isLoading = false;
  
  // Préférences
  String _currency = "USDC";
  String _language = "Français";

  // Données mockées initiales
  final List<TransactionModel> _transactions = [
    TransactionModel(
      hash: '0x34...df2', 
      amount: 150.00, 
      status: 'Confirmed', 
      timestamp: DateTime.now()
    ),
  ];

  // Getters
  double get dailyVolume => _dailyVolume;
  List<TransactionModel> get transactions => List.unmodifiable(_transactions);
  bool get isLoading => _isLoading;
  String get currency => _currency;
  String get language => _language;

  // Sauvegarde des paramètres
  void updateSettings({required String newCurrency, required String newLanguage}) {
    _currency = newCurrency;
    _language = newLanguage;
    notifyListeners();
  }

  // Traitement Paiement
  Future<String?> processPayment(String recipient, double amount) async {
    _isLoading = true;
    notifyListeners();

    try {
      final txHash = await _service.executeTransaction(recipient, amount);
      
      _dailyVolume += amount;
      _transactions.insert(0, TransactionModel(
        hash: txHash, 
        amount: amount, 
        status: 'Confirmed', 
        timestamp: DateTime.now()
      ));
      
      return txHash;
    } catch (e) {
      return null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}