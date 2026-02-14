import 'package:flutter/material.dart';
import '../services/encryption_service.dart';
import '../app_theme.dart';

class ChatRoomScreen extends StatefulWidget {
  final String chatName;
  const ChatRoomScreen({super.key, required this.chatName});

  @override
  State<ChatRoomScreen> createState() => _ChatRoomScreenState();
}

class _ChatRoomScreenState extends State<ChatRoomScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, dynamic>> _messages = [
    {'text': 'Hey there!', 'isSelf': false, 'isEncrypted': true},
    {'text': 'Hello! How are you?', 'isSelf': true, 'isEncrypted': true},
  ];

  void _sendMessage() {
    if (_controller.text.trim().isEmpty) return;
    
    // In a real app, we would encrypt before sending to server
    // Here we show the "encrypted" state for demo
    final plainText = _controller.text;
    final encrypted = EncryptionService.encryptMessage(plainText);
    
    setState(() {
      _messages.add({
        'text': plainText, // Store plain for local display
        'isSelf': true,
        'encryptedText': encrypted,
        'isEncrypted': true,
      });
      _controller.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: Row(
          children: [
            const CircleAvatar(radius: 18, child: Icon(Icons.person, size: 20)),
            const SizedBox(width: 8),
            Text(widget.chatName, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ],
        ),
        actions: [
          IconButton(icon: const Icon(Icons.videocam), onPressed: () {}),
          IconButton(icon: const Icon(Icons.call), onPressed: () {}),
          IconButton(icon: const Icon(Icons.more_vert), onPressed: () {}),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          color: AppColors.chatBackground,
          image: DecorationImage(
            image: NetworkImage('https://user-images.githubusercontent.com/15075759/28719144-86dc0f70-73b1-11e7-911d-60d70fcded21.png'),
            fit: BoxFit.cover,

            opacity: 0.08,
          ),
        ),

        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  final msg = _messages[index];
                  return _ChatBubble(
                    text: msg['text'],
                    isSelf: msg['isSelf'],
                    isEncrypted: msg['isEncrypted'],
                  );
                },
              ),
            ),
            _buildInputArea(),
          ],
        ),
      ),
    );
  }

  Widget _buildInputArea() {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
              ),
              child: Row(
                children: [
                  IconButton(icon: const Icon(Icons.emoji_emotions_outlined, color: Colors.grey), onPressed: () {}),
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      decoration: const InputDecoration(
                        hintText: 'Message',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  IconButton(icon: const Icon(Icons.attach_file, color: Colors.grey), onPressed: () {}),
                  IconButton(icon: const Icon(Icons.camera_alt, color: Colors.grey), onPressed: () {}),
                ],
              ),
            ),
          ),
          const SizedBox(width: 8),
          CircleAvatar(
            backgroundColor: const Color(0xFF128C7E),
            radius: 24,
            child: IconButton(
              icon: const Icon(Icons.send, color: Colors.white),
              onPressed: _sendMessage,
            ),
          ),
        ],
      ),
    );
  }
}

class _ChatBubble extends StatelessWidget {
  final String text;
  final bool isSelf;
  final bool isEncrypted;

  const _ChatBubble({required this.text, required this.isSelf, this.isEncrypted = false});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isSelf ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.75),
        decoration: BoxDecoration(
          color: isSelf ? AppColors.bubbleSelf : AppColors.bubbleOther,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(12),
            topRight: const Radius.circular(12),
            bottomLeft: isSelf ? const Radius.circular(12) : Radius.zero,
            bottomRight: isSelf ? Radius.zero : const Radius.circular(12),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 2,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(text, style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 2),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (isEncrypted)
                  const Icon(Icons.lock_outline, size: 10, color: Colors.grey),
                const SizedBox(width: 4),
                const Text('12:00 PM', style: TextStyle(fontSize: 10, color: Colors.grey)),
                if (isSelf) ...[
                  const SizedBox(width: 4),
                  const Icon(Icons.done_all, size: 14, color: Colors.blue),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}
