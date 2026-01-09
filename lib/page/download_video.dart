import 'package:flutter/material.dart';
import 'package:videoparse/utils/extensions/log_extensions.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class DownloadVideoPage extends StatefulWidget {
  const DownloadVideoPage({super.key});

  @override
  State<DownloadVideoPage> createState() => _DownloadVideoPageState();
}

class _DownloadVideoPageState extends State<DownloadVideoPage> {
  var yt = YoutubeExplode();

  Future<Video> getVideoInfo() async {
    // final videoId = VideoId('Dpp1sIL1m5Q');
    var video = await yt.videos.get(
        // 'https://www.youtube.com/shorts/TU6wNhEY1iQ'); // Returns a Video instance.
        'https://youtube.com/watch?v=Dpp1sIL1m5Q'); // Returns a Video instance.
    var title = video.title; // "Scamazon Prime"
    var author = video.author; // "Jim Browning"
    var duration = video.duration; // Instance of Duration - 0:19:48.00000
    var manifest = await yt.videos.streams.getManifest(video.id, ytClients: [
      YoutubeApiClient.safari,
      YoutubeApiClient.androidVr
    ]); // The streams provided by both clients will be merged.
    manifest.muxed.first.url.log();
    // var streamInfo = manifest.muxed.withHighestBitrate();

    return video;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("视频下载"),
      ),
      body: Container(
        child: TextButton(onPressed: () async {
         final v =  await getVideoInfo();
         "v=$v".log();
        }, child: Text("视频下载")),
      ),
    );
  }
}
