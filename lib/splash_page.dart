import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nav_router/nav_router.dart';
import 'package:tmdb_demo/ui/home_page/home_page.dart';
import 'package:tmdb_demo/widgets/app_bar_common.dart';
import 'package:tmdb_demo/widgets/image_asset.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    //移除原生splash
    FlutterNativeSplash.remove();
    Future.delayed(
      const Duration(seconds: 3),
      () {
        //3s后跳转到主页
        pushReplacement(const HomePage());
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const AppBarCommon(
        title: '',
        hasBack: false,
        color: Colors.transparent,
        systemUiOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      body: Container(
        width: 1.sw,
        height: 1.sh,
        padding: EdgeInsets.only(bottom: 0.5.sh - 250.h),
        alignment: Alignment.center,
        child: ImageAsset('logo', size: 250.w),
      ),
    );
  }
}
