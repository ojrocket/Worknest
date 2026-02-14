import 'package:flutter/material.dart';
import 'chat_room_screen.dart';

class CirclesScreen extends StatelessWidget {
  const CirclesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> chats = [
      {'name': 'Alex', 'message': 'Hey, how is the project?', 'time': '10:30 AM', 'unread': '2'},
      {'name': 'Sarah', 'message': 'See you tomorrow!', 'time': '9:15 AM', 'unread': '0'},
      {'name': 'Work Group', 'message': 'Meeting at 2 PM', 'time': 'Yesterday', 'unread': '5'},
      {'name': 'John', 'message': 'Got it, thanks!', 'time': 'Wednesday', 'unread': '0'},
      {'name': 'Design Team', 'message': 'New mockups are ready', 'time': 'Tuesday', 'unread': '0'},
      {'name': 'Mom', 'message': 'Call me later', 'time': 'Monday', 'unread': '1'},
    ];

    return Scaffold(
      body: ListView.separated(
        itemCount: chats.length,
        separatorBuilder: (context, index) => const Divider(indent: 72, height: 1),
        itemBuilder: (context, i) {
          final chat = chats[i];
          return ListTile(
            leading: CircleAvatar(
              radius: 24,
              backgroundColor: Colors.grey[300],
              child: const Icon(Icons.person, color: Colors.white, size: 30),
            ),
            title: Text(chat['name']!, style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text(chat['message']!, maxLines: 1, overflow: TextOverflow.ellipsis),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(chat['time']!, style: TextStyle(color: chat['unread'] != '0' ? const Color(0xFF25D366) : Colors.grey, fontSize: 12)),
                if (chat['unread'] != '0')
                  Container(
                    margin: const EdgeInsets.only(top: 4),
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(color: const Color(0xFF25D366), shape: BoxShape.circle),
                    child: Text(chat['unread']!, style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                  ),
              ],
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ChatRoomScreen(chatName: chat['name']!)),
              );
            },
          );
        },
      ),
    );
  }
}

const Box_Circle = BoxShape.circle;

