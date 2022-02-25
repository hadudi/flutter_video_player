// ignore_for_file: must_be_immutable, prefer_const_constructors

import 'package:flutter/material.dart';
import '../model/category_model.dart';

/* 
获取 widget位置
RenderObject? box = ctx.findRenderObject();
double x =  box?.getTransformTo(null).getTranslation().x ?? 0;
ctx.size;
 */
class CategoryItemView extends StatefulWidget {
  CategoryItemView({
    Key? key,
    required this.model,
    this.onTap,
    this.enable = true,
  }) : super(key: key);

  AllCategoriesGroupModel model;
  final ValueChanged<int>? onTap;
  bool enable;

  @override
  _CategoryItemViewState createState() => _CategoryItemViewState();
}

class _CategoryItemViewState extends State<CategoryItemView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController =
        TabController(length: widget.model.itemArray.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<AllCategoriesItemModel> itemArray = widget.model.itemArray;
    return Theme(
      data: Theme.of(context).copyWith(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
      child: TabBar(
        controller: _tabController,
        isScrollable: true,
        padding: EdgeInsets.symmetric(horizontal: 6),
        labelPadding: EdgeInsets.symmetric(horizontal: 3, vertical: 6),
        indicatorWeight: 0.0001,
        indicatorColor: Colors.white,
        enableFeedback: false,
        onTap: !widget.enable
            ? null
            : (index) {
                AllCategoriesItemModel e = itemArray[index];
                setState(() {
                  for (var item in itemArray) {
                    item.selected = false;
                  }
                  e.selected = true;
                });
                widget.onTap?.call(index);
              },
        tabs: itemArray
            .map(
              (e) => Tab(
                height: 32,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: !widget.enable
                      ? null
                      : BoxDecoration(
                          color: e.selected ? Color(0xfff3f6f8) : Colors.white,
                          borderRadius: BorderRadius.circular(16),
                        ),
                  child: Text(
                    e.title,
                    style: TextStyle(
                      color: !widget.enable
                          ? Color(0xffcbcdd4)
                          : (e.selected
                              ? Color(0xfffb6060)
                              : Color(0xff868996)),
                      fontSize: 14,
                      fontWeight: !widget.enable
                          ? FontWeight.normal
                          : (e.selected ? FontWeight.w500 : FontWeight.normal),
                    ),
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
