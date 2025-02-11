import 'dart:async';
import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_samples/global_instances.dart';

class PriceChart extends StatefulWidget {
  const PriceChart({super.key});

  @override
  State<PriceChart> createState() => _PriceChartState();
}

class _PriceChartState extends State<PriceChart>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  int _selectedInterval = 0; // 0: 4H, 1: 1D, 2: MAX
  Timer? _debounceTimer;
  double? _touchedXValue;

  List<ShowingTooltipIndicators> _activeTooltips = [];

  final List<List<FlSpot>> _data = [];

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < 3; i++) {
      _data.add(generateFlSpotData(50));
    }
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
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
        Row(
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
        SizedBox(
          height: 300,
          child: LineChart(
            LineChartData(
              lineTouchData: LineTouchData(
                touchTooltipData: LineTouchTooltipData(
                  getTooltipColor: (_) => Colors.transparent,
                  getTooltipItems: (List<LineBarSpot> touchedSpots) {
                    logger.d(
                        'getTooltipItems touchedSpots.length: ${touchedSpots.length}');
                    return touchedSpots.map((spot) {
                      logger.d(
                          'getTooltipItems spot.x: ${spot.x} spot.y: ${spot.y}');
                      return LineTooltipItem(
                        '${spot.y}', // 文案内容
                        const TextStyle(
                          color: Colors.black54, // 修改文案颜色为蓝色
                          fontWeight: FontWeight.bold,
                        ),
                      );
                    }).toList();
                  },
                  showOnTopOfTheChartBoxArea: true,
                  tooltipMargin: -16,
                ),
                getTouchLineStart: (barData, spotIndex) {
                  // 设置竖线的起始位置
                  return 0;
                },
                getTouchLineEnd: (barData, spotIndex) {
                  // 设置竖线的结束位置
                  logger.d(
                      'getTouchLineEnd barData.spots.length: ${barData.spots.length} spotIndex: $spotIndex');
                  return 1;
                },
                touchSpotThreshold: 10,
                handleBuiltInTouches: false,
                touchCallback:
                    (FlTouchEvent event, LineTouchResponse? response) {
                  logger.d(
                      'touchCallback event.runtimeType: ${event.runtimeType} lineBarSpots x: ${response?.lineBarSpots?.first.x} y: ${response?.lineBarSpots?.first.y}');
                  if (event is FlPanDownEvent ||
                      event is FlPanUpdateEvent ||
                      event is FlLongPressStart ||
                      event is FlLongPressMoveUpdate) {
                    final newX = response?.lineBarSpots?.first.x;
                    // final intervalThreshold =
                    //     (20 / (Get.width / _data[_selectedInterval].length))
                    //         .toInt();
                    // logger.d(
                    //     'touchCallback intervalThreshold: $intervalThreshold');
                    // if (newX == null ||
                    //     _touchedXValue == newX ||
                    //     _touchedXValue != null &&
                    //         (_touchedXValue! - newX).abs() <
                    //             intervalThreshold) {
                    //   return;
                    // }
                    final lineBarSpots = response?.lineBarSpots;
                    if (lineBarSpots != null &&
                        lineBarSpots.isNotEmpty &&
                        event.localPosition != null) {
                      // 获取最近的数据点索引
                      final nearestSpot = lineBarSpots.reduce((a, b) =>
                          (a.x - event.localPosition!.dx).abs() <
                                  (b.x - event.localPosition!.dx).abs()
                              ? a
                              : b);
                      setState(() {
                        _touchedXValue = newX;
                        _activeTooltips = [
                          // ShowingTooltipIndicators(
                          //   lineBarSpots,
                          // ),
                        ];
                      });
                    }
                  } else if (event is FlPanEndEvent ||
                      event is FlPanCancelEvent ||
                      event is FlLongPressEnd) {
                    setState(() {
                      _touchedXValue = null;
                      _activeTooltips = [];
                    });
                  }
                },
                getTouchedSpotIndicator:
                    (LineChartBarData barData, List<int> spotIndexes) {
                  // 设置竖线样式
                  return spotIndexes.map((spotIndex) {
                    return TouchedSpotIndicatorData(
                      FlLine(
                        color: spotIndex == 0
                            ? Colors.grey
                            : Colors.transparent, // 竖线颜色
                        strokeWidth: 1, // 竖线宽度
                        dashArray: const [5, 5], // 虚线样式
                      ),
                      const FlDotData(show: false), // 隐藏圆点
                    );
                  }).toList();
                },
              ),
              lineBarsData: _generateLineBarsData(),
              showingTooltipIndicators: _activeTooltips,
              titlesData: const FlTitlesData(show: false),
              borderData: FlBorderData(show: false),
              gridData: const FlGridData(show: false),
            ),
          ),
        ),
      ],
    );
  }

  List<LineChartBarData> _generateLineBarsData() {
    if (_touchedXValue == null) {
      return [
        getLineChartBarData(_data[_selectedInterval], Colors.green, false)
      ];
    }

    List<FlSpot> leftSpots = [];
    List<FlSpot> rightSpots = [];

    for (var spot in _data[_selectedInterval]) {
      if (spot.x < _touchedXValue!) {
        leftSpots.add(spot);
      } else if (spot.x == _touchedXValue) {
        leftSpots.add(spot);
        rightSpots.add(spot);
      } else {
        rightSpots.add(spot);
      }
    }

    return [
      getLineChartBarData(leftSpots, Colors.green, false),
      getLineChartBarData(rightSpots, Colors.grey, false),
    ];
  }

  LineChartBarData getLineChartBarData(
      List<FlSpot> spots, Color color, bool showIndicator) {
    return LineChartBarData(
      spots: spots,
      isCurved: true,
      color: color,
      barWidth: 2,
      dotData: const FlDotData(show: false),
      showingIndicators: showIndicator
          ? [spots.indexWhere((spot) => spot.x == _touchedXValue)]
          : [],
      belowBarData: BarAreaData(
        show: true,
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            color.withAlpha((0.3 * 255).toInt()), // 顶部颜色
            color.withAlpha(0), // 底部颜色（完全透明）
          ],
        ),
      ),
    );
  }

  List<FlSpot> generateFlSpotData(int count) {
    final Random random = Random();
    final List<FlSpot> spots = [];

    double lastY = 0.08; // 初始价格
    for (int i = 0; i < count; i++) {
      // 生成一个随机的价格变化
      double delta =
          (random.nextDouble() - 0.5) * 0.02; // 随机变化范围在 -0.01 到 0.01 之间
      lastY += delta;

      // 确保价格不会为负数
      if (lastY < 0) lastY = 0;

      // lastY 保留8位小数
      lastY = double.parse(lastY.toStringAsFixed(8));
      // 添加 FlSpot 节点
      spots.add(FlSpot(i.toDouble(), lastY));
    }

    return spots;
  }

  @override
  void dispose() {
    _controller.dispose();
    _debounceTimer?.cancel();
    super.dispose();
  }
}
