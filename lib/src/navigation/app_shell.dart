import 'package:flutter/material.dart';
import '../screens/home_screen.dart';
import '../screens/circles_screen.dart';
import '../screens/groups_screen.dart';
import '../screens/calls_screen.dart';
import '../screens/work_screen.dart';
import '../screens/tasks_screen.dart';
import '../screens/scanner_screen.dart';
import '../screens/you_screen.dart';

class AppShell extends StatefulWidget {
  const AppShell({super.key});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this, initialIndex: 1);
    _tabController.addListener(() {
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('WorkNest',
            style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
              icon: const Icon(Icons.camera_alt_outlined), onPressed: () {}),
          IconButton(icon: const Icon(Icons.search), onPressed: () {}),
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'Home') {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const HomeScreen()));
              } else if (value == 'Scanner') {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ScannerScreen()));
              } else if (value == 'Wellbeing') {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const YouScreen()));
              }
            },
            itemBuilder: (BuildContext context) {
              return {'Home', 'Scanner', 'Wellbeing', 'Settings'}
                  .map((String choice) {
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
          labelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
          tabs: const [
            Tab(text: 'GROUPS'),
            Tab(text: 'CHATS'),
            Tab(text: 'CALLS'),
            Tab(text: 'WORK'),
            Tab(text: 'TO-DO'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          GroupsScreen(),
          CirclesScreen(),
          CallsScreen(),
          WorkScreen(),
          TasksScreen(),
        ],
      ),
      floatingActionButton: _buildFab(),
    );
  }

  Widget? _buildFab() {
    switch (_tabController.index) {
      case 0:
        return FloatingActionButton(
          onPressed: () {},
          child: const Icon(Icons.group_add),
        );
      case 1:
        return FloatingActionButton(
          onPressed: () {},
          child: const Icon(Icons.message),
        );
      case 2:
        return FloatingActionButton(
          onPressed: () {},
          child: const Icon(Icons.add_call),
        );
      case 4:
        return FloatingActionButton(
          onPressed: () {},
          child: const Icon(Icons.add_task),
        );
      default:
        return null;
    }
  }
}
