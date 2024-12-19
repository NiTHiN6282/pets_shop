import 'package:flutter/material.dart';

class CustomContainer extends StatelessWidget {
  String url;
  CustomContainer({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: _ContainerClipper(),
      child: Image.network(
        url,
        width: 300, // Match the CustomPaint size
        // height: 200, // Match the CustomPaint size
        fit: BoxFit.cover, // Ensures the image fits the container
      ),
    );
  }
}

class _ContainerClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double constantValue = 20;

    final Path path = Path()
      ..moveTo(0, constantValue) // Start from top-left corner
      ..lineTo(
          0, size.height - constantValue) // Left side, to bottom-left corner
      ..quadraticBezierTo(
          0, size.height, constantValue, size.height) // Bottom-left curve
      ..lineTo(
          size.width - (2 * (constantValue + 15)), size.height) // Bottom side
      ..quadraticBezierTo(
          size.width - (constantValue + 30),
          size.height,
          size.width - (constantValue + 30),
          size.height - constantValue) // Bottom-right inward curve
      ..quadraticBezierTo(
          size.width - (constantValue + 30),
          size.height - (constantValue + 30),
          size.width - 30,
          size.height - (constantValue + 30)) // Bottom-right inward curve
      ..quadraticBezierTo(
          size.width,
          size.height - (constantValue + 30),
          size.width,
          size.height - ((2 * constantValue) + 25)) // Bottom-right inward curve
      ..lineTo(size.width, constantValue) // Right side, to top-right corner
      ..quadraticBezierTo(
          size.width, 0, size.width - constantValue, 0) // Top-right curve
      ..lineTo(constantValue, 0) // Top side
      ..quadraticBezierTo(0, 0, 0, constantValue); // Top-left inward curve

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
