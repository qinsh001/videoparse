import 'package:flutter/material.dart';
// 导入 media_kit 相关包
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';

class MyVideoPlayer extends StatefulWidget {
  final String videoUrl;
  const MyVideoPlayer({super.key, required this.videoUrl});

  @override
  State<MyVideoPlayer> createState() => _MyVideoPlayerState();
}

class _MyVideoPlayerState extends State<MyVideoPlayer> {
  // 1. 定义播放器和控制器
  late final player = Player();
  late final controller = VideoController(player);

  @override
  void initState() {
    super.initState();
    // 2. 初始化播放器并打开视频
    player.open(Media(widget.videoUrl));
  }

  @override
  void dispose() {
    // 3. 释放资源
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: AspectRatio(
            aspectRatio: 16 / 9, //
            child: Video(
              controller: controller,
              // 使用 Material 风格的控制条
              controls: MaterialVideoControls,
            ),
          ),
        ),
      ),
    );
  }
}