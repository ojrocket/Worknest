import 'package:flutter/material.dart';
import 'chat_room_screen.dart';
import '../services/chat_service.dart';

class GroupsScreen extends StatelessWidget {
  const GroupsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final groups = [
      {
        'name': 'Office Announcements',
        'members': '125 members',
        'lastMsg': 'HR: New policy document shared',
        'time': '10:30 AM',
        'unread': '3',
        'color': Colors.indigo,
        'initial': 'OA',
      },
      {
        'name': 'Wellness Circle',
        'members': '42 members',
        'lastMsg': 'Priya: Yoga session at 5 PM today 🧘',
        'time': '9:45 AM',
        'unread': '1',
        'color': Colors.teal,
        'initial': 'WC',
      },
      {
        'name': 'Tech Talk',
        'members': '89 members',
        'lastMsg': 'Raj: Flutter 4.0 migration notes attached',
        'time': '9:00 AM',
        'unread': '12',
        'color': Colors.deepPurple,
        'initial': 'TT',
      },
      {
        'name': 'Lunch Buddies',
        'members': '15 members',
        'lastMsg': 'Sam: Anyone up for Thai food? 🍜',
        'time': 'Yesterday',
        'unread': '0',
        'color': Colors.orange,
        'initial': 'LB',
      },
      {
        'name': 'Design Sprint',
        'members': '8 members',
        'lastMsg': 'You: Updated the wireframes',
        'time': 'Yesterday',
        'unread': '0',
        'color': Colors.pink,
        'initial': 'DS',
      },
      {
        'name': 'Project Alpha',
        'members': '34 members',
        'lastMsg': 'Mike: Sprint review at 3 PM',
        'time': 'Tuesday',
        'unread': '5',
        'color': Colors.green,
        'initial': 'PA',
      },
      {
        'name': 'Remote Workers',
        'members': '67 members',
        'lastMsg': 'Anita: VPN issues anyone? 🔧',
        'time': 'Monday',
        'unread': '0',
        'color': Colors.blueGrey,
        'initial': 'RW',
      },
      {
        'name': 'Fun & Games',
        'members': '53 members',
        'lastMsg': 'Leo: Friday quiz night is on! 🎉',
        'time': 'Monday',
        'unread': '8',
        'color': Colors.amber,
        'initial': 'FG',
      },
    ];

    // Ensure each group exists in ChatService so the chat room works
    final chatService = ChatService();
    for (final group in groups) {
      chatService.ensureChat(
        group['name'] as String,
        initialMessages: _getGroupMessages(group['name'] as String),
      );
    }

