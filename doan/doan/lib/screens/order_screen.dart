import 'package:flutter/material.dart';
import 'package:doan/providers/cart_provider.dart';
import 'package:doan/model/item.dart';
import 'package:provider/provider.dart';
import 'package:doan/providers/item_provider.dart';
import 'package:badges/badges.dart' as badges;
import 'package:doan/screens/manage_items_screen.dart'; // Add this import

class OrderScreen extends StatefulWidget {
  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  String _orderType = 'Mang đi';
  int? _selectedTable;
  String _selectedCategory = 'Cà phê';
  String _searchQuery = '';
  Map<int, String> _tableStatus = {
    for (int i = 1; i <= 10; i++) i: 'Trống'
  };
  double _icePercentage = 50;
  double _sugarPercentage = 50;

  void _showInvoiceDialog(BuildContext context, List<CartItem> items, double totalAmount, CartProvider cart, int? tableNumber) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text("Hóa Đơn - ${tableNumber != null ? 'Bàn $tableNumber' : 'Mang đi'}"),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ...items.map((item) => ListTile(
                leading: Image.asset(item.item.image, width: 50, height: 50),
                title: Text(item.item.name),
                subtitle: Text("${item.item.price}đ x ${item.quantity}\nĐá: ${item.icePercentage.round()}%, Đường: ${item.sugarPercentage.round()}%"),
              )),
              Divider(),
              ListTile(
                title: Text("Tổng tiền", style: TextStyle(fontWeight: FontWeight.bold)),
                trailing: Text("${totalAmount}đ", style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            child: Text("Hủy"),
            onPressed: () => Navigator.of(ctx).pop(),
          ),
          ElevatedButton(
            child: Text("Xác Nhận"),
            onPressed: () {
              Navigator.of(ctx).pop();
              // Navigate to CheckoutScreen
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CheckoutScreen(
                    tableNumber: tableNumber,
                    onCheckout: () {
                      if (tableNumber != null) {
                        cart.clearTableCart(tableNumber);
                        setState(() {
                          _tableStatus[tableNumber] = 'Trống';
                          _selectedTable = null;
                        });
                      } else {
                        cart.clearCart();
                      }
                      _showSnackBar(context, "Thanh toán thành công");
                    },
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final items = Provider.of<ItemProvider>(context)
        .getItemsByCategory(_selectedCategory)
        .where((item) => item.name.toLowerCase().contains(_searchQuery.toLowerCase()))
        .toList();
    final categories = Provider.of<ItemProvider>(context).categories;
    final cart = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Bán Hàng",
          style: TextStyle(color: Colors.black, fontSize: 18), // Chỉnh màu chữ thành màu đen
        ),
        backgroundColor: Color.fromARGB(255, 224, 224, 224), // Màu xám
        centerTitle: true,
        actions: [
          badges.Badge(
            badgeContent: Text(
              cart.items.length.toString(),
              style: TextStyle(color: const Color.fromARGB(255, 0, 0, 0), fontSize: 12),
            ),
            position: badges.BadgePosition.topEnd(top: 0, end: 3),
            child: IconButton(
              onPressed: () {
                // Chuyển đến trang giỏ hàng
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CartScreen()),
                );
              },
              icon: Icon(Icons.shopping_cart, color: Colors.black),
            ),
          ),
        ],
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _orderType = 'Mang đi';
                          _selectedTable = null;
                        });
                      },
                      child: Text("Mang đi"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _orderType == 'Mang đi' ? Color(0xFF121212) : Color(0xFFE0E0E0), // Đen than hoặc Xám nhẹ
                        foregroundColor: _orderType == 'Mang đi' ? Colors.white : Colors.black,
                        padding: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                        textStyle: TextStyle(fontSize: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Flexible(
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _orderType = 'Tại bàn';
                          _selectedTable = null;
                        });
                      },
                      child: Text("Tại bàn"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _orderType == 'Tại bàn' ? Color(0xFF121212) : Color(0xFFE0E0E0), // Đen than hoặc Xám nhẹ
                        foregroundColor: _orderType == 'Tại bàn' ? Colors.white : Colors.black,
                        padding: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                        textStyle: TextStyle(fontSize: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  ),
                ],
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
            if (_orderType == 'Tại bàn' && _selectedTable == null)
              Expanded(
                child: GridView.builder(
                  padding: EdgeInsets.all(10),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: MediaQuery.of(context).size.width > 600 ? 4 : 3,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: 10, // Giả sử có 10 bàn
                  itemBuilder: (context, index) {
                    int tableNumber = index + 1;
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedTable = tableNumber;
                        });
                      },
                      child: Column(
                        children: [
                          Icon(
                            Icons.table_chart,
                            size: 40,
                            color: _selectedTable == tableNumber ? Color(0xFF121212) : Color(0xFF2A2D32), // Đen than hoặc Xám đậm
                          ),
                          Text(
                            "Bàn $tableNumber",
                            style: TextStyle(color: Color(0xFF4A4A4A), fontSize: 12), // Xám đậm
                          ),
                          Text(
                            _tableStatus[tableNumber]!,
                            style: TextStyle(color: Color(0xFF4A4A4A), fontSize: 12), // Xám đậm
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            if (_orderType == 'Mang đi' || _selectedTable != null)
              Expanded(
                child: Column(
                  children: [
                    if (_selectedTable != null)
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.table_chart,
                              size: 40,
                              color: Color(0xFF121212), // Đen than
                            ),
                            SizedBox(width: 10),
                            Text(
                              "Bàn $_selectedTable",
                              style: TextStyle(color: Color(0xFF1E1E1E), fontSize: 14), // Đen tinh tế
                            ),
                          ],
                        ),
                      ),
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
                    Expanded(
                      child: GridView.builder(
                        padding: EdgeInsets.all(10),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: MediaQuery.of(context).size.width > 600 ? 4 : 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          childAspectRatio: 0.7,
                        ),
                        itemCount: items.length,
                        itemBuilder: (context, index) {
                          final item = items[index];
                          return Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            elevation: 5,
                            shadowColor: Colors.black.withOpacity(0.5),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Image.asset(item.image, fit: BoxFit.cover),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                                    child: Column(
                                      children: [
                                        Text(
                                          item.name,
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xFF1E1E1E), // Đen tinh tế
                                          ),
                                        ),
                                        Text(
                                          "${item.price}đ",
                                          style: TextStyle(color: Color(0xFF6B4226), fontSize: 12), // Nâu mocha
                                        ),
                                        SizedBox(height: 5),
                                        Text(
                                          item.description,
                                          style: TextStyle(
                                            fontSize: 10,
                                            color: Color(0xFF4A4A4A), // Xám đậm
                                          ),
                                          textAlign: TextAlign.center,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      _showOptionsDialog(context, item, cart);
                                    },
                                    child: Text("Thêm"),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Color(0xFF121212), // Đen than
                                      foregroundColor: Colors.white,
                                      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                                      textStyle: TextStyle(fontSize: 12),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            if (_selectedTable != null && _tableStatus[_selectedTable!] == 'Chờ thanh toán')
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () {
                    // Show invoice dialog for the selected table
                    final tableItems = cart.tableItems[_selectedTable!] ?? [];
                    final tableTotalAmount = cart.getTableTotalAmount(_selectedTable!);
                    _showInvoiceDialog(context, tableItems, tableTotalAmount, cart, _selectedTable);
                  },
                  child: Text("Thanh Toán"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF121212), // Đen than
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    textStyle: TextStyle(fontSize: 14),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  void _showOptionsDialog(BuildContext context, Item item, CartProvider cart) {
    double icePercentage = _icePercentage;
    double sugarPercentage = _sugarPercentage;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Chọn tùy chọn"),
          content: StatefulBuilder(
            builder: (context, setState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("Chọn % đá: ${icePercentage.round()}%"),
                  Slider(
                    value: icePercentage,
                    min: 0,
                    max: 100,
                    divisions: 10,
                    label: "${icePercentage.round()}%",
                    onChanged: (value) {
                      setState(() {
                        icePercentage = value;
                      });
                    },
                  ),
                  Text("Chọn % đường: ${sugarPercentage.round()}%"),
                  Slider(
                    value: sugarPercentage,
                    min: 0,
                    max: 100,
                    divisions: 10,
                    label: "${sugarPercentage.round()}%",
                    onChanged: (value) {
                      setState(() {
                        sugarPercentage = value;
                      });
                    },
                  ),
                ],
              );
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Hủy"),
            ),
            ElevatedButton(
              onPressed: () {
                cart.addToCart(item, icePercentage, sugarPercentage, tableNumber: _selectedTable);
                Navigator.of(context).pop();
                _showSnackBar(context, "Thêm món thành công");
                setState(() {
                  if (_selectedTable != null) {
                    _tableStatus[_selectedTable!] = 'Chờ thanh toán';
                  }
                });
              },
              child: Text("Thêm"),
            ),
          ],
        );
      },
    );
  }
}

