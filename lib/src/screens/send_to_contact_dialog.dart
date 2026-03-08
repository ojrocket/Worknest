import 'package:flutter/material.dart';
import '../services/chat_service.dart';

/// Opens a dialog to pick a contact and send a document to them.
void showSendToContactDialog(BuildContext context, String documentName) {
  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (ctx) => _SendToContactSheet(documentName: documentName),
  );
}

class _SendToContactSheet extends StatelessWidget {
  final String documentName;
  const _SendToContactSheet({required this.documentName});

  @override
  Widget build(BuildContext context) {
    final chatService = ChatService();
    final contacts = chatService.chats;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                const Icon(Icons.send_rounded, color: Colors.indigo),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'Send "$documentName"',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          const Divider(),
          Flexible(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: contacts.length,
              itemBuilder: (context, i) {
                final contact = contacts[i];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.indigo.withOpacity(0.1),
                    child: Text(
                      (contact['name'] as String).substring(0, 1).toUpperCase(),
                      style: const TextStyle(
                          color: Colors.indigo, fontWeight: FontWeight.bold),
                    ),
                  ),
                  title: Text(contact['name'] as String,
                      style: const TextStyle(fontWeight: FontWeight.w600)),
                  trailing: const Icon(Icons.arrow_forward_ios,
                      size: 14, color: Colors.grey),
                  onTap: () {
                    // Send the document via ChatService
                    chatService.sendMessage(
                      contact['name'] as String,
                      '📄 Shared: $documentName',
                      type: 'file',
                      path: documentName,
                    );
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                            '✅ Sent "$documentName" to ${contact['name']}'),
                        behavior: SnackBarBehavior.floating,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
