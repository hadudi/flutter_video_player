// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_video_player/database/hv_manager.dart';
import 'pages/splash/splash_page.dart';
import 'routes/route_manager.dart';

export 'package:flutter_video_player/uitl/r_sources.dart';

void main() {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.bottom, SystemUiOverlay.top]);
    //滚动性能优化
    GestureBinding.instance?.resamplingEnabled = true;
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    await HiveManager.initHive();
    runApp(const MyApp());
  }, (error, stack) {});
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const SplashScreen(),
      onGenerateRoute: RouteManager.generateRoute,
      onUnknownRoute: (settings) {},
      showPerformanceOverlay: false,
      debugShowCheckedModeBanner: false,
      navigatorObservers: [CFNavigatorObservers()],
    );
  }
}
