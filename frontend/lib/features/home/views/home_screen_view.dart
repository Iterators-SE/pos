import '../models/menu_item.dart';

abstract class HomeScreenView {
  final String persistKey = 'menu';

  List<String> drawerList;
  
  Map<String, Function> defaultItemMap;
  List<MenuItem> menuItems;
  void onReorder(int oldIndex, int newIndex);
  Future<List<MenuItem>> getMenuItems();
  void persistOrder();
}
