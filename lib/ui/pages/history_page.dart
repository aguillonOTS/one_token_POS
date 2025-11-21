import 'package:flutter/material.dart';
import '../../logic/wallet_provider.dart';
import '../organisms/transaction_list.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final walletState = WalletProvider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Historique Transactions"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: TransactionList(transactions: walletState.transactions),
      ),
    );
  }
}