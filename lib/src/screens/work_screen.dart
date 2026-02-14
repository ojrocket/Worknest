import 'package:flutter/material.dart';
import 'tasks_screen.dart';
import '../services/chat_service.dart';

class WorkScreen extends StatelessWidget {
  const WorkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Work'),
          bottom: const TabBar(
            isScrollable: true,
            tabs: [
            Tab(text: 'Tasks'), // New Tab
            Tab(text: 'Docs'),
            Tab(text: 'Sheets'),
            Tab(text: 'Slides'),
            Tab(text: 'Scans'),
          ]),
        ),
        body: TabBarView(children: [
          const TasksScreen(), // New Screen
          const _DocsTab(), 
          const _SheetsTab(), 
          const _SlidesTab(), 
          const _ScansTab()
        ]),
      ),
    );
  }
}

class _DocsTab extends StatelessWidget {
  const _DocsTab();

  void _sharePdf(BuildContext context, String fileName) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        final chatService = ChatService();
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text('Share "$fileName" with...', style: Theme.of(context).textTheme.titleLarge),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: chatService.chats.length,
                itemBuilder: (context, index) {
                  final chat = chatService.chats[index];
                  return ListTile(
                    leading: CircleAvatar(child: Text(chat['name'][0])),
                    title: Text(chat['name']),
                    onTap: () {
                      chatService.sendPdf(chat['name'], fileName);
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Sent "$fileName" to ${chat['name']}')),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final docs = ['Project-Specs.pdf', 'Budget-2024.pdf', 'Design-Brief.pdf'];

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: docs.length,
      separatorBuilder: (_, __) => const Divider(),
      itemBuilder: (context, index) {
        return ListTile(
          leading: const Icon(Icons.picture_as_pdf, color: Colors.red, size: 40),
          title: Text(docs[index]),
          subtitle: const Text('2.4 MB • Modified today'),
          trailing: IconButton(
            icon: const Icon(Icons.share, color: Colors.blue),
            onPressed: () => _sharePdf(context, docs[index]),
          ),
        );
      },
    );
  }
}

class _SheetsTab extends StatelessWidget {
  const _SheetsTab();
  @override
  Widget build(BuildContext context) {
    final sheets = ['Budget_Q1.xlsx', 'Attendees_List.xlsx', 'Inventory.xlsx'];
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: sheets.length,
      separatorBuilder: (_, __) => const Divider(),
      itemBuilder: (context, index) {
        return ListTile(
          leading: const Icon(Icons.table_chart, color: Colors.green, size: 40),
          title: Text(sheets[index]),
          subtitle: const Text('Spreadsheet • Edited yesterday'),
          trailing: const Icon(Icons.more_vert),
        );
      },
    );
  }
}

class _SlidesTab extends StatelessWidget {
  const _SlidesTab();
  @override
  Widget build(BuildContext context) {
     final slides = ['Q1_Review_Deck.pptx', 'Pitch_Deck_v2.pptx'];
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: slides.length,
      separatorBuilder: (_, __) => const Divider(),
      itemBuilder: (context, index) {
        return ListTile(
          leading: const Icon(Icons.slideshow, color: Colors.orange, size: 40),
          title: Text(slides[index]),
          subtitle: const Text('Presentation • Edited 2 days ago'),
          trailing: const Icon(Icons.more_vert),
        );
      },
    );
  }
}

class _ScansTab extends StatelessWidget {
  const _ScansTab();
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      padding: const EdgeInsets.all(16),
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      children: List.generate(4, (index) {
        return Container(
          color: Colors.grey[200],
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.image, size: 50, color: Colors.grey),
              Text('Scan_${index + 1}.jpg'),
            ],
          ),
        );
      }),
    );
  }
}

class _Placeholder extends StatelessWidget {
  final String label;
  const _Placeholder(this.label);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.construction, size: 48, color: Theme.of(context).colorScheme.primary),
          const SizedBox(height: 12),
          Text('$label coming to life…', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 4),
          const Text('This starter builds and runs now. Replace with full editors.'),
        ],
      ),
    );
  }
}
