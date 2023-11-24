import 'package:flutter/material.dart';
import 'package:flutter_samples/routes.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: Row(
        children: [
          Expanded(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  Get.toNamed(Routes.htmlTest);
                },
                child: const Text('Html Test'),
              ),
              Container(height: 10.0,),
              ElevatedButton(
                onPressed: () {
                  Get.toNamed(Routes.networkTest);
                },
                child: const Text('Network Test'),
              ),
            ],
          ))
        ],
      ),
    );
  }
}
