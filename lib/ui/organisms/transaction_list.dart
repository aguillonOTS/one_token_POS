import 'package:flutter/material.dart';
import '../../logic/blockchain_service.dart';
import '../molecules/transaction_tile.dart';
import '../../utils/app_localization.dart';
import '../../logic/wallet_provider.dart';

/// Organism handling the list of recent transactions.
/// Manages empty states and renders a scrollable list of TransactionTiles.
class TransactionList extends StatelessWidget {
  final List<TransactionModel> transactions;

  const TransactionList({super.key, required this.transactions});

  @override
  Widget build(BuildContext context) {
    final walletState = WalletProvider.of(context);
    final lang = walletState.language;

    if (transactions.isEmpty) {
      return Center(
        child: Text(
          AppLocalization.get(lang, 'no_transaction'),
          style: const TextStyle(color: Colors.grey),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.only(bottom: 16),
      itemCount: transactions.length,
      itemBuilder: (context, index) {
        return TransactionTile(tx: transactions[index]);
      },
    );
  }
}