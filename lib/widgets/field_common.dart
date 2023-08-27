import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import '../utils/color_helper.dart';
import 'image_asset.dart';

class FieldCommon extends StatelessWidget {
  final TextEditingController controller;
  final bool clear;
  final BoxDecoration? decoration;
  final FocusNode? focusNode;
  final double? fontSize;
  final double? height;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;
  final int? maxLines;
  final int? maxLength;
  final bool obscureText;
  final ValueChanged<String>? onSubmitted;
  final ValueChanged<String>? onChanged;
  final EdgeInsetsGeometry? padding;
  final String? placeholder;
  final TextStyle? placeholderStyle;
  final Widget? prefix;
  final Widget? suffix;
  final bool readOnly;
  final TextStyle? style;
  final TextAlign textAlign;
  final OverlayVisibilityMode? suffixMode;
  final TextInputAction? textInputAction;
  final double? cursorHeight;
  final double? cursorWidth;
  final bool showCursor;
  final Color? cursorColor;
  final Radius? cursorRadius;
  final TextAlignVertical? textAlignVertical;
  final Function()? onTap;
  final bool autofocus;

  const FieldCommon({
    Key? key,
    required this.controller,
    this.clear = false,
    this.decoration,
    this.focusNode,
    this.fontSize,
    this.height,
    this.inputFormatters,
    this.keyboardType,
    this.maxLines,
    this.maxLength,
    this.obscureText = false,
    this.onSubmitted,
    this.onChanged,
    this.padding,
    this.placeholder,
    this.placeholderStyle,
    this.prefix,
    this.suffix,
    this.readOnly = false,
    this.style,
    this.textAlign = TextAlign.start,
    this.suffixMode = OverlayVisibilityMode.editing,
    this.textInputAction,
    this.cursorHeight,
    this.cursorColor,
    this.cursorRadius,
    this.cursorWidth,
    this.showCursor = true,
    this.onTap,
    this.textAlignVertical,
    this.autofocus = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? 44,
      child: CupertinoTextField(
        controller: controller,
        onTap: onTap,
        decoration: decoration,
        cursorHeight: cursorHeight,
        cursorColor: cursorColor,
        cursorRadius: cursorRadius ?? const Radius.circular(2),
        cursorWidth: cursorWidth ?? 2.0,
        showCursor: showCursor,
        focusNode: focusNode,
        inputFormatters: inputFormatters,
        keyboardType: keyboardType,
        maxLines: maxLines,
        maxLength: maxLength,
        obscureText: obscureText,
        onChanged: onChanged,
        onSubmitted: onSubmitted,
        padding: padding ?? EdgeInsets.zero,
        placeholder: placeholder,
        placeholderStyle:
            placeholderStyle ?? TextStyle(color: ColorHelper.c8Color, fontSize: fontSize ?? 14),
        prefix: prefix,
        style: style ?? TextStyle(color: ColorHelper.threeColor, fontSize: fontSize ?? 14),
        suffixMode: suffixMode ?? OverlayVisibilityMode.always,
        suffix: clear
            ? GestureDetector(
                behavior: HitTestBehavior.opaque,
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: ImageAsset('clear', size: 20),
                ),
                onTap: () => controller.clear(),
              )
            : suffix,
        textAlign: textAlign,
        textInputAction: textInputAction ?? TextInputAction.next,
        readOnly: readOnly,
        textAlignVertical: textAlignVertical,
        autofocus: autofocus,
      ),
    );
  }
}
