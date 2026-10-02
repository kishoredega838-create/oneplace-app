import 'package:flutter/material.dart';

void main() {
  runApp(const OnePlaceMasterApp());
}

class OnePlaceMasterApp extends StatefulWidget {
  const OnePlaceMasterApp({super.key});

  @override
  State<OnePlaceMasterApp> createState() => _OnePlaceMasterAppState();
}

class _OnePlaceMasterAppState extends State<OnePlaceMasterApp> {
  ThemeMode _themeMode = ThemeMode.light;

  void _toggleTheme(bool isDark) {
    setState(() {
      _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'OnePlace',
      themeMode: _themeMode,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        colorSchemeSeed: Colors.indigo,
        scaffoldBackgroundColor: const Color(0xFFF8F9FA),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorSchemeSeed: Colors.indigo,
        scaffoldBackgroundColor: const Color(0xFF121212),
      ),
      home: MainMasterScreen(
        onThemeChanged: _toggleTheme,
        isDarkMode: _themeMode == ThemeMode.dark,
      ),
    );
  }
}

class MainMasterScreen extends StatefulWidget {
  final Function(bool) onThemeChanged;
  final bool isDarkMode;

  const MainMasterScreen({
    super.key,
    required this.onThemeChanged,
    required this.isDarkMode,
  });

  @override
  State<MainMasterScreen> createState() => _MainMasterScreenState();
}

class _MainMasterScreenState extends State<MainMasterScreen> {
  int _currentIndex = 0;

  bool _isLoggedIn = true;
  String _userEmail = 'user@oneplace.io';
  String _userName = 'Kishore Dega';

  // Saved Locations
  final List<Map<String, String>> _savedLocations = [
    {
      'name': 'Primary Office',
      'address': 'Tech Hub, Sector 4, Hyderabad',
      'tag': 'Work',
      'coords': '17.4482° N, 78.3915° E'
    },
    {
      'name': 'Home Residence',
      'address': 'Plot 42, Sri Krishna Nagar',
      'tag': 'Home',
      'coords': '17.4065° N, 78.4772° E'
    },
    {
      'name': 'Central Supermarket',
      'address': 'Main Bazaar Road',
      'tag': 'Market',
      'coords': '17.4399° N, 78.4983° E'
    },
  ];

  final List<Map<String, dynamic>> _tasks = [
    {'title': 'Complete app UI design', 'done': false, 'priority': 'High', 'location': 'Primary Office'},
    {'title': 'Review monthly spending', 'done': true, 'priority': 'Medium', 'location': 'Home Residence'},
    {'title': 'Team discussion call', 'done': false, 'priority': 'Normal', 'location': 'Primary Office'},
  ];

  final List<Map<String, String>> _notes = [
    {
      'title': 'OnePlace Vision',
      'body': 'Create the most seamless, intelligent workspace app with AI life guide.',
      'date': 'Today',
      'location': 'Primary Office'
    },
    {
      'title': 'Creative Ideas',
      'body': 'Design modern interactive UI for productive workflows.',
      'date': 'Yesterday',
      'location': 'Home Residence'
    },
  ];

  final List<Map<String, dynamic>> _expenses = [
    {'title': 'Fast Food', 'amount': 320, 'category': 'Food', 'location': 'Central Supermarket'},
    {'title': 'Cloud Subscription', 'amount': 499, 'category': 'Software', 'location': 'Online'},
    {'title': 'Fuel & Travel', 'amount': 250, 'category': 'Travel', 'location': 'Main Bazaar Road'},
  ];

  // AI Assistant Chat Messages
  final List<Map<String, String>> _aiChatMessages = [
    {
      'sender': 'ai',
      'text': 'Namaskaram! Nenu mee OneAI Life Assistant ni. Mee life goals, daily planning, financial tips, leda routine gurinchi emaina adagandi, meeku toduga untanu! ✨'
    }
  ];

  final TextEditingController _aiInputController = TextEditingController();

  int get _totalExpenses => _expenses.fold(0, (sum, item) => sum + (item['amount'] as int));
  int get _pendingTasksCount => _tasks.where((t) => t['done'] == false).length;

