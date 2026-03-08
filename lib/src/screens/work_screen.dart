import 'package:flutter/material.dart';
import 'send_to_contact_dialog.dart';

class WorkScreen extends StatelessWidget {
  const WorkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Column(
        children: [
          Material(
            color: Theme.of(context).colorScheme.primary.withOpacity(0.05),
            child: const TabBar(
              labelColor: Colors.indigo,
              unselectedLabelColor: Colors.grey,
              indicatorColor: Colors.indigo,
              tabs: [
                Tab(text: 'Docs'),
                Tab(text: 'Sheets'),
                Tab(text: 'Slides'),
                Tab(text: 'Scans'),
              ],
            ),
          ),
          const Expanded(
            child: TabBarView(
              children: [_DocsTab(), _SheetsTab(), _SlidesTab(), _ScansTab()],
            ),
          ),
        ],
      ),
    );
  }
}

// ──────────────────── Docs Tab ────────────────────

class _DocsTab extends StatelessWidget {
  const _DocsTab();

  @override
  Widget build(BuildContext context) {
    final docs = [
      {'name': 'Project Proposal v2.docx', 'date': 'Feb 14, 2026', 'size': '245 KB', 'icon': Icons.description, 'color': Colors.blue},
      {'name': 'Meeting Notes - Sprint 12.docx', 'date': 'Feb 13, 2026', 'size': '128 KB', 'icon': Icons.description, 'color': Colors.blue},
      {'name': 'Employee Handbook 2026.pdf', 'date': 'Feb 10, 2026', 'size': '1.2 MB', 'icon': Icons.picture_as_pdf, 'color': Colors.red},
      {'name': 'Q1 Goals & OKRs.pdf', 'date': 'Feb 8, 2026', 'size': '340 KB', 'icon': Icons.picture_as_pdf, 'color': Colors.red},
      {'name': 'Onboarding Checklist.docx', 'date': 'Feb 5, 2026', 'size': '98 KB', 'icon': Icons.description, 'color': Colors.blue},
    ];

    return _DocumentList(docs: docs);
  }
}

// ──────────────────── Sheets Tab ────────────────────

class _SheetsTab extends StatelessWidget {
  const _SheetsTab();

  @override
  Widget build(BuildContext context) {
    final sheets = [
      {'name': 'Budget Q1 2026.xlsx', 'date': 'Feb 14, 2026', 'size': '520 KB', 'icon': Icons.grid_on, 'color': Colors.green},
      {'name': 'Expense Tracker - Feb.xlsx', 'date': 'Feb 12, 2026', 'size': '180 KB', 'icon': Icons.grid_on, 'color': Colors.green},
      {'name': 'Team Roster & Skills Matrix.xlsx', 'date': 'Feb 9, 2026', 'size': '310 KB', 'icon': Icons.grid_on, 'color': Colors.green},
      {'name': 'KPI Dashboard Data.xlsx', 'date': 'Feb 6, 2026', 'size': '890 KB', 'icon': Icons.grid_on, 'color': Colors.green},
    ];

    return _DocumentList(docs: sheets);
  }
}

// ──────────────────── Slides Tab ────────────────────

class _SlidesTab extends StatelessWidget {
  const _SlidesTab();

  @override
  Widget build(BuildContext context) {
    final slides = [
      {'name': 'Product Roadmap 2026.pptx', 'date': 'Feb 13, 2026', 'size': '4.5 MB', 'icon': Icons.slideshow, 'color': Colors.orange},
      {'name': 'Investor Pitch Deck.pptx', 'date': 'Feb 10, 2026', 'size': '8.2 MB', 'icon': Icons.slideshow, 'color': Colors.orange},
      {'name': 'Team Retro Feb.pptx', 'date': 'Feb 7, 2026', 'size': '1.1 MB', 'icon': Icons.slideshow, 'color': Colors.orange},
    ];

    return _DocumentList(docs: slides);
  }
}

// ──────────────────── Scans Tab ────────────────────

class _ScansTab extends StatelessWidget {
  const _ScansTab();

  @override
  Widget build(BuildContext context) {
    final scans = [
      {'name': 'Receipt - Office Supplies.pdf', 'date': 'Feb 14, 2026', 'size': '1.4 MB', 'icon': Icons.document_scanner, 'color': Colors.deepPurple},
      {'name': 'Whiteboard Notes.pdf', 'date': 'Feb 11, 2026', 'size': '2.8 MB', 'icon': Icons.document_scanner, 'color': Colors.deepPurple},
      {'name': 'ID Card Scan.pdf', 'date': 'Feb 3, 2026', 'size': '980 KB', 'icon': Icons.document_scanner, 'color': Colors.deepPurple},
    ];

    return _DocumentList(docs: scans);
  }
}

// ──────────────────── Shared Document List Widget ────────────────────

class _DocumentList extends StatelessWidget {
  final List<Map<String, dynamic>> docs;
  const _DocumentList({required this.docs});

  @override
  Widget build(BuildContext context) {
    if (docs.isEmpty) {
      return const Center(child: Text('No documents yet'));
    }

    return ListView.separated(
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: docs.length,
      separatorBuilder: (_, __) => const Divider(indent: 72, height: 1),
      itemBuilder: (context, i) {
        final doc = docs[i];
        return ListTile(
          leading: Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: (doc['color'] as Color).withOpacity(0.12),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(doc['icon'] as IconData, color: doc['color'] as Color),
          ),
          title: Text(
            doc['name'] as String,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: Text('${doc['date']}  •  ${doc['size']}',
              style: const TextStyle(fontSize: 12, color: Colors.grey)),
          trailing: IconButton(
            icon: const Icon(Icons.send_rounded, color: Colors.indigo),
            tooltip: 'Send to contact',
            onPressed: () {
              showSendToContactDialog(context, doc['name'] as String);
            },
          ),
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Opening ${doc['name']}')),
            );
          },
        );
      },
    );
  }
}
