import 'package:flutter/material.dart';
import '../models/user.dart';
import '../widgets/wallet_card.dart';

class DashboardScreen extends StatelessWidget {
  final User user;

  const DashboardScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pluss Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.qr_code_scanner),
            onPressed: () {
              // TODO: Implementar escáner QR para códigos de transacción
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Escáner QR próximamente')),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Saludo personalizado
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                '¡Hola, ${user.name}!',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),

            // Tarjeta de billetera
            WalletCard(user: user),

            // Acciones rápidas
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Acciones rápidas',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _QuickActionButton(
                  icon: Icons.group_add,
                  label: 'Crear Grupo',
                  onTap: () {
                    Navigator.pushNamed(context, '/group-codes');
                  },
                ),
                _QuickActionButton(
                  icon: Icons.receipt,
                  label: 'Transacciones',
                  onTap: () {
                    // TODO: Navegar a pantalla de transacciones
                  },
                ),
                _QuickActionButton(
                  icon: Icons.account_balance,
                  label: 'Retirar',
                  onTap: () {
                    Navigator.pushNamed(context, '/withdrawals');
                  },
                ),
              ],
            ),

            // Transacciones recientes
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Transacciones recientes',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            _RecentTransactionsList(),
          ],
        ),
      ),
    );
  }
}

class _QuickActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _QuickActionButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: 80,
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Icon(icon, size: 32, color: Theme.of(context).colorScheme.primary),
            const SizedBox(height: 4),
            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}

class _RecentTransactionsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Datos simulados de transacciones recientes
    final transactions = [
      {'commerce': 'Supermercado Central', 'amount': 45.50, 'cashback': 4.55, 'date': '2024-01-15'},
      {'commerce': 'Farmacia Salud', 'amount': 25.00, 'cashback': 2.50, 'date': '2024-01-14'},
      {'commerce': 'Restaurante El Buen Sabor', 'amount': 75.30, 'cashback': 7.53, 'date': '2024-01-13'},
    ];

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: transactions.length,
      itemBuilder: (context, index) {
        final tx = transactions[index];
        return Card(
          child: ListTile(
            leading: const Icon(Icons.receipt, color: Colors.green),
            title: Text(tx['commerce'] as String),
            subtitle: Text('Bs. ${tx['amount']} - Cashback: Bs. ${tx['cashback']}'),
            trailing: Text(tx['date'] as String),
          ),
        );
      },
    );
  }
}