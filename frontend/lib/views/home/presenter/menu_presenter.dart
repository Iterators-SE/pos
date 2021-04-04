import '../model/menu_data.dart';

List<dynamic> getMenus() {
  return items.map((item) => item.option).toList();
}