  void _sendAIMessage(String userText) {
    if (userText.trim().isEmpty) return;
    setState(() {
      _aiChatMessages.add({'sender': 'user', 'text': userText.trim()});
    });
    _aiInputController.clear();

    // AI Response Simulation with Life Wisdom
    Future.delayed(const Duration(milliseconds: 600), () {
      String response = "Chala manchi prashna adigaru! ";
      final query = userText.toLowerCase();

      if (query.contains('money') || query.contains('save') || query.contains('expense') || query.contains('budget')) {
        response += "Financial discipline kosam '50/30/20 rule' follow avvandi: 50% avasaralaku (needs), 30% korikalaku (wants), 20% direct savings/investments ki pettandi. Mee OnePlace Money tab lo daily prathi chinna karchuni log cheyadam marvakanadi!";
      } else if (query.contains('stress') || query.contains('peace') || query.contains('sad') || query.contains('tension')) {
        response += "Jeevitham lo tension sahajame. 5 nimishalu deep breathing cheyandi, screen nunchi konchem dooram ga velli fresh ga nilabadandi. Prathi samasya ki samayam tho patu oka margam dorukuthundi, stay strong!";
      } else if (query.contains('routine') || query.contains('plan') || query.contains('productivity') || query.contains('goal')) {
        response += "Vijayavanthamaina roju kosam: Udayanne top 3 most important panulani OnePlace Tasks lo 'High Priority' ga mark chesi mundhu avi poorthi cheyandi. Consistency ee prathi success ki secret!";
      } else {
        response += "Mee alochana chala bavundi. Jeevitham lo edaina saadinchalante chinna chinna rojuvari habits chala mukhyam. Mee goals ni OnePlace lo tasks roopam lo pettukoni roju oka step mundhuku veyyandi!";
      }

      setState(() {
        _aiChatMessages.add({'sender': 'ai', 'text': response});
      });
    });
  }