    return Scaffold(
      body: ListView.separated(
        itemCount: groups.length,
        separatorBuilder: (context, index) =>
            const Divider(indent: 72, height: 1),
        itemBuilder: (context, i) {
          final group = groups[i];
          final hasUnread =
              group['unread'] != '0' && group['unread'] != null;
          return ListTile(
            leading: CircleAvatar(
              radius: 26,
              backgroundColor: (group['color'] as Color).withOpacity(0.15),
              child: Text(
                group['initial'] as String,
                style: TextStyle(
                  color: group['color'] as Color,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
            title: Text(group['name'] as String,
                style: TextStyle(
                  fontWeight: hasUnread ? FontWeight.bold : FontWeight.w500,
                )),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  group['lastMsg'] as String,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: hasUnread ? Colors.black87 : Colors.grey,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  '${group['members']}',
                  style: const TextStyle(fontSize: 11, color: Colors.grey),
                ),
              ],
            ),
            isThreeLine: true,
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(group['time'] as String,
                    style: TextStyle(
                        color: hasUnread
                            ? const Color(0xFF25D366)
                            : Colors.grey,
                        fontSize: 12)),
                if (hasUnread)
                  Container(
                    margin: const EdgeInsets.only(top: 4),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
                    decoration: BoxDecoration(
                      color: const Color(0xFF25D366),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(group['unread'] as String,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            fontWeight: FontWeight.bold)),
                  ),
              ],
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      ChatRoomScreen(chatName: group['name'] as String),
                ),
              );
            },
          );
        },
      ),
    );
  }

  /// Pre-populated messages for each group chat
  List<Map<String, dynamic>> _getGroupMessages(String groupName) {
    switch (groupName) {
      case 'Office Announcements':
        return [
          {'text': 'Good morning everyone! 🌟', 'isSelf': false, 'isEncrypted': true, 'type': 'text'},
          {'text': 'Reminder: All team leads meeting at 11 AM', 'isSelf': false, 'isEncrypted': true, 'type': 'text'},
          {'text': 'New policy document has been shared on the portal', 'isSelf': false, 'isEncrypted': true, 'type': 'text'},
          {'text': 'Thanks for the update!', 'isSelf': true, 'isEncrypted': true, 'type': 'text'},
        ];
      case 'Wellness Circle':
        return [
          {'text': 'Yoga session at 5 PM today! 🧘', 'isSelf': false, 'isEncrypted': true, 'type': 'text'},
          {'text': 'Count me in!', 'isSelf': true, 'isEncrypted': true, 'type': 'text'},
          {'text': 'Also, hydration reminder — drink water 💧', 'isSelf': false, 'isEncrypted': true, 'type': 'text'},
        ];
      case 'Tech Talk':
        return [
          {'text': 'Has anyone tried the new Flutter 4.0 preview?', 'isSelf': false, 'isEncrypted': true, 'type': 'text'},
          {'text': 'Yes! The Impeller renderer is amazing', 'isSelf': true, 'isEncrypted': true, 'type': 'text'},
          {'text': 'I\'ll share the migration notes today', 'isSelf': false, 'isEncrypted': true, 'type': 'text'},
          {'text': 'Flutter 4.0 migration notes attached 📎', 'isSelf': false, 'isEncrypted': true, 'type': 'text'},
        ];
      case 'Lunch Buddies':
        return [
          {'text': 'What\'s for lunch today? 🍕', 'isSelf': false, 'isEncrypted': true, 'type': 'text'},
          {'text': 'Anyone up for Thai food? 🍜', 'isSelf': false, 'isEncrypted': true, 'type': 'text'},
          {'text': 'I\'m in! Let\'s go at 12:30', 'isSelf': true, 'isEncrypted': true, 'type': 'text'},
        ];
      case 'Design Sprint':
        return [
          {'text': 'Wireframes v2 are ready for review', 'isSelf': false, 'isEncrypted': true, 'type': 'text'},
          {'text': 'Looks great! Love the new nav flow', 'isSelf': false, 'isEncrypted': true, 'type': 'text'},
          {'text': 'Updated the wireframes with feedback', 'isSelf': true, 'isEncrypted': true, 'type': 'text'},
        ];
      case 'Project Alpha':
        return [
          {'text': 'Sprint planning starts at 10 AM', 'isSelf': false, 'isEncrypted': true, 'type': 'text'},
          {'text': 'I\'ve updated the backlog', 'isSelf': true, 'isEncrypted': true, 'type': 'text'},
          {'text': 'Sprint review at 3 PM — be prepared!', 'isSelf': false, 'isEncrypted': true, 'type': 'text'},
        ];
      case 'Remote Workers':
        return [
          {'text': 'Anyone else facing VPN issues? 🔧', 'isSelf': false, 'isEncrypted': true, 'type': 'text'},
          {'text': 'Yes, been down since morning', 'isSelf': true, 'isEncrypted': true, 'type': 'text'},
          {'text': 'IT team is on it, ETA 30 min', 'isSelf': false, 'isEncrypted': true, 'type': 'text'},
        ];
      case 'Fun & Games':
        return [
          {'text': 'Friday quiz night is ON! 🎉', 'isSelf': false, 'isEncrypted': true, 'type': 'text'},
          {'text': 'What\'s the theme this week?', 'isSelf': true, 'isEncrypted': true, 'type': 'text'},
          {'text': 'Movie trivia! 🎬🍿', 'isSelf': false, 'isEncrypted': true, 'type': 'text'},
          {'text': 'I\'m in! Prepare to lose 😎', 'isSelf': true, 'isEncrypted': true, 'type': 'text'},
        ];
      default:
        return [];
    }
  }
}
