import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:flutter/services.dart';
import 'package:logger/logger.dart';
import 'package:videoparse/model/json_convert_content.dart';
import 'package:videoparse/model/simple_models.dart';
import 'package:videoparse/protobuf/videoparse.pb.dart';
import 'package:videoparse/utils/log_extensions.dart';
import 'package:videoparse/utils/network/x_http_utils.dart';

class ApiUtils {
  ///https://node.video.qq.com/x/api/hot_search?channdlId=0&_=1700632980323
  static Future<VideoParseList> getTvBoxData() async {
    final url = 'https://gitee.com/andoridityu/files/raw/master/xxx.json';
    final jsonX = await XHttpUtils.getForJson("$corsProxyUrl$url");
    return VideoParseList.fromBuffer(Uint8List.fromList(jsonX["data"].cast<int>()));
  }

  static Future<String> testGetUrl(
      {String url =
          "https://gitee.com/andoridityu/files/raw/master/xxx.json"}) async {
    final request = await XHttpUtils.getForString("$corsProxyUrl$url");
    return request;
  }

  static Future<List<LiveChannelItem>> getLiveChannelItemS() async {
    final jsonX = await rootBundle.loadString("assets/json/tv.txt");
    // String reply = await request.transform(utf8.decoder).join();
    final list = jsonX.trim().split('\n').mapIndexed((index, e) {
      final item = e.split(",");
      return LiveChannelItem(item.first, [item.last], index: index);
    }).toList();
    final infoList = await getEpginfoList();
    list.first.epginfoList = infoList;
    return list;
  }

  static Future<EpginfoList> getEpginfoList({String name = "CCTV 综合"}) async {
    final request = await XHttpUtils.getForFullResponse(
        "https://epg.112114.xyz/?ch=${Uri.encodeFull(name)}&date=2023-11-27");
    String reply = await request.transform(utf8.decoder).join();
    Logger().e("reply=$reply");
    final list = EpginfoList.fromJson(json.decode(reply));
    return list;
  }
}
