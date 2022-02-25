// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_video_player/pages/login/login_input_text_view.dart';
import 'package:flutter_video_player/pages/login/login_view_model.dart';
import 'package:flutter_video_player/routes/route_manager.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../util/util.dart';

class LoginPageView extends StatefulWidget {
  const LoginPageView({Key? key}) : super(key: key);

  @override
  _LoginPageViewState createState() => _LoginPageViewState();
}

class _LoginPageViewState extends State<LoginPageView> {
  late bool isLogining = false;
  late bool readBox = false;

  late TextEditingController _phoneCtrl;
  late TextEditingController _codeCtrl;

  final ValueNotifier counter = ValueNotifier(10);
  Timer? _timer;

  late final LoginViewModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = LoginViewModel();
    _phoneCtrl = TextEditingController();
    _codeCtrl = TextEditingController();
  }

  @override
  void dispose() {
    counter.dispose();
    _phoneCtrl.dispose();
    _codeCtrl.dispose();
    _timer?.cancel();
    super.dispose();
  }

/* 发送验证码 */
  void sendCode(String mobile) {
    if (!Util.isMobile(mobile)) {
      Fluttertoast.showToast(
        msg: '请输入正确的手机号',
        gravity: ToastGravity.CENTER,
      );
      return;
    }
    if (_timer?.isActive == true || _phoneCtrl.text.length != 11) {
      return;
    }
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (mounted) {
        counter.value--;
        if (counter.value == 0) {
          timer.cancel();
          counter.value = 10;
        }
      }
    });
    viewModel.sendVerifyCode(mobile).then((value) {
      if (value) {
        Fluttertoast.showToast(
          msg: '验证码发送成功',
          gravity: ToastGravity.CENTER,
        );
      } else {
        Fluttertoast.showToast(
          msg: '验证码发送失败，请稍后再试!',
          gravity: ToastGravity.CENTER,
        );
      }
    });
  }

  /// 验证码登录
  void loginWithCode(String mobile, String code) async {
    if (!readBox) {
      await Fluttertoast.showToast(
        msg: '请先阅读并同意用户协议和隐私政策',
        gravity: ToastGravity.CENTER,
      );
      return;
    }

    if (isLogining) {
      isLogining = false;
      return;
    }
    isLogining = true;
    if (Util.isMobile(mobile) && Util.isVerifyCode(code)) {
      await Fluttertoast.showToast(
        msg: '正在登录中。。。',
        gravity: ToastGravity.CENTER,
      );
      bool success = await viewModel.verifyCodeLogin(mobile, code);
      isLogining = false;
      await Fluttertoast.cancel();
      if (success) {
        await Fluttertoast.showToast(
          msg: '登录成功',
          gravity: ToastGravity.CENTER,
        );
        await Fluttertoast.cancel();
        Navigator.pop(context);
      } else {
        await Fluttertoast.showToast(
          msg: '登录失败',
          gravity: ToastGravity.CENTER,
        );
      }
    } else {
      isLogining = false;
      await Fluttertoast.showToast(
        msg: '请输入正确的手机号和验证码',
        gravity: ToastGravity.CENTER,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Stack(
          children: <Widget>[
            Positioned(
              top: 0,
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
            Positioned(
              top: Util.statusBarHeight,
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back_ios,
                  size: 18,
                  color: Colors.white,
                ),
              ),
            ),
            Positioned(
              top: Util.navgationBarHeight + 20,
              left: 20,
              child: const Text(
                '登录/注册',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                  color: Color(0xfffafbfc),
                ),
              ),
            ),
            Positioned.fill(
              top: Util.navgationBarHeight + 74,
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24),
                  ),
                ),
                child: Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(top: 42),
                      height: 34,
                      child: Row(
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 24),
                            child: Center(
                              child: Text(
                                '+86',
                                style: TextStyle(
                                  color: Color(0xffadb6c2),
                                  fontSize: 24,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 12),
                            color: Color(0x4dadb6c2),
                            width: 2,
                            height: 20,
                          ),
                          Container(
                            width: Util.appWidth - 110,
                            padding: EdgeInsets.only(left: 14),
                            alignment: Alignment.center,
                            child: LoginInputTextView(
                              controller: _phoneCtrl,
                              placeholder: '请输入手机号',
                              maxLength: 11,
                              onChanged: (value) => setState(() {}),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(24, 12, 24, 20),
                      child: Divider(height: 0.5),
                    ),
                    Container(
                      height: 34,
                      padding: EdgeInsets.only(right: 24),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            width: Util.appWidth - 120,
                            padding: EdgeInsets.only(left: 24),
                            alignment: Alignment.center,
                            child: LoginInputTextView(
                              controller: _codeCtrl,
                              placeholder: '请输入验证码,6个数字即可',
                              maxLength: 6,
                              onChanged: (value) => setState(() {}),
                            ),
                          ),
                          ValueListenableBuilder(
                            valueListenable: counter,
                            builder: (context, value, chile) {
                              String codeMsg = '';
                              if (value == 10 || value == 0) {
                                codeMsg = '发送验证码';
                              } else {
                                codeMsg = '${value}s 重新发送';
                              }
                              return TextButton(
                                onPressed: () {
                                  sendCode(_phoneCtrl.text);
                                },
                                child: Text(
                                  codeMsg,
                                  style: TextStyle(
                                    color: Color(0xfffafbfc),
                                    fontSize: 12,
                                  ),
                                ),
                                style: TextButton.styleFrom(
                                  padding: EdgeInsets.zero,
                                  backgroundColor: (value == 10 &&
                                          _phoneCtrl.text.length == 11)
                                      ? Color(0xfffb6060)
                                      : Color(0xffcbcccd),
                                  minimumSize: Size(84, 29),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(24, 10, 24, 90),
                      child: Divider(
                        height: 1,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        loginWithCode(_phoneCtrl.text, _codeCtrl.text);
                      },
                      child: Text(
                        '登录/注册',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      style: TextButton.styleFrom(
                        backgroundColor: _phoneCtrl.text.length == 11 &&
                                _codeCtrl.text.length == 6
                            ? Colors.red
                            : Color(0xffcacbcc),
                        minimumSize: Size(Util.appWidth - 76, 48),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Radio<bool>(
                          value: readBox,
                          groupValue: readBox ? true : null,
                          toggleable: true,
                          splashRadius: 7,
                          activeColor: Color(0xfffb6060),
                          onChanged: (v) => setState(() {
                            // ValueNotifier
                            readBox = !(v == null);
                          }),
                        ),
                        Text.rich(
                          TextSpan(
                            children: <InlineSpan>[
                              TextSpan(
                                text: '我已阅读并同意',
                                style: TextStyle(
                                  color: Color(0xff868996),
                                  fontSize: 12,
                                ),
                              ),
                              TextSpan(
                                text: '《用户协议》',
                                style: TextStyle(
                                  color: Color(0xfffb6060),
                                  fontSize: 12,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.pushNamed(
                                      context,
                                      RouteManager.webPage,
                                      arguments: 'https://www.baidu.com',
                                    );
                                  },
                              ),
                              TextSpan(
                                text: '和',
                                style: TextStyle(
                                  color: Color(0xff868996),
                                  fontSize: 12,
                                ),
                              ),
                              TextSpan(
                                text: '《隐私政策》',
                                style: TextStyle(
                                  color: Color(0xfffb6060),
                                  fontSize: 12,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.pushNamed(
                                      context,
                                      RouteManager.webPage,
                                      arguments: 'https://www.sina.com',
                                    );
                                  },
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
