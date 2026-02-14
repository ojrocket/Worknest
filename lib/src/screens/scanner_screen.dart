import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class ScannerScreen extends StatefulWidget {
  const ScannerScreen({super.key});

  @override
  State<ScannerScreen> createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen> {
  String? _text;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Scanner & OCR')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(children: [
              ElevatedButton.icon(
                icon: const Icon(Icons.upload_file),
                label: const Text('Pick Image/PDF'),
                onPressed: _pickFile,
              ),
              const SizedBox(width: 12),
              if (_text != null)
                ElevatedButton.icon(
                  icon: const Icon(Icons.save_alt),
                  label: const Text('Export Text'),
                  onPressed: () {},
                ),
            ]),
            const SizedBox(height: 16),
            Expanded(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: SingleChildScrollView(
                  child: Text(_text ??
                      'Use the button above to select a scan. OCR is stubbed in this starter.'),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> _pickFile() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.image);
    if (result == null) return;
    final path = result.files.single.path!;
    setState(() => _text =
        'Selected file: $path\n\n(Integrate ML Kit / Vision OCR here).');
  }
}
