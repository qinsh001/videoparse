import 'dart:js_interop';
import 'dart:ui_web' as ui_web;
import 'package:flutter/material.dart';
import 'package:web/web.dart' as web;

class MyIFrame extends StatefulWidget {
  final String url;
  const MyIFrame(this.url, {super.key});

  @override
  State<MyIFrame> createState() => _MyIFrameState();
}

class _MyIFrameState extends State<MyIFrame> {
  // 1. 将 IFrame 元素提升为 State 的成员变量
  late final web.HTMLIFrameElement _iframe;
  late final String _viewId;
  @override
  void initState() {
    super.initState();

    _viewId = 'iframe-${DateTime.now().millisecondsSinceEpoch}';

    // 2. 在 initState 中创建 IFrame 实例
    _iframe = web.HTMLIFrameElement()
      ..src = widget.url // 初始设置 URL
      ..style.border = 'none'
      ..style.width = '100%'
      ..style.height = '100%'
      ..allowFullscreen = true
      ..setAttribute('allow', 'fullscreen');

    // 3. 注册工厂，让它返回我们已经创建好的 _iframe 实例
    ui_web.platformViewRegistry.registerViewFactory(_viewId, (int viewId) => _iframe);
  }

  /// 4. 实现 didUpdateWidget 生命周期方法
  @override
  void didUpdateWidget(covariant MyIFrame oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.url != oldWidget.url) {
      // 5. 直接更新 IFrame 元素的 src 属性
      _iframe.src = widget.url;
    }
  }

  @override
  Widget build(BuildContext context) {
    return HtmlElementView(viewType: _viewId);
  }
}

