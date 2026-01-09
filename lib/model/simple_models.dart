// 你可以根据需要将 PlayItem 重命名为更合适的名称，如 VideoInfo 等
class PlayItem {
  PlayItem({
    required this.playTitle,
    required this.cTitleOutput,
    required this.playUrl,
  });

  // 从 JSON Map 创建 PlayItem 实例
  factory PlayItem.fromJson(Map<String, dynamic> json) {
    return PlayItem(
      playTitle: json['playTitle'] ?? '', // 使用 ?? '' 提供默认值，防止null
      cTitleOutput: json['cTitleOutput'] ?? '',
      playUrl: json['playUrl'] ?? '',
    );
  }

  // 定义新的字段，并使用明确的类型（如 String），而不是 dynamic
  final String playTitle;
  final String cTitleOutput;
  final String playUrl;

  // 将 PlayItem 实例转换为 JSON Map
  Map<String, dynamic> toJson() {
    return {
      'playTitle': playTitle,
      'cTitleOutput': cTitleOutput,
      'playUrl': playUrl,
    };
  }

  // copyWith 方法，用于创建对象的副本并修改部分字段
  PlayItem copyWith({
    String? playTitle,
    String? cTitleOutput,
    String? playUrl,
  }) {
    return PlayItem(
      playTitle: playTitle ?? this.playTitle,
      cTitleOutput: cTitleOutput ?? this.cTitleOutput,
      playUrl: playUrl ?? this.playUrl,
    );
  }

  // 重写 == 操作符，用于比较两个对象是否相等
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is PlayItem &&
              runtimeType == other.runtimeType &&
              playTitle == other.playTitle &&
              cTitleOutput == other.cTitleOutput &&
              playUrl == other.playUrl;

  // 重写 hashCode，确保相等的对象有相同的哈希码
  @override
  int get hashCode => Object.hash(
    playTitle,
    cTitleOutput,
    playUrl,
  );
}

class FileModel {
  FileModel({
    required this.name,
    required this.size,
    required this.url,
    required this.modTime,
    required this.mode,
    required this.isDir,
    required this.isSymlink,
  });

  /// 文件名，例如："998 以琳赞.jpg"
  final String name;

  /// 文件大小（字节），例如：361187
  final int size;

  /// 文件的URL路径，例如："./998%20%E4%BB%A5%E7%90%B3%E8%B5%9E.jpg"
  final String url;

  /// 文件最后修改时间，例如："2025-12-31T02:39:57.259357349Z"
  final DateTime modTime;

  /// 文件模式/权限，例如：493
  final int mode;

  /// 是否是目录，例如：false
  final bool isDir;

  /// 是否是符号链接，例如：false
  final bool isSymlink;

  /// 从JSON对象创建FileModel实例的工厂构造函数
  factory FileModel.fromJson(Map<String, dynamic> json) => FileModel(
    name: json["name"],
    size: json["size"],
    url: json["url"],
    modTime: DateTime.parse(json["mod_time"]), // 将字符串解析为DateTime
    mode: json["mode"],
    isDir: json["is_dir"],
    isSymlink: json["is_symlink"],
  );

  /// 将FileModel实例转换为JSON对象的方法
  Map<String, dynamic> toJson() => {
    "name": name,
    "size": size,
    "url": url,
    "mod_time": modTime.toIso8601String(), // 将DateTime转换为ISO 8601格式的字符串
    "mode": mode,
    "is_dir": isDir,
    "is_symlink": isSymlink,
  };
}
class VideoModel {
  VideoModel({
    required this.title,
    required this.imageUrl,
    required this.videoUrl,
  });

  /// 视频标题, 例如: "主祷文"
  final String title;
  /// 视频封面图片URL, 例如: "https://wenzhuang.top/images/zdw.webp"
  final String imageUrl;
  /// 视频播放地址URL, 例如: "https://wenzhuang.top/video/zdw.mp4"
  final String videoUrl;

  /// 从JSON Map创建VideoModel实例的工厂构造函数
  factory VideoModel.fromJson(Map<String, dynamic> json) {
    return VideoModel(
      title: json['title'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      videoUrl: json['videoUrl'] ?? '',
    );
  }

  /// 将VideoModel实例转换为JSON Map的方法
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'imageUrl': imageUrl,
      'videoUrl': videoUrl,
    };
  }

  /// copyWith 方法，用于创建对象的副本并可选择性地修改字段
  VideoModel copyWith({
    String? title,
    String? imageUrl,
    String? videoUrl,
  }) {
    return VideoModel(
      title: title ?? this.title,
      imageUrl: imageUrl ?? this.imageUrl,
      videoUrl: videoUrl ?? this.videoUrl,
    );
  }

  /// 重写toString方法，方便调试时打印对象信息
  @override
  String toString() {
    return 'VideoModel(title: $title, imageUrl: $imageUrl, videoUrl: $videoUrl)';
  }

  /// 重写 == 操作符，用于比较两个VideoModel对象是否相等
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is VideoModel &&
        other.title == title &&
        other.imageUrl == imageUrl &&
        other.videoUrl == videoUrl;
  }

  /// 重写 hashCode，确保相等的对象有相同的哈希码
  @override
  int get hashCode {
    return title.hashCode ^ imageUrl.hashCode ^ videoUrl.hashCode;
  }
}