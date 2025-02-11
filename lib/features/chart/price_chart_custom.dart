import 'package:flutter/material.dart';
import 'dart:math' as math;

class PriceChartCustom extends StatefulWidget {
  final List<double> prices;

  const PriceChartCustom({super.key, required this.prices});

  @override
  State<PriceChartCustom> createState() => _PriceChartState();
}

class _PriceChartState extends State<PriceChartCustom> {
  double? _selectedX;
  bool _isDragging = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanStart: (details) => _handleTouch(details.localPosition.dx),
      onPanUpdate: (details) => _handleTouch(details.localPosition.dx),
      onPanEnd: (_) => _clearSelection(),
      onPanCancel: () => _clearSelection(),
      child: CustomPaint(
        size: const Size(double.infinity, 300), // 260 主图 + 40 顶部文本区域
        painter: _ChartPainter(
          prices: widget.prices,
          selectedX: _isDragging ? _selectedX : null,
        ),
      ),
    );
  }

  void _handleTouch(double x) {
    setState(() {
      _selectedX = x.clamp(0, double.infinity);
      _isDragging = true;
    });
  }

  void _clearSelection() {
    setState(() {
      _isDragging = false;
      _selectedX = null;
    });
  }
}

class _ChartPainter extends CustomPainter {
  final List<double> prices;
  final double? selectedX;

  static const double mainChartHeight = 260; // 主图的高度
  static const double extraHeight = 40; // 顶部文本区域的高度

  _ChartPainter({required this.prices, this.selectedX});

  @override
  void paint(Canvas canvas, Size size) {
    if (prices.isEmpty) return;

    final pricePoints = _calculatePricePoints(size);
    _drawGradientArea(canvas, size, pricePoints);
    _drawPriceLine(canvas, pricePoints);

    if (selectedX != null) {
      _drawVerticalLine(canvas, size, selectedX!);
      _drawPriceText(canvas, size, selectedX!);
    }
  }

  List<Offset> _calculatePricePoints(Size size) {
    final minPrice = prices.reduce(math.min);
    final maxPrice = prices.reduce(math.max);
    final range = maxPrice - minPrice;
    final stepX = size.width / (prices.length - 1);

    return prices.asMap().entries.map((entry) {
      final x = entry.key * stepX;
      final y = mainChartHeight - (entry.value - minPrice) / range * mainChartHeight;
      return Offset(x, y + extraHeight); // 调整价格点 y 坐标
    }).toList();
  }

  void _drawGradientArea(Canvas canvas, Size size, List<Offset> points) {
    Path path = Path()
      ..moveTo(points.first.dx, points.first.dy)
      ..addPolygon(points, false)
      ..lineTo(size.width, mainChartHeight + extraHeight)
      ..lineTo(0, mainChartHeight + extraHeight)
      ..close();

    final gradient = LinearGradient(
      colors: [Colors.blue.withOpacity(0.3), Colors.transparent],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    );

    canvas.drawPath(
      path,
      Paint()..shader = gradient.createShader(Rect.fromLTRB(0, 0, size.width, mainChartHeight + extraHeight)),
    );
  }

  void _drawPriceLine(Canvas canvas, List<Offset> points) {
    if (points.length < 2) return;

    Paint greenPaint = Paint()
      ..color = Colors.green
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    Paint grayPaint = Paint()
      ..color = Colors.grey
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    int splitIndex = selectedX == null ? points.length : (selectedX! / points.last.dx * points.length).clamp(0, points.length - 1).toInt();

    for (int i = 0; i < points.length - 1; i++) {
      final start = points[i];
      final end = points[i + 1];

      final paint = i < splitIndex ? greenPaint : grayPaint;
      canvas.drawLine(start, end, paint);
    }
  }

  void _drawVerticalLine(Canvas canvas, Size size, double x) {
    final clampedX = x.clamp(0, size.width).toDouble();

    final paint = Paint()
      ..color = Colors.grey
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    const dashHeight = 5;
    const dashSpace = 5;
    double startY = extraHeight; // 从 40px（顶部文本区域）开始绘制竖线
    while (startY < mainChartHeight + extraHeight) {
      double endY = startY + dashHeight;
      if (endY > mainChartHeight + extraHeight) endY = mainChartHeight + extraHeight;
      canvas.drawLine(Offset(clampedX, startY), Offset(clampedX, endY), paint);
      startY += dashHeight + dashSpace;
    }
  }

  void _drawPriceText(Canvas canvas, Size size, double x) {
    final index = ((x / size.width) * (prices.length - 1))
        .round()
        .clamp(0, prices.length - 1);
    final price = prices[index];

    final textPainter = TextPainter(
      text: TextSpan(
        text: '\$${price.toStringAsFixed(2)}',
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();

    final offsetX = (x - textPainter.width / 2)
        .clamp(0, size.width - textPainter.width)
        .toDouble();
    final offsetY = (40 - textPainter.height) / 2; // 文本位于顶部文本区域上方

    // 绘制背景
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(
          offsetX - 4,
          offsetY - 2,
          textPainter.width + 8,
          textPainter.height + 4,
        ),
        const Radius.circular(4),
      ),
      Paint()..color = Colors.black.withOpacity(0.7),
    );

    // 绘制文本
    textPainter.paint(canvas, Offset(offsetX, offsetY));
  }

  @override
  bool shouldRepaint(covariant _ChartPainter oldDelegate) {
    return oldDelegate.prices != prices || oldDelegate.selectedX != selectedX;
  }
}