void _showSnackBar(BuildContext context, String message) {
  final snackBar = SnackBar(
    content: Text(message),
    duration: Duration(seconds: 2),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

class CartScreen extends StatelessWidget {
  void _showEditQuantityDialog(BuildContext context, CartItem cartItem, CartProvider cart) {
    showDialog(
      context: context,
      builder: (ctx) {
        int quantity = cartItem.quantity;
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text("Chỉnh sửa số lượng"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("Số lượng:"),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: Icon(Icons.remove),
                        onPressed: () {
                          if (quantity > 1) {
                            setState(() {
                              quantity--;
                            });
                          }
                        },
                      ),
                      Text(quantity.toString()),
                      IconButton(
                        icon: Icon(Icons.add),
                        onPressed: () {
                          setState(() {
                            quantity++;
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(ctx).pop();
                  },
                  child: Text("Hủy"),
                ),
                ElevatedButton(
                  onPressed: () {
                    cart.updateItemQuantity(cartItem.item, quantity);
                    Navigator.of(ctx).pop();
                  },
                  child: Text("Lưu"),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Giỏ Hàng",
          style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)), // Xám đậm
        ),
        backgroundColor: Color.fromARGB(255, 224, 224, 224), // Đen than
      ),
      body: Container(
        color: Color(0xFFF7F7F7), // Nền chính: Trắng sữa
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: cart.items.length,
                itemBuilder: (context, index) {
                  final cartItem = cart.items[index];
                  return ListTile(
                    leading: Image.asset(cartItem.item.image, width: 40, height: 40),
                    title: Text(
                      cartItem.item.name,
                      style: TextStyle(color: Color(0xFF1E1E1E)), // Đen tinh tế
                    ),
                    subtitle: Text(
                      "${cartItem.item.price}đ x ${cartItem.quantity}\nĐá: ${cartItem.icePercentage.round()}%, Đường: ${cartItem.sugarPercentage.round()}%\n${cartItem.tableNumber != null ? 'Tại bàn ${cartItem.tableNumber}' : 'Mang đi'}\nThời gian thêm: ${cartItem.addedTime.hour}:${cartItem.addedTime.minute}",
                      style: TextStyle(color: Color(0xFF4A4A4A)), // Xám đậm
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit, color: Colors.blue),
                          onPressed: () => _showEditQuantityDialog(context, cartItem, cart),
                        ),
                        IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            cart.removeFromCart(cartItem.item);
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Tổng tiền: ${cart.totalAmount}đ",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF1E1E1E)), // Đen tinh tế
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  // Chuyển đến trang thanh toán
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CheckoutScreen(
                      tableNumber: null,
                      onCheckout: () {
                        cart.clearCart();
                      },
                    )),
                  );
                },
                child: Text("Thanh Toán"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFF7F7F7), // Trắng sữa
                  foregroundColor: Color(0xFF4A4A4A), // Xám đậm
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  textStyle: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CheckoutScreen extends StatelessWidget {
  final int? tableNumber;
  final VoidCallback onCheckout;

  CheckoutScreen({required this.tableNumber, required this.onCheckout});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    final items = tableNumber != null ? cart.tableItems[tableNumber] ?? [] : cart.items;
    final totalAmount = tableNumber != null
        ? cart.getTableTotalAmount(tableNumber!)
        : items.fold(0, (sum, cartItem) => sum + (cartItem.item.price * cartItem.quantity).toInt());

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Thanh Toán",
          style: TextStyle(color: Colors.black), // Chữ màu đen
        ),
        backgroundColor: Color.fromARGB(255, 224, 224, 224), // Màu xám
      ),
      body: Container(
        color: Color(0xFFF7F7F7), // Nền chính: Trắng sữa
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Giảm giá (%)",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: "0",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),
              Text(
                "Thu khác",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: "0",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),
              Text(
                "Khách cần trả",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Text(
                "$totalAmount đ",
                style: TextStyle(fontSize: 16, color: Colors.blue),
              ),
              SizedBox(height: 10),
              Text(
                "Khách thanh toán",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Text(
                "${items.fold(0, (sum, cartItem) => sum + (cartItem.item.price * cartItem.quantity).toInt())}đ",
                style: TextStyle(fontSize: 16, color: Colors.blue),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    child: Text("Tiền mặt"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey,
                      foregroundColor: Colors.white,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text("Chuyển khoản"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text("Thẻ"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Center(
                child: Column(
                  children: [
                    Text(
                      "VCB",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Text("Nguyễn Văn A"),
                    SizedBox(height: 10),
                    Image.asset('assets/qr.jpg', width: 100, height: 100), // QR code image
                    SizedBox(height: 10),
                    Text(
                      "140704070007763",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    // Xử lý thanh toán
                    if (tableNumber != null) {
                      cart.clearTableCart(tableNumber!);
                    } else {
                      cart.clearCart();
                    }
                    onCheckout();
                    Navigator.pop(context);
                  },
                  child: Text("Hoàn thành"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                    textStyle: TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
