import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tmdb_demo/widgets/text_common.dart';

import '../provider/view_state_model.dart';
import '../utils/color_helper.dart';

class TextButtonCommon extends StatelessWidget {
  final EdgeInsetsGeometry? margin;
  final double? fontSize;
  final ViewStateModel? model;
  final String text;
  final VoidCallback? onTap;
  final Color color;
  final Color? textColor;
  final Decoration? decoration;
  final Color? backgroundColor;
  final Color? overlayColor;
  final bool bold;
  final EdgeInsets? padding;
  final TextDecoration? textDecoration;
  final double? width;
  final double? height;

  const TextButtonCommon({
    Key? key,
    this.margin,
    this.fontSize,
    this.model,
    this.color = ColorHelper.primaryColor,
    this.textColor,
    this.decoration,
    this.text = '确认',
    this.onTap,
    this.backgroundColor,
    this.overlayColor,
    this.bold = false,
    this.padding,
    this.textDecoration,
    this.width,
    this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MaterialStateProperty<Size?>? minimumSize = MaterialStateProperty.all(Size(width ?? 0, height ?? 0));

    return Container(
      margin: margin,
      child: TextButton(
        onPressed: model != null && model!.isBusy
            ? () {}
            : () {
                //默认取消聚焦
                FocusScopeNode currentFocus = FocusScope.of(context);
                if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
                  FocusManager.instance.primaryFocus?.unfocus();
                }
                if (onTap != null) onTap!();
              },
        style: ButtonStyle(
          minimumSize: minimumSize,

          padding: MaterialStateProperty.all(padding),

          ///背景色
          backgroundColor: MaterialStateProperty.all(backgroundColor ?? Colors.transparent),

          ///水波纹
          overlayColor: MaterialStateProperty.all(overlayColor ?? ColorHelper.bgColor),
        ),
        child: TextCommon(
          text,
          color: textColor ?? Colors.black,
          bold: bold,
          fontSize: fontSize ?? 14.sp,
          textDecoration: textDecoration,
        ),
      ),
    );
  }
}
