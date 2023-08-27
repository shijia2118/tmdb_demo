import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nav_router/nav_router.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:tmdb_demo/api/dio_manager.dart';
import 'package:tmdb_demo/splash_page.dart';
import 'package:tmdb_demo/ui/constant.dart';

void main() {
  //保持原生的splash，直到进入启动页
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  DioManager.getInstance(); //获取网络管理器实例

  runApp(const MyApp());

  //设置沉浸式状态栏，颜色透明
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: SystemUiOverlay.values);
  SystemUiOverlayStyle systemUiOverlayStyle = const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarBrightness: Brightness.light, //白色图标
  );
  SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return RefreshConfiguration(
      hideFooterWhenNotFull: true, //列表数据不满一页,不触发加载更多
      headerBuilder: () => ClassicHeader(
        refreshingIcon: SizedBox(
          width: 25.0,
          height: 25.0,
          child: Platform.isIOS
              ? const CupertinoActivityIndicator(color: Colors.grey)
              : const CircularProgressIndicator(color: Colors.grey, strokeWidth: 2.0),
        ),
      ),
      footerBuilder: () => ClassicFooter(
        loadingIcon: SizedBox(
          width: 25.0,
          height: 25.0,
          child: Platform.isIOS
              ? const CupertinoActivityIndicator(color: Colors.grey)
              : const CircularProgressIndicator(color: Colors.grey, strokeWidth: 2.0),
        ),
      ),
      enableBallisticLoad: true, // 可以通过惯性滑动触发加载更多
      springDescription: const SpringDescription(stiffness: 170, damping: 16, mass: 1.9),
      shouldFooterFollowWhenNotFull: (status) {
        return true;
      },
      //初始化屏幕适配
      child: ScreenUtilInit(
        builder: (context, _) => MaterialApp(
          debugShowCheckedModeBanner: false,
          title: '影视demo',
          //路由
          navigatorObservers: [routeObserver],
          navigatorKey: navGK,
          localizationsDelegates: const [
            // 这行是关键
            RefreshLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('zh'),
            Locale('en'),
          ],
          builder: (context, widget) {
            //初始化屏幕适配
            return MediaQuery(
              data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0), //字体不随系统而变化
              child: Scaffold(
                //全局适配:点击空白处收起软键盘
                body: GestureDetector(
                  onTap: () {
                    FocusScopeNode currentFocus = FocusScope.of(context);
                    if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
                      FocusManager.instance.primaryFocus?.unfocus();
                    }
                  },
                  child: widget!,
                ),
              ),
            );
          },
          home: const SplashPage(),
        ),
      ),
    );
  }
}
