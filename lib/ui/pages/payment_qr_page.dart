import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../../logic/wallet_provider.dart';
import '../../utils/app_localization.dart';
import '../atoms/fee_text.dart';

class PaymentQrPage extends StatefulWidget {
  final double amount;
  final String ngo;

  const PaymentQrPage({super.key, required this.amount, required this.ngo});

  @override
  State<PaymentQrPage> createState() => _PaymentQrPageState();
}

class _PaymentQrPageState extends State<PaymentQrPage> {
  bool _isPaymentReceived = false;

  String get _paymentData {
    const contract = "0xYourContractAddress";
    const merchant = "0xYourMerchantAddress";
    return "ethereum:$contract/transfer?address=$merchant&uint256=${widget.amount}&data=NGO:${widget.ngo}";
  }

  void _triggerValidation() async {
    final walletState = WalletProvider.of(context);
    await walletState.processPayment("CLIENT_WALLET", widget.amount);
    
    if (mounted) {
      setState(() => _isPaymentReceived = true);
      await Future.delayed(const Duration(seconds: 1));
      if (mounted) {
        Navigator.pushReplacementNamed(
            context, 
            '/success', 
            arguments: {'amount': widget.amount, 'ngo': widget.ngo}
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final walletState = WalletProvider.of(context);
    final lang = walletState.language;
    final symbol = AppLocalization.getCurrencySymbol(walletState.currency);

    return Scaffold(
      appBar: AppBar(title: Text(AppLocalization.get(lang, 'waiting_payment_title'))),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [const BoxShadow(color: Colors.black12, blurRadius: 10)],
              ),
              child: Column(
                children: [
                  if (_isPaymentReceived)
                    const Icon(Icons.check_circle, size: 200, color: Colors.green)
                  else
                    QrImageView(
                      data: _paymentData,
                      version: QrVersions.auto,
                      size: 240.0,
                      backgroundColor: Colors.white,
                    ),
                  const SizedBox(height: 20),
                  
                  // Montant Principal (Affiche la devise ici : ex "€150.00" ou "USDC 150.00")
                  Text(
                    "$symbol${widget.amount.toStringAsFixed(2)}",
                    style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                  ),
                  
                  Text("${AppLocalization.get(lang, 'ngo')}: ${widget.ngo}", 
                       style: const TextStyle(color: Colors.blueGrey, fontWeight: FontWeight.bold)),
                  
                  const SizedBox(height: 8),
                  
                  // --- CORRECTION EXPLICITE ---
                  // Nous affichons uniquement le texte traduit, SANS ajouter "($symbol)" à la fin.
                  Text(
                    AppLocalization.get(lang, 'scan_instruction'), 
                    style: const TextStyle(color: Colors.grey)
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
            
            if (!_isPaymentReceived) ...[
              const CircularProgressIndicator(),
              const SizedBox(height: 20),
              FeeText(AppLocalization.get(lang, 'waiting_scan'), isBold: true),
              const SizedBox(height: 40),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: OutlinedButton.icon(
                  onPressed: _triggerValidation,
                  icon: const Icon(Icons.qr_code_scanner),
                  label: Text(AppLocalization.get(lang, 'simulate_btn')),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(0xFF10B981),
                    side: const BorderSide(color: Color(0xFF10B981)),
                  ),
                ),
              )
            ] else ...[
              FeeText(AppLocalization.get(lang, 'payment_confirmed'), isBold: true, color: Colors.green, fontSize: 24),
            ],
          ],
        ),
      ),
    );
  }
}