import 'package:flutter/material.dart';
import 'package:flutter_video_player/pages/mine/mine_view_model.dart';
import 'package:flutter_video_player/routes/route_manager.dart';
import 'package:flutter_video_player/user/user_manager.dart';
import 'package:flutter_video_player/util/util.dart';

class MinePageView extends StatefulWidget {
  const MinePageView({
    Key? key,
  }) : super(key: key);

  @override
  _MinePageViewState createState() => _MinePageViewState();
}

class _MinePageViewState extends State<MinePageView> {
  late final MineViewModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = MineViewModel();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      viewModel.requestData().then((value) {
        if (mounted) {
          setState(() {});
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Stack(
          children: [
            Positioned(
              left: 0,
              right: 0,
              height: 375,
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0xfffb6060), Color(0xffff8383)],
                  ),
                ),
              ),
            ),
            Positioned.fill(
              child: RefreshIndicator(
                child: SingleChildScrollView(
                  child: SizedBox(
                    height: Util.appHeight - Util.tabBarHeight,
                    child: Stack(
                      children: <Widget>[
                        Positioned.fill(
                          child: Container(
                            margin: EdgeInsets.only(
                                top: Util.navgationBarHeight + 74),
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(24),
                                topRight: Radius.circular(24),
                              ),
                            ),
                            child: Stack(
                              children: <Widget>[
                                Positioned(
                                  top: 70,
                                  left: 10,
                                  right: 10,
                                  child: Text(
                                    viewModel.nickName,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xff32383a),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 100,
                                  left: 10,
                                  right: 10,
                                  child: Text(
                                    viewModel.phoneText,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Color(0xffadb6c2),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 150,
                                  child: SizedBox(
                                    width: Util.appWidth,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        // Offstage(
                                        //   child: Padding(
                                        //     padding: EdgeInsets.only(left: 12),
                                        //     child: Text(
                                        //       '观看历史',
                                        //       style: TextStyle(
                                        //         color: Color(0xff32383a),
                                        //         fontSize: 16,
                                        //         fontWeight: FontWeight.w500,
                                        //       ),
                                        //     ),
                                        //   ),
                                        // ),
                                        Offstage(
                                          offstage: viewModel.funcList.isEmpty,
                                          child: const Padding(
                                            padding: EdgeInsets.only(left: 12),
                                            child: Text(
                                              '常用功能',
                                              style: TextStyle(
                                                color: Color(0xff32383a),
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 12),
                                          child: Wrap(
                                            children: (viewModel.funcList
                                                .map(
                                                  (e) => GestureDetector(
                                                    onTap: () {
                                                      if (e.title == '设置') {
                                                        Navigator.pushNamed(
                                                          context,
                                                          RouteManager.setting,
                                                        );
                                                      }
                                                    },
                                                    child: Container(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              right: 15),
                                                      width: Util.appWidth / 4,
                                                      height: 70,
                                                      child: Stack(
                                                        children: [
                                                          Positioned(
                                                            top: 0,
                                                            left: 0,
                                                            right: 0,
                                                            child:
                                                                Image.network(
                                                              e.icon ?? '',
                                                              height: 22,
                                                              fit: BoxFit
                                                                  .fitHeight,
                                                            ),
                                                          ),
                                                          Positioned(
                                                            top: 34,
                                                            left: 0,
                                                            right: 0,
                                                            child: Text(
                                                              e.title ?? '',
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                )
                                                .toList()),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          top: Util.navgationBarHeight + 4,
                          left: 0,
                          right: 0,
                          child: Center(
                            child: GestureDetector(
                              child: Image.asset(
                                viewModel.avatar,
                              ),
                              onTap: () {
                                gotoLogin();
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                onRefresh: () async {
                  viewModel.requestData().then((value) {
                    if (mounted) {
                      setState(() {});
                    }
                  });
                },
              ),
            ),
            Positioned(
              top: Util.statusBarHeight,
              right: 0,
              child: IconButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('确认退出吗'),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  Navigator.maybePop(context);
                                },
                                child: const Text('取消')),
                            TextButton(
                                onPressed: () async {
                                  await UserManger.instance.logout();
                                  await Navigator.maybePop(context);
                                  if (mounted) {
                                    setState(() {});
                                  }
                                },
                                child: const Text('确定')),
                          ],
                        );
                      });
                },
                icon: const Icon(
                  Icons.search,
                  size: 18,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  gotoLogin() async {
    if (!UserManger.instance.isLogin) {
      await Navigator.pushNamed(context, RouteManager.login);
      if (mounted) {
        setState(() {});
      }
    }
  }
}
