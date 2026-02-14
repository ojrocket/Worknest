import 'package:flutter/material.dart';

class CallsScreen extends StatelessWidget {
  const CallsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final calls = [
      {'name': 'Alex', 'time': 'Today, 10:45 AM', 'type': 'incoming'},
      {'name': 'Sarah', 'time': 'Yesterday, 6:30 PM', 'type': 'missed'},
      {'name': 'Work Group', 'time': 'Yesterday, 2:00 PM', 'type': 'video'},
      {'name': 'Mom', 'time': 'Monday, 8:15 PM', 'type': 'outgoing'},
    ];

    return Scaffold(
      body: ListView.separated(
        itemCount: calls.length,
        separatorBuilder: (context, index) => const Divider(indent: 72, height: 1),
        itemBuilder: (context, i) {
          final call = calls[i];
          IconData icon;
          Color color;
          
          switch (call['type']) {
            case 'incoming':
              icon = Icons.call_received;
              color = Colors.green;
              break;
            case 'missed':
              icon = Icons.call_missed;
              color = Colors.red;
              break;
            case 'outgoing':
              icon = Icons.call_made;
              color = Colors.green;
              break;
            case 'video':
              icon = Icons.videocam;
              color = Colors.blue;
              break;
            default:
              icon = Icons.call;
              color = Colors.grey;
          }

          return ListTile(
            leading: CircleAvatar(
              radius: 24,
              backgroundImage: null, // Could add placeholder images
              backgroundColor: Colors.grey[300],
              child: const Icon(Icons.person, color: Colors.white),
            ),
            title: Text(call['name']!, style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Row(
              children: [
                Icon(icon, size: 16, color: color),
                const SizedBox(width: 4),
                Text(call['time']!),
              ],
            ),
            trailing: IconButton(
              icon: Icon(call['type'] == 'video' ? Icons.videocam : Icons.call, color: Theme.of(context).colorScheme.primary),
              onPressed: () {},
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add_call),
      ),
    );
  }
}
