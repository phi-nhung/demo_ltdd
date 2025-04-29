import 'package:flutter/material.dart';


class QuanLyKhachHang extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Khách hàng'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.sort),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DropdownButton<String>(
                  value: 'Toàn thời gian',
                  items: ['Toàn thời gian', 'Hôm nay', 'Tuần này']
                      .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                      .toList(),
                  onChanged: (value) {},
                ),
                DropdownButton<String>(
                  value: 'Tất cả nhóm khách',
                  items: ['Tất cả nhóm khách', 'VIP', 'Khách lẻ']
                      .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                      .toList(),
                  onChanged: (value) {},
                ),
              ],
            ),
            SizedBox(height: 20),
            Text(
              'Tổng tiền bán',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
           
            
            SizedBox(height: 10),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.brown.shade100,
                  child: Icon(Icons.person, color: Color.fromARGB(255, 108, 66, 38)),
                ),
                title: Text('Nguyễn Văn Nam', style: TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text('Chưa có số điện thoại', style: TextStyle(color: Colors.grey)),
                trailing: Text('100,000', style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),
            SizedBox(height: 10),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.brown.shade100,
                  child: Icon(Icons.person, color: Color.fromARGB(255, 108, 66, 38)),
                ),
                title: Text('Hồ Văn Phú', style: TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text('0978567554', style: TextStyle(color: Colors.grey)),
                trailing: Text('300,000', style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),
            SizedBox(height: 10),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.brown.shade100,
                  child: Icon(Icons.person, color: Color.fromARGB(255, 108, 66, 38)),
                ),
                title: Text('Lê Thị Hoa', style: TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text('0906785645', style: TextStyle(color: Colors.grey)),
                trailing: Text('150,000', style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Color.fromARGB(255, 107, 66, 38),
        child: Icon(Icons.add, color: Color.fromARGB(255, 247, 247, 247)),
      ),
    );
  }
}
