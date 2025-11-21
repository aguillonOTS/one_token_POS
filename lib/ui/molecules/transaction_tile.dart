import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../logic/blockchain_service.dart';

/// List Item displaying a single transaction summary.
/// Shows status icon, hash, timestamp, and formatted amount.
class TransactionTile extends StatelessWidget {
  final TransactionModel tx;

  const TransactionTile({super.key, required this.tx});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.green.shade100,
          child: const Icon(Icons.check, color: Colors.green, size: 20),
        ),
        title: Text("Tx: ${tx.hash.substring(0, 8)}..."),
        subtitle: Text(DateFormat('HH:mm').format(tx.timestamp)),
        trailing: Text(
          // Note: Displaying raw amount here. Consider injecting currency symbol for full consistency.
          "${tx.amount.toStringAsFixed(2)}", 
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}