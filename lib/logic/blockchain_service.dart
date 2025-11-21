import 'dart:async';
import 'dart:math';

class TransactionModel {
  final String hash;
  final double amount;
  final String status;
  final DateTime timestamp;

  TransactionModel({
    required this.hash,
    required this.amount,
    required this.status,
    required this.timestamp,
  });
}

class BlockchainService {
  // Simule l'interaction avec le Smart Contract
  Future<String> executeTransaction(String recipient, double amount) async {
    // Simulation de latence réseau (RPC call)
    await Future.delayed(const Duration(seconds: 2));
    // Retourne un faux hash de transaction Ethereum
    return "0x${Random().nextInt(999999999)}abcdef";
  }
}