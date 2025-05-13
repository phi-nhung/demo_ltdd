import 'package:flutter/material.dart';

class QuanLyNhanVien extends StatefulWidget {
  const QuanLyNhanVien({super.key});
  @override
  State<QuanLyNhanVien> createState() => _QLNhanVien();
}

class _QLNhanVien extends State<QuanLyNhanVien> {
  // Danh sách nhân viên mẫu
  final List<Map<String, dynamic>> nhanViens = [
    {"name": "Nguyễn Văn A", "position": "Quản lý", "icons": [Icons.account_box]},
    {"name": "Trần Thị B", "position": "Nhân viên", "icons": [Icons.account_box]},
    {"name": "Lê Văn C", "position": "Kế toán", "icons": [Icons.account_box]},
    {"name": "Hoàng Thị D", "position": "Nhân viên", "icons": [Icons.account_box]},
    {"name": "Phạm Văn E", "position": "Bảo vệ", "icons": [Icons.account_box]},
    {"name": "Đặng Thị F", "position": "Nhân viên", "icons": [Icons.account_box]},
    {"name": "Lý Văn G", "position": "Kế toán", "icons": [Icons.account_box]},
    {"name": "Bùi Thị H", "position": "Nhân viên", "icons": [Icons.account_box]},
    {"name": "Dương Văn I", "position": "Nhân viên", "icons": [Icons.account_box]},
    {"name": "Ngô Thị K", "position": "Quản lý", "icons": [Icons.account_box]},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 224, 224, 224),
        title: const Text(
          "Quản lý nhân viên",
          style: TextStyle(color: Color.fromARGB(255, 30, 30, 30)),
        ),
        centerTitle: true,
        toolbarHeight: 50,
        leading: IconButton(onPressed: () {}, icon: Icon(Icons.menu)),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.notifications)),
          IconButton(onPressed: () {}, icon: Icon(Icons.add)),
        ],
      ),
      body: Column(
        children: [
          // Thanh lọc tìm kiếm & sắp xếp
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            color: Color.fromARGB(255, 244, 238, 238),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.calendar_today, color: Color.fromARGB(255, 18, 18, 18), size: 20),
                    SizedBox(width: 5),
                    DropdownButton<String>(
                      value: "Toàn thời gian",
                      underline: SizedBox(),
                      icon: Icon(Icons.arrow_drop_down, color: Color.fromARGB(255, 18, 18, 18)),
                      style: TextStyle(color: Color.fromARGB(255, 18, 18, 18), fontSize: 16),
                      items: ["Toàn thời gian", "Hôm nay", "Tuần này", "Tháng này"]
                          .map((String value) => DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              ))
                          .toList(),
                      onChanged: (newValue) {},
                    ),
                  ],
                ),
                Row(
                  children: [
                    IconButton(onPressed: () {}, icon: Icon(Icons.search), color: Color.fromARGB(255, 18, 18, 18)),
                    IconButton(onPressed: () {}, icon: Icon(Icons.swap_vert), color: Color.fromARGB(255, 18, 18, 18)),
                  ],
                )
              ],
            ),
          ),
          const SizedBox(height: 10),
          // Danh sách nhân viên
          Expanded(
            child: ListView.builder(
              itemCount: nhanViens.length,
              padding: const EdgeInsets.all(10),
              itemBuilder: (BuildContext context, int index) {
                final nhanVien = nhanViens[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: NhanVien(
                    title: nhanVien["name"],
                    chucvu: nhanVien["position"],
                    icon: nhanVien["icons"].cast<IconData>(),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// Widget hiển thị 1 nhân viên
class NhanVien extends StatelessWidget {
  final String title;
  final String chucvu;
  final List<IconData> icon;

  const NhanVien({
    Key? key,
    required this.title,
    required this.chucvu,
    this.icon = const [],
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 247, 247, 247),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 3,
            offset: Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Color.fromARGB(255, 68, 72, 80),
            child: Text(title[0], style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                Text(chucvu, style: const TextStyle(color: Colors.grey, fontSize: 14)),
              ],
            ),
          ),
          if (icon.isNotEmpty)
            Row(
              children: icon.map((iconData) {
                return Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Icon(iconData, size: 20, color: Color.fromARGB(255, 18, 18, 18)),
                );
              }).toList(),
            ),
        ],
      ),
    );
  }
}
