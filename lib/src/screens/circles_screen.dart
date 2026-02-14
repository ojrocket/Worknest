import 'package:flutter/material.dart';
import 'chat_room_screen.dart';
import '../services/chat_service.dart';

class CirclesScreen extends StatefulWidget {
  const CirclesScreen({super.key});

  @override
  State<CirclesScreen> createState() => _CirclesScreenState();
}

class _CirclesScreenState extends State<CirclesScreen> {
  final ChatService _chatService = ChatService();

  void _refresh() {
    if (mounted) setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _chatService.addListener(_refresh);
  }

  @override
  void dispose() {
    _chatService.removeListener(_refresh);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final chats = _chatService.chats;

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

