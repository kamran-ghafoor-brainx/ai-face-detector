import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import '../models/emotion_result.dart';

class EmotionClassifier {
  // Thresholds for emotion classification
  static const double _smileThreshold = 0.6;
  static const double _eyeOpenThreshold = 0.5;
  static const double _eyeClosedThreshold = 0.4;
  static const double _lowSmileThreshold = 0.2;
  static const double _headTiltThreshold = 15.0; // degrees

  EmotionResult classify(Face face) {
    // Extract face features
    final smileProb = face.smilingProbability ?? 0.0;
    final leftEyeOpen = face.leftEyeOpenProbability ?? 0.0;
    final rightEyeOpen = face.rightEyeOpenProbability ?? 0.0;
    final avgEyeOpen = (leftEyeOpen + rightEyeOpen) / 2.0;

    // Calculate head tilt (using Euler angles)
    final headEulerY = face.headEulerAngleY ?? 0.0;
    final headEulerZ = face.headEulerAngleZ ?? 0.0;
    final headTilt = (headEulerY.abs() + headEulerZ.abs()) / 2.0;

    // Rule-based classification
    EmotionType emotion;
    double confidence;

    // SAD: low smile + low eye open + noticeable head tilt
    if (smileProb < _lowSmileThreshold &&
        avgEyeOpen < _eyeClosedThreshold &&
        headTilt > _headTiltThreshold) {
      emotion = EmotionType.sad;
      confidence = _calculateSadConfidence(smileProb, avgEyeOpen, headTilt);
    }
    // HAPPY: high smile + eyes open
    else if (smileProb > _smileThreshold && avgEyeOpen > _eyeOpenThreshold) {
      emotion = EmotionType.happy;
      confidence = _calculateHappyConfidence(smileProb, avgEyeOpen);
    }
    // NEUTRAL: everything else
    else {
      emotion = EmotionType.neutral;
      confidence = _calculateNeutralConfidence(smileProb, avgEyeOpen, headTilt);
    }

    return EmotionResult(
      emotion: emotion,
      confidence: confidence,
      smileProbability: smileProb,
      eyeOpenProbability: avgEyeOpen,
      headTiltAngle: headTilt,
    );
  }

  double _calculateHappyConfidence(double smile, double eyeOpen) {
    // Higher confidence when both smile and eye open are high
    final smileWeight = (smile - _smileThreshold) / (1.0 - _smileThreshold);
    final eyeWeight = (eyeOpen - _eyeOpenThreshold) / (1.0 - _eyeOpenThreshold);
    return ((smileWeight + eyeWeight) / 2.0).clamp(0.5, 1.0);
  }

  double _calculateSadConfidence(
      double smile, double eyeOpen, double headTilt) {
    // Higher confidence when all indicators are strong
    final smileWeight = (1.0 - smile) / 1.0;
    final eyeWeight = (1.0 - eyeOpen) / 1.0;
    final tiltWeight = (headTilt / 45.0).clamp(0.0, 1.0);
    return ((smileWeight + eyeWeight + tiltWeight) / 3.0).clamp(0.5, 1.0);
  }

  double _calculateNeutralConfidence(
      double smile, double eyeOpen, double headTilt) {
    // Neutral confidence based on how "middle" the values are
    final smileDeviation = (smile - 0.5).abs() / 0.5;
    final eyeDeviation = (eyeOpen - 0.5).abs() / 0.5;
    final tiltDeviation = (headTilt / 30.0).clamp(0.0, 1.0);
    final avgDeviation = (smileDeviation + eyeDeviation + tiltDeviation) / 3.0;
    return (1.0 - avgDeviation).clamp(0.5, 1.0);
  }
}

