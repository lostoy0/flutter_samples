import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_samples/models/order_entity.dart';
import 'package:flutter_samples/models/result_entity.dart';
import 'package:flutter_samples/models/result_list_entity.dart';
import 'package:flutter_samples/models/user_entity.dart';
import 'package:flutter_samples/network/http_client.dart';

class NetworkTestPage extends StatelessWidget {
  const NetworkTestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Network Test'),),
      body: Row(
        children: [
          Expanded(child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(onPressed: () => testGet(), child: const Text('Test Get')),
              Container(height: 10.0,),
              ElevatedButton(onPressed: () => testPost(), child: const Text('Test Post')),
            ],
          ))
        ],
      ),
    );
  }
  
  void testGet() async {
    // final response = await Dio().get<ResultEntity<UserEntity>>('https://d4142d34-e936-4559-8902-6c766f9634b3.mock.pstmn.io/getUser');
    final response = await HttpClient.instance().get<UserEntity>('https://d4142d34-e936-4559-8902-6c766f9634b3.mock.pstmn.io/getUser');
    debugPrint('response type: ${response.data.runtimeType} data type: ${response.data?.data.runtimeType}');
    debugPrint('response: \n${response}');
  }
  
  void testPost() async {
    // final response = await Dio().post<ResultListEntity<OrderEntity>>('https://d4142d34-e936-4559-8902-6c766f9634b3.mock.pstmn.io/getOrders');
    final response = await HttpClient.instance().post<List<OrderEntity>>('https://d4142d34-e936-4559-8902-6c766f9634b3.mock.pstmn.io/getOrders');
    debugPrint('response type: ${response.data.runtimeType} data type: ${response.data?.data.runtimeType}');
    debugPrint('response: \n$response');
  }
}
