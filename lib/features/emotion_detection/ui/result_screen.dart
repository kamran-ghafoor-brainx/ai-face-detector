import 'dart:io';
import 'package:flutter/material.dart';
import '../models/emotion_result.dart';
import '../../../widgets/emotion_card.dart';
import '../../../widgets/metric_tile.dart';
import '../../../theme/app_theme.dart';

class ResultScreen extends StatelessWidget {
  final EmotionResult result;
  final String imagePath;

  const ResultScreen({
    super.key,
    required this.result,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final emotionColor = AppTheme.getEmotionColor(result.emotionLabel, isDark);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Emotion Result'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 16),
            // Emotion Card
            EmotionCard(
              result: result,
              isDark: isDark,
            ),
            const SizedBox(height: 32),
            // Captured Image
            if (File(imagePath).existsSync())
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.file(
                    File(imagePath),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            const SizedBox(height: 32),
            // Metrics Section
            Text(
              'Metrics Breakdown',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16),
            // Smile Probability
            MetricTile(
              label: 'Smile Probability',
              value: result.smileProbability * 100,
              unit: '%',
              icon: Icons.sentiment_satisfied,
              color: Colors.green,
            ),
            const SizedBox(height: 12),
            // Eye Open Probability
            MetricTile(
              label: 'Eye Openness',
              value: result.eyeOpenProbability * 100,
              unit: '%',
              icon: Icons.visibility,
              color: Colors.blue,
            ),
            const SizedBox(height: 12),
            // Head Tilt
            MetricTile(
              label: 'Head Tilt Angle',
              value: result.headTiltAngle,
              unit: '°',
              icon: Icons.swap_vert,
              color: Colors.orange,
            ),
            const SizedBox(height: 32),
            // Scan Again Button
            SizedBox(
              height: 56,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.refresh),
                label: const Text(
                  'Scan Again',
                  style: TextStyle(fontSize: 18),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: emotionColor,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

