import 'package:flutter/material.dart';

class GroupsScreen extends StatelessWidget {
  const GroupsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final groups = [
      {'name': 'Office Announcements', 'members': '125 members', 'status': 'Official'},
      {'name': 'Wellness Circle', 'members': '42 members', 'status': 'Community'},
      {'name': 'Tech Talk', 'members': '89 members', 'status': 'Public'},
      {'name': 'Lunch Buddies', 'members': '15 members', 'status': 'Private'},
    ];

    return Scaffold(
      body: ListView.separated(
        itemCount: groups.length,
        separatorBuilder: (context, index) => const Divider(indent: 72, height: 1),
        itemBuilder: (context, i) {
          final group = groups[i];
          return ListTile(
            leading: CircleAvatar(
              radius: 24,
              backgroundColor: Colors.teal[100],
              child: const Icon(Icons.groups, color: Colors.teal),
            ),
            title: Text(group['name']!, style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text('${group['members']} • ${group['status']}'),
            trailing: const Icon(Icons.chevron_right, color: Colors.grey),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Opening ${group['name']}')));
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.group_add),
      ),
    );
  }
}
