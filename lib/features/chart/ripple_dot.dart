import 'package:flutter/material.dart';

class RippleDotDemo extends StatelessWidget {
  const RippleDotDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: RippleDot(
                radius: 20,
                color: Colors.blue,
                centerPointRadius: 5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RippleDot extends StatefulWidget {
  final double radius;
  final Color color;
  final double centerPointRadius;

  const RippleDot(
      {super.key,
      required this.radius,
      required this.color,
      required this.centerPointRadius});

  @override
  State<RippleDot> createState() => _RippleDotState();
}

class _RippleDotState extends State<RippleDot>
    with SingleTickerProviderStateMixin {
  late AnimationController _rippleDotAnimController;

  @override
  void initState() {
    super.initState();
    _rippleDotAnimController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
  }

  @override
  void dispose() {
    _rippleDotAnimController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 2 * widget.radius,
      height: 2 * widget.radius,
      child: AnimatedBuilder(
        animation: _rippleDotAnimController,
        builder: (context, child) {
          return CustomPaint(
            size: Size.square(2 * widget.radius),
            painter: RippleDotPainter(
                progress: _rippleDotAnimController.value,
                radius: widget.radius,
                color: widget.color,
                centerPointRadius: widget.centerPointRadius),
          );
        },
      ),
    );
  }
}

class RippleDotPainter extends CustomPainter {
  final double progress;
  final double radius;
  final Color color;
  final double centerPointRadius;

  RippleDotPainter(
      {required this.progress,
      required this.radius,
      required this.color,
      required this.centerPointRadius});

  @override
  void paint(Canvas canvas, Size size) {
    final dotPaint = Paint()..color = color;
    final ripplePaint = Paint()
      ..color = color.withOpacity(1 - progress)
      ..style = PaintingStyle.fill
      ..strokeWidth = 2;

    final center = Offset(size.width / 2, size.height / 2);

    // 画中心的圆点
    canvas.drawCircle(center, centerPointRadius, dotPaint);

    // 画扩散的水纹
    final rippleRadius = radius * progress;
    canvas.drawCircle(center, rippleRadius, ripplePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
