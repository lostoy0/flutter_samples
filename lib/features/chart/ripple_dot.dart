import 'package:flutter/material.dart';

class RippleDotDemo extends StatelessWidget {
  const RippleDotDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Center(
          child: SizedBox(
            width: 40,
            height: 40,
            child: RippleDot(),
          ),
        ),
      ),
    );
  }
}

class RippleDot extends StatefulWidget {
  const RippleDot({super.key});

  @override
  State<RippleDot> createState() => _RippleDotState();
}

class _RippleDotState extends State<RippleDot>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  int _count = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 40,
      height: 40,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          if (_count < 60) {
            _count++;
          } else {
            _count = 0;
          }
          return CustomPaint(
            size: const Size.square(40),
            painter: RippleDotPainter(_controller.value),
          );
        },
      ),
    );
  }
}


int _count2 = 0;

class RippleDotPainter extends CustomPainter {
  final double progress;

  RippleDotPainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    if (_count2 < 60) {
      _count2++;
    } else {
      _count2 = 0;
    }
    final center = Offset(size.width / 2, size.height / 2);
    final dotPaint = Paint()..color = Colors.blueAccent;
    final ripplePaint = Paint()
      ..color = Colors.blueAccent.withOpacity(1 - progress)
      ..style = PaintingStyle.fill
      ..strokeWidth = 2;

    // 画中心的圆点
    canvas.drawCircle(center, 5, dotPaint);

    // 画扩散的水纹
    final maxRadius = 20;
    final rippleRadius = maxRadius * progress;
    canvas.drawCircle(center, rippleRadius, ripplePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
