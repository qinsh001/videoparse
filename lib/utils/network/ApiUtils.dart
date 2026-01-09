
import 'package:flutter/foundation.dart';
import 'package:videoparse/protobuf/videoparse.pb.dart';
import 'package:videoparse/utils/network/x_http_utils.dart';

import '../../main.dart';
import '../../model/simple_models.dart';
import '../app_utils.dart';

const  corsProxyUrl2= "https://wenzhuang.top/api/v1/hello?url=";
class ApiUtils {
  ///https://node.video.qq.com/x/api/hot_search?channdlId=0&_=1700632980323
  static Future<bool> getTvBoxData() async {
    final url = 'https://gitee.com/andoridityu/files/raw/master/xxx.json';
    final jsonX = await XHttpUtils.getForJson("$corsProxyUrl2$url");
    final result = VideoParseList.fromBuffer(
        Uint8List.fromList(jsonX["data"].cast<int>()));
    final items =
        result.list.where((element) => AppUtils.isUrl(element.url)).toList();
    parseItems.clear();
    parseItems.addAll(items);
    return true;
  }
  static Future<List<FileModel>> readJiDu(String name) async {
    final url = 'https://wenzhuang.top/api/v1/weixin?method=readJsonTest&fileName=$name.json';
    final jsonX = await XHttpUtils.getForJson(url);
    final list = jsonX["data"] as List<dynamic>;
    return list.map((e)=>FileModel.fromJson(e)).toList();
  }
  static Future<List<VideoModel>> readJiDuVideo() async {
    final url = 'https://wenzhuang.top/api/v1/weixin?method=readJsonTest&fileName=video.json';
    final jsonX = await XHttpUtils.getForJson(url);
    final list = jsonX["data"] as List<dynamic>;
    return list.map((e)=>VideoModel.fromJson(e)).toList();
  }

  static Future<List<PlayItem>> fetchVideoDetailWithUtils(String videoUrl) async{
    //怎么判断是腾讯视频还是爱奇艺 根据域名
    final uri = Uri.tryParse(videoUrl);
    final String cid,vid,type;

    // 如果 URL 格式不正确，直接返回空列表
    if (uri == null || uri.host.isEmpty) {
      return [];
    }
    // 根据 host 属性判断域名
    if (uri.host.contains('v.qq.com')) {
      final RegExp regExp = RegExp(r'cover/([^/]+)/([^/\.]+)\.html');
      final match = regExp.firstMatch(videoUrl);
        if (match == null) {
          return [];
        }
       cid = match.group(1)!;
       vid = match.group(2)!;
       type = "qq";
    } else if (uri.host.contains('iqiyi.com')) {
      // 是爱奇艺视频，调用爱奇艺的详情获取方法
      final RegExp regExp = RegExp(r'v_([a-zA-Z0-9]+)\.html');
      final match = regExp.firstMatch(videoUrl);
      if (match == null) return [];
      String pageId = match.group(1)!;
      cid = pageId;
      vid="";
      type="iqiyi";
    } else {
      cid="";
      vid="";
      type="";
      return []; // 或者可以抛出一个错误 throw Exception("不支持的视频源");
    }
    String targetUrl = "https://wenzhuang.top/api/v1/study?type=$type&cid=$cid&vid=$vid";
    final jsonX = await XHttpUtils.getForJson(targetUrl,headers: {
      "Authorization":"my_secret_token_123"
    });
    final list = jsonX["data"] as List<dynamic>;
    return list.map((e)=>PlayItem.fromJson(e)).toList();
  }

}
