import 'dart:convert';
import 'package:dio/dio.dart';

class ProxyServer {
  final String method;
  final String password;
  final String address;
  final int port;
  final String description;

  ProxyServer({
    required this.method,
    required this.password,
    required this.address,
    required this.port,
    required this.description,
  });

  @override
  String toString() {
    return 'ProxyServer{method: $method, password: $password, address: $address, port: $port, description: $description}';
  }
}

class ProxyParser {
  final Dio _dio = Dio();

  Future<List<ProxyServer>> fetchAndParseProxies(String url) async {
    try {
      // 1. 用 dio 发送请求
      Response response = await _dio.get(url);
      if (response.statusCode == 200) {
        // 2. base64 解码
        String decodedContent = utf8.decode(base64.decode(_normalizeBase64(response.data.trim())));

        // 3. 按行解析 Shadowsocks 连接信息
        List<String> lines = decodedContent.split('\n');
        List<ProxyServer> servers = [];

        for (String line in lines) {
          if (line.isNotEmpty) {
            // Shadowsocks 连接信息格式: ss://base64-encoded-method:password@hostname:port#description
            if (line.startsWith('ss://')) {
              // 去掉 ss:// 前缀
              String content = line.substring(5);

              // 拆分 base64 编码部分和剩余部分
              int atIndex = content.indexOf('@');
              if (atIndex != -1) {
                String base64Part = content.substring(0, atIndex);
                String remainingPart = content.substring(atIndex + 1);

                // 解码 base64 部分
                String decodedBase64 = utf8.decode(base64.decode(_normalizeBase64(base64Part)));

                // 分离 method:password 和 hostname:port#description
                int colonIndex = decodedBase64.indexOf(':');
                if (colonIndex != -1) {
                  String method = decodedBase64.substring(0, colonIndex);
                  String password = decodedBase64.substring(colonIndex + 1);

                  String hostnameAndPort = remainingPart;
                  String description = '';
                  int hashIndex = remainingPart.indexOf('#');
                  if (hashIndex != -1) {
                    hostnameAndPort = remainingPart.substring(0, hashIndex);
                    description = Uri.decodeComponent(remainingPart.substring(hashIndex + 1));
                  }

                  // 分离 hostname 和 port
                  int portIndex = hostnameAndPort.lastIndexOf(':');
                  if (portIndex != -1) {
                    String hostname = hostnameAndPort.substring(0, portIndex);
                    int port = int.parse(hostnameAndPort.substring(portIndex + 1));

                    servers.add(ProxyServer(
                      method: method,
                      password: password,
                      address: hostname,
                      port: port,
                      description: description,
                    ));
                  }
                }
              }
            }
          }
        }

        // 4. 返回结构化的代理服务器列表
        return servers;
      } else {
        throw Exception('Failed to fetch proxy list');
      }
    } catch (e) {
      throw Exception('Error parsing proxy list: $e');
    }
  }

  String _normalizeBase64(String base64String) {
    return base64String.padRight((base64String.length + 3) ~/ 4 * 4, '=');
  }
}
