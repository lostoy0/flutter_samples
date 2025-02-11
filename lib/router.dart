import 'package:flutter_samples/features/chart/price_chart_page.dart';
import 'package:flutter_samples/features/countdown_page.dart';
import 'package:flutter_samples/features/easyrefresh_test_page.dart';
import 'package:flutter_samples/features/home_page.dart';
import 'package:flutter_samples/features/tab_page.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

import 'features/chart/price_chart_custum_page.dart';
import 'features/easyrefresh_example.dart';

class Pages {
  static const String home = '/';
  static const String countdown = '/countdown';
  static const String tabPage = '/tabPage';
  static const String easyRefreshPage = '/easyRefreshPage';
  static const String easyRefreshPage2 = '/easyRefreshPage2';
  static const String priceChart = '/priceChart';
  static const String priceChartCustom = '/priceChartCustom';

  static List<GetPage> pages = [
    GetPage(name: home, page: () => const MyHomePage()),
    GetPage(name: countdown, page: () => const CountdownPage()),
    GetPage(name: tabPage, page: () => const TabPage()),
    GetPage(name: easyRefreshPage, page: () => const EasyRefreshTestPage()),
    GetPage(name: easyRefreshPage2, page: () => const EasyRefreshExample()),
    GetPage(name: priceChart, page: () => const PriceChartPage()),
    GetPage(name: priceChartCustom, page: () => const PriceChartCustomPage()),
  ];
}
