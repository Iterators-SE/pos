import '../model/menu_data.dart';

void getMenus() {
  List<String> menu = items.map((item) {
    return item.option;
  }).toList();
}
