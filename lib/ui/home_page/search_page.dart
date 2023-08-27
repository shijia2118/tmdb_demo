import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:tmdb_demo/entity/movie_entity.dart';
import 'package:tmdb_demo/provider/provider_widget.dart';
import 'package:tmdb_demo/provider/view_state_widget.dart';
import 'package:tmdb_demo/ui/home_page/movie_item.dart';
import 'package:tmdb_demo/ui/home_page/search_bar_builder.dart';
import 'package:tmdb_demo/utils/color_helper.dart';
import 'package:tmdb_demo/view_model/list_model.dart';
import 'package:tmdb_demo/view_model/refresh_model.dart';
import 'package:tmdb_demo/widgets/app_bar_common.dart';
import 'package:tmdb_demo/widgets/image_asset.dart';
import 'package:tmdb_demo/widgets/text_common.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController textEditingController = TextEditingController();
  final FocusNode focusNode = FocusNode();

  RefreshModel<MovieEntity> model = RefreshModel();

  ListModel<MovieEntity> suggestionModel = ListModel();
  List<String> suggestionList = [];

  bool showSuggestion = true;

  @override
  void initState() {
    super.initState();
    getSuggestionList();
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        if (mounted) {
          setState(() {
            showSuggestion = true;
          });
        }
      } else {
        if (mounted) {
          setState(() {
            showSuggestion = false;
          });
        }
      }
    });
  }

  @override
  void dispose() {
    textEditingController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    /// 搜索结果
    Widget searchResultWidget = ProviderWidget<RefreshModel<MovieEntity>>(
      builder: (context, model, _) {
        return viewStateBuilder(model, onSearch) ??
            SmartRefresher(
              controller: model.refreshController,
              enablePullUp: model.list.length >= 20,
              onRefresh: () => model.refresh(),
              onLoading: () => model.loadMore(),
              child: GridView.builder(
                padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.w),
                itemCount: model.list.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 5.w,
                  crossAxisSpacing: 6.w,
                  childAspectRatio: 0.65,
                ),
                itemBuilder: (context, index) {
                  return MovieItem(movieEntity: model.list[index]);
                },
              ),
            );
      },
      model: model,
    );

    /// 搜索建议
    Widget searchSuggestionWidget = Visibility(
      visible: showSuggestion,
      child: Container(
        width: 1.sw,
        color: Colors.white,
        child: ListView.separated(
          itemCount: suggestionList.length,
          separatorBuilder: (context, index) {
            return Container(
              width: 1.sw,
              height: 1,
              color: ColorHelper.eaColor,
            );
          },
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () => onSuggestionItemClicked(index),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.w),
                color: Colors.white,
                child: Row(
                  children: [
                    ImageAsset('search', width: 15.w, height: 15.w),
                    SizedBox(width: 10.w),
                    TextCommon(suggestionList[index]),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );

    return Scaffold(
      appBar: AppBarCommon(
        title: '影视搜索',
        bottom: SearchBarBuilder(
          focusNode: focusNode,
          controller: textEditingController,
          onSearch: onSearch,
        ),
        bottomHeight: 50.h,
      ),
      body: Stack(
        children: [
          searchResultWidget,
          searchSuggestionWidget,
        ],
      ),
    );
  }

  ///获取推荐列表
  void getSuggestionList() async {
    await suggestionModel.initData();
    if (suggestionModel.list.isNotEmpty) {
      for (int i = 0; i < suggestionModel.list.length; i++) {
        if (i >= 10) break;
        String? title = suggestionModel.list[i].title;
        String? name = suggestionModel.list[i].name;
        if (title != null) {
          suggestionList.add(title);
        } else if (name != null) {
          suggestionList.add(name);
        }
      }
      setState(() {});
    }
  }

  ///搜索建议item点击事件
  void onSuggestionItemClicked(int index) async {
    textEditingController.text = suggestionList[index]; //赋值
    focusNode.unfocus(); //失去焦点
    await onSearch(); //开始搜索
  }

  ///根据标题搜索
  Future onSearch() async {
    model.query = textEditingController.text;
    await model.initData();
  }
}
