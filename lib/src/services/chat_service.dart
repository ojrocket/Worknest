import 'package:flutter/foundation.dart';

class ChatService extends ChangeNotifier {
  static final ChatService _instance = ChatService._internal();

  factory ChatService() {
    return _instance;
  }

  ChatService._internal();

  final List<Map<String, dynamic>> _chats = [
    {
      'id': '1',
      'name': 'Alex',
      'message': 'Hey, how is the project?',
      'time': '10:30 AM',
      'unread': '2',
      'messages': [
        {'text': 'Hey there!', 'isSelf': false, 'isEncrypted': true, 'type': 'text'},
        {'text': 'Hello! How are you?', 'isSelf': true, 'isEncrypted': true, 'type': 'text'},
      ]
    },
    {
      'id': '2',
      'name': 'Sarah',
      'message': 'See you tomorrow!',
      'time': '9:15 AM',
      'unread': '0',
      'messages': []
    },
    {
      'id': '3',
      'name': 'Work Group',
      'message': 'Meeting at 2 PM',
      'time': 'Yesterday',
      'unread': '5',
      'messages': []
    },
     {
      'id': '4',
      'name': 'Design Team',
      'message': 'New mockups are ready',
      'time': 'Tuesday',
      'unread': '0',
      'messages': []
    },
  ];

  List<Map<String, dynamic>> get chats => _chats;

  List<Map<String, dynamic>> getMessages(String chatName) {
    final chat = _chats.firstWhere((c) => c['name'] == chatName, orElse: () => {});
    if (chat.isNotEmpty) {
      return List<Map<String, dynamic>>.from(chat['messages']);
    }
    return [];
  }

  void sendMessage(String chatName, String text, {String type = 'text', String? path}) {
    final index = _chats.indexWhere((c) => c['name'] == chatName);
    if (index != -1) {
      final newMessage = {
        'text': text,
        'isSelf': true,
        'isEncrypted': type == 'text',
        'type': type,
        if (path != null) 'path': path, // For files/images
      };
      
      // Add to messages list
      (_chats[index]['messages'] as List).add(newMessage);
      
      // Update snippet
      _chats[index]['message'] = type == 'text' ? text : 'Sent a file';
      _chats[index]['time'] = 'Now';
      
      notifyListeners();
    }
  }

  void sendPdf(String chatName, String fileName) {
    sendMessage(chatName, '📄 Shared PDF: $fileName', type: 'file', path: fileName);
  }
}
