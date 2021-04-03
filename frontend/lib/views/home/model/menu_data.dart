class Menu {
  String id;
  String option;
  String url;

  Menu({this.id, this.option, this.url});
}

List<Menu> items = [
    Menu(id: '0', option: "PROCESS ORDERS", url: "assets/images/orders.png"),
    Menu(id: '1', option: "SEE STOCK", url: "assets/images/stocks.png"),
    Menu(id: '2', option: "DISCOUNTS", url: "assets/images/coffee-icon.png"),
    Menu(id: '3', option: "USERS", url: "assets/images/coffee-icon.png")
  ];