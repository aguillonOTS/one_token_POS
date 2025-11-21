import 'package:flutter/material.dart';
import 'logic/wallet_provider.dart';
import 'logic/wallet_state.dart';
import 'ui/pages/confirmation_page.dart';
import 'ui/pages/dashboard_page.dart';
import 'ui/pages/history_page.dart'; // Import Nouvelle page
import 'ui/pages/payment_qr_page.dart';
import 'ui/pages/settings_page.dart';
import 'utils/constants.dart';

void main() {
  runApp(const OneTeamPosApp());
}

class OneTeamPosApp extends StatelessWidget {
  const OneTeamPosApp({super.key});

  @override
  Widget build(BuildContext context) {
    return WalletProvider(
      notifier: WalletState(),
      child: MaterialApp(
        title: kAppName,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFF0F172A),
            secondary: const Color(0xFF10B981),
          ),
          scaffoldBackgroundColor: const Color(0xFFF8FAFC),
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => const DashboardPage(),
          '/settings': (context) => const SettingsPage(),
          '/history': (context) => const HistoryPage(), // Nouvelle route
        },
        onGenerateRoute: (settings) {
          if (settings.name == '/payment_qr') {
            final args = settings.arguments as Map<String, dynamic>;
            return MaterialPageRoute(
              builder: (context) => PaymentQrPage(
                amount: args['amount'],
                ngo: args['ngo'],
              ),
            );
          }

          if (settings.name == '/success') {
            final args = settings.arguments as Map<String, dynamic>;
            return MaterialPageRoute(
              builder: (context) => ConfirmationPage(
                targetAddress: "CLIENT", 
                amount: args['amount'],
                ngoName: args['ngo'],
              ),
            );
          }
          return null;
        },
      ),
    );
  }
}