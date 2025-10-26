import 'package:flutter/material.dart';

class WithdrawalScreen extends StatefulWidget {
  const WithdrawalScreen({super.key});

  @override
  State<WithdrawalScreen> createState() => _WithdrawalScreenState();
}

class _WithdrawalScreenState extends State<WithdrawalScreen> {
  final _formKey = GlobalKey<FormState>();
  final _accountNumberController = TextEditingController();
  final _accountHolderController = TextEditingController();
  final _bankController = TextEditingController();
  final _amountController = TextEditingController();

  String _withdrawalPeriod = 'monthly'; // 'monthly' or 'yearly'

  @override
  void dispose() {
    _accountNumberController.dispose();
    _accountHolderController.dispose();
    _bankController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  void _submitWithdrawal() {
    if (_formKey.currentState!.validate()) {
      // TODO: Implementar retiro real con verificación de cuenta
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Solicitud de retiro enviada: Bs. ${_amountController.text} - Período: ${_withdrawalPeriod == 'monthly' ? 'Fin de mes' : 'Fin de año'}'
          ),
        ),
      );

      // Limpiar formulario
      _accountNumberController.clear();
      _accountHolderController.clear();
      _bankController.clear();
      _amountController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Retiros de Cashback'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Información del saldo
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Saldo Disponible',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Bs. 150.50', // TODO: Obtener del usuario actual
                      style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            Text(
              'Solicitar Retiro',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),

            // Período de retiro
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Período de Retiro',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: RadioListTile<String>(
                            title: const Text('Fin de Mes'),
                            value: 'monthly',
                            groupValue: _withdrawalPeriod,
                            onChanged: (value) {
                              setState(() {
                                _withdrawalPeriod = value!;
                              });
                            },
                          ),
                        ),
                        Expanded(
                          child: RadioListTile<String>(
                            title: const Text('Fin de Año'),
                            value: 'yearly',
                            groupValue: _withdrawalPeriod,
                            onChanged: (value) {
                              setState(() {
                                _withdrawalPeriod = value!;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Formulario de cuenta bancaria
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Datos de Cuenta Bancaria',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'La cuenta debe estar a tu nombre para verificar la titularidad',
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                      const SizedBox(height: 16),

                      TextFormField(
                        controller: _accountNumberController,
                        decoration: const InputDecoration(
                          labelText: 'Número de Cuenta',
                          hintText: '1234567890',
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Ingresa el número de cuenta';
                          }
                          if (value.length < 10) {
                            return 'Número de cuenta inválido';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),

                      TextFormField(
                        controller: _accountHolderController,
                        decoration: const InputDecoration(
                          labelText: 'Nombre del Titular',
                          hintText: 'Juan Pérez',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Ingresa el nombre del titular';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),

                      TextFormField(
                        controller: _bankController,
                        decoration: const InputDecoration(
                          labelText: 'Banco',
                          hintText: 'Banco Unión',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Ingresa el nombre del banco';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),

                      TextFormField(
                        controller: _amountController,
                        decoration: const InputDecoration(
                          labelText: 'Monto a Retirar (Bs.)',
                          hintText: '100.00',
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.numberWithOptions(decimal: true),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Ingresa el monto';
                          }
                          final amount = double.tryParse(value);
                          if (amount == null || amount <= 0) {
                            return 'Monto inválido';
                          }
                          if (amount > 150.50) { // TODO: Validar contra saldo real
                            return 'Monto excede el saldo disponible';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 24),

                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _submitWithdrawal,
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            backgroundColor: Theme.of(context).colorScheme.primary,
                            foregroundColor: Colors.white,
                          ),
                          child: const Text('Solicitar Retiro'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Historial de retiros
            Text(
              'Historial de Retiros',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            _buildWithdrawalHistory(),
          ],
        ),
      ),
    );
  }

  Widget _buildWithdrawalHistory() {
    final withdrawals = [
      {'date': '2024-01-31', 'amount': 200.00, 'status': 'Aprobado', 'period': 'Mensual'},
      {'date': '2023-12-31', 'amount': 500.00, 'status': 'Aprobado', 'period': 'Anual'},
      {'date': '2023-11-30', 'amount': 150.00, 'status': 'Pendiente', 'period': 'Mensual'},
    ];

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: withdrawals.length,
      itemBuilder: (context, index) {
        final withdrawal = withdrawals[index];
        return Card(
          child: ListTile(
            leading: Icon(
              withdrawal['status'] == 'Aprobado' ? Icons.check_circle : Icons.pending,
              color: withdrawal['status'] == 'Aprobado' ? Colors.green : Colors.orange,
            ),
            title: Text('Bs. ${(withdrawal['amount'] as double).toStringAsFixed(2)}'),
            subtitle: Text('${withdrawal['period']} - ${withdrawal['date']}'),
            trailing: Text(
              withdrawal['status'] as String,
              style: TextStyle(
                color: withdrawal['status'] == 'Aprobado' ? Colors.green : Colors.orange,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      },
    );
  }
}