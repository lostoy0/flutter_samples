import 'dart:async';
import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_samples/features/chart/price_chart_custom.dart';

class PriceChartCustomPage extends StatelessWidget {
  const PriceChartCustomPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Price Chart Custom')),
      body: const PriceChart2(),
    );
  }
}

class PriceChart2 extends StatefulWidget {
  const PriceChart2({super.key});

  @override
  State<PriceChart2> createState() => _PriceChartState();
}

class _PriceChartState extends State<PriceChart2>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  int _selectedInterval = 0; // 0: 4H, 1: 1D, 2: MAX
  Timer? _debounceTimer;
  double? _touchedXValue;

  List<ShowingTooltipIndicators> _activeTooltips = [];

  final List<List<double>> _data = [];

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < 3; i++) {
      _data.add(generatePrices(50));
    }
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);
  }

  void _switchInterval(int index) {
    setState(() {
      _selectedInterval = index;
      _controller.reset();
      _controller.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 300,
          color: Colors.transparent,
          child: PriceChartCustom(prices: _data[_selectedInterval]),
        ),
        Container(
          color: Colors.transparent,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton(
                onPressed: () => _switchInterval(0),
                child: const Text(
                  '4H',
                  style: TextStyle(color: Colors.green),
                ),
              ),
              TextButton(
                onPressed: () => _switchInterval(1),
                child: const Text(
                  '1D',
                  style: TextStyle(color: Colors.green),
                ),
              ),
              TextButton(
                onPressed: () => _switchInterval(2),
                child: const Text(
                  'MAX',
                  style: TextStyle(color: Colors.green),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  List<double> generatePrices(int count) {
    final Random random = Random();
    final List<double> prices = [];

    double price = 0.08; // 初始价格
    for (int i = 0; i < count; i++) {
      // 生成一个随机的价格变化
      double delta =
          (random.nextDouble() - 0.5) * 0.02; // 随机变化范围在 -0.01 到 0.01 之间
      price += delta;

      // 确保价格不会为负数
      if (price < 0) price = 0;

      // lastY 保留8位小数
      price = double.parse(price.toStringAsFixed(8));
      // 添加 FlSpot 节点
      prices.add(price);
    }

    return prices;
  }

  @override
  void dispose() {
    _controller.dispose();
    _debounceTimer?.cancel();
    super.dispose();
  }
}
