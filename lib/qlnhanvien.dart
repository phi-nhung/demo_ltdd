import 'package:flutter/material.dart';
import 'package:doan/database/data.dart';
import 'package:doan/model/nhanvien.dart';
import 'package:doan/themnhanvien.dart';

class QuanLyNhanVien extends StatefulWidget {
  @override
  _QuanLyNhanVienState createState() => _QuanLyNhanVienState();
}

class _QuanLyNhanVienState extends State<QuanLyNhanVien> {
  List<NhanVien> nhanviens = [];
  List<NhanVien> dsNhanviens = [];
  TextEditingController _timkiemController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadNhanVien();

    _timkiemController.addListener(() {
      _dsNhanviens(_timkiemController.text);
    });
  }

  @override
  void dispose() {
    _timkiemController.dispose();
    super.dispose();
  }

  Future<void> _loadNhanVien() async {
    final data = await DSNhanVien.instance.getNhanvien();
    setState(() {
      nhanviens = data;
      dsNhanviens = data;
    });
  }

  void _dsNhanviens(String keyword) {
    final query = keyword.toLowerCase();
    setState(() {
      dsNhanviens = nhanviens
          .where((nv) => nv.tennhanvien.toLowerCase().contains(query))
          .toList();
    });
  }

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
          IconButton(
              onPressed: () async {
                final result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ThemNhanVien()));
                if (result == true) {
                  _loadNhanVien();
                }
              },
              icon: Icon(Icons.add)),
        ],
      ),
      body: Column(
        children: [
          // Ô tìm kiếm
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _timkiemController,
              decoration: InputDecoration(
                hintText: 'Tìm nhân viên theo tên...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: dsNhanviens.isEmpty
                ? Center(child: Text('Không có nhân viên nào phù hợp'))
                : ListView.builder(
                    itemCount: dsNhanviens.length,
                    itemBuilder: (context, index) {
                      final nhanvien = dsNhanviens[index];
                      return ListTile(
                        leading: CircleAvatar(
                            child: Text(nhanvien.tennhanvien[0])),
                        title: Text(nhanvien.tennhanvien, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                        subtitle: Text(nhanvien.chucvu, style: const TextStyle(color: Colors.grey, fontSize: 14)),
                        trailing: Icon(Icons.account_circle, size: 20, color: Color.fromARGB(255, 18, 18, 18)),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
