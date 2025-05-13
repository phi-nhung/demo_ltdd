import 'package:doan/model/item.dart';
import 'package:flutter/material.dart';

class ItemProvider with ChangeNotifier {
  final List<Item> _items = [
    Item(
      id: 1,
      name: "Cà phê sữa",
      price: 25000,
      image: "assets/cafe_sua.jpg", // Corrected image path
      description: "Cà phê sữa thơm ngon, đậm đà hương vị Việt.",
      category: "Cà phê",
    ),
    Item(
      id: 2,
      name: "Cà phê đen",
      price: 20000,
      image: "assets/cafe_den.jpg", // Corrected image path
      description: "Cà phê đen nguyên chất, không đường, không sữa.",
      category: "Cà phê",
    ),
    Item(
      id: 3,
      name: "Trà đào",
      price: 30000,
      image: "assets/tra_dao.jpg", // Corrected image path
      description: "Trà đào tươi mát, hương vị ngọt ngào.",
      category: "Trà",
    ),
    Item(
      id: 4,
      name: "Bạc xỉu",
      price: 30000,
      image: "assets/bac_xiu.jpg", // Corrected image pathe path
      description: "Bạc xỉu thơm ngon, ngọt dịu hương vị Việt.",
      category: "Cà phê",
    ),
    Item(
      id: 5,
      name: "Espresso",
      price: 35000,
      image: "assets/espresso.jpg", // Corrected image path
      description: "Cà phê sữa thơm ngon, đậm đà hương vị Việt.",
      category: "Cà phê",
    ),
    Item(
      id: 6,
      name: "Trà chanh",
      price: 25000,
      image: "assets/tra_chanh.jpg", // Corrected image path
      description: "Trà chanh sảng khoái.",
      category: "Trà",
    ),
    Item(
      id: 7,
      name: "Trà mãng cầu",
      price: 30000,
      image: "assets/tra_mangcau.jpg", // Corrected image path
      description: "Trà mãng cầu chua ngọt thanh mát.",
      category: "Trà",
    ),
    Item(
      id: 8,
      name: "Nước ép dưa hấu",
      price: 20000,
      image: "assets/ep_hau.jpg", // Corrected image path
      description: "Cà phê đen nguyên chất, không đường, không sữa.",
      category: "Nước ép",
    ),
    Item(
      id: 9,
      name: "Trà đào",
      price: 30000,
      image: "assets/tra_dao.jpg", // Corrected image path
      description: "Trà đào tươi mát, hương vị ngọt ngào.",
      category: "Trà",
    ),
    Item(
      id: 10,
      name: "Nước ép cam",
      price: 20000,
      image: "assets/ep_cam.jpg", // Corrected image path
      description: "Nước ép cam tự nhiên, tốt cho sức khỏe.",
      category: "Nước ép",
    ),
    Item(
      id: 11,
      name: "Nước ép lựu",
      price: 35000,
      image: "assets/ep_luu.jpg", // Corrected image path
      description: "Nước ép lựu thanh mát, ngọt dịu.",
      category: "Nước ép",
    ),
    Item(
      id: 12,
      name: "Americano",
      price: 25000,
      image: "assets/americano.jpg", // Corrected image path
      description: "Cà phê đen nguyên chất, không đường, không sữa.",
      category: "Cà phê",
    ),
  ];

  List<Item> get items => _items;

  List<String> get categories => _items.map((item) => item.category).toSet().toList();

  List<Item> getItemsByCategory(String category) {
    return _items.where((item) => item.category == category).toList();
  }

  void addItem(Item item) {
    _items.add(item);
    notifyListeners();
  }

  void updateItem(int index, Item newItem) {
    _items[index] = newItem;
    notifyListeners();
  }

  void deleteItem(int index) {
    _items.removeAt(index);
    notifyListeners();
  }
}
