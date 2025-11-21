import 'package:flutter/material.dart';
import '../../logic/wallet_provider.dart';
import '../../utils/constants.dart';
import '../../utils/app_localization.dart';
import '../atoms/app_button.dart';
import '../atoms/fee_text.dart';
import '../organisms/balance_card.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final walletState = WalletProvider.of(context);
    final lang = walletState.language;

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalization.get(lang, 'app_title')),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings), 
            onPressed: () => Navigator.pushNamed(context, '/settings'),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            BalanceCard(dailyVolume: walletState.dailyVolume),
            const SizedBox(height: 24),
            
            FeeText(AppLocalization.get(lang, 'quick_actions'), isBold: true, fontSize: 18),
            const SizedBox(height: 12),
            
            AppButton(
              label: AppLocalization.get(lang, 'new_payment_btn'),
              icon: Icons.qr_code,
              onPressed: () => _showPaymentDialog(context),
            ),
            
            const SizedBox(height: 24),
            
            FeeText(AppLocalization.get(lang, 'navigation'), isBold: true, fontSize: 18),
            const SizedBox(height: 12),
            
            AppButton(
              label: AppLocalization.get(lang, 'history_btn'),
              icon: Icons.history,
              backgroundColor: Colors.blueGrey,
              onPressed: () => Navigator.pushNamed(context, '/history'),
            ),
            
            const Spacer(),
          ],
        ),
      ),
    );
  }

  void _showPaymentDialog(BuildContext context) {
    final TextEditingController amountCtrl = TextEditingController();
    String selectedNgo = kNgoList.first;
    
    final walletState = WalletProvider.of(context);
    final lang = walletState.language;
    final symbol = AppLocalization.getCurrencySymbol(walletState.currency);
    
    // --- CORRECTION : Icône Dynamique (€ ou $) ---
    IconData currencyIcon = Icons.attach_money; // Par défaut $
    if (walletState.currency == 'EUR') {
      currencyIcon = Icons.euro;
    }

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            title: Text(AppLocalization.get(lang, 'new_payment_title')),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: amountCtrl,
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  autofocus: true,
                  decoration: InputDecoration(
                    labelText: "${AppLocalization.get(lang, 'amount_label')} ($symbol)", 
                    border: const OutlineInputBorder(),
                    // L'icône change maintenant selon la devise !
                    prefixIcon: Icon(currencyIcon),
                  ),
                ),
                const SizedBox(height: 20),
                Text(AppLocalization.get(lang, 'ngo_label'), style: const TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                DropdownButtonFormField<String>(
                  value: selectedNgo,
                  isExpanded: true,
                  decoration: const InputDecoration(border: OutlineInputBorder()),
                  items: kNgoList.map((ngo) => DropdownMenuItem(value: ngo, child: Text(ngo))).toList(),
                  onChanged: (val) => setState(() => selectedNgo = val!),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(ctx), 
                child: Text(AppLocalization.get(lang, 'cancel'))
              ),
              FilledButton(
                onPressed: () {
                  final amount = double.tryParse(amountCtrl.text);
                  if (amount != null && amount > 0) {
                    Navigator.pop(ctx);
                    Navigator.pushNamed(
                      context, 
                      '/payment_qr', 
                      arguments: {'amount': amount, 'ngo': selectedNgo}
                    );
                  }
                },
                child: Text(AppLocalization.get(lang, 'generate_qr')),
              )
            ],
          );
        }
      ),
    );
  }
}