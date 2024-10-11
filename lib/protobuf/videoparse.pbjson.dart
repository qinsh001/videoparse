//
//  Generated code. Do not modify.
//  source: videoparse.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use videoParseItemDescriptor instead')
const VideoParseItem$json = {
  '1': 'VideoParseItem',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    {'1': 'type', '3': 2, '4': 1, '5': 5, '10': 'type'},
    {'1': 'url', '3': 3, '4': 1, '5': 9, '10': 'url'},
  ],
};

/// Descriptor for `VideoParseItem`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List videoParseItemDescriptor = $convert.base64Decode(
    'Cg5WaWRlb1BhcnNlSXRlbRISCgRuYW1lGAEgASgJUgRuYW1lEhIKBHR5cGUYAiABKAVSBHR5cG'
    'USEAoDdXJsGAMgASgJUgN1cmw=');

@$core.Deprecated('Use videoParseListDescriptor instead')
const VideoParseList$json = {
  '1': 'VideoParseList',
  '2': [
    {'1': 'list', '3': 1, '4': 3, '5': 11, '6': '.VideoParseItem', '10': 'list'},
  ],
};

/// Descriptor for `VideoParseList`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List videoParseListDescriptor = $convert.base64Decode(
    'Cg5WaWRlb1BhcnNlTGlzdBIjCgRsaXN0GAEgAygLMg8uVmlkZW9QYXJzZUl0ZW1SBGxpc3Q=');

