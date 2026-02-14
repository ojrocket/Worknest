import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart'; // for kIsWeb
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import '../services/encryption_service.dart';
import '../services/chat_service.dart';
import '../app_theme.dart';

class ChatRoomScreen extends StatefulWidget {
  final String chatName;
  const ChatRoomScreen({super.key, required this.chatName});

  @override
  State<ChatRoomScreen> createState() => _ChatRoomScreenState();
}

class _ChatRoomScreenState extends State<ChatRoomScreen> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final ImagePicker _picker = ImagePicker();
  final ChatService _chatService = ChatService();
  List<Map<String, dynamic>> _messages = [];

  void _refresh() {
    if (mounted) {
      setState(() {
        _messages = _chatService.getMessages(widget.chatName);
      });
      _scrollToBottom();
    }
  }

  @override
  void initState() {
    super.initState();
    _chatService.addListener(_refresh);
    _messages = _chatService.getMessages(widget.chatName);
    WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());
  }

  @override
  void dispose() {
    _chatService.removeListener(_refresh);
    super.dispose();
  }

  void _sendMessage() {
    if (_controller.text.trim().isEmpty) return;
    
    final plainText = _controller.text;
    
    _chatService.sendMessage(widget.chatName, plainText);
    _controller.clear();
  }

  Future<void> _sendImage(ImageSource source) async {
    try {
      final XFile? photo = await _picker.pickImage(source: source);
      if (photo != null) {
        _chatService.sendMessage(widget.chatName, '📷 Image', type: 'image', path: photo.path);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error picking image: $e')));
    }
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
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
        ),

        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  final msg = _messages[index];
                  return _ChatBubble(
                    text: msg['text'],
                    isSelf: msg['isSelf'],
                    isEncrypted: msg['isEncrypted'] ?? false,
                    type: msg['type'] ?? 'text',
                    imagePath: msg['path'] ?? msg['imagePath'],
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
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.emoji_emotions_outlined, color: Colors.grey), 
                    onPressed: () {},
                  ),
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      decoration: const InputDecoration(
                        hintText: 'Message',
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 8),
                      ),
                      onSubmitted: (_) => _sendMessage(),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.attach_file, color: Colors.grey), 
                    onPressed: () => _sendImage(ImageSource.gallery),
                  ),
                  IconButton(
                    icon: const Icon(Icons.camera_alt, color: Colors.grey), 
                    onPressed: () => _sendImage(ImageSource.camera),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 8),
          CircleAvatar(
            backgroundColor: Theme.of(context).colorScheme.primary,
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
  final String type;
  final String? imagePath;

  const _ChatBubble({
    required this.text, 
    required this.isSelf, 
    this.isEncrypted = false,
    this.type = 'text',
    this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isSelf ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        padding: const EdgeInsets.all(4), 
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
            if ((type == 'image' || type == 'file') && imagePath != null)
              type == 'image' 
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: kIsWeb 
                    ? Image.network(imagePath!, height: 200, width: 200, fit: BoxFit.cover)
                    : Image.file(File(imagePath!), height: 200, width: 200, fit: BoxFit.cover),
                )
              : Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.picture_as_pdf, color: Colors.red),
                      const SizedBox(width: 8),
                      Flexible(child: Text(imagePath!, overflow: TextOverflow.ellipsis)),
                    ],
                  ),
                ),
            if (type == 'text' || type == 'file') // Show text for file as caption
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: Text(text, style: TextStyle(fontSize: 16, color: isSelf ? Colors.white : Colors.black)),
              ),
            const SizedBox(height: 2),
            Padding(
              padding: const EdgeInsets.only(right: 4, bottom: 2),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (isEncrypted)
                    Icon(Icons.lock_outline, size: 10, color: isSelf ? Colors.white70 : Colors.grey),
                  const SizedBox(width: 4),
                  Text('12:00 PM', style: TextStyle(fontSize: 10, color: isSelf ? Colors.white70 : Colors.grey)),
                  if (isSelf) ...[
                    const SizedBox(width: 4),
                    const Icon(Icons.done_all, size: 14, color: Colors.white),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
