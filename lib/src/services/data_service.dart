class DataService {
  // Mock database of chats for "Content Matching" feature
  static final List<Map<String, dynamic>> allChats = [
    {
      'id': '1',
      'name': 'Project Alpha Team',
      'messages': [
        'Hey, did we finalize the UI specs?',
        'Yes, looking into the Indigo theme now.',
        'The authentication flow needs to be web-compatible.',
      ]
    },
    {
      'id': '2',
      'name': 'Marketing Group',
      'messages': [
        'We need to push the new branding.',
        'WorkNest is going to change the productivity game.',
        'Make sure the AI features are highlighted.',
      ]
    },
    {
      'id': '3',
      'name': 'Dev Sync',
      'messages': [
        'Flutter Web has some restrictions on SMTP.',
        'I am working on the PDF generation service.',
        'Gemini API integration is looking good.',
      ]
    },
  ];

  static List<String> findMatches(String content) {
    final Set<String> matchedGroups = {};
    final contentLower = content.toLowerCase();

    // Simple keyword matching logic
    for (var chat in allChats) {
      for (var msg in (chat['messages'] as List<String>)) {
        // Check if any significant word from the message appears in the content
        // In a real app, this would be vector search or full-text search
        final words = msg.toLowerCase().split(' ').where((w) => w.length > 4);
        for (var word in words) {
          if (contentLower.contains(word)) {
            matchedGroups.add(chat['name']);
            break; 
          }
        }
      }
    }
    return matchedGroups.toList();
  }
}
