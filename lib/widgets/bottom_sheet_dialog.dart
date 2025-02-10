import 'package:flutter/material.dart';

void showBottomSheetDemoDialog(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (context) => BottomSheetContent(),
  );
}

class BottomSheetContent extends StatefulWidget {
  @override
  _BottomSheetContentState createState() => _BottomSheetContentState();
}

class _BottomSheetContentState extends State<BottomSheetContent> {
  TextEditingController _searchController = TextEditingController();
  List<String> _dataList = List.generate(100, (index) => 'Item $index');
  List<String> _filteredDataList = [];

  @override
  void initState() {
    super.initState();
    _filteredDataList = _dataList;
    _searchController.addListener(() {
      setState(() {
        _filteredDataList = _dataList
            .where((item) =>
            item.toLowerCase().contains(_searchController.text.toLowerCase()))
            .toList();
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      builder: (context, scrollController) {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  labelText: 'Search',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                controller: scrollController,
                itemCount: _filteredDataList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_filteredDataList[index]),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
