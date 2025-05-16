import 'package:doan/account.dart';
import 'package:doan/qlnhanvien.dart';
import 'package:doan/qlban.dart';
import 'package:flutter/material.dart';
import 'package:doan/screens/manage_items_screen.dart';
import'package:doan/screens/order_screen.dart';
import 'package:doan/quanlykhachhang.dart';
import 'package:doan/doanhthu.dart';

class AdminHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Coffe Shop",
          style: TextStyle(color: Colors.white, fontFamily: 'DancingScript', fontSize: 30),
        ),
        backgroundColor: Color.fromARGB(255, 18, 18, 18),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: GestureDetector(
              onTap: () {
                // Mở menu khi nhấn vào avatar hoặc tên người dùng
                _showUserMenu(context);
              },
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage('assets/avatar.png'), // Đảm bảo bạn có hình ảnh avatar trong thư mục assets
                    radius: 20,
                  ),
                  SizedBox(width: 8),
                  Text(
                    'Nguyễn Văn A', // Thay bằng tên người dùng hiện tại
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      body: GridView.count(
        crossAxisCount: 2,
        padding: EdgeInsets.all(16),
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        children: [
          _buildDashboardItem(context,OrderScreen(), Icons.sell_outlined, "Bán hàng"),
          _buildDashboardItem(context, AdminHome(),Icons.list_alt_rounded, "Đơn hàng"),
          _buildDashboardItem(context, QL_Ban(),Icons.table_chart, "Quản lý bàn"),
          _buildDashboardItem(context, ManageItemsScreen(),Icons.menu_book, "Quản lý menu"),
          _buildDashboardItem(context, QL_KhachHang(),Icons.person_pin_outlined, "Khách hàng"),
          _buildDashboardItem(context, QL_NhanVien(), Icons.people, "Nhân viên"),
          _buildDashboardItem(context, DoanhThu(),Icons.bar_chart_outlined, "Doanh thu"),
          _buildDashboardItem(context,AdminHome(), Icons.settings, "Cài đặt"),
        ],
      ),
    );
  }

  // Hàm để hiển thị menu khi nhấn vào avatar hoặc tên người dùng
  void _showUserMenu(BuildContext context) {
    showMenu(
      context: context,
      position: RelativeRect.fromLTRB(100, 60, 0, 0), // Đặt vị trí menu (có thể điều chỉnh)
      items: [
        PopupMenuItem(
          onTap: ()=>Navigator.push(context,MaterialPageRoute(builder: (context)=>ProfileScreen())),
          value: 'account',
          child: Row(
            children: [
              Icon(Icons.account_circle, color: Colors.black),
              SizedBox(width: 8),
              Text('Tài khoản'),
            ],
          ),
        ),
        PopupMenuItem(
          value: 'logout',
          child: Row(
            children: [
              Icon(Icons.logout, color: Colors.black),
              SizedBox(width: 8),
              Text('Đăng xuất'),
            ],
          ),
        ),
      ],
      elevation: 8.0,
    ).then((value) {
      if (value != null) {
        // Thực hiện hành động sau khi chọn mục từ menu
        if (value == 'account') {
          // TODO: Điều hướng đến màn hình tài khoản
        } else if (value == 'logout') {
          // TODO: Thực hiện đăng xuất
          print('Đăng xuất');
        }
      }
    });
  }

  Widget _buildDashboardItem(BuildContext context, Widget app, IconData icon, String title) {
  return GestureDetector(
    onTap: () => Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => app),
    ),
    child: Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 40, color: Colors.brown),
          SizedBox(height: 10),
          Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        ],
      ),
    ),
  );
}}