import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:foreclair/src/data/models/weather/tide/tide_model.dart';

class TideCurve extends StatelessWidget {
  final List<TideModel> tides;
  final DateTime currentTime;
  final Color curveColor;
  final Color gradientStartColor;
  final Color gradientEndColor;
  final double tideHeight;
  final bool isLabelsVisible;

  const TideCurve({
    super.key,
    required this.tides,
    required this.currentTime,
    required this.curveColor,
    required this.gradientStartColor,
    required this.gradientEndColor,
    this.tideHeight = 220,
    this.isLabelsVisible = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: tideHeight + (isLabelsVisible ? 35 : 0), // Add space for labels if needed
      width: double.infinity,
      child: CustomPaint(
        painter: _TideCurvePainter(
          tides: tides,
          currentTime: currentTime,
          curveColor: curveColor,
          gradientStartColor: gradientStartColor,
          gradientEndColor: gradientEndColor,
          tideHeight: tideHeight,
          isLabelsVisible: isLabelsVisible,
        ),
      ),
    );
  }
}

class _TideCurvePainter extends CustomPainter {
  final List<TideModel> tides;
  final DateTime currentTime;
  final Color curveColor;
  final Color gradientStartColor;
  final Color gradientEndColor;
  final double tideHeight;
  final bool isLabelsVisible;

  _TideCurvePainter({
    required this.tides,
    required this.currentTime,
    required this.curveColor,
    required this.gradientStartColor,
    required this.gradientEndColor,
    required this.tideHeight,
    required this.isLabelsVisible,
  });

  static const int totalMinutes = 24 * 60;

  @override
  void paint(Canvas canvas, Size size) {
    if (tides.isEmpty || size.width <= 0 || size.height <= 0) return;

    final curvePaint = Paint()
      ..color = curveColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.2
      ..isAntiAlias = true;

    final dotPaint = Paint()..color = curveColor;

    // Calculate the actual curve area
    final labelSpace = isLabelsVisible ? 35.0 : 0.0;
    final curveAreaHeight = tideHeight;
    final curveAreaTop = labelSpace;

    // Gradient for the curve area only
    final gradientPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [gradientStartColor, gradientEndColor],
        stops: [0.0, 1.0],
      ).createShader(Rect.fromLTWH(0, curveAreaTop, size.width, curveAreaHeight))
      ..style = PaintingStyle.fill;

    // Prepare tide points
    List<_TidePoint> sorted =
        tides.map((t) => _TidePoint((t.time.hour * 60 + t.time.minute).toDouble(), t.coefficient, t.isHighTide)).toList()
          ..sort((a, b) => a.min.compareTo(b.min));

    if (sorted.length == 1) {
      final only = sorted.first;
      sorted.insert(0, _TidePoint(only.min - 360, only.coeff, !only.isHigh));
      sorted.add(_TidePoint(only.min + 360, only.coeff, !only.isHigh));
    }

    // Average half-tide span
    double avgSpan;
    if (sorted.length > 1) {
      final spans = <double>[];
      for (int i = 1; i < sorted.length; i++) {
        spans.add((sorted[i].min - sorted[i - 1].min).abs());
      }
      avgSpan = spans.reduce((a, b) => a + b) / spans.length;
    } else {
      avgSpan = 360.0;
    }

    // Add virtual points before/after
    final before = _TidePoint(sorted.first.min - avgSpan, sorted.first.coeff, !sorted.first.isHigh);
    final after = _TidePoint(sorted.last.min + avgSpan, sorted.last.coeff, !sorted.last.isHigh);
    final extended = <_TidePoint>[before, ...sorted, after];

    // Max coefficient for scaling
    final maxCoeff = extended.map((e) => e.coeff).reduce(math.max);

    // Vertical mapping - now using the full tideHeight for the curve
    final baseY = curveAreaTop + curveAreaHeight * 0.5; // Center of curve area
    final maxAmplitude = curveAreaHeight * 0.45; // Use almost full height for amplitude

    // Precompute Y positions
    final extMinutes = extended.map((e) => e.min).toList();
    final extY = extended.map((e) => _coeffToY(e.coeff, e.isHigh, maxCoeff, baseY, maxAmplitude)).toList();

