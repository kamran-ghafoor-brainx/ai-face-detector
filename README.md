# Face Emotion Detector

A complete Flutter application that detects emotions from faces using Google ML Kit Face Detection and rule-based emotion classification. The app works fully offline and provides a beautiful, modern UI with Material 3 design.

## Features

- 📷 **Camera Integration**: Front and rear camera support with live preview
- 🎭 **Emotion Detection**: Detects Happy, Neutral, and Sad emotions
- 📊 **Detailed Metrics**: Shows smile probability, eye openness, and head tilt angle
- 🎨 **Modern UI**: Material 3 design with dark mode support
- 🔒 **Fully Offline**: No internet connection required
- ⚡ **Real-time Processing**: Fast face detection and emotion classification

## Architecture

The app follows a clean, modular architecture:

```
lib/
 ├── main.dart
 ├── app.dart
 ├── theme/
 │    └── app_theme.dart
 ├── features/
 │    └── emotion_detection/
 │         ├── ui/
 │         │    ├── camera_screen.dart
 │         │    └── result_screen.dart
 │         ├── logic/
 │         │    ├── emotion_classifier.dart
 │         │    └── face_detector_service.dart
 │         └── models/
 │              └── emotion_result.dart
 └── widgets/
      ├── emotion_card.dart
      ├── metric_tile.dart
      └── camera_overlay.dart
```

## Emotion Classification Rules

The app uses rule-based classification (no ML training required):

### Happy 😊
- **Condition**: High smile probability (>0.6) + Eyes open (>0.5)
- **Confidence**: Calculated based on smile and eye openness values

### Sad 😢
- **Condition**: Low smile (<0.2) + Low eye open (<0.4) + Head tilt (>15°)
- **Confidence**: Calculated based on all three indicators

### Neutral 😐
- **Condition**: Everything else
- **Confidence**: Based on how "middle" the values are

## Setup Instructions

### Prerequisites

- Flutter SDK (latest stable version)
- Android Studio / Xcode for mobile development
- A physical device or emulator with camera support

### Installation

1. **Clone the repository** (if applicable) or navigate to the project directory

2. **Install dependencies**:
   ```bash
   flutter pub get
   ```

3. **Run the app**:
   ```bash
   flutter run
   ```

### Platform-Specific Setup

#### Android

Camera permissions are already configured in `android/app/src/main/AndroidManifest.xml`. The app will request camera permission at runtime.

**Note**: Minimum SDK version is set to 21 (required for ML Kit).

#### iOS

Camera permissions are configured in `ios/Runner/Info.plist`. The app will request camera permission at runtime.

**Note**: 
- iOS deployment target is set to 15.5 (required for latest ML Kit)
- For iOS, you need to run:
```bash
cd ios
pod install
cd ..
```

## Dependencies

- `google_mlkit_face_detection`: ^0.13.1 - Google ML Kit for face detection
- `google_mlkit_commons`: ^0.11.0 - Common ML Kit utilities
- `camera`: ^0.11.0+1 - Camera plugin for Flutter
- `permission_handler`: ^11.3.1 - Handle runtime permissions

## How It Works

1. **Camera Preview**: The app displays a live camera preview
2. **Capture**: User taps "Scan Emotion" to capture a photo
3. **Face Detection**: ML Kit detects faces in the captured image
4. **Feature Extraction**: The app extracts:
   - Smile probability
   - Left and right eye open probabilities
   - Head Euler angles (X, Y, Z)
5. **Emotion Classification**: Rule-based classifier determines emotion
6. **Result Display**: Shows emotion with emoji, confidence, and detailed metrics

## Usage

1. Launch the app
2. Grant camera permission when prompted
3. Point the camera at a face
4. Tap "Scan Emotion" button
5. View the emotion result with detailed metrics
6. Tap "Scan Again" to detect another emotion

## Technical Details

### Face Detection Configuration

- **Performance Mode**: Accurate (for better detection quality)
- **Tracking**: Disabled (single face detection)
- **Landmarks**: Enabled (for better feature extraction)
- **Classification**: Enabled (for smile and eye open probabilities)
- **Min Face Size**: 0.1 (10% of image)

### UI/UX Features

- Smooth animations for emotion transitions
- Color-coded emotions (Green for Happy, Blue for Neutral, Orange for Sad)
- Loading indicators during processing
- Error handling for no face detected scenarios
- Dark mode support
- Responsive design

## Troubleshooting

### Camera not working
- Ensure camera permissions are granted
- Check if the device has a working camera
- Try restarting the app

### No face detected
- Ensure good lighting
- Face should be clearly visible
- Try moving closer or adjusting angle
- Ensure face is not too small in frame

### Build errors
- Run `flutter clean` and `flutter pub get`
- For iOS: Run `pod install` in the `ios` directory
- Ensure you're using the latest Flutter SDK

## License

This project is open source and available for educational purposes.

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.
