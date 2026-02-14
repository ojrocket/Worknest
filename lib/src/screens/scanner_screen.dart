import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart'; // for kIsWeb
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:printing/printing.dart'; // For PdfPreview
import '../services/ai_service.dart';
import '../services/pdf_service.dart';
import '../services/data_service.dart';
import '../app_theme.dart';

class ScannerScreen extends StatefulWidget {
  const ScannerScreen({super.key});

  @override
  State<ScannerScreen> createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen> {
  final ImagePicker _picker = ImagePicker();
  XFile? _selectedImage;
  bool _isAnalyzing = false;
  String? _analysisResult;
  Uint8List? _generatedPdfBytes;
  List<String> _matchedChats = [];

  Future<void> _pickImage(ImageSource source) async {
    try {
      final XFile? image = await _picker.pickImage(source: source);
      if (image != null) {
        setState(() {
          _selectedImage = image;
          _analysisResult = null;
          _generatedPdfBytes = null;
          _matchedChats = [];
        });
      }
    } catch (e) {
      // Handle error
      print('Error picking image: $e');
    }
  }

  Future<void> _analyzeAndGenerate() async {
    if (_selectedImage == null) return;

    setState(() => _isAnalyzing = true);

    // 1. Analyze with AI
    final text = await AiService.analyzeImageAndGenerateReport(_selectedImage!.path);
    
    // 2. Generate PDF
    final pdfBytes = await PdfService.generateReport(text);

    // 3. Find Matches
    final matches = DataService.findMatches(text);

    if (!mounted) return;
    setState(() {
      _analysisResult = text;
      _generatedPdfBytes = pdfBytes;
      _matchedChats = matches;
      _isAnalyzing = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_generatedPdfBytes != null) {
      return _buildPdfResultScreen();
    }

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.document_scanner_rounded, size: 64, color: AppColors.primary),
              const SizedBox(height: 24),
              Text(
                'AI Smart Scanner',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.ink,
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'Snap a photo to generate a detailed PDF report\nand find related team discussions.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 48),
              if (_selectedImage != null) ...[
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: kIsWeb
                      ? Image.network(_selectedImage!.path, height: 200, fit: BoxFit.cover)
                      : Image.file(File(_selectedImage!.path), height: 200, fit: BoxFit.cover),
                ),
                const SizedBox(height: 24),
              ],
              if (_isAnalyzing)
                const Column(
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 16),
                    Text('Analyzing & Generating Report...'),
                  ],
                )
              else
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () => _pickImage(ImageSource.gallery),
                      icon: const Icon(Icons.photo_library),
                      label: const Text('Gallery'),
                      style: ElevatedButton.styleFrom(padding: const EdgeInsets.all(20)),
                    ),
                    const SizedBox(width: 16),
                    if (_selectedImage != null)
                      ElevatedButton.icon(
                        onPressed: _analyzeAndGenerate,
                        icon: const Icon(Icons.auto_awesome),
                        label: const Text('Analyze'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.accent,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.all(20),
                        ),
                      )
                    else
                      ElevatedButton.icon(
                        onPressed: () => _pickImage(ImageSource.camera),
                        icon: const Icon(Icons.camera_alt),
                        label: const Text('Camera'),
                        style: ElevatedButton.styleFrom(padding: const EdgeInsets.all(20)),
                      ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPdfResultScreen() {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Generated Report'),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => setState(() => _generatedPdfBytes = null),
        ),
      ),
      body: Column(
        children: [
          if (_matchedChats.isNotEmpty)
            Container(
              padding: const EdgeInsets.all(12),
              color: Colors.amber.shade50,
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.warning_amber_rounded, color: Colors.amber),
                      const SizedBox(width: 8),
                      Text('Related Discussions Found!', style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    children: _matchedChats.map((chat) => Chip(
                      label: Text(chat),
                      backgroundColor: Colors.white,
                      avatar: const CircleAvatar(child: Icon(Icons.group, size: 14)),
                    )).toList(),
                  ),
                ],
              ),
            ),
          Expanded(
            child: PdfPreview(
              build: (format) => _generatedPdfBytes!,
              useActions: true, // Allow download/print
            ),
          ),
        ],
      ),
    );
  }
}
