class Item {
  int id;
  String name;
  double price;
  String image;
  String description;
  String category; // Thêm thuộc tính category

  Item({
    required this.id,
    required this.name,
    required this.price,
    required this.image,
    required this.description,
    required this.category, // Thêm thuộc tính category
  });
}

class CartItem {
  Item item;
  int quantity;
  double icePercentage;
  double sugarPercentage;
  int? tableNumber;
  DateTime addedTime; // Thêm thuộc tính thời gian

  CartItem({
    required this.item,
    required this.quantity,
    required this.icePercentage,
    required this.sugarPercentage,
    this.tableNumber,
    required this.addedTime, // Thêm thuộc tính thời gian
  });
}