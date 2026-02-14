import 'package:flutter/material.dart';

class WorkScreen extends StatelessWidget {
  const WorkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Work'),
          bottom: const TabBar(tabs: [
            Tab(text: 'Docs'),
            Tab(text: 'Sheets'),
            Tab(text: 'Slides'),
            Tab(text: 'Scans'),
          ]),
        ),
        body: const TabBarView(children: [
          _DocsTab(), _SheetsTab(), _SlidesTab(), _ScansTab()
        ]),
      ),
    );
  }
}

class _DocsTab extends StatelessWidget {
  const _DocsTab();
  @override
  Widget build(BuildContext context) => _Placeholder('Docs');
}
class _SheetsTab extends StatelessWidget {
  const _SheetsTab();
  @override
  Widget build(BuildContext context) => _Placeholder('Sheets');
}
class _SlidesTab extends StatelessWidget {
  const _SlidesTab();
  @override
  Widget build(BuildContext context) => _Placeholder('Slides');
}
class _ScansTab extends StatelessWidget {
  const _ScansTab();
  @override
  Widget build(BuildContext context) => _Placeholder('Scans');
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
