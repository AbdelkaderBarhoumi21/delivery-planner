// lib/features/shop/screens/order/widgets/order_trip_map.dart
import 'dart:math' as math;
import 'package:flutter/material.dart';

class LatLng {
  final double lat;
  final double lon;
  const LatLng(this.lat, this.lon);
}

class StaticTripMap extends StatelessWidget {
  const StaticTripMap({
    super.key,
    required this.depot,
    required this.stops,
    this.height = 180,
    this.padding = 16,
    this.strokeColor,
    this.pinColor,
  });

  final LatLng depot;
  final List<LatLng> stops;
  final double height;
  final double padding;
  final Color? strokeColor;
  final Color? pinColor;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: SizedBox(
        height: height,
        width: double.infinity,
        child: CustomPaint(
          painter: _TripMapPainter(
            depot: depot,
            stops: stops,
            padding: padding,
            strokeColor: strokeColor ?? Theme.of(context).primaryColor,
            pinColor: pinColor ?? Colors.redAccent,
          ),
        ),
      ),
    );
  }
}

class _TripMapPainter extends CustomPainter {
  _TripMapPainter({
    required this.depot,
    required this.stops,
    required this.padding,
    required this.strokeColor,
    required this.pinColor,
  });

  final LatLng depot;
  final List<LatLng> stops;
  final double padding;
  final Color strokeColor;
  final Color pinColor;

  // Projection mercator simplifiée
  Offset _project(LatLng p) {
    final x = p.lon;
    final y = math.log(math.tan((math.pi / 4) + (p.lat * math.pi / 360)));
    return Offset(x, y);
  }

  @override
  void paint(Canvas canvas, Size size) {
    // fond
    final bg = Paint()
      ..color = const Color(0xFFF7F7F9)
      ..style = PaintingStyle.fill;
    final border = Paint()
      ..color = const Color(0x22000000)
      ..style = PaintingStyle.stroke;

    final rect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, size.width, size.height),
      const Radius.circular(12),
    );
    canvas.drawRRect(rect, bg);
    canvas.drawRRect(rect, border);

    final points = <LatLng>[depot, ...stops];
    if (points.isEmpty) return;

    // bbox projetée
    final proj = points.map(_project).toList();
    double minX = proj.first.dx, maxX = proj.first.dx;
    double minY = proj.first.dy, maxY = proj.first.dy;
    for (final o in proj) {
      minX = math.min(minX, o.dx);
      maxX = math.max(maxX, o.dx);
      minY = math.min(minY, o.dy);
      maxY = math.max(maxY, o.dy);
    }
    if ((maxX - minX).abs() < 1e-9) { maxX += 1e-6; minX -= 1e-6; }
    if ((maxY - minY).abs() < 1e-9) { maxY += 1e-6; minY -= 1e-6; }

    // transform canvas
    final w = size.width - 2 * padding;
    final h = size.height - 2 * padding;
    final sx = w / (maxX - minX);
    final sy = h / (maxY - minY);
    final s = math.min(sx, sy);
    final ox = padding + (w - s * (maxX - minX)) / 2;
    final oy = padding + (h - s * (maxY - minY)) / 2;

    Offset toCanvas(Offset m) =>
        Offset(ox + (m.dx - minX) * s, oy + (maxY - m.dy) * s);

    final depotP = toCanvas(_project(depot));
    final stopPs = stops.map((e) => toCanvas(_project(e))).toList();

    // ligne itinéraire
    if (stopPs.isNotEmpty) {
      final path = Path()..moveTo(depotP.dx, depotP.dy);
      for (final p in stopPs) {
        path.lineTo(p.dx, p.dy);
      }
      final linePaint = Paint()
        ..color = strokeColor
        ..strokeWidth = 2
        ..style = PaintingStyle.stroke;
      canvas.drawPath(path, linePaint);
    }

    // dépôt (carré)
    final depotPaint = Paint()..color = pinColor;
    const depotSize = 8.0;
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(center: depotP, width: depotSize, height: depotSize),
        const Radius.circular(2),
      ),
      depotPaint,
    );

    // stops (ronds numérotés)
    final stopPaint = Paint()..color = strokeColor;
    final textPainter = TextPainter(textDirection: TextDirection.ltr);
    for (int i = 0; i < stopPs.length; i++) {
      final p = stopPs[i];
      canvas.drawCircle(p, 7, stopPaint);
      final label = (i + 1).toString();
      textPainter.text = TextSpan(
        text: label,
        style: const TextStyle(fontSize: 10, color: Colors.white, fontWeight: FontWeight.w600),
      );
      textPainter.layout(minWidth: 0, maxWidth: 20);
      final tp = Offset(p.dx - textPainter.width / 2, p.dy - textPainter.height / 2);
      textPainter.paint(canvas, tp);
    }
  }

  @override
  bool shouldRepaint(covariant _TripMapPainter old) {
    bool listEq(List<LatLng> a, List<LatLng> b) {
      if (a.length != b.length) return false;
      for (var i = 0; i < a.length; i++) {
        if (a[i].lat != b[i].lat || a[i].lon != b[i].lon) return false;
      }
      return true;
    }

    return depot.lat != old.depot.lat ||
        depot.lon != old.depot.lon ||
        padding != old.padding ||
        strokeColor != old.strokeColor ||
        pinColor != old.pinColor ||
        !listEq(stops, old.stops);
  }
}
