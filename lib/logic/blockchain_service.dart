import 'dart:async';
import 'dart:math';

/// Data Transfer Object representing a blockchain transaction.
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

/// Service simulating Web3 interactions.
/// In production, this would use 'web3dart' to sign and broadcast transactions.
class BlockchainService {
  
  /// Simulates a transaction execution on the blockchain.
  /// Returns a fake transaction hash after a network delay.
  Future<String> executeTransaction(String recipient, double amount) async {
    // Simulate network latency (RPC call)
    await Future.delayed(const Duration(seconds: 2));
    
    // Generate a random mock hash
    return "0x${Random().nextInt(999999999)}abcdef";
  }
}