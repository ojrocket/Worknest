import 'dart:io';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:flutter/foundation.dart'; // for kIsWeb

class AiService {
  // Replace with a valid API key or use a secure way to fetch it
  static const String _apiKey = 'YOUR_GEMINI_API_KEY';

  static Future<String> analyzeImageAndGenerateReport(String imagePath) async {
    try {
      if (_apiKey == 'YOUR_GEMINI_API_KEY') {
        // Fallback for demo without key
        await Future.delayed(const Duration(seconds: 2));
        return _getMockAnalysis();
      }

      final model = GenerativeModel(model: 'gemini-pro-vision', apiKey: _apiKey);
      final prompt = TextPart("Analyze this document/image. Extract the key text and provide a detailed summary, followed by a 'Deep Dive' section explaining the concepts found in the document. Format as clean text.");

      // Handling Web vs Mobile file reading
      Uint8List imageBytes;
      if (kIsWeb) {
        // In a real web app with XFile, we'd pass bytes directly. 
        // For this demo structure, assuming we might need to fetch or generic mock
        return _getMockAnalysis(); 
      } else {
        imageBytes = await File(imagePath).readAsBytes();
      }

      final imageParts = [DataPart('image/jpeg', imageBytes)];
      final response = await model.generateContent([
        Content.multi([prompt, ...imageParts])
      ]);

      return response.text ?? "No analysis could be generated.";
    } catch (e) {
      print('AI Error: $e');
      return _getMockAnalysis();
    }
  }

  static String _getMockAnalysis() {
    return '''
# Document Analysis Report

## Summary
The scanned document appears to be a technical specification regarding "Project WorkNest". It outlines key deliverables including authentication flows, UI redesigns, and AI integration. The document emphasizes a shift towards a professional aesthetic using Indigo and Slate color palettes.

## Deep Dive: Concepts & Context

### 1. Web-Compatible Authentication
The document discusses the challenges of implementing SMTP on the web. It suggests using HTTP-based services like EmailJS or SendGrid as a workaround for browser security restrictions. This is a common pattern in Modern Web App (PWA) development.

### 2. UI/UX Philosophy
The transition from a "WhatsApp Clone" to a "Professional Productivity Tool" signifies a strategic pivot. The Indigo color (#3F51B5) is chosen to evoke trust, stability, and intelligence, aligning with the expanded feature set impacting workspace wellbeing.

### 3. AI-Driven Workflows
The mention of "Smart Scanners" indicates a move towards GenAI. By converting raw pixels (images) into structured knowledge (PDF reports), the app aims to reduce cognitive load for users, automating the "reading and understanding" phase of document management.

## Related Topics
- Flutter Web Development
- Google Gemini API
- Clean Architecture
''';
  }
}
