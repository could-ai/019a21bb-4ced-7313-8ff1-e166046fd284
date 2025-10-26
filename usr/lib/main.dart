import 'package:flutter/material.dart';
import 'screens/registration_screen.dart';
import 'screens/dashboard_screen.dart';
import 'screens/group_codes_screen.dart';
import 'screens/savings_cup_screen.dart';
import 'screens/withdrawal_screen.dart';

import 'models/user.dart';

void main() {
  runApp(const PlussApp());
}

class PlussApp extends StatelessWidget {
  const PlussApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pluss - Cashback Inteligente',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF4CAF50), // Verde para representar ahorro
          brightness: Brightness.light,
        ),
        useMaterial3: true,
        fontFamily: 'Roboto',
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          elevation: 0,
        ),
        cardTheme: CardTheme(
          elevation: 4,
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      home: const MainNavigation(),
    );
  }
}

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _selectedIndex = 0;
  User? _currentUser;

  // Simulación de usuario logueado (se reemplazará con autenticación real)
  final User _mockUser = User(
    id: '1',
    carnetNumber: '123456789',
    name: 'Juan Pérez',
    email: 'juan@example.com',
    walletBalance: 150.50,
    isMinor: false,
    groupCodes: ['GRUPO001', 'PAREJA2024'],
  );

  late final List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    // Simular login automático para desarrollo
    _currentUser = _mockUser;
    _screens = [
      DashboardScreen(user: _currentUser!),
      const GroupCodesScreen(),
      const SavingsCupScreen(),
      const WithdrawalScreen(),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_currentUser == null) {
      return const RegistrationScreen();
    }

    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.group),
            label: 'Códigos Grupales',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.emoji_events),
            label: 'Savings Cup',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_balance_wallet),
            label: 'Retiros',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Theme.of(context).colorScheme.primary,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}