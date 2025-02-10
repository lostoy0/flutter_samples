import 'package:flutter/material.dart';
import 'package:flutter_samples/ext/string_ext.dart';
import 'package:flutter_samples/router.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    debugPrint('0.0000001324 = ${"0.0000001324".formatZero(minZeroCount: 4)}');
    return GetMaterialApp(
      title: 'Flutter Demo',
      getPages: Pages.pages,
      initialRoute: Pages.home,
    );
  }
}
