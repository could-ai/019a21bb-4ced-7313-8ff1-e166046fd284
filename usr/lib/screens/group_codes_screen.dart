import 'package:flutter/material.dart';

class GroupCodesScreen extends StatefulWidget {
  const GroupCodesScreen({super.key});

  @override
  State<GroupCodesScreen> createState() => _GroupCodesScreenState();
}

class _GroupCodesScreenState extends State<GroupCodesScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _targetController = TextEditingController();

  // Datos simulados de códigos grupales
  final List<Map<String, dynamic>> _groupCodes = [
    {
      'code': 'GRUPO001',
      'name': 'Boda Ana y Carlos',
      'description': 'Ahorro para luna de miel',
      'target': 5000.0,
      'current': 1250.0,
      'participants': 15,
      'endDate': '2024-12-31',
    },
    {
      'code': 'PAREJA2024',
      'name': 'Viaje de Graduación',
      'description': 'Ahorro grupal para viaje',
      'target': 3000.0,
      'current': 850.0,
      'participants': 8,
      'endDate': '2024-07-15',
    },
  ];

  void _createGroupCode() {
    if (_formKey.currentState!.validate()) {
      // TODO: Implementar creación real de código grupal
      final newCode = {
        'code': 'GRUPO${DateTime.now().millisecondsSinceEpoch.toString().substring(8)}',
        'name': _nameController.text,
        'description': _descriptionController.text,
        'target': double.tryParse(_targetController.text) ?? 0.0,
        'current': 0.0,
        'participants': 1,
        'endDate': '2024-12-31', // Fecha por defecto
      };

      setState(() {
        _groupCodes.add(newCode);
      });

      // Limpiar formulario
      _nameController.clear();
      _descriptionController.clear();
      _targetController.clear();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Código grupal creado: ${newCode['code']}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Códigos Grupales'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Crear Código Grupal',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            const Text(
              'Crea códigos para metas grupales como bodas, viajes o ahorros compartidos',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 16),

            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      labelText: 'Nombre del Grupo',
                      hintText: 'Ej: Boda Ana y Carlos',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Ingresa un nombre para el grupo';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),

                  TextFormField(
                    controller: _descriptionController,
                    decoration: const InputDecoration(
                      labelText: 'Descripción',
                      hintText: '¿Cuál es la meta del grupo?',
                      border: OutlineInputBorder(),
                    ),
                    maxLines: 2,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Ingresa una descripción';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),

                  TextFormField(
                    controller: _targetController,
                    decoration: const InputDecoration(
                      labelText: 'Meta de Ahorro (Bs.)',
                      hintText: '5000',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Ingresa la meta de ahorro';
                      }
                      final amount = double.tryParse(value);
                      if (amount == null || amount <= 0) {
                        return 'Ingresa un monto válido';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 24),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _createGroupCode,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: const Text('Crear Código Grupal'),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),
            Text(
              'Mis Códigos Grupales',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),

            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _groupCodes.length,
              itemBuilder: (context, index) {
                final code = _groupCodes[index];
                final progress = (code['current'] / code['target']).clamp(0.0, 1.0);

                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              code['code'],
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.share),
                              onPressed: () {
                                // TODO: Implementar compartir código
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Compartir código: ${code['code']}')),
                                );
                              },
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          code['name'],
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          code['description'],
                          style: const TextStyle(color: Colors.grey),
                        ),
                        const SizedBox(height: 16),
                        LinearProgressIndicator(
                          value: progress,
                          backgroundColor: Colors.grey[300],
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Theme.of(context).colorScheme.primary,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Bs. ${code['current']} / Bs. ${code['target']}'),
                            Text('${code['participants']} participantes'),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showCreateDialog(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showCreateDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          left: 16,
          right: 16,
          top: 16,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Crear Nuevo Código Grupal',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            // El formulario ya está arriba, aquí podríamos duplicar o simplificar
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                // Scroll to top o mostrar mensaje
              },
              child: const Text('Ir al formulario'),
            ),
          ],
        ),
      ),
    );
  }
}