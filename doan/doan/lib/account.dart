import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController _nameController = TextEditingController(text: "Nguyen Van A");
  final TextEditingController _emailController = TextEditingController(text: "nguyenvana@example.com");
  final TextEditingController _phoneController = TextEditingController(text: "0123456789");

  bool _isEditing = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 247, 247, 247), // Trắng sữa
      appBar: AppBar(
        title: Text("Thông tin tài khoản", style: TextStyle(color: Colors.white),),
        backgroundColor: Color.fromARGB(255, 107, 66, 38), // Nâu mocha
        actions: [
          IconButton(
            icon: Icon(_isEditing ? Icons.check : Icons.edit),
            color: Colors.white,
            onPressed: () {
              setState(() {
                _isEditing = !_isEditing;
              });
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTextField("Họ tên", _nameController, Icons.person),
            SizedBox(height: 15),
            _buildTextField("Email", _emailController, Icons.email, enabled: false),
            SizedBox(height: 15),
            _buildTextField("Số điện thoại", _phoneController, Icons.phone),
            SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 107, 66, 38), // Nâu mocha
                  padding: EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: _isEditing ? () {} : null,
                child: Text(
                  "Lưu thông tin",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller, IconData icon, {bool enabled = true}) {
    return TextField(
      controller: controller,
      enabled: _isEditing && enabled,
      decoration: InputDecoration(
        filled: true,
        fillColor: Color.fromARGB(255, 224, 224, 224), // Xám nhẹ
        prefixIcon: Icon(icon, color: Color.fromARGB(255, 42, 45, 50)),
        labelText: label,
        labelStyle: TextStyle(color: Color.fromARGB(255, 74, 74, 74)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
