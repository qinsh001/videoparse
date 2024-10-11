import 'package:flutter/material.dart';
import 'package:flutter_fullscreen/flutter_fullscreen.dart';
import 'package:videoparse/page/web_page.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_web/webview_flutter_web.dart';

Future<void> main() async {
  WebViewPlatform.instance = WebWebViewPlatform();
  WidgetsFlutterBinding.ensureInitialized();
  await FullScreen.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Video Parse',
      theme: ThemeData(
        fontFamily: 'NotoSansSC',
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const WebDataPage(),
    );
  }
}


