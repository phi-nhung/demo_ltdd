import 'package:flutter/material.dart';

class QuanLyBan extends StatelessWidget {
  const QuanLyBan({super.key});
  @override

   Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 224, 224, 224),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 247, 247, 247),
        title: const Text("Quản lý bàn", style: TextStyle(color: Color.fromARGB(255, 30, 30, 30))),
        toolbarHeight: 50,
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {},
        ),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.search)),
          IconButton(onPressed: () {}, icon: Icon(Icons.notifications)),
          IconButton(onPressed: () {}, icon: Icon(Icons.add)),
        ],
      ),
      
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 247, 247, 247),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 10),
                Row (
                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                   children: <Widget>[
                    Text("Tất cả", style: TextStyle(fontSize: 15)),
                     Text("Sử dụng", style: TextStyle(fontSize: 15)),
                     Text("Còn trống", style: TextStyle(fontSize: 15)),
                   ],
                ),
              ],
            )
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 247, 247, 247),
            ),
            child: Row (
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                buildTabButton("Tầng 1", isSelected: true),
                buildTabButton("Tầng 2"),
                buildTabButton("Tầng 3"),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              padding: const EdgeInsets.all(10),
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              children: [
                BanCard(
                  title: "Giao đi", iconList: [Icons.delivery_dining]
                ),
                BanCard(title: "Mang về", iconList: [Icons.shopping_cart],),
                BanCard(title: "Bàn 01"),
                BanCard(title: "Bàn 02", time: "1h40p", price: "200,000", iconList: [Icons.access_time]),
                BanCard(title: "Bàn 03"),
                BanCard(title: "Bàn 04", time: "2h", price: "250,000", iconList: [Icons.access_time, Icons.people, Icons.edit, Icons.image]),
                BanCard(title: "Bàn 05"),
                BanCard(title: "Bàn 06"),
              ],
            ),
          )
        ],
      ),
    );
   }
    Widget buildTabButton(String title, {bool isSelected = false}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 50, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? Color.fromARGB(255, 71, 74, 80) : const Color.fromARGB(255, 247, 247, 247),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Color.fromARGB(255, 224, 224, 224)),
      ),
      child: Text(
        title,
        style: TextStyle(color: isSelected ? Color.fromARGB(255, 247, 247, 247) : Color.fromARGB(255, 77, 76, 76), fontWeight: FontWeight.normal),
      ),
    );
  }
}

class BanCard extends StatelessWidget {
  final String title;
  final String? time;
  final String? price;
  final List<IconData> iconList;

  const BanCard({
    Key? key,
    required this.title,
    this.time,
    this.price,
     this.iconList = const [],
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 247, 247, 247),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          Row (
            children: [
              IconButton(
                icon: Icon(Icons.remove_circle_outline, color: Colors.red),
                    onPressed: () {},
              ),
              IconButton(
                    icon: Icon(Icons.add_circle_outline, color: Colors.green),
                    onPressed: () {},
              ),
            ],
          ),
          const SizedBox(height: 5),
          if (time != null) Text(time!),
          if (price != null) Text(price!),
          const Spacer(),
          if (iconList.isNotEmpty)
            Row(
              children: iconList
                  .map((iconData) => Padding(
                        padding: const EdgeInsets.only(right: 5),
                        child: Icon(iconData, size: 20),
                      ))
                  .toList(),
            ),
        ],
      ),
    );
  }
}