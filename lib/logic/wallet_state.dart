import 'package:flutter/foundation.dart';
import 'blockchain_service.dart';

/// Manages the global state of the wallet (transactions, balance, settings).
/// Implements the 'ChangeNotifier' pattern for reactive UI updates.
class WalletState extends ChangeNotifier {
  final BlockchainService _service = BlockchainService();
  
  // State variables
  double _dailyVolume = 12450.00;
  bool _isLoading = false;
  
  // User Preferences (Default values)
  String _currency = "USDC";
  String _language = "Français";

  // Mocked initial transaction history
  final List<TransactionModel> _transactions = [
    TransactionModel(
      hash: '0x34...df2', 
      amount: 150.00, 
      status: 'Confirmed', 
      timestamp: DateTime.now()
    ),
  ];

  // Getters to expose state safely
  double get dailyVolume => _dailyVolume;
  List<TransactionModel> get transactions => List.unmodifiable(_transactions);
  bool get isLoading => _isLoading;
  String get currency => _currency;
  String get language => _language;

  /// Updates app settings and notifies listeners to trigger a rebuild (e.g., language change).
  void updateSettings({required String newCurrency, required String newLanguage}) {
    _currency = newCurrency;
    _language = newLanguage;
    notifyListeners(); 
  }

  /// Simulates the One Token payment protocol.
  /// Adds the transaction to local history upon success.
  Future<String?> processPayment(String recipient, double amount) async {
    _isLoading = true;
    notifyListeners();

    try {
      // Call the blockchain service (Mock)
      final txHash = await _service.executeTransaction(recipient, amount);
      
      // Optimistic UI update
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