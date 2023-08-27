import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tmdb_demo/widgets/shimmer_widget.dart';

import '../utils/color_helper.dart';
import '../widgets/image_asset.dart';
import '../widgets/text_common.dart';
import 'view_state_model.dart';

Widget? viewStateBuilder(
  ViewStateModel model,
  VoidCallback onTap, {
  ViewStateModel? model2,
  Widget? emptyWidget,
  String? emptyMessage,
  Widget? busyWidget,

  /// 页面失效的按钮标题
  String? loseText,

  /// 页面失效的图片
  Widget? loseImage,
}) {
  if (model.isBusy || (model2 != null && model2.isBusy)) {
    // 繁忙
    return busyWidget ?? const ViewStateBusyWidget();
  } else if (model.isEmpty || (model2 != null && model2.isEmpty)) {
    // 空状态
    return emptyWidget ??
        ViewStateEmptyWidget(
          empty: emptyWidget,
          message: emptyMessage,
          onPressed: () {},
        );
  } else if (model.isError || (model2 != null && model2.isError)) {
    // 报错
    model.showErrorMessage();
    if (model2 != null) {
      model2.showErrorMessage();
    }
    return ViewStateErrorWidget(
      error: model.viewStateError ?? ViewStateError(ViewStateErrorType.defaultError),
      onPressed: onTap,
    );
  }
  // 正常页面
  return null;
}

/// 加载中
class ViewStateBusyWidget extends StatelessWidget {
  const ViewStateBusyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(child: ShimmerWidget());
  }
}

/// 基础Widget
class ViewStateWidget extends StatelessWidget {
  final String? title;

  final String? message;
  final Widget? image;
  final String? buttonText;
  final VoidCallback? onPressed;

  const ViewStateWidget({
    Key? key,
    this.image,
    this.title,
    this.message,
    required this.onPressed,
    this.buttonText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        image ?? ImageAsset('page_empty', width: 75.w, height: 56.w),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 15.w),
          child: TextCommon(title ?? '加载失败', color: ColorHelper.c8Color, fontSize: 16.sp),
        ),
        Visibility(
          visible: buttonText != null,
          child: Center(
            child: ViewStateButton(
              textData: buttonText,
              onPressed: onPressed,
            ),
          ),
        ),
      ],
    );
  }
}

/// ErrorWidget
class ViewStateErrorWidget extends StatelessWidget {
  final ViewStateError error;
  final String? title;
  final String? message;
  final Widget? image;
  final String? buttonText;
  final VoidCallback? onPressed;

  const ViewStateErrorWidget({
    Key? key,
    required this.error,
    this.image,
    this.title,
    this.message,
    this.buttonText,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget defaultImage = ImageAsset('page_error', width: 54.w, height: 60.w);
    String defaultTitle = '加载失败';
    String defaultButtonText = buttonText ?? '点击重试';

    var errorMessage = error.message;
    switch (error.errorType) {
      case ViewStateErrorType.networkError:
        defaultImage = ImageAsset(
          "wifi_lost",
          width: 100.w,
          height: 85.w,
        );
        defaultTitle = '无网络';
        defaultButtonText = '点击重试';
        break;

      default:
        break;
    }

    return Center(
      child: ViewStateWidget(
        onPressed: onPressed,
        image: image ?? defaultImage,
        title: title ?? defaultTitle,
        message: message ?? errorMessage,
        buttonText: defaultButtonText,
      ),
    );
  }
}

/// 页面无数据
class ViewStateEmptyWidget extends StatelessWidget {
  final String? message;
  final Widget? image;
  final Widget? buttonText;
  final VoidCallback? onPressed;
  final EdgeInsets? margin;

  const ViewStateEmptyWidget({
    Key? key,
    this.image,
    this.message,
    this.buttonText,
    this.onPressed,
    Widget? empty,
    this.margin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: ViewStateWidget(
        onPressed: onPressed,
        image: Center(
          child: image ??
              ImageAsset(
                "page_empty",
                width: 100.w,
                height: 120.w,
              ),
        ),
        title: message ?? '暂无数据',
      ),
    );
  }
}

/// 公用Button
class ViewStateButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String? textData;

  const ViewStateButton({
    Key? key,
    required this.onPressed,
    this.textData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        side: MaterialStateProperty.all(
          const BorderSide(color: ColorHelper.primaryColor),
        ),
      ),
      child: TextCommon(
        textData ?? "重新加载",
        color: ColorHelper.primaryColor,
        fontSize: 15.sp,
      ),
    );
  }
}
