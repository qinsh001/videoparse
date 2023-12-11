import 'dart:html';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:videoparse/model/simple_models.dart';
import 'package:videoparse/utils/app_utils.dart';
import 'package:videoparse/utils/log_extensions.dart';
import 'package:videoparse/utils/network/ApiUtils.dart';
import 'package:videoparse/widget/my_iframe/my_iframe_web.dart';

class WebDataPage extends StatelessWidget {
  const WebDataPage({super.key});

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
          final items = snapshot.data!.parses
              .where((element) => AppUtils.isUrl(element.url))
              .toList();
          return WebPage(items: items);
        },
        future: ApiUtils.getTvBoxData(),
      ),
    );
  }
}

class WebPage extends StatefulWidget {
  final List<ParsesItem> items;

  const WebPage({Key? key, required this.items}) : super(key: key);

  @override
  State<WebPage> createState() => _WebPageState();
}

class _WebPageState extends State<WebPage> {
  final list = <ParsesItem>[];
  late ParsesItem item = widget.items.first;
  late TextEditingController controller;
  late ValueNotifier<bool> isHide;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
    isHide = ValueNotifier(false);
    document.addEventListener('fullscreenchange', _onFullScreenChange);
  }

  void _onFullScreenChange(Event event) {
    "_onFullScreenChange=${document.fullscreenElement}".log();
    isHide.value = document.fullscreenElement != null;
  }

  @override
  dispose() {
    controller.dispose();
    isHide.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ValueListenableBuilder(
            builder: (context, value, child) {
              return Visibility(
                visible: !value,
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: TextButton(
                        onPressed: () {
                          // isHide.value = !isHide.value;
                          document.documentElement?.requestFullscreen();
                          isHide.value = true;
                        },
                        child: const Text("FullScreen(ESC exit))"),
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: TextField(
                          controller: controller,
                          decoration:
                              const InputDecoration(hintText: "Please enter the video link"),
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
                      children: widget.items
                          .map((e) => ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  foregroundColor: Colors.white,
                                  backgroundColor:
                                      item == e ? Colors.green : Colors.blue),
                              onPressed: () {
                                setState(() {
                                  item = e;
                                });
                              },
                              child: Text(e.name)))
                          .toList(),
                    ),
                    const Gap(20),
                  ],
                ),
              );
            },
            valueListenable: isHide,
          ),
          Expanded(
              child: controller.text.isNotEmpty && item != null
                  ? MyIFrame("${item?.url}${controller.text.trim()}")
                  : const SizedBox.shrink()),
        ],
      ),
    );
  }
}
