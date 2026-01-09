import 'dart:convert';
import 'dart:math';

import 'package:flutter/services.dart';

import 'package:http/http.dart' as http;
import 'package:videoparse/model/simple_models.dart';
import 'package:videoparse/utils/extensions/log_extensions.dart';

class AppUtils {
  static bool isUrl(String url) {
    return url.startsWith("http://") || url.startsWith("https://");
  }

  static Future<String> convertM3UToJson(String inputFilePath) async {
    List<String> lines = inputFilePath.trim().split("\n");
    List<Map<String, String>> playlist = [];
    Map<String, String>? currentEntry;
    for (var line in lines) {
      line = line.trim();
      if (line.startsWith('#EXTINF:')) {
        currentEntry = {};
        int commaIndex = line.indexOf(',');
        if (commaIndex != -1) {
          currentEntry['duration'] = line.substring(8, commaIndex);
          currentEntry['title'] = line.substring(commaIndex + 1);
        } else {
          currentEntry['duration'] = line.substring(8);
        }
      } else if (line.isNotEmpty && !line.startsWith('#')) {
        if (currentEntry != null) {
          currentEntry['url'] = line;
          playlist.add(currentEntry);
          currentEntry = null;
        }
      }
    }
    String json = jsonEncode(playlist);
    return json;
  }


  static Future<String> generateShortLink(String longUrl) async {
    var apiKey = '';
    var endpoint = 'https://api-ssl.bitly.com/v4/shorten';

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $apiKey',
    };

    var body = json.encode({
      'long_url': longUrl,
    });

    var response =
        await http.post(Uri.parse(endpoint), headers: headers, body: body);

    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      var shortLink = jsonResponse['id'];
      return shortLink;
    } else {
      throw Exception('Failed to generate short link');
    }
  }

}
