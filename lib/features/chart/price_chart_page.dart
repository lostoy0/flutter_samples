import 'package:flutter/material.dart';
import 'package:flutter_samples/features/chart/price_chart.dart';

class PriceChartPage extends StatelessWidget {
  const PriceChartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Price Chart')),
      body: const PriceChart(),
    );
  }
}
