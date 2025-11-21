import 'package:flutter/material.dart';
import '../../logic/wallet_provider.dart';
import '../../utils/app_localization.dart';
import '../organisms/transaction_list.dart';

/// Dedicated page for viewing full transaction history.
/// Accesses global state to retrieve past transactions.
class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final walletState = WalletProvider.of(context);
    final lang = walletState.language;

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalization.get(lang, 'history_title')),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: TransactionList(transactions: walletState.transactions),
      ),
    );
  }
}