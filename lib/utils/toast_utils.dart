// lib/utils/toast_utils.dart

import 'package:flutter/material.dart';

enum ToastType { success, error, warning, info }

class ToastUtils {
  // 私有构造函数，防止外部实例化
  ToastUtils._();

  static void show(
      BuildContext context,
      String message, {
        ToastType type = ToastType.info,
      }) {
    // 根据不同的类型选择不同的背景颜色
    Color backgroundColor;
    switch (type) {
      case ToastType.success:
        backgroundColor = Colors.green;
        break;
      case ToastType.error:
        backgroundColor = Colors.red;
        break;
      case ToastType.warning:
        backgroundColor = Colors.orange;
        break;
      case ToastType.info:
      backgroundColor = Colors.black87;
        break;
    }

    // 在调用 showSnackBar 之前，先移除当前的 SnackBar（如果有的话）
    // 这可以防止用户快速连续点击时，SnackBar 队列堆积
    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    // 显示新的 SnackBar
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: backgroundColor,
        behavior: SnackBarBehavior.floating, // 浮动样式，在Web上更好看
        margin: const EdgeInsets.all(12), // 配合 floating 使用
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        duration: const Duration(seconds: 3), // 持续时间
      ),
    );
  }

  // 为了方便调用，可以创建几个快捷方法
  static void success(BuildContext context, String message) {
    show(context, message, type: ToastType.success);
  }

  static void error(BuildContext context, String message) {
    show(context, message, type: ToastType.error);
  }

  static void warning(BuildContext context, String message) {
    show(context, message, type: ToastType.warning);
  }
}
