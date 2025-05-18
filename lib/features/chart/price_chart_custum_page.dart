import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_samples/features/chart/price_chart_custom.dart';
import 'package:flutter_samples/global_instances.dart';

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

/*
{
    "close": "2.53139181",
    "time": 1740580200
  }
 */
class KlinePoint {
  final double close;
  final int time;

  KlinePoint({required this.close, required this.time});

  factory KlinePoint.fromJson(Map<String, dynamic> json) {
    return KlinePoint(
      close: double.parse(json['close']),
      time: json['time'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'close': close,
      'time': time,
    };
  }
}

class _PriceChartState extends State<PriceChart2>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  int _selectedInterval = 0;
  Timer? _debounceTimer;
  double? _touchedXValue;

  List<List<KlinePoint>> _data = [];
  late List<KlinePoint> _oldPrices;
  late List<KlinePoint> _currentPrices;

  @override
  void initState() {
    super.initState();
    // 初始化三个数据集，每个包含50个数据点
    _data = List.generate(3, (index) => generatePrices(500));
    _oldPrices = List.from(_data[0]);
    _currentPrices = List.from(_data[0]);

    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller)
      ..addListener(() {
        setState(() {
          // 根据动画进度插值生成过渡数据
          _currentPrices = _interpolatePrices(
            _oldPrices,
            _data[_selectedInterval],
            _animation.value,
          );
        });
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          // 动画完成后更新旧数据
          _oldPrices = List.from(_data[_selectedInterval]);
        }
      });

    Future.wait([
      loadJsonData("assets/json/kline_4h.json"),
      loadJsonData("assets/json/kline_1d.json"),
      loadJsonData("assets/json/kline_1y.json"),
    ]).then((data) {
      _data = data;
      setState(() {
        _oldPrices = List.from(_data[0]);
        _currentPrices = List.from(_data[0]);
      });
    }).onError((e, s) {
      logger.e(e, stackTrace: s);
    });
  }

  Future<List<KlinePoint>> loadJsonData(String fileName) async {
    String jsonString = await rootBundle.loadString(fileName);
    Map<String, dynamic> klineJson = jsonDecode(jsonString);
    List<dynamic> points = klineJson['data']['points'];
    List<KlinePoint> kline = points.map((point) {
      return KlinePoint.fromJson(point);
    }).toList();
    return kline;
  }

  void _switchInterval(int index) {
    if (index == _selectedInterval) return;
    setState(() {
      _oldPrices = List.from(_currentPrices);
      _selectedInterval = index;
      _controller.reset();
      _controller.forward();
    });
  }

  List<KlinePoint> _interpolatePrices(
    List<KlinePoint> start,
    List<KlinePoint> end,
    double progress,
  ) {
    assert(start.length == end.length, "Data length mismatch");
    return List.generate(start.length, (i) {
      return KlinePoint(
          close: start[i].close + (end[i].close - start[i].close) * progress,
          time: start[i].time);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 300,
          color: Colors.transparent,
          child: PriceChartCustom(prices: _currentPrices),
        ),
        Container(
          color: Colors.transparent,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton(
                onPressed: () => _switchInterval(0),
                child: Text(
                  '4H',
                  style: TextStyle(
                    color: _selectedInterval == 0 ? Colors.green : Colors.grey,
                  ),
                ),
              ),
              TextButton(
                onPressed: () => _switchInterval(1),
                child: Text(
                  '1D',
                  style: TextStyle(
                    color: _selectedInterval == 1 ? Colors.green : Colors.grey,
                  ),
                ),
              ),
              TextButton(
                onPressed: () => _switchInterval(2),
                child: Text(
                  'MAX',
                  style: TextStyle(
                    color: _selectedInterval == 2 ? Colors.green : Colors.grey,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  List<KlinePoint> generatePrices(int count) {
    final random = Random();
    List<KlinePoint> prices = [];
    double price = 0.08;
    for (int i = 0; i < count; i++) {
      double delta = (random.nextDouble() - 0.5) * 0.02;
      price += delta;
      price = price.clamp(0, double.infinity);
      prices.add(KlinePoint(
          close: double.parse(price.toStringAsFixed(8)),
          time: DateTime.now().millisecondsSinceEpoch));
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
