import 'package:flutter/material.dart';
import 'package:doan/providers/item_provider.dart';
import 'package:doan/model/item.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:doan/screens/order_screen.dart'; // Import the OrderScreen file

class ManageItemsScreen extends StatefulWidget {
  @override
  _ManageItemsScreenState createState() => _ManageItemsScreenState();
}

class _ManageItemsScreenState extends State<ManageItemsScreen> {
  String _selectedCategory = 'Tất cả';
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final itemProvider = Provider.of<ItemProvider>(context);
    final categories = ['Tất cả', 'Trà', 'Cà phê', 'Nước ép'];

    final items = _selectedCategory == 'Tất cả'
        ? itemProvider.items
        : itemProvider.getItemsByCategory(_selectedCategory)
            .where((item) => item.name.toLowerCase().contains(_searchQuery.toLowerCase()))
            .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Quản lý Mặt Hàng",
          style: TextStyle(color: Colors.black, fontSize: 18),
        ),
        backgroundColor: Color.fromARGB(255, 224, 224, 224), // Màu xám
        centerTitle: true,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 224, 224, 224),
              ),
              child: Text(
                'Menu',
                style: TextStyle(color: Colors.black, fontSize: 24),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Trang chủ'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.shopping_cart),
              title: Text('Bán Hàng'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => OrderScreen()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.manage_accounts),
              title: Text('Quản lý Mặt Hàng'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ManageItemsScreen()),
                );
              },
            ),
          ],
        ),
      ),
      body: Container(
        color: Color(0xFFF7F7F7), // Nền chính: Trắng sữa
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: DropdownButton<String>(
                value: _selectedCategory,
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedCategory = newValue!;
                  });
                },
                items: categories.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value, style: TextStyle(fontSize: 14)),
                  );
                }).toList(),
                style: TextStyle(color: Colors.black),
                dropdownColor: Colors.white,
                iconEnabledColor: Colors.black,
                underline: Container(
                  height: 2,
                  color: Colors.black,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Tìm kiếm sản phẩm',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  setState(() {
                    _searchQuery = value;
                  });
                },
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final item = items[index];
                  return ListTile(
                    leading: Image.asset(item.image, width: 40, height: 40),
                    title: Text(
                      item.name,
                      style: TextStyle(color: Color(0xFF1E1E1E), fontSize: 14), // Đen tinh tế
                    ),
                    subtitle: Text(
                      "${item.price}đ",
                      style: TextStyle(color: Color(0xFF4A4A4A), fontSize: 12), // Xám đậm
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit, color: Colors.blue, size: 20),
                          onPressed: () => _showEditDialog(context, item, index),
                        ),
                        IconButton(
                          icon: Icon(Icons.delete, color: Colors.red, size: 20),
                          onPressed: () => itemProvider.deleteItem(index),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddDialog(context),
        child: Icon(Icons.add),
        backgroundColor: Color(0xFF121212), // Đen than
      ),
    );
  }

  void _showAddDialog(BuildContext context) {
    final nameController = TextEditingController();
    final priceController = TextEditingController();
    final descriptionController = TextEditingController();
    String _selectedCategory = 'Trà';
    File? _image;

    Future<void> _pickImage() async {
      final pickedFile = await ImagePicker().getImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    }

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text("Thêm Mặt Hàng"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: nameController, decoration: InputDecoration(labelText: "Tên món")),
            TextField(controller: priceController, decoration: InputDecoration(labelText: "Giá"), keyboardType: TextInputType.number),
            TextField(controller: descriptionController, decoration: InputDecoration(labelText: "Mô tả")),
            DropdownButton<String>(
              value: _selectedCategory,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedCategory = newValue!;
                });
              },
              items: <String>['Trà', 'Cà phê', 'Nước ép']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            SizedBox(height: 10),
            _image == null
                ? Text("Chưa chọn hình ảnh")
                : Image.file(_image!, height: 100, width: 100),
            TextButton(
              child: Text("Chọn hình ảnh"),
              onPressed: _pickImage,
            ),
          ],
        ),
        actions: [
          TextButton(child: Text("Hủy"), onPressed: () => Navigator.of(ctx).pop()),
          ElevatedButton(
            child: Text("Thêm"),
            onPressed: () {
              if (nameController.text.isNotEmpty && priceController.text.isNotEmpty && descriptionController.text.isNotEmpty && _image != null) {
                Provider.of<ItemProvider>(context, listen: false).addItem(
                  Item(
                    id: DateTime.now().millisecondsSinceEpoch,
                    name: nameController.text,
                    price: double.parse(priceController.text),
                    image: _image!.path,
                    description: descriptionController.text,
                    category: _selectedCategory,
                  ),
                );
                Navigator.of(ctx).pop();
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF121212), // Đen than
              foregroundColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  void _showEditDialog(BuildContext context, Item item, int index) {
    final nameController = TextEditingController(text: item.name);
    final priceController = TextEditingController(text: item.price.toString());
    final descriptionController = TextEditingController(text: item.description);
    String _selectedCategory = item.category;
    File? _image = File(item.image);

    Future<void> _pickImage() async {
      final pickedFile = await ImagePicker().getImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    }

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text("Chỉnh sửa Mặt Hàng"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: nameController, decoration: InputDecoration(labelText: "Tên món")),
            TextField(controller: priceController, decoration: InputDecoration(labelText: "Giá"), keyboardType: TextInputType.number),
            TextField(controller: descriptionController, decoration: InputDecoration(labelText: "Mô tả")),
            DropdownButton<String>(
              value: _selectedCategory,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedCategory = newValue!;
                });
              },
              items: <String>['Trà', 'Cà phê', 'Nước ép']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            SizedBox(height: 10),
            _image == null
                ? Text("Chưa chọn hình ảnh")
                : Image.file(_image!, height: 100, width: 100),
            TextButton(
              child: Text("Chọn hình ảnh"),
              onPressed: _pickImage,
            ),
          ],
        ),
        actions: [
          TextButton(child: Text("Hủy"), onPressed: () => Navigator.of(ctx).pop()),
          ElevatedButton(
            child: Text("Lưu"),
            onPressed: () {
              if (nameController.text.isNotEmpty && priceController.text.isNotEmpty && descriptionController.text.isNotEmpty && _image != null) {
                Provider.of<ItemProvider>(context, listen: false).updateItem(
                  index,
                  Item(
                    id: item.id,
                    name: nameController.text,
                    price: double.parse(priceController.text),
                    image: _image!.path,
                    description: descriptionController.text,
                    category: _selectedCategory,
                  ),
                );
                Navigator.of(ctx).pop();
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF121212), // Đen than
              foregroundColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}