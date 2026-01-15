import 'dart:io';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';

class FaceDetectorService {
  late FaceDetector _faceDetector;

  FaceDetectorService() {
    final options = FaceDetectorOptions(
      enableTracking: false,
      enableLandmarks: true,
      enableContours: false,
      enableClassification: true,
      minFaceSize: 0.1,
      performanceMode: FaceDetectorMode.accurate,
    );
    _faceDetector = FaceDetector(options: options);
  }

  Future<Face?> detectFaceFromFile(File file) async {
    try {
      final inputImage = InputImage.fromFile(file);
      final faces = await _faceDetector.processImage(inputImage);

      if (faces.isEmpty) {
        return null;
      }

      return faces.first;
    } catch (e) {
      return null;
    }
  }

  void dispose() {
    _faceDetector.close();
  }
}

