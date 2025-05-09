import 'package:flutter/material.dart';
import 'package:doan/database/data.dart';
import 'package:doan/model/nhanvien.dart';

class ThemNhanVien extends StatefulWidget {
  @override
  _ThemNhanVienState createState() => _ThemNhanVienState();
}

class _ThemNhanVienState extends State<ThemNhanVien> {
  final _formKey = GlobalKey<FormState>();
  final _manhanvienController = TextEditingController();
  final _tennhanvienController = TextEditingController();
  final _emailController = TextEditingController();
  final _sdtController = TextEditingController();
  final _chucvuController = TextEditingController();

  Future<void> _luuNhanVien() async {
  if (_formKey.currentState!.validate()) {
    final newEmployee = NhanVien(
      manhanvien: _manhanvienController.text.trim(),
      tennhanvien: _tennhanvienController.text.trim(),
      email: _emailController.text.trim(),
      sdt: _sdtController.text.trim(),
      chucvu: _chucvuController.text.trim(),
    );
    try {
      await DSNhanVien.instance.insertNhanVien(newEmployee);
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Thành công'),
            content: Text('Đã lưu thông tin nhân viên thành công.'),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop(); 
                  Navigator.pop(context, true); 
                },
              ),
            ],
          );
        },
      );
    } catch (e) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Lỗi'),
            content: Text('Mã nhân viên này đã tồn tại.'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  } 
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Thêm nhân viên')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _manhanvienController,
                decoration: InputDecoration(labelText: 'Mã nhân viên'),
                validator: (value) => value!.isEmpty ? 'Nhập mã nhân viên' : null,
              ),
              TextFormField(
                controller: _tennhanvienController,
                decoration: InputDecoration(labelText: 'Tên nhân viên'),
                validator: (value) => value!.isEmpty ? 'Nhập tên' : null,
              ),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email'),
                validator: (value) => value!.isEmpty ? 'Nhập email' : null,
              ),
              TextFormField(
                controller: _sdtController,
                decoration: InputDecoration(labelText: 'Số điện thoại'),
                validator: (value) => value!.isEmpty ? 'Nhập số điện thoại' : null,
              ),
              TextFormField(
                controller: _chucvuController,
                decoration: InputDecoration(labelText: 'Chức vụ'),
                validator: (value) => value!.isEmpty ? 'Nhập chức vụ' : null,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _luuNhanVien,
                child: Text('Lưu'),
              )
            ],
          ),
        ),
      ),
    );
  }
}

