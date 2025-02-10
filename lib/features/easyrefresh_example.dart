import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';

class EasyRefreshExample extends StatefulWidget {
  const EasyRefreshExample({super.key});

  @override
  State<EasyRefreshExample> createState() => _EasyRefreshExampleState();
}

class _EasyRefreshExampleState extends State<EasyRefreshExample> {
  List<int> items = List.generate(20, (index) => index);

  Future<void> _refresh() async {
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      items = List.generate(20, (index) => index + 20);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('EasyRefresh Example'),
      ),
      body: EasyRefresh(
        header: const ClassicHeader(),
        onRefresh: _refresh,
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Container(
                height: 200,
                color: Colors.red,
                child: Center(child: Text('Section 1')),
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                height: 200,
                color: Colors.green,
                child: Center(child: Text('Section 2')),
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                height: 200,
                color: Colors.blue,
                child: Center(child: Text('Section 3')),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                    (context, index) {
                  return ListTile(
                    title: Text('Item $index'),
                  );
                },
                childCount: items.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
