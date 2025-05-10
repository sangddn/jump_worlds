import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

/// A hexagon-shaped border with optional rounded corners.
///
/// The hexagon is drawn with 6 equal sides, oriented with two horizontal edges
/// at the top and bottom. The corners can be rounded using the [cornerRadius]
/// parameter.
///
/// Example usage:
/// ```dart
/// Container(
///   decoration: ShapeDecoration(
///     shape: HexagonShape(
///       cornerRadius: 8.0,
///       side: BorderSide(color: Colors.blue, width: 2.0),
///     ),
///   ),
///   child: SizedBox(
///     width: 100,
///     height: 100,
///   ),
/// )
/// ```
class HexagonShape extends ShapeBorder {
  /// Creates a hexagon border.
  ///
  /// The [side] and [cornerRadius] arguments must not be null.
  const HexagonShape({this.side = BorderSide.none, this.cornerRadius = 0.0});

  /// The style of this border.
  final BorderSide side;

  /// The radius of the corner rounding.
  ///
  /// If this value is 0.0, the hexagon will have sharp corners.
  /// Values greater than 0.0 will round the corners.
  final double cornerRadius;

  Path _getPath(Rect rect) {
    // We need to adjust the rect if we have a border width
    if (side.width > 0.0) {
      rect = rect.deflate(side.width / 2.0);
    }

    final double width = rect.width;
    final double height = rect.height;
    final double radius = math.max(
      0.0,
      math.min(cornerRadius, math.min(width, height) / 6),
    );

    // Calculate hexagon points
    final double centerX = rect.center.dx;
    final double centerY = rect.center.dy;

    // The hexagon is inscribed in the rectangle
    final double hexHeight = height;

    // Points for a regular hexagon (clockwise from top)
    // final double quarterWidth = width / 4;
    // final double threeQuarterWidth = 3 * width / 4;
    // final double sixthHeight = hexHeight / 6;
    // final double fiveSixthHeight = 5 * hexHeight / 6;

    final Path path = Path();

    if (radius <= 0.0) {
      // No corner rounding - draw straight lines
      path.moveTo(centerX, rect.top); // Top point
      path.lineTo(rect.right, centerY - hexHeight / 4); // Top right
      path.lineTo(rect.right, centerY + hexHeight / 4); // Bottom right
      path.lineTo(centerX, rect.bottom); // Bottom point
      path.lineTo(rect.left, centerY + hexHeight / 4); // Bottom left
      path.lineTo(rect.left, centerY - hexHeight / 4); // Top left
      path.close();
    } else {
      // With corner rounding
      // Top
      path.moveTo(centerX + radius, rect.top);
      path.lineTo(rect.right - radius, centerY - hexHeight / 4);

      // Top right corner
      path.arcToPoint(
        Offset(rect.right, centerY - hexHeight / 4 + radius),
        radius: Radius.circular(radius),
      );

      // Right
      path.lineTo(rect.right, centerY + hexHeight / 4 - radius);

      // Bottom right corner
      path.arcToPoint(
        Offset(rect.right - radius, centerY + hexHeight / 4),
        radius: Radius.circular(radius),
      );

      // Bottom
      path.lineTo(centerX + radius, rect.bottom);

      // Bottom corner
      path.arcToPoint(
        Offset(centerX - radius, rect.bottom),
        radius: Radius.circular(radius),
      );

      // Bottom left
      path.lineTo(rect.left + radius, centerY + hexHeight / 4);

      // Bottom left corner
      path.arcToPoint(
        Offset(rect.left, centerY + hexHeight / 4 - radius),
        radius: Radius.circular(radius),
      );

      // Left
      path.lineTo(rect.left, centerY - hexHeight / 4 + radius);

      // Top left corner
      path.arcToPoint(
        Offset(rect.left + radius, centerY - hexHeight / 4),
        radius: Radius.circular(radius),
      );

      // Back to top
      path.lineTo(centerX - radius, rect.top);

      // Top corner
      path.arcToPoint(
        Offset(centerX + radius, rect.top),
        radius: Radius.circular(radius),
      );
    }

    return path;
  }

  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.all(side.width);

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
    return _getPath(rect.deflate(side.width));
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    return _getPath(rect);
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {
    if (rect.isEmpty) return;
    switch (side.style) {
      case BorderStyle.none:
        break;
      case BorderStyle.solid:
        final Path path = getOuterPath(rect, textDirection: textDirection);
        final Paint paint = side.toPaint();
        canvas.drawPath(path, paint);
    }
  }

  @override
  ShapeBorder scale(double t) {
    return HexagonShape(side: side.scale(t), cornerRadius: cornerRadius * t);
  }

  @override
  ShapeBorder? lerpFrom(ShapeBorder? a, double t) {
    if (a is HexagonShape) {
      return HexagonShape(
        side: BorderSide.lerp(a.side, side, t),
        cornerRadius: ui.lerpDouble(a.cornerRadius, cornerRadius, t)!,
      );
    }
    return super.lerpFrom(a, t);
  }

  @override
  ShapeBorder? lerpTo(ShapeBorder? b, double t) {
    if (b is HexagonShape) {
      return HexagonShape(
        side: BorderSide.lerp(side, b.side, t),
        cornerRadius: ui.lerpDouble(cornerRadius, b.cornerRadius, t)!,
      );
    }
    return super.lerpTo(b, t);
  }

  @override
  bool operator ==(Object other) {
    if (runtimeType != other.runtimeType) return false;
    return other is HexagonShape &&
        other.side == side &&
        other.cornerRadius == cornerRadius;
  }

  @override
  int get hashCode => Object.hash(side, cornerRadius);

  @override
  String toString() {
    return '${objectRuntimeType(this, 'HexagonShape')}($side, $cornerRadius)';
  }
}