  void _viewLocationDetails(BuildContext context, String locationName) {
    final loc = _savedLocations.firstWhere(
      (element) => element['name'] == locationName,
      orElse: () => {
        'name': locationName,
        'address': 'Custom tagged location point',
        'tag': 'Custom',
        'coords': '17.3850° N, 78.4867° E'
      },
    );

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Row(
          children: [
            const Icon(Icons.location_on, color: Colors.redAccent),
            const SizedBox(width: 8),
            Expanded(child: Text(loc['name']!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18))),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('GPS: ${loc['coords']!}', style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.indigo)),
            const SizedBox(height: 6),
            Text('Address: ${loc['address']!}'),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Close')),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      _buildHomeView(),
      _buildAIChatView(),
      _buildTasksView(),
      _buildMoneyView(),
      _buildLocationsHubView(),
      _buildProfileView(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('OnePlace', style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 0.5)),
        actions: [
          IconButton(
            icon: const Icon(Icons.shield_moon_outlined),
            onPressed: () => widget.onThemeChanged(!widget.isDarkMode),
          ),
        ],
      ),
      body: pages[_currentIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (idx) => setState(() => _currentIndex = idx),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.auto_awesome_outlined), selectedIcon: Icon(Icons.auto_awesome), label: 'OneAI'),
          NavigationDestination(icon: Icon(Icons.task_alt_outlined), selectedIcon: Icon(Icons.task_alt), label: 'Tasks'),
          NavigationDestination(icon: Icon(Icons.account_balance_wallet_outlined), selectedIcon: Icon(Icons.account_balance_wallet), label: 'Money'),
          NavigationDestination(icon: Icon(Icons.place_outlined), selectedIcon: Icon(Icons.place), label: 'Locations'),
          NavigationDestination(icon: Icon(Icons.person_outline), selectedIcon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }

  // 1. Home Screen
  Widget _buildHomeView() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Hello, $_userName 👋', style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          const Text('Unified Productivity, Location & AI Life Assistant.', style: TextStyle(color: Colors.grey)),
          const SizedBox(height: 20),
          Card(
            color: Colors.indigo.withAlpha(25),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: ListTile(
              leading: const Icon(Icons.auto_awesome, color: Colors.indigo, size: 28),
              title: const Text('Need Life Advice or Daily Plan?', style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: const Text('Ask OneAI anything to guide your day.'),
              trailing: const Icon(Icons.arrow_forward_ios, size: 14),
              onTap: () => setState(() => _currentIndex = 1),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: _infoCard(icon: Icons.check_circle_outline, color: Colors.teal, title: 'Tasks Due', value: '$_pendingTasksCount'),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _infoCard(icon: Icons.account_balance_wallet_outlined, color: Colors.deepOrange, title: 'Spent Total', value: '₹$_totalExpenses'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // 2. AI Assistant Chat Screen
  Widget _buildAIChatView() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          color: Colors.indigo.withAlpha(15),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                ActionChip(
                  label: const Text('💡 How to save money?'),
                  onPressed: () => _sendAIMessage('How to save money?'),
                ),
                const SizedBox(width: 8),
                ActionChip(
                  label: const Text('⚡ Boost productivity'),
                  onPressed: () => _sendAIMessage('How to boost productivity?'),
                ),
                const SizedBox(width: 8),
                ActionChip(
                  label: const Text('🌿 Dealing with stress'),
                  onPressed: () => _sendAIMessage('Give me tips for dealing with stress'),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: _aiChatMessages.length,
            itemBuilder: (ctx, i) {
              final msg = _aiChatMessages[i];
              final isAI = msg['sender'] == 'ai';
              return Align(
                alignment: isAI ? Alignment.centerLeft : Alignment.centerRight,
                child: Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(14),
                  constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.78),
                  decoration: BoxDecoration(
                    color: isAI ? (Theme.of(context).brightness == Brightness.dark ? const Color(0xFF2C2C2C) : Colors.white) : Colors.indigo,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2))],
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (isAI) ...[
                        const Icon(Icons.auto_awesome, color: Colors.indigo, size: 18),
                        const SizedBox(width: 8),
                      ],
                      Flexible(
                        child: Text(
                          msg['text']!,
                          style: TextStyle(
                            color: isAI ? (Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black87) : Colors.white,
                            fontSize: 14.5,
                            height: 1.35,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            border: Border(top: BorderSide(color: Colors.grey.withAlpha(50))),
          ),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _aiInputController,
                  decoration: const InputDecoration(
                    hintText: 'Life gurinchi emaina adagandi...',
                    border: InputBorder.none,
                  ),
                  onSubmitted: _sendAIMessage,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.send, color: Colors.indigo),
                onPressed: () => _sendAIMessage(_aiInputController.text),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // 3. Tasks Screen
  Widget _buildTasksView() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _tasks.length,
      itemBuilder: (ctx, i) => Card(
        child: CheckboxListTile(
          title: Text(_tasks[i]['title']),
          subtitle: Text('Location: ${_tasks[i]['location']}'),
          value: _tasks[i]['done'],
          onChanged: (val) => setState(() => _tasks[i]['done'] = val ?? false),
        ),
      ),
    );
  }

  // 4. Money Screen
  Widget _buildMoneyView() {
    return Column(
      children: [
        Container(
          width: double.infinity,
          margin: const EdgeInsets.all(16),
          padding: const EdgeInsets.all(22),
          decoration: BoxDecoration(
            gradient: const LinearGradient(colors: [Colors.indigo, Colors.deepPurpleAccent]),
            borderRadius: BorderRadius.circular(18),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Total Spending', style: TextStyle(color: Colors.white70)),
              const SizedBox(height: 6),
              Text('₹$_totalExpenses', style: const TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: _expenses.length,
            itemBuilder: (ctx, i) => ListTile(
              title: Text(_expenses[i]['title']),
              subtitle: Text(_expenses[i]['category']),
              trailing: Text('- ₹${_expenses[i]['amount']}', style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
            ),
          ),
        ),
      ],
    );
  }

  // 5. Locations Screen
  Widget _buildLocationsHubView() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _savedLocations.length,
      itemBuilder: (ctx, i) => Card(
        child: ListTile(
          leading: const Icon(Icons.location_on, color: Colors.indigo),
          title: Text(_savedLocations[i]['name']!),
          subtitle: Text(_savedLocations[i]['address']!),
          onTap: () => _viewLocationDetails(context, _savedLocations[i]['name']!),
        ),
      ),
    );
  }

  // 6. Profile Screen
  Widget _buildProfileView() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          CircleAvatar(
            radius: 40,
            backgroundColor: Colors.indigo,
            child: Text(_userName[0], style: const TextStyle(fontSize: 32, color: Colors.white)),
          ),
          const SizedBox(height: 10),
          Text(_userName, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          Text(_userEmail, style: const TextStyle(color: Colors.grey)),
          const SizedBox(height: 20),
          Card(
            child: SwitchListTile(
              secondary: const Icon(Icons.dark_mode_outlined),
              title: const Text('Dark Mode'),
              value: widget.isDarkMode,
              onChanged: widget.onThemeChanged,
            ),
          ),
        ],
      ),
    );
  }

  static Widget _infoCard({required IconData icon, required Color color, required String title, required String value}) {
    return Card(
      elevation: 0.4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, size: 28, color: color),
            const SizedBox(height: 10),
            Text(title, style: const TextStyle(color: Colors.grey)),
            const SizedBox(height: 4),
            Text(value, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}

          
              
