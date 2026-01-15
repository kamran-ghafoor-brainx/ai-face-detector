import 'package:flutter/material.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';

class CameraOverlay extends StatelessWidget {
  final Face? face;
  final Size imageSize;
  final Size screenSize;

  const CameraOverlay({
    super.key,
    required this.face,
    required this.imageSize,
    required this.screenSize,
  });

  @override
  Widget build(BuildContext context) {
    if (face == null) {
      return const SizedBox.shrink();
    }

    final boundingBox = _scaleBoundingBox(face!.boundingBox);

    return Positioned(
      left: boundingBox.left,
      top: boundingBox.top,
      width: boundingBox.width,
      height: boundingBox.height,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.green, width: 3),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Stack(
          children: [
            Positioned(
              top: -20,
              left: 0,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Text(
                  'Face Detected',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Rect _scaleBoundingBox(Rect boundingBox) {
    // Calculate scale factors
    final scaleX = screenSize.width / imageSize.width;
    final scaleY = screenSize.height / imageSize.height;

    // Scale the bounding box
    return Rect.fromLTWH(
      boundingBox.left * scaleX,
      boundingBox.top * scaleY,
      boundingBox.width * scaleX,
      boundingBox.height * scaleY,
    );
  }
}
