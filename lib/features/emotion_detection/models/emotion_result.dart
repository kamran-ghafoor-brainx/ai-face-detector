enum EmotionType {
  happy,
  sad,
  neutral,
}

class EmotionResult {
  final EmotionType emotion;
  final double confidence;
  final double smileProbability;
  final double eyeOpenProbability;
  final double headTiltAngle;

  EmotionResult({
    required this.emotion,
    required this.confidence,
    required this.smileProbability,
    required this.eyeOpenProbability,
    required this.headTiltAngle,
  });

  String get emotionLabel {
    switch (emotion) {
      case EmotionType.happy:
        return 'Happy';
      case EmotionType.sad:
        return 'Sad';
      case EmotionType.neutral:
        return 'Neutral';
    }
  }

  String get emoji {
    switch (emotion) {
      case EmotionType.happy:
        return '😊';
      case EmotionType.sad:
        return '😢';
      case EmotionType.neutral:
        return '😐';
    }
  }
}

