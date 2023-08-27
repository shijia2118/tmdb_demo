import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nav_router/nav_router.dart';
import 'package:tmdb_demo/utils/color_helper.dart';
import 'package:tmdb_demo/widgets/image_asset.dart';
import 'package:tmdb_demo/widgets/text_common.dart';

const kTopWidgetHeight = 44.0; //appbar在没有底部组件时的高度

class AppBarCommon extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Widget? titleBuilder;
  final double? titleSize;
  final bool? hasBack;
  final Widget? right;
  final VoidCallback? popAction;
  final double bottomHeight; //底部组件的高度
  final double unIncludeBottomHeight; //无bottom时,appbar高度
  final Color? color;
  final Color? backColor; //返回键颜色
  final Widget? bottom;
  final Alignment? titleAlign; //标题对齐方式
  final EdgeInsets? titlePadding; //标题内边距
  final Color? titleColor; //标题颜色
  final AlignmentGeometry? bottomAlign; //底部组件对齐方式
  final SystemUiOverlayStyle systemUiOverlayStyle; //状态栏字体颜色

  const AppBarCommon({
    Key? key,
    required this.title,
    this.titleBuilder,
    this.titleSize,
    this.hasBack,
    this.right,
    this.popAction,
    this.bottomHeight = 0,
    this.color,
    this.bottom,
    this.titleAlign,
    this.titlePadding,
    this.titleColor,
    this.backColor,
    this.bottomAlign,
    this.systemUiOverlayStyle = SystemUiOverlayStyle.light,
    this.unIncludeBottomHeight = kTopWidgetHeight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: systemUiOverlayStyle,
      child: Container(
        color: color ?? ColorHelper.primaryColor,
        padding: EdgeInsets.only(top: ScreenUtil().statusBarHeight),
        width: double.infinity,
        height: ScreenUtil().statusBarHeight + unIncludeBottomHeight + bottomHeight,
        child: Column(
          children: [
            Stack(
              children: <Widget>[
                ///标题
                titleBuilder ??
                    Container(
                      alignment: titleAlign ?? Alignment.center,
                      height: unIncludeBottomHeight,
                      padding: titlePadding ?? const EdgeInsets.all(0),
                      child: TextCommon(
                        title,
                        color: titleColor ?? Colors.white,
                        fontSize: titleSize ?? 17.sp,
                        bold: true,
                      ),
                    ),
                // 返回键
                Visibility(
                  visible: hasBack ?? true,
                  child: GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    child: Container(
                      color: Colors.transparent,
                      alignment: Alignment.center,
                      width: unIncludeBottomHeight,
                      height: unIncludeBottomHeight,
                      child: ImageAsset(
                        'go_back',
                        width: 11.w,
                        height: 20.w,
                        color: backColor ?? Colors.white,
                      ),
                    ),
                    onTap: () {
                      if (popAction != null) {
                        popAction!();
                      } else {
                        pop();
                      }
                    },
                  ),
                ),

                ///右侧icon组
                Container(
                  height: unIncludeBottomHeight,
                  alignment: Alignment.centerRight,
                  child: right,
                ),
              ],
            ),

            ///底部组件
            Container(
              alignment: Alignment.bottomCenter,
              height: bottomHeight,
              width: 1.sw,
              child: bottom ?? Container(),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(unIncludeBottomHeight + bottomHeight);
}
