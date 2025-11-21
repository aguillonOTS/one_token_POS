import 'package:flutter/material.dart';
import '../../logic/blockchain_service.dart';
import '../molecules/transaction_tile.dart';

/// Organisme responsable de l'affichage de la liste des transactions.
/// Il gère le cas d'une liste vide et délègue le rendu de chaque item à une Molécule.
class TransactionList extends StatelessWidget {
  final List<TransactionModel> transactions;

  const TransactionList({super.key, required this.transactions});

  @override
  Widget build(BuildContext context) {
    if (transactions.isEmpty) {
      return const Center(
        child: Text(
          "Aucune transaction récente",
          style: TextStyle(color: Colors.grey),
        ),
      );
    }

    return ListView.builder(
      // Padding pour éviter que le dernier item ne soit collé au bord
      padding: const EdgeInsets.only(bottom: 16),
      itemCount: transactions.length,
      itemBuilder: (context, index) {
        // Injection de la donnée dans la Molécule
        return TransactionTile(tx: transactions[index]);
      },
    );
  }
}