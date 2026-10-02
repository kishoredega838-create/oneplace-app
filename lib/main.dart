import 'package:flutter/material.dart';

void main() {
  runApp(const OnePlaceApp());
}

class OnePlaceApp extends StatelessWidget {
  const OnePlaceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'OnePlace',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.indigo,
        brightness: Brightness.light,
      ),
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = const [
    HomeTab(),
    Center(child: Text('Notes Page 📝', style: TextStyle(fontSize: 20))),
    Center(child: Text('Tasks Page ✅', style: TextStyle(fontSize: 20))),
    Center(child: Text('Money & Finances 💰', style: TextStyle(fontSize: 20))),
    Center(child: Text('Profile Settings 👤', style: TextStyle(fontSize: 20))),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'OnePlace',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.notes_outlined),
            selectedIcon: Icon(Icons.notes),
            label: 'Notes',
          ),
          NavigationDestination(
            icon: Icon(Icons.task_alt_outlined),
            selectedIcon: Icon(Icons.task_alt),
            label: 'Tasks',
          ),
          NavigationDestination(
            icon: Icon(Icons.account_balance_wallet_outlined),
            selectedIcon: Icon(Icons.account_balance_wallet),
            label: 'Money',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Good Morning 👋',
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 6),
          const Text(
            'Your life, organized in one place.',
            style: TextStyle(fontSize: 15, color: Colors.grey),
          ),
          const SizedBox(height: 25),
          Row(
            children: [
              Expanded(
                child: _infoCard(icon: Icons.check_circle_outline, title: 'Tasks', value: '3'),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _infoCard(icon: Icons.account_balance_wallet_outlined, title: 'Expenses', value: '₹450'),
              ),
            ],
          ),
          const SizedBox(height: 28),
          const Text('Quick Actions', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 14),
          Row(
            children: [
              _actionButton(Icons.note_add_outlined, 'Note'),
              const SizedBox(width: 10),
              _actionButton(Icons.add_task, 'Task'),
              const SizedBox(width: 10),
              _actionButton(Icons.currency_rupee, 'Expense'),
            ],
          ),
          const SizedBox(height: 28),
          const Text('Recent Notes', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          const Card(
            elevation: 0.5,
            child: ListTile(
              leading: Icon(Icons.note_outlined),
              title: Text('Welcome to OnePlace'),
              subtitle: Text('Your personal life assistant'),
              trailing: Icon(Icons.arrow_forward_ios, size: 14),
            ),
          ),
        ],
      ),
    );
  }

  static Widget _infoCard({required IconData icon, required String title, required String value}) {
    return Card(
      elevation: 0.5,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
        child: Column(
          children: [
            Icon(icon, size: 28),
            const SizedBox(height: 8),
            Text(title, style: const TextStyle(color: Colors.black54)),
            const SizedBox(height: 4),
            Text(value, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  static Widget _actionButton(IconData icon, String title) {
    return Expanded(
      child: Card(
        elevation: 0.5,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 14),
          child: Column(
            children: [
              Icon(icon),
              const SizedBox(height: 6),
              Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
            ],
          ),
        ),
      ),
    );
  }
}
