# Kindred Work & Wellbeing (Starter App)

A Flutter starter you can **build and run today** (Android & iOS). It includes:
- Home, Circles (chat), Work hub (Docs, Sheets, Slides), Scanner (stub OCR), You (wellbeing)
- Cool color UI theme (light/dark), basic navigation, local storage
- AI assistant stubs (pluggable with Azure OpenAI)
- Firebase-ready structure (optional), but runs **offline** by default

## Quick Start

```bash
flutter --version # Flutter 3.16+ recommended
flutter pub get
flutter run
```

## Build APK (Debug)
```bash
flutter build apk --debug
```

## iOS run (requires Xcode/macOS)
```bash
cd ios && pod install && cd ..
flutter run -d ios
```

## Notes
- OCR and AI are stubbed with interfaces. Replace with platform code (ML Kit / Apple Vision) and Azure OpenAI key.
- This is a scaffold to help you reach a production build quickly.
