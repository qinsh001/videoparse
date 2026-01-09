import 'dart:async';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:videoparse/page/web_page.dart';
import 'package:videoparse/widget/error_page.dart';

import '../page/download_video.dart';
import '../page/image_viewer_page.dart';
import '../page/jidu.dart';
import '../page/my_video_player.dart';

part 'router.g.dart';

final GoRouter goRouter = GoRouter(
  routes: $appRoutes,
  initialLocation: RoutePath.videoParse,
  errorPageBuilder: (context, state) => NoTransitionPage<void>(
    key: state.pageKey,
    child: const ErrorPage(),
  ),
  redirect: (context, state) async {
    return null;
  },
);

extension GoRouterX on GoRouter {
  Future<T?> pushAndRemoveUntilX<T extends Object?>(
      String location, String popUtil,
      {Object? extra}) {
    routerDelegate.navigatorKey.currentState
        ?.popUntil(ModalRoute.withName(popUtil));
    return push(location, extra: extra);
  }

  //
  void popUntil(String location) {
    routerDelegate.navigatorKey.currentState
        ?.popUntil(ModalRoute.withName(location));
  }

  void singTopPush(String location, {Object? extra}) {
    pushReplacement(location, extra: extra);
  }

  bool hasLocation(String location) {
    return routerDelegate.currentConfiguration.matches
            .firstWhereOrNull((element) {
          return element.matchedLocation.contains(location);
        }) !=
        null;
  }
}

class RoutePath {
  RoutePath._();

  static const videoPlayer = '/videoPlayer';
  static const videoParse = '/';
  static const videoParse2 = '/videoParse2';
  static const jsonInputPage = '/JsonInputPage';
  static const videoDownload = '/videoDownload';
  static const imageViewer = '/imageViewer';
  static const ppt = '/ppt';
  static const jidu = '/jidu';

  static const List<String> notLoginPages = [];
}

class RouteTitle {
  RouteTitle._();


}

@TypedGoRoute<VideoParseRoute>(path: RoutePath.videoParse)
class VideoParseRoute extends GoRouteData with $VideoParseRoute {
  final bool isLxj;

  const VideoParseRoute({this.isLxj =false});

  @override
  Widget build(BuildContext context, GoRouterState state) => WebDataPage(isLxj: isLxj,);
}

@TypedGoRoute<VideoParse2Route>(path: RoutePath.videoParse2)
class VideoParse2Route extends GoRouteData with $VideoParse2Route {
  //添加url

  const VideoParse2Route();

  @override
  Widget build(BuildContext context, GoRouterState state) => const Web2Page();
}

@TypedGoRoute<VideoDownloadRoute>(path: RoutePath.videoDownload)
class VideoDownloadRoute extends GoRouteData with $VideoDownloadRoute {
  const VideoDownloadRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const DownloadVideoPage();
}

@TypedGoRoute<PptRoute>(path: RoutePath.ppt)
class PptRoute extends GoRouteData with $PptRoute {
  final String url;

  const PptRoute({this.url = ""});

  @override
  Widget build(BuildContext context, GoRouterState state) => PowerPointViewerPage(fileUrl: url);
}

@TypedGoRoute<ImageViewerRoute>(path: RoutePath.imageViewer)
class ImageViewerRoute extends GoRouteData with $ImageViewerRoute {
  final String url;

  const ImageViewerRoute({this.url = ""});

  @override
  Widget build(BuildContext context, GoRouterState state) => ImageViewerPage(imageUrl: url);
}
@TypedGoRoute<SongListRoute>(path: RoutePath.jidu)
class SongListRoute extends GoRouteData with $SongListRoute {
  const SongListRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => SongListPage();
}

@TypedGoRoute<MyVideoPlayerRoute>(path: RoutePath.videoPlayer)
class MyVideoPlayerRoute extends GoRouteData with $MyVideoPlayerRoute {
  final String url;

  const MyVideoPlayerRoute({this.url = ""});

  @override
  Widget build(BuildContext context, GoRouterState state) =>  MyVideoPlayer(videoUrl: url);
}


