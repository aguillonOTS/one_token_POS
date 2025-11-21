import 'package:flutter/material.dart';
import '../../logic/wallet_provider.dart';
import '../../utils/constants.dart';
import '../../utils/app_localization.dart';
import '../atoms/app_button.dart';

/// Settings Page.
/// Allows modification of global app state (Language, Currency, Network).
/// Uses local state for temporary selection before saving to the global Provider.
class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _isTestnet = true;
  String? _selectedLanguage;
  String? _selectedCurrency;
  bool _isInitialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Initialize local state from Global Provider
    if (!_isInitialized) {
      final walletState = WalletProvider.of(context);
      _selectedLanguage = walletState.language;
      _selectedCurrency = walletState.currency;
      _isInitialized = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    // Use the locally selected language for immediate UI feedback
    final lang = _selectedLanguage ?? "Français";

    return Scaffold(
      appBar: AppBar(title: Text(AppLocalization.get(lang, 'settings_title'))),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildSectionHeader(AppLocalization.get(lang, 'network_section')),
          _buildSwitchTile(AppLocalization.get(lang, 'testnet_mode'), _isTestnet, (v) => setState(() => _isTestnet = v)),
          _buildTextField(AppLocalization.get(lang, 'contract_addr'), "0x1234...abcd"),
          
          const SizedBox(height: 24),
          
          _buildSectionHeader(AppLocalization.get(lang, 'prefs_section')),
          
          _buildDropdownTile(
            AppLocalization.get(lang, 'lang_label'), 
            _selectedLanguage!, 
            ["Français", "English"], 
            (val) => setState(() => _selectedLanguage = val)
          ),
          _buildDropdownTile(
            AppLocalization.get(lang, 'currency_label'), 
            _selectedCurrency!, 
            ["USDC", "EUR", "USD"],
            (val) => setState(() => _selectedCurrency = val)
          ),

          const SizedBox(height: 40),
          
          // Save Button: Commits changes to the Global State
          AppButton(
            label: AppLocalization.get(lang, 'save_back'),
            icon: Icons.save,
            onPressed: () {
              final walletState = WalletProvider.of(context);
              walletState.updateSettings(
                newCurrency: _selectedCurrency!,
                newLanguage: _selectedLanguage!
              );

              Navigator.pop(context);
              
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(AppLocalization.get(lang, 'saved')),
                  backgroundColor: const Color(0xFF10B981),
                )
              );
            },
          ),
        ],
      ),
    );
  }

  // UI Helper Methods (Molecules)
  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12, top: 8),
      child: Text(
        title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF0F172A)),
      ),
    );
  }

  Widget _buildSwitchTile(String title, bool value, Function(bool) onChanged) {
    return Card(
      child: SwitchListTile(
        title: Text(title),
        value: value,
        onChanged: onChanged,
        activeColor: const Color(0xFF10B981),
      ),
    );
  }

  Widget _buildTextField(String label, String placeholder) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        child: TextField(
          decoration: InputDecoration(border: InputBorder.none, labelText: label, hintText: placeholder),
        ),
      ),
    );
  }

  Widget _buildDropdownTile(String title, String value, List<String> items, ValueChanged<String?> onChanged) {
    return Card(
      child: ListTile(
        title: Text(title),
        trailing: DropdownButton<String>(
          value: value,
          underline: const SizedBox(),
          items: items.map((v) => DropdownMenuItem(value: v, child: Text(v))).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}