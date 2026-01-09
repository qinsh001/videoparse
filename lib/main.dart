import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:media_kit/media_kit.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:videoparse/protobuf/videoparse.pb.dart';
import 'package:videoparse/utils/app_utils.dart';
import 'package:videoparse/utils/extensions/hook_ext.dart';
import 'package:videoparse/utils/sp_utils.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_web/webview_flutter_web.dart';
final List<VideoParseItem> parseItems = [];

Future<void> main() async {
  WebViewPlatform.instance = WebWebViewPlatform();
  WidgetsFlutterBinding.ensureInitialized();
  await SpUtils.init();
  MediaKit.ensureInitialized();
  setPathUrlStrategy();
  GoogleFonts.config.allowRuntimeFetching = false;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Video Parse',
      theme: ThemeData(
        fontFamily: 'PingFang SC, Microsoft YaHei, Roboto, sans-serif',
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routerConfig: userAppRouter(),
    );
  }
}


