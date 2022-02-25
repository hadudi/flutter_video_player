class AllCategoriesGroupModel {
  String groupType = '';
  List<AllCategoriesItemModel> itemArray = [];
  int groupIndex = 0;
  String drameType = '';

  AllCategoriesGroupModel.fromJson(Map map) {
    groupType = map['filterType'];
    itemArray = (map['dramaFilterItemList'] as List)
        .map((e) => AllCategoriesItemModel.fromJson(e))
        .toList()
      ..first.selected = true;
  }
}

class AllCategoriesItemModel {
  String title = '';
  String idStr = '';
  bool selected = false;

  AllCategoriesItemModel.fromJson(Map map)
      : title = map['displayName'],
        idStr = map['value'];
}
