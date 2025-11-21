import 'package:flutter/widgets.dart';
import 'wallet_state.dart';

// Implémentation d'un Provider via InheritedNotifier (natif Flutter)
class WalletProvider extends InheritedNotifier<WalletState> {
  const WalletProvider({
    super.key,
    required WalletState super.notifier,
    required super.child,
  });

  static WalletState of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<WalletProvider>()!.notifier!;
  }
}