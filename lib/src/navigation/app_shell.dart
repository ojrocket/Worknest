import 'package:flutter/material.dart';
import '../screens/home_screen.dart';
import '../screens/circles_screen.dart';
import '../screens/work_screen.dart';
import '../screens/scanner_screen.dart';
import '../screens/you_screen.dart';

class AppShell extends StatefulWidget {
  const AppShell({super.key});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this, initialIndex: 1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('WorkNest', style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [
          IconButton(icon: const Icon(Icons.camera_alt_outlined), onPressed: () {}),
          IconButton(icon: const Icon(Icons.search), onPressed: () {}),
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'Home') {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const HomeScreen()));
              } else if (value == 'Work Hub') {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const WorkScreen()));
              } else if (value == 'Scanner') {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const ScannerScreen()));
              } else if (value == 'Wellbeing') {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const YouScreen()));
              }
            },
            itemBuilder: (BuildContext context) {
              return {'Home', 'Work Hub', 'Scanner', 'Wellbeing', 'Settings'}.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          indicatorWeight: 3,
          labelStyle: const TextStyle(fontWeight: FontWeight.bold),
          tabs: [
            Tab(icon: Icon(Icons.groups)),
            Tab(text: 'CHATS'),
            Tab(text: 'STATUS'),
            Tab(text: 'CALLS'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          const Center(child: Text('Communities')),
          const CirclesScreen(),
          const Center(child: Text('Status View')),
          const Center(child: Text('Calls View')),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.message),
      ),
    );
  }
}
