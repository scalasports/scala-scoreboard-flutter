import 'package:flutter/material.dart';

/// A widget that draws an upward-facing triangle using a specified [color] and [size].
///
/// The triangle is centered within its bounding box and fills the width and height
/// specified by [size]. The color of the triangle is set via [color].
///
/// This widget is implemented using [CustomPaint] and a custom painter [_TriangleUpPainter].
class TriangleUp extends StatelessWidget {
  /// Creates an upward-facing triangle.
  ///
  /// The [color] and [size] parameters must not be null.
  const TriangleUp({super.key, required this.color, required this.size});

  /// The color of the triangle.
  final Color color;

  /// The size of the bounding box for the triangle.
  ///
  /// This determines both the width and height of the triangle.
  final double size;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(size, size),
      painter: _TriangleUpPainter(color),
    );
  }
}

/// A custom painter responsible for drawing an upward-facing triangle.
///
/// The [color] of the triangle is set when creating this painter.
class _TriangleUpPainter extends CustomPainter {
  /// Creates a painter that draws an upward-facing triangle with the specified [color].
  const _TriangleUpPainter(this.color);

  /// The color used to fill the triangle.
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final path = Path()
      ..moveTo(size.width / 2, 0) // Top center
      ..lineTo(0, size.height) // Bottom left
      ..lineTo(size.width, size.height) // Bottom right
      ..close(); // Close the path to form a triangle

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

/// A widget that draws a downward-facing triangle using a specified [color] and [size].
///
/// The triangle is centered within its bounding box and fills the width and height
/// specified by [size]. The color of the triangle is set via [color].
///
/// This widget is implemented using [CustomPaint] and a custom painter [_TriangleDownPainter].
class TriangleDown extends StatelessWidget {
  /// Creates a downward-facing triangle.
  ///
  /// The [color] and [size] parameters must not be null.
  const TriangleDown({
    super.key,
    required this.color,
    required this.size,
  });

  /// The color of the triangle.
  final Color color;

  /// The size of the bounding box for the triangle.
  ///
  /// This determines both the width and height of the triangle.
  final double size;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(size, size),
      painter: _TriangleDownPainter(color),
    );
  }
}

/// A custom painter responsible for drawing a downward-facing triangle.
///
/// The [color] of the triangle is set when creating this painter.
class _TriangleDownPainter extends CustomPainter {
  /// Creates a painter that draws a downward-facing triangle with the specified [color].
  const _TriangleDownPainter(this.color);

  /// The color used to fill the triangle.
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final path = Path()
      ..moveTo(0, 0) // Top left
      ..lineTo(size.width, 0) // Top right
      ..lineTo(size.width / 2, size.height) // Bottom center
      ..close(); // Close the path to form a triangle

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
