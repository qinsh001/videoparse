import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:cached_network_image/cached_network_image.dart'; // 1. 导入这个包
class ImageViewerPage extends StatelessWidget {
  final String imageUrl;

  const ImageViewerPage({
    super.key,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 使用黑色背景更适合图片预览
      backgroundColor: Colors.black,
      body: Center(
        child: PhotoView(
          imageProvider: CachedNetworkImageProvider(imageUrl),
          // --- 以下是常用配置，可以根据需要调整 ---
          // 加载时显示的 Widget
          loadingBuilder: (context, event) => const Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          ),
          // 背景装饰
          backgroundDecoration: const BoxDecoration(
            color: Colors.black,
          ),
          // 最小和最大缩放比例
          minScale: PhotoViewComputedScale.contained * 0.8,
          maxScale: PhotoViewComputedScale.covered * 2.0,
          // 初始缩放比例
          initialScale: PhotoViewComputedScale.contained,
          // 英雄动画标签，可以实现平滑的过渡效果（如果列表页也有对应tag）
          // heroAttributes: PhotoViewHeroAttributes(tag: imageUrl),
        ),
      ),
    );
  }
}
