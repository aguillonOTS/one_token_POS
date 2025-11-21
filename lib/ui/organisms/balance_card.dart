import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../logic/wallet_provider.dart';
import '../../utils/constants.dart';
import '../../utils/app_localization.dart'; // Import

class BalanceCard extends StatelessWidget {
  final double dailyVolume;

  const BalanceCard({super.key, required this.dailyVolume});

  @override
  Widget build(BuildContext context) {
    final walletState = WalletProvider.of(context);
    final lang = walletState.language;
    // Récupération du bon symbole (€, $, USDC)
    final symbol = AppLocalization.getCurrencySymbol(walletState.currency);

    // Formatage dynamique avec le bon symbole
    final fmt = NumberFormat.currency(symbol: symbol, decimalDigits: 2);
    
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blueGrey.shade900, Colors.blueGrey.shade800],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Colors.blueGrey.withOpacity(0.3), blurRadius: 10, offset: const Offset(0, 5))
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(AppLocalization.get(lang, 'daily_volume'), style: const TextStyle(color: Colors.white70)),
          const SizedBox(height: 8),
          Text(
            fmt.format(dailyVolume),
            style: const TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              _MiniStat("ONG (2%)", fmt.format(dailyVolume * kNgoFeePercent)),
              const SizedBox(width: 20),
              _MiniStat("Team (0.2%)", fmt.format(dailyVolume * kDevFeePercent)),
            ],
          )
        ],
      ),
    );
  }
}

class _MiniStat extends StatelessWidget {
  final String label;
  final String value;
  const _MiniStat(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: Colors.greenAccent, fontSize: 12)),
        Text(value, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ],
    );
  }
}