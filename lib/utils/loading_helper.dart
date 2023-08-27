import 'package:flutter/material.dart';
import 'package:nav_router/nav_router.dart';
import 'package:tmdb_demo/widgets/spinkit_circle.dart';
import 'package:tmdb_demo/widgets/text_common.dart';

class LoadingHelper {
  static bool isLoading = false;

  static void showLoading(BuildContext context, {String? message}) {
    if (isLoading) {
      dismiss();
    }
    isLoading = true;
    var widget = WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xFF3A3A3A).withOpacity(0.9),
              borderRadius: BorderRadius.circular(10),
            ),
            width: 100,
            height: 100,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SpinKitCircle(color: Colors.white),
                Container(
                  margin: const EdgeInsets.only(top: 13),
                  child: TextCommon(message ?? '正在加载', color: Colors.white, fontSize: 14),
                ),
              ],
            ),
          ),
        ),
      ),
    );
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return widget;
      },
    );
  }

  static void dismiss() {
    if (isLoading) {
      pop();
      isLoading = false;
    }
  }
}
