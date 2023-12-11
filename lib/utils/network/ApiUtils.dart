import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:flutter/services.dart';
import 'package:logger/logger.dart';
import 'package:videoparse/model/simple_models.dart';
import 'package:videoparse/utils/log_extensions.dart';
import 'package:videoparse/utils/network/x_http_utils.dart';


class ApiUtils {
  ///https://node.video.qq.com/x/api/hot_search?channdlId=0&_=1700632980323
  static Future<TvboxModel?> getTvBoxData() async {
    // final result = await HttpUtils.getForJson(
    //     "https://gitee.com/andoridityu/files/raw/master/xxx.json",headers: {
    //   "Access-Control-Allow-Origin": "*",
    //   "Access-Control-Allow-Methods": "POST, GET, OPTIONS, PUT, DELETE, HEAD",
    //   "Access-Control-Allow-Headers": "X-Requested-With",
    // });
    final jsonX = await rootBundle.loadString("assets/json/tv_box.json");
    "jsonX=${jsonX.substring(0,20)}".log();
     try{
       return TvboxModel.fromJson(json.decode(jsonX));
     }catch(e){
       print(e);
     }
  }


  static Future<List<LiveChannelItem>> getLiveChannelItemS() async {
    // final request = await XHttpUtils.getForFullResponse(
    //     "https://haoyong.qsh001.top/web/assets/tv.txt");
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
