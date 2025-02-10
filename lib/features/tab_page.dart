import 'package:flutter/material.dart';

class TabPage extends StatelessWidget {
  const TabPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tab page'),
      ),
      body: DefaultTabController(
        length: 3,
        child: Column(
          children: [
            Container(
              color: Colors.blue,
              child: TabBar(
                isScrollable: true,
                tabAlignment: TabAlignment.start,
                indicatorColor: Colors.red,
                dividerHeight: 2,
                labelPadding: EdgeInsets.only(left: 16),
                tabs: [
                  Tab(height: 32, text: 'Tab 1111111'),
                  Tab(height: 32, text: 'Tab 2'),
                  Tab(height: 32, text: 'Tab 3'),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  Center(child: Text('Tab 1')),
                  Center(child: Text('Tab 2')),
                  Center(child: Text('Tab 3')),
                ]
              )
            )
          ]
        )
      ),
    );
  }
}
