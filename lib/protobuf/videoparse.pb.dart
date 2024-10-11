//
//  Generated code. Do not modify.
//  source: videoparse.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class VideoParseItem extends $pb.GeneratedMessage {
  factory VideoParseItem({
    $core.String? name,
    $core.int? type,
    $core.String? url,
  }) {
    final $result = create();
    if (name != null) {
      $result.name = name;
    }
    if (type != null) {
      $result.type = type;
    }
    if (url != null) {
      $result.url = url;
    }
    return $result;
  }
  VideoParseItem._() : super();
  factory VideoParseItem.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory VideoParseItem.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'VideoParseItem', createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'name')
    ..a<$core.int>(2, _omitFieldNames ? '' : 'type', $pb.PbFieldType.O3)
    ..aOS(3, _omitFieldNames ? '' : 'url')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  VideoParseItem clone() => VideoParseItem()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  VideoParseItem copyWith(void Function(VideoParseItem) updates) => super.copyWith((message) => updates(message as VideoParseItem)) as VideoParseItem;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static VideoParseItem create() => VideoParseItem._();
  VideoParseItem createEmptyInstance() => create();
  static $pb.PbList<VideoParseItem> createRepeated() => $pb.PbList<VideoParseItem>();
  @$core.pragma('dart2js:noInline')
  static VideoParseItem getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<VideoParseItem>(create);
  static VideoParseItem? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get name => $_getSZ(0);
  @$pb.TagNumber(1)
  set name($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasName() => $_has(0);
  @$pb.TagNumber(1)
  void clearName() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get type => $_getIZ(1);
  @$pb.TagNumber(2)
  set type($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasType() => $_has(1);
  @$pb.TagNumber(2)
  void clearType() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get url => $_getSZ(2);
  @$pb.TagNumber(3)
  set url($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasUrl() => $_has(2);
  @$pb.TagNumber(3)
  void clearUrl() => clearField(3);
}

class VideoParseList extends $pb.GeneratedMessage {
  factory VideoParseList({
    $core.Iterable<VideoParseItem>? list,
  }) {
    final $result = create();
    if (list != null) {
      $result.list.addAll(list);
    }
    return $result;
  }
  VideoParseList._() : super();
  factory VideoParseList.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory VideoParseList.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'VideoParseList', createEmptyInstance: create)
    ..pc<VideoParseItem>(1, _omitFieldNames ? '' : 'list', $pb.PbFieldType.PM, subBuilder: VideoParseItem.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  VideoParseList clone() => VideoParseList()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  VideoParseList copyWith(void Function(VideoParseList) updates) => super.copyWith((message) => updates(message as VideoParseList)) as VideoParseList;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static VideoParseList create() => VideoParseList._();
  VideoParseList createEmptyInstance() => create();
  static $pb.PbList<VideoParseList> createRepeated() => $pb.PbList<VideoParseList>();
  @$core.pragma('dart2js:noInline')
  static VideoParseList getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<VideoParseList>(create);
  static VideoParseList? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<VideoParseItem> get list => $_getList(0);
}


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
