// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:flutter_video_player/database/hv_manager.dart';
import 'package:flutter_video_player/providers/config_provider.dart';
import 'package:provider/provider.dart';
import 'pages/splash/splash_page.dart';
import 'routes/route_manager.dart';

export 'package:flutter_video_player/util/r_sources.dart';

void main() {
  runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      SystemChrome.setEnabledSystemUIMode(
        SystemUiMode.manual,
        overlays: [
          SystemUiOverlay.bottom,
          SystemUiOverlay.top,
        ],
      );
      //滚动性能优化
      GestureBinding.instance.resamplingEnabled = true;
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
      ]);
      // await HiveManager.initHive();
      runApp(const MyApp());
    },
    (error, StackTrace stack) {
      // ignore: avoid_print
      print('发生错误了 $error --- $stack');
    },
    zoneSpecification: ZoneSpecification(
      // 拦截print
      print: (Zone self, ZoneDelegate parent, Zone zone, String line) {
        parent.print(zone, "Interceptor: $line");
      },
      // 拦截未处理的异步错误
      handleUncaughtError: (Zone self, ZoneDelegate parent, Zone zone,
          Object error, StackTrace stackTrace) {
        parent.print(zone, '${error.toString()} $stackTrace');
      },
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ConfigProvider(),
        ),
      ],
      builder: (context, child) => const MaterialApp(
        home: SplashScreen(),
        onGenerateRoute: RouteManager.generateRoute,
        showPerformanceOverlay: false,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
