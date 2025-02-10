import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';

class EasyRefreshTestPage extends StatefulWidget {
  const EasyRefreshTestPage({super.key});

  @override
  State<EasyRefreshTestPage> createState() => _EasyRefreshTestPageState();
}

class _EasyRefreshTestPageState extends State<EasyRefreshTestPage> {
  List<int> items = List.generate(20, (index) => index);

  Future<void> _refresh() async {
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      items = List.generate(20, (index) => index + 20);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('EasyRefresh'),
      // ),
      body: Container(
        child: Column(
          children: [
            Container(
              height: 50,
              color: Colors.blue,
              child: Row(
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('返回'),
                  ),
                ],
              ),
            ),
            Expanded(
              child: EasyRefresh(
                onRefresh: () async {},
                header: const ClassicHeader(),
                child: SingleChildScrollView(
                  child: Column(
                    children: items.map((item) {
                      return ListTile(
                        title: Text('Item $item'),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