    // Sample per pixel
    final int widthPx = size.width.ceil();
    final List<Offset> samples = List.filled(widthPx + 1, Offset.zero, growable: false);
    int segIndex = 0;
    for (int px = 0; px <= widthPx; px++) {
      final double minute = (px / size.width) * totalMinutes;
      while (segIndex < extMinutes.length - 2 && minute > extMinutes[segIndex + 1]) {
        segIndex++;
      }
      final double t0 = extMinutes[segIndex];
      final double t1 = extMinutes[segIndex + 1];
      final double ratio = (t1 - t0).abs() < 1e-6 ? 0.0 : ((minute - t0) / (t1 - t0)).clamp(0.0, 1.0);
      final double s = (1 - math.cos(math.pi * ratio)) / 2;
      final double y = extY[segIndex] + (extY[segIndex + 1] - extY[segIndex]) * s;
      samples[px] = Offset(px.toDouble(), y);
    }

    // Fill under curve - fill only within the curve area
    final Path fillPath = Path()
      ..moveTo(0, curveAreaTop + curveAreaHeight)
      ..lineTo(samples[0].dx, samples[0].dy);
    for (int i = 1; i < samples.length; i++) {
      fillPath.lineTo(samples[i].dx, samples[i].dy);
    }
    fillPath.lineTo(size.width, curveAreaTop + curveAreaHeight);
    fillPath.close();
    canvas.drawPath(fillPath, gradientPaint);

    // Stroke
    final Path strokePath = Path()..moveTo(samples[0].dx, samples[0].dy);
    for (int i = 1; i < samples.length; i++) {
      strokePath.lineTo(samples[i].dx, samples[i].dy);
    }
    canvas.drawPath(strokePath, curvePaint);

    // Dot for current time
    final double nowMinutes = currentTime.hour * 60 + currentTime.minute + currentTime.second / 60.0;
    final double nowX = (nowMinutes / totalMinutes) * size.width;
    final double nowY = _yForMinute(nowMinutes, extMinutes, extY);
    canvas.drawCircle(Offset(nowX, nowY), 5.2, dotPaint);
    canvas.drawCircle(
      Offset(nowX, nowY),
      5.2,
      Paint()
        ..color = curveColor
        ..style = PaintingStyle.fill
        ..strokeWidth = 2,
    );

    // Labels above the curve (if space is available)
    if (isLabelsVisible) {
      final textPainter = TextPainter(textDirection: TextDirection.ltr);
      for (final t in tides) {
        final tideMinutes = (t.time.hour * 60 + t.time.minute).toDouble();
        final x = (tideMinutes / totalMinutes) * size.width;
        final y = _yForMinute(tideMinutes, extMinutes, extY);
        final timeStr = "${t.time.hour.toString().padLeft(2, '0')}:${t.time.minute.toString().padLeft(2, '0')}";
        final coeffStr = t.coefficient.toStringAsFixed(0);

        // Time label - positioned above the curve area
        textPainter.text = TextSpan(
          text: timeStr,
          style: TextStyle(color: curveColor, fontSize: 11, fontWeight: FontWeight.w500),
        );
        textPainter.layout();
        textPainter.paint(canvas, Offset(x - textPainter.width / 2, math.max(0, y - 30)));

        // Coefficient label
        textPainter.text = TextSpan(
          text: coeffStr,
          style: TextStyle(color: curveColor, fontSize: 10),
        );
        textPainter.layout();
        textPainter.paint(canvas, Offset(x - textPainter.width / 2, math.max(12, y - 17)));
      }
    }
  }

  double _yForMinute(double minute, List<double> extMinutes, List<double> extY) {
    if (minute <= extMinutes.first) return extY.first;
    if (minute >= extMinutes.last) return extY.last;
    int i = 0;
    while (i < extMinutes.length - 1 && minute > extMinutes[i + 1]) {
      i++;
    }
    final double t0 = extMinutes[i];
    final double t1 = extMinutes[i + 1];
    final double ratio = (t1 - t0).abs() < 1e-6 ? 0.0 : ((minute - t0) / (t1 - t0)).clamp(0.0, 1.0);
    final double s = (1 - math.cos(math.pi * ratio)) / 2;
    return extY[i] + (extY[i + 1] - extY[i]) * s;
  }

  static double _coeffToY(double coeff, bool isHigh, double maxCoeff, double baseY, double maxAmplitude) {
    final double normalized = (maxCoeff <= 0) ? 0.0 : (coeff / maxCoeff);
    final double amplitude = maxAmplitude * normalized;
    return baseY + (isHigh ? -amplitude : amplitude);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class _TidePoint {
  final double min;
  final double coeff;
  final bool isHigh;

  _TidePoint(this.min, this.coeff, this.isHigh);
}
