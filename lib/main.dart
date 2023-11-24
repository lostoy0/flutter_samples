import 'package:flutter/material.dart';
import 'package:flutter_samples/routes.dart';
import 'package:get/get.dart';

void main() {
  runApp(
    GetMaterialApp(
      title: 'Flutter Samples',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/home',
      getPages: Pages.pages,
    ),
  );
}
