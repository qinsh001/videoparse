import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';
import 'package:videoparse/main.dart';
import 'package:videoparse/router/router.dart';
import 'package:videoparse/utils/app_utils.dart';
import 'package:videoparse/utils/extensions/log_extensions.dart';
import 'package:videoparse/utils/network/ApiUtils.dart';

import '../model/simple_models.dart';
import '../utils/toast_utils.dart';
import '../widget/my_iframe/my_iframe_web2.dart';

class WebDataPage extends StatelessWidget {
  final bool isLxj;

  const WebDataPage({super.key, this.isLxj = false});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            "${snapshot.error}".log();
            return Center(child: Text(snapshot.error.toString()));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasData && snapshot.data == true) {
            return isLxj ? const Web2Page() : const WebPage();
          }
          return const Center(child: Text("no data"));
        },
        future: ApiUtils.getTvBoxData(),
      ),
      bottomNavigationBar: Text(
        """免责声明：
1. 本站为个人非盈利技术研究站点，所有内容均通过第三方公开 API 接口自动化抓取。
2. 本站自身不存储、不提供、不上传任何视频文件，亦不具备内容审核能力。
3. 视频版权归原权利人所有，本站仅提供链接解析服务。
4. 用户通过本站搜索到的内容，其风险由用户自行承担。
5. 如有侵权内容，请联系 API 资源提供方。若需本站屏蔽特定链接，请联系：[longyujun0624@live.cn]，我们将在核实后 24 小时内处理""",
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 12, color: Colors.grey[500], height: 1.5),
      ),
    );
  }
}

class WebPage extends StatefulWidget {
  const WebPage({super.key});

  @override
  State<WebPage> createState() => _WebPageState();
}

class _WebPageState extends State<WebPage> {
  final list = parseItems;

  int current = 0;
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
  }

  void addVideoListener() {}

  @override
  dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () {
              VideoParseRoute(isLxj: true).go(context);
            },
            child: const Text(
              "去看连续剧",
              style: TextStyle(color: Colors.black), // AppBar上最好用白色字体
            ),
          ),
          const Gap(10), // 增加一点间距
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Column(
            children: [
              Row(
                children: [
                  Expanded(
                      child: TextField(
                    controller: controller,
                    decoration: const InputDecoration(
                        hintText: "Please enter the video link"),
                  )),
                  TextButton(
                      onPressed: () {
                        setState(() {});
                      },
                      child: const Text("parse")),
                ],
              ),
              const Gap(20),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: list
                    .mapIndexed((index, e) => ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor:
                                current == index ? Colors.green : Colors.blue),
                        onPressed: () {
                          setState(() {
                            current = index;
                          });
                        },
                        child: Text(e.name)))
                    .toList(),
              ),
              const Gap(20),
            ],
          ),
          Expanded(
              child: controller.text.isNotEmpty
                  ? MyIFrame(
                      "${list[current].url}${controller.text.trim()}",
                    )
                  : const SizedBox.shrink()),
        ],
      ),
    );
  }
}

class Web2Page extends StatefulWidget {
  const Web2Page({super.key});

  @override
  State<Web2Page> createState() => _Web2PageState();
}

class _Web2PageState extends State<Web2Page> {
  final parseList = parseItems;
  final urlList = <PlayItem>[];

  int currentParseIndex = 0;
  int currentUrlIndex = 0;
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
  }

  void addVideoListener() {}

  @override
  dispose() {
    controller.dispose();
    super.dispose();
  }

  String getVideoUrl() {
    if (urlList.isNotEmpty && parseList.isNotEmpty) {
      String targetUrl =
          "${parseList[currentParseIndex].url}${urlList[currentUrlIndex].playUrl.trim()}";
      return targetUrl;
    } else {
      return "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            '当前剧集: ${urlList.isNotEmpty ? urlList[currentUrlIndex].playTitle : '0'}'), // 显示当前剧集编号
        // 将全屏按钮放到 AppBar 的右侧
        actions: [
          TextButton(
              onPressed: () {
                VideoParseRoute(isLxj: false).go(context);
              },
              child: const Text("去看电影")),

          const Gap(10), // 增加一点间距
        ],
      ),
      drawer: Drawer(
        child: PointerInterceptor(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(color: Colors.blue),
                child: Text(
                  '剧集列表',
                  style: TextStyle(color: Colors.white, fontSize: 24),
                ),
              ),
              Expanded(
                // 使用GridView来展示剧集
                child: GridView.builder(
                  padding: const EdgeInsets.all(8.0),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3, // 每行显示3个
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                    childAspectRatio: 2.5, // 宽高比
                  ),
                  itemCount: urlList.length,
                  itemBuilder: (context, index) {
                    final isSelected = index == currentUrlIndex;
                    final item = urlList[index];
                    return ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor:
                            isSelected ? Colors.white : Colors.black,
                        backgroundColor:
                            isSelected ? Colors.green : Colors.grey[300],
                      ),
                      onPressed: () {
                        setState(() {
                          currentUrlIndex = index;
                        });
                        Navigator.of(context).pop(); // 点击后关闭抽屉
                      },
                      child: Text(
                        item.cTitleOutput,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Column(
            children: [
              Row(
                children: [
                  Expanded(
                      child: TextField(
                    maxLines: 5,
                    minLines: 5,
                    controller: controller,
                    decoration: const InputDecoration(
                        hintText: "Please enter the video url"),
                  )),
                  TextButton(
                      onPressed: () async {
                        final currentContext = context;
                        final text = controller.text;
                        if (text.isEmpty) {
                          return; // 如果输入为空，则不执行任何操作
                        }
                        List<PlayItem> resultList = [];
                        if (AppUtils.isUrl(text)) {
                          // 显示一个加载指示器给用户反馈
                          ToastUtils.show(currentContext, "正在从URL解析，请稍候...");
                          resultList =
                              await ApiUtils.fetchVideoDetailWithUtils(
                                  text);
                        } else {
                          ToastUtils.show(
                              currentContext, "输入格式无法识别，请输入支持的URL",
                              type: ToastType.error);
                          return;
                        }
                        if (!currentContext.mounted) return;
                        if (resultList.isNotEmpty) {
                          setState(() {
                            //如果是json就直接用这个方法解析
                            urlList.clear();
                            urlList.addAll(resultList);
                            currentUrlIndex = 0;
                          });
                        } else {
                          if (mounted) {
                            ToastUtils.show(
                                currentContext, "输入格式无法识别，请输入支持的URL",
                                type: ToastType.error);
                          }
                        }
                      },
                      child: const Text("parse")),
                ],
              ),
              const Gap(20),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: parseList
                    .mapIndexed((index, e) => ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: currentParseIndex == index
                                ? Colors.green
                                : Colors.blue),
                        onPressed: () {
                          setState(() {
                            currentParseIndex = index;
                          });
                        },
                        child: Text(e.name)))
                    .toList(),
              ),
              const Gap(20),
            ],
          ),
          Expanded(
              child: getVideoUrl().isNotEmpty
                  ? MyIFrame(getVideoUrl())
                  : const SizedBox.shrink()),
        ],
      ),
    );
  }
}
