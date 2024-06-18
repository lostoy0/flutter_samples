import 'package:flutter/material.dart';
import 'proxy_parser.dart';

const subscriptionUrl = "";

class ProxyListScreen extends StatefulWidget {
  @override
  _ProxyListScreenState createState() => _ProxyListScreenState();
}

class _ProxyListScreenState extends State<ProxyListScreen> {
  final ProxyParser _proxyParser = ProxyParser();
  late Future<List<ProxyServer>> _futureProxies;

  @override
  void initState() {
    super.initState();
    _futureProxies = _proxyParser.fetchAndParseProxies(subscriptionUrl);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Proxy List'),
      ),
      body: FutureBuilder<List<ProxyServer>>(
        future: _futureProxies,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No proxies found'));
          } else {
            List<ProxyServer> proxies = snapshot.data!;
            return ListView.builder(
              itemCount: proxies.length,
              itemBuilder: (context, index) {
                ProxyServer proxy = proxies[index];
                return ListTile(
                  title: Text(proxy.address),
                  subtitle: Text(
                      'Port: ${proxy.port}\nDescription: ${proxy.description}'),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _futureProxies = _proxyParser.fetchAndParseProxies(subscriptionUrl);
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
