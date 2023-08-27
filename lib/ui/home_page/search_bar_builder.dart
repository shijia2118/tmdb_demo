import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tmdb_demo/utils/color_helper.dart';
import 'package:tmdb_demo/widgets/image_asset.dart';
import 'package:tmdb_demo/widgets/out_line_field_common.dart';
import 'package:tmdb_demo/widgets/text_button_common.dart';

class SearchBarBuilder extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode? focusNode;
  final Function()? onSearch;
  const SearchBarBuilder({
    super.key,
    required this.controller,
    this.onSearch,
    this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.sw,
      height: 50.h,
      padding: EdgeInsets.fromLTRB(15.w, 6.w, 0, 6.w),
      child: Row(
        children: [
          Expanded(
            child: OutlineFieldCommon(
              controller: controller,
              backgroundColor: Colors.white,
              borderCircular: 20.r,
              autofocus: true,
              focusNode: focusNode,
              borderColor: Colors.transparent,
              placeholder: '请输入标题搜索',
              prefix: Padding(
                padding: EdgeInsets.only(left: 10.w),
                child: ImageAsset(
                  'search',
                  width: 18.w,
                  height: 18.w,
                ),
              ),
            ),
          ),
          TextButtonCommon(
            text: '搜索',
            textColor: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.w),
            overlayColor: ColorHelper.b6Color,
            onTap: onSearch,
          )
        ],
      ),
    );
  }
}
