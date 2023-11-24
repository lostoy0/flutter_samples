import 'dart:html';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

class HtmlTestPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    DivElement frame = DivElement();
    IFrameElement iframe = IFrameElement()
      ..style.width = '100%'
      ..style.height = '100%'
      // ..src = 'https://flutter.dev'
      ..src = '/web/test.html'
      ..style.border = 'none';
    frame.append(iframe);
    // //设置token
    // StyleElement sFrame = StyleElement();
    // String script = """localStorage.setItem('token',token)""";
    // sFrame.innerHtml = script;
    // frame.append(sFrame);
    //ignore: undefined_prefixed_name
    ui.platformViewRegistry
        .registerViewFactory('hello-world', (int viewId) => frame);
    return Scaffold(
      appBar: AppBar(title: const Text('Html Test')),
      body: const HtmlElementView(
        viewType: "hello-world",
      ),
    );
  }
}
