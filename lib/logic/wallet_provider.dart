import 'package:flutter/widgets.dart';
import 'wallet_state.dart';

/// Dependency Injection mechanism.
/// Uses 'InheritedNotifier' to efficiently propagate WalletState down the widget tree
/// and trigger rebuilds only when the notifier (WalletState) updates.
class WalletProvider extends InheritedNotifier<WalletState> {
  const WalletProvider({
    super.key,
    required WalletState super.notifier,
    required super.child,
  });

  /// Helper method to access the state from any descendant widget.
  static WalletState of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<WalletProvider>()!.notifier!;
  }
}