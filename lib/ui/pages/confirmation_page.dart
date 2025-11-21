import 'package:flutter/material.dart';
import '../../logic/wallet_provider.dart';
import '../../utils/constants.dart';
import '../../utils/app_localization.dart';
import '../atoms/app_button.dart';
import '../molecules/fee_row.dart';

/// Transaction Receipt Page.
/// Displays the final breakdown for the customer.
/// Note: Internal protocol fees (0.2%) are hidden from this view for simplicity.
class ConfirmationPage extends StatelessWidget {
  final String targetAddress;
  final double amount;
  final String? ngoName;

  const ConfirmationPage({
    super.key, 
    required this.targetAddress, 
    required this.amount,
    this.ngoName
  });

  @override
  Widget build(BuildContext context) {
    final walletState = WalletProvider.of(context);
    final lang = walletState.language;
    final symbol = AppLocalization.getCurrencySymbol(walletState.currency);

    // Protocol Calculations
    final ngoFee = amount * kNgoFeePercent;
    final devFee = amount * kDevFeePercent;
    final merchantNet = amount - ngoFee - devFee;

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalization.get(lang, 'receipt_title')),
        automaticallyImplyLeading: false, // Prevent back navigation during receipt view
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const Icon(Icons.check_circle_outline, size: 80, color: Colors.green),
            const SizedBox(height: 16),
            Text(AppLocalization.get(lang, 'payment_success'), style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 32),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  children: [
                    Text(
                      "$symbol${amount.toStringAsFixed(2)}", 
                      style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold)
                    ),
                    Text(AppLocalization.get(lang, 'amount_paid'), style: const TextStyle(color: Colors.grey)),
                    const Divider(height: 30),
                    
                    // Customer-facing breakdown
                    FeeRow(label: AppLocalization.get(lang, 'merchant'), value: "$symbol${merchantNet.toStringAsFixed(2)}"),
                    FeeRow(
                      label: "${AppLocalization.get(lang, 'donor_ngo')} (${ngoName ?? 'Partenaire'})", 
                      value: "$symbol${ngoFee.toStringAsFixed(2)}",
                      highlight: true
                    ),
                  ],
                ),
              ),
            ),
            const Spacer(),
            
            // Return to Dashboard
            AppButton(
              label: AppLocalization.get(lang, 'new_sale'),
              icon: Icons.store,
              onPressed: () {
                Navigator.popUntil(context, ModalRoute.withName('/'));
              },
            ),
            const SizedBox(height: 12),
            TextButton(
              onPressed: () {
                Navigator.popUntil(context, ModalRoute.withName('/'));
              },
              child: Text(AppLocalization.get(lang, 'back_menu'), style: const TextStyle(color: Colors.grey)),
            ),
          ],
        ),
      ),
    );
  }
}