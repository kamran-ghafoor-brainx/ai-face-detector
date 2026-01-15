import 'package:flutter/material.dart';
import 'theme/app_theme.dart';
import 'features/emotion_detection/ui/camera_screen.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Face Emotion Detector',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      home: const CameraScreen(),
    );
  }
}

