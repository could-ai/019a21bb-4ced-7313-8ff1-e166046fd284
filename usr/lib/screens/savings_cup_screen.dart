import 'package:flutter/material.dart';

class SavingsCupScreen extends StatelessWidget {
  const SavingsCupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Savings Cup'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Theme.of(context).colorScheme.primary,
                    Theme.of(context).colorScheme.secondary,
                  ],
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.emoji_events,
                        color: Colors.white,
                        size: 32,
                      ),
                      const SizedBox(width: 12),
                      Text(
                        'Copa Intercolegial del Ahorro',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    '¡Participa y gana premios por ahorrar más!',
                    style: TextStyle(color: Colors.white70),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Inscripción
            Text(
              'Inscripción',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Para participar en el Savings Cup, necesitas:',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 12),
                    _RequirementItem(
                      icon: Icons.school,
                      text: 'Ser estudiante de colegio',
                    ),
                    _RequirementItem(
                      icon: Icons.group,
                      text: '1-3 representantes mayores de edad del curso',
                    ),
                    _RequirementItem(
                      icon: Icons.assignment_turned_in,
                      text: 'Aceptar términos y condiciones',
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          // TODO: Implementar formulario de inscripción
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Formulario de inscripción próximamente')),
                          );
                        },
                        child: const Text('Inscribir mi Curso'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Ranking
            Text(
              'Ranking Actual',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            _buildRankingList(),
            const SizedBox(height: 24),

            // Premios
            Text(
              'Premios',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            _buildPrizesList(),
          ],
        ),
      ),
    );
  }

  Widget _buildRankingList() {
    final rankings = [
      {'position': 1, 'school': 'Colegio Nacional', 'amount': 2500.0},
      {'position': 2, 'school': 'Liceo América', 'amount': 2100.0},
      {'position': 3, 'school': 'Instituto Moderno', 'amount': 1950.0},
      {'position': 4, 'school': 'Colegio San José', 'amount': 1800.0},
      {'position': 5, 'school': 'Escuela República', 'amount': 1650.0},
    ];

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: rankings.length,
      itemBuilder: (context, index) {
        final rank = rankings[index];
        return Card(
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: _getPositionColor(rank['position'] as int),
              child: Text(
                '${rank['position']}',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            title: Text(rank['school'] as String),
            trailing: Text(
              'Bs. ${(rank['amount'] as double).toStringAsFixed(0)}',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildPrizesList() {
    final prizes = [
      {'position': '1er Lugar', 'prize': 'Tablet + Diploma', 'value': 'Bs. 2,000'},
      {'position': '2do Lugar', 'prize': 'Smartphone + Diploma', 'value': 'Bs. 1,500'},
      {'position': '3er Lugar', 'prize': 'Auriculares + Diploma', 'value': 'Bs. 1,000'},
      {'position': 'Participación', 'prize': 'Certificado Digital', 'value': 'Bs. 0'},
    ];

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: prizes.length,
      itemBuilder: (context, index) {
        final prize = prizes[index];
        return Card(
          child: ListTile(
            title: Text(prize['position'] as String),
            subtitle: Text(prize['prize'] as String),
            trailing: Text(
              prize['value'] as String,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
          ),
        );
      },
    );
  }

  Color _getPositionColor(int position) {
    switch (position) {
      case 1:
        return Colors.amber;
      case 2:
        return Colors.grey[400]!;
      case 3:
        return Colors.brown[300]!;
      default:
        return Colors.blue;
    }
  }
}

class _RequirementItem extends StatelessWidget {
  final IconData icon;
  final String text;

  const _RequirementItem({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(icon, color: Theme.of(context).colorScheme.primary),
          const SizedBox(width: 12),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }
}