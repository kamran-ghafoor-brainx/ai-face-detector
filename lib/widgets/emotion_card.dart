import 'package:flutter/material.dart';
import '../features/emotion_detection/models/emotion_result.dart';
import '../theme/app_theme.dart';

class EmotionCard extends StatelessWidget {
  final EmotionResult result;
  final bool isDark;

  const EmotionCard({
    super.key,
    required this.result,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    final emotionColor = AppTheme.getEmotionColor(result.emotionLabel, isDark);

    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      child: Container(
        padding: const EdgeInsets.all(32),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              emotionColor.withOpacity(0.1),
              emotionColor.withOpacity(0.05),
            ],
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 500),
              transitionBuilder: (child, animation) {
                return ScaleTransition(
                  scale: animation,
                  child: FadeTransition(
                    opacity: animation,
                    child: child,
                  ),
                );
              },
              child: Text(
                result.emoji,
                key: ValueKey(result.emotion),
                style: const TextStyle(fontSize: 80),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              result.emotionLabel,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: emotionColor,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              '${(result.confidence * 100).toStringAsFixed(0)}% confidence',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Colors.grey[600],
                  ),
            ),
          ],
        ),
      ),
    );
  }
}

