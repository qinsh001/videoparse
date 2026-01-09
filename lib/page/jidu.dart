import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:videoparse/router/router.dart';

import 'package:videoparse/utils/network/ApiUtils.dart';

import '../model/simple_models.dart';
import '../widget/my_iframe/my_iframe_web2.dart';

class SongListPage extends StatefulWidget {
  const SongListPage({super.key});

  @override
  State<SongListPage> createState() => _SongListPageState();
}

class _SongListPageState extends State<SongListPage>
    with SingleTickerProviderStateMixin {
  // 你的目录地址

  final tabs = ["迦南诗选", "赞美诗", "赞美诗歌", "视频"];
  late final tabC = TabController(length: tabs.length, vsync: this);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("弟兄姊妹平安"),
        bottom: TabBar(
            controller: tabC,
            tabs: tabs
                .map((e) => Tab(
                      text: e,
                    ))
                .toList()),
      ),
      body: TabBarView(controller: tabC, children: [
        TabBarItem(
          name: 'jnsp',
        ),
        TabBarItem(
          name: 'zms',
        ),
        TabBarItem(
          name: 'zmsg',
        ),
        VideoListPage(),
      ]),
    );
  }
}

class TabBarItem extends StatefulWidget {
  final String name;

  const TabBarItem({super.key, required this.name});

  @override
  State<TabBarItem> createState() => _TabBarItemState();
}

class _TabBarItemState extends State<TabBarItem>
    with AutomaticKeepAliveClientMixin {
  // 定义 Future 变量，避免 build 时重复请求
  late final String baseUrl = "https://wenzhuang.top/jidu/${widget.name}/";
  late final Future<List<FileModel>> _filesFuture;

  @override
  void initState() {
    super.initState();
    // 2. 在 initState 中初始化 Future，这保证了它只会被调用一次
    _filesFuture = ApiUtils.readJiDu(widget.name);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: FutureBuilder<List<FileModel>>(
        future: _filesFuture,
        builder: (context, snapshot) {
          // 1. 加载中状态
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          // 2. 错误状态
          if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 48, color: Colors.red),
                  Text("错误: ${snapshot.error}"),
                ],
              ),
            );
          }

          // 3. 数据为空状态
          final files = snapshot.data ?? [];
          if (files.isEmpty) {
            return const Center(child: Text("目录下没有文件"));
          }
          // 4. 加载成功：展示响应式 GridView
          return ListView.builder(
            // physics: const BouncingScrollPhysics(), // 可以尝试不同的滚动效果
            itemCount: files.length,
            // (可选) 预估每个 item 的高度，可以帮助 Flutter 优化布局和滚动
            prototypeItem: const ListTile(title: Text("Placeholder")),
            itemBuilder: (context, index) {
              final file = files[index];
              String fileName = file.name;
              String encodedUrl = "$baseUrl${Uri.encodeComponent(fileName)}";
              bool isPpsFile = fileName.toLowerCase().endsWith('.pps') ||
                  fileName.toLowerCase().endsWith('.ppt') ||
                  fileName.toLowerCase().endsWith('.pptx');
              return ListTile(
                leading: const Icon(Icons.music_note, color: Colors.deepPurple),
                title: Text(
                  fileName,
                  maxLines: 2, // 允许文件名最多显示两行
                  overflow: TextOverflow.ellipsis,
                ),
                onTap: () {
                  if (isPpsFile) {
                    PptRoute(url: encodedUrl).push(context);
                  } else {
                    ImageViewerRoute(url: encodedUrl).push(context);
                  }
                },
              );
            },
          );
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class PowerPointViewerPage extends StatefulWidget {
  final String fileUrl;

  const PowerPointViewerPage({
    super.key,
    required this.fileUrl,
  });

  @override
  State<PowerPointViewerPage> createState() => _PowerPointViewerPageState();
}

class _PowerPointViewerPageState extends State<PowerPointViewerPage> {
  late String finalUrl =
      'https://view.officeapps.live.com/op/view.aspx?src=${widget.fileUrl}';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MyIFrame(finalUrl),
    );
  }
}

class VideoListPage extends StatefulWidget {
  const VideoListPage({super.key});

  @override
  State<VideoListPage> createState() => _VideoListPageState();
}

class _VideoListPageState extends State<VideoListPage>
    with AutomaticKeepAliveClientMixin {
  late final Future<List<VideoModel>> _filesFuture;

  @override
  void initState() {
    super.initState();
    // 2. 在 initState 中初始化 Future，这保证了它只会被调用一次
    _filesFuture = ApiUtils.readJiDuVideo();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: FutureBuilder<List<VideoModel>>(
        future: _filesFuture,
        builder: (context, snapshot) {
          // 1. 加载中状态
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          // 2. 错误状态
          if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 48, color: Colors.red),
                  Text("错误: ${snapshot.error}"),
                ],
              ),
            );
          }

          // 3. 数据为空状态
          final files = snapshot.data ?? [];
          if (files.isEmpty) {
            return const Center(child: Text("目录下没有文件"));
          }
          return GridView.builder(
            padding: EdgeInsets.all(15),
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200, // 调整到合适宽度
              crossAxisSpacing: 20,
              mainAxisExtent:200,
              mainAxisSpacing: 20,
            ),

            itemCount: files.length,
            // (可选) 预估每个 item 的高度，可以帮助 Flutter 优化布局和滚动
            itemBuilder: (context, index) {
              final file = files[index];
              String fileName = file.title;
              return  InkWell(
                onTap: (){
                  MyVideoPlayerRoute(url: file.videoUrl).push(context);
                },
                child: GridTile(
                  // 底部标题栏
                  footer: GridTileBar(
                    backgroundColor: Colors.black54, // 半透明黑
                    title: Text(
                      fileName,
                      style: const TextStyle(fontSize: 12),
                    ),
                    leading: const Icon(Icons.play_circle_outline, size: 20),
                    trailing: const Icon(Icons.info_outline, size: 16),
                  ),
                  // 主体内容：显示视频封面图片
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8), // 圆角
                      color: Colors.grey[200],
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: CachedNetworkImage(imageUrl: file.imageUrl,fit: BoxFit.cover,),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
