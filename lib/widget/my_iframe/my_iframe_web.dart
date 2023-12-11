import 'package:flutter/material.dart';
import 'package:webview_flutter_platform_interface/webview_flutter_platform_interface.dart';


class MyIFrame extends StatefulWidget {
  final String url;
  final Function(double, dynamic)? heightFunc;

  const MyIFrame(this.url, {Key? key, this.heightFunc}) : super(key: key);

  @override
  State<MyIFrame> createState() => _MyIFrameState();
}

class _MyIFrameState extends State<MyIFrame> {
  late final PlatformWebViewController _controller = PlatformWebViewController(
    const PlatformWebViewControllerCreationParams(),
  )..loadRequest(
    LoadRequestParams(
      uri: Uri.parse(widget.url),
    ),
  );

  @override
  void didUpdateWidget(covariant MyIFrame oldWidget) {
    if (widget.url != oldWidget.url) {
      _controller.loadRequest(LoadRequestParams(
        uri: Uri.parse(widget.url),
      ));
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        PlatformWebViewWidget(
          PlatformWebViewWidgetCreationParams(controller: _controller),
        ).build(context),
      ],
    );
  }
}
