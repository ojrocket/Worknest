import 'package:flutter/material.dart';

class CallsScreen extends StatelessWidget {
  const CallsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final callSections = [
      {
        'header': 'Today',
        'calls': [
          {'name': 'Alex', 'time': '10:45 AM', 'type': 'incoming', 'duration': '5 min'},
          {'name': 'Sarah', 'time': '9:20 AM', 'type': 'missed', 'duration': ''},
          {'name': 'Work Group', 'time': '8:00 AM', 'type': 'video', 'duration': '32 min'},
        ],
      },
      {
        'header': 'Yesterday',
        'calls': [
          {'name': 'Mom', 'time': '8:15 PM', 'type': 'outgoing', 'duration': '12 min'},
          {'name': 'Design Team', 'time': '4:30 PM', 'type': 'video', 'duration': '45 min'},
          {'name': 'Raj', 'time': '2:00 PM', 'type': 'incoming', 'duration': '3 min'},
          {'name': 'Alex', 'time': '11:00 AM', 'type': 'missed', 'duration': ''},
        ],
      },
      {
        'header': 'This Week',
        'calls': [
          {'name': 'HR Helpdesk', 'time': 'Tue, 3:10 PM', 'type': 'outgoing', 'duration': '8 min'},
          {'name': 'Priya', 'time': 'Mon, 6:45 PM', 'type': 'incoming', 'duration': '22 min'},
          {'name': 'IT Support', 'time': 'Mon, 10:00 AM', 'type': 'missed', 'duration': ''},
        ],
      },
    ];

    return Scaffold(
      body: ListView.builder(
        itemCount: callSections.length,
        itemBuilder: (context, sectionIndex) {
          final section = callSections[sectionIndex];
          final calls = section['calls'] as List<Map<String, String>>;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Section header
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                child: Text(
                  section['header'] as String,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[600],
                    letterSpacing: 0.5,
                  ),
                ),
              ),
              ...calls.map((call) => _CallTile(call: call)),
              if (sectionIndex < callSections.length - 1)
                const Divider(height: 1),
            ],
          );
        },
      ),
    );
  }
}

class _CallTile extends StatelessWidget {
  final Map<String, String> call;
  const _CallTile({required this.call});

  @override
  Widget build(BuildContext context) {
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

    final isMissed = call['type'] == 'missed';

    return ListTile(
      leading: CircleAvatar(
        radius: 24,
        backgroundColor: Colors.grey[200],
        child: const Icon(Icons.person, color: Colors.grey),
      ),
      title: Text(
        call['name']!,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: isMissed ? Colors.red : null,
        ),
      ),
      subtitle: Row(
        children: [
          Icon(icon, size: 16, color: color),
          const SizedBox(width: 4),
          Text(call['time']!),
          if (call['duration']!.isNotEmpty) ...[
            const Text(' • '),
            Text(call['duration']!, style: const TextStyle(fontSize: 12)),
          ],
        ],
      ),
      trailing: IconButton(
        icon: Icon(
          call['type'] == 'video' ? Icons.videocam : Icons.call,
          color: Theme.of(context).colorScheme.primary,
        ),
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Calling ${call['name']}...')),
          );
        },
      ),
    );
  }
}
