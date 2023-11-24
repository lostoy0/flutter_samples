import 'package:flutter_samples/pages/home_page.dart';
import 'package:flutter_samples/pages/html_test_page.dart';
import 'package:flutter_samples/pages/network_test_page.dart';
import 'package:get/get.dart';

class Routes {
  static const home = '/home';
  static const htmlTest = '/html-test';
  static const networkTest = '/network-test';
}

class Pages {
  static final pages = [
    GetPage(name: Routes.home, page: () => const HomePage()),
    GetPage(name: Routes.htmlTest, page: () => HtmlTestPage()),
    GetPage(name: Routes.networkTest, page: () => NetworkTestPage())
  ];
}
