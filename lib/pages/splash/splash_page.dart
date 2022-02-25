// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_video_player/routes/route_manager.dart';
import 'package:flutter_video_player/user/user_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  Future<bool> get isFirstLaunch async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool ret = prefs.getBool('FirstLaunch') ?? true;
    if (ret) {
      prefs.setBool('FirstLaunch', false);
    }
    return ret;
  }

  @override
  initState() {
    super.initState();
    UserManger.instance.getLocalLogin();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1500),
    );
    _animation = Tween(begin: 1.0, end: 1.2).animate(_controller);
    _animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Navigator.of(context).pushNamedAndRemoveUntil(
          RouteManager.root,
          (route) => false,
        );
      }
    });
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
        future: isFirstLaunch,
        builder: (context, AsyncSnapshot<bool> snap) {
          if (snap.data == false) {
            return ScaleTransition(
              scale: _animation,
              child: Image.network(
                "https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=1059109819,2238091618&fm=26&gp=0.jpg",
                scale: 2.0,
                fit: BoxFit.cover,
              ),
            );
          }
          return Container(
            color: Colors.white,
          );
        });
  }
}
