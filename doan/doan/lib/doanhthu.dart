import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';



class DoangThu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Doanh thu'),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.help_outline),
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
                  value: 'Hôm nay',
                  items: ['Hôm nay', 'Hôm qua', 'Tuần này']
                      .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                      .toList(),
                  onChanged: (value) {},
                ),
                DropdownButton<String>(
                  value: 'Tất cả chi nhánh',
                  items: ['Tất cả chi nhánh', 'Chi nhánh trung tâm']
                      .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                      .toList(),
                  onChanged: (value) {},
                ),
              ],
            ),
            SizedBox(height: 20),
            Text(
              'Doanh thu',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Row(
              children: [
                ChoiceChip(
                  label: Text('Giờ'),
                  selected: true,
                  onSelected: (value) {},
                ),
                SizedBox(width: 10),
                ChoiceChip(
                  label: Text('Ngày'),
                  selected: false,
                  onSelected: (value) {},
                ),
                SizedBox(width: 10),
                ChoiceChip(
                  label: Text('Thứ'),
                  selected: false,
                  onSelected: (value) {},
                ),
              ],
            ),
            SizedBox(height: 10),
                Container(
                  height: 200,
                  child: BarChart(
                    BarChartData(
                      alignment: BarChartAlignment.spaceAround,
                      barGroups: [
                        for (int i = 0; i < 10; i++)
                          BarChartGroupData(
                            x: i,
                            barRods: [
                              BarChartRodData(toY: (i + 1) * 100.0, color:Color.fromARGB(255, 107, 66, 38)),
                            ],
                          ),
                      ],
                    ),
                  ),
                ),
            SizedBox(height: 20),
            Text(
              'Số lượng khách hàng',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Center(
              child: Text('Chưa có dữ liệu', style: TextStyle(color: Colors.grey)),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: 'Tổng quan'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_bag), label: 'Hàng hóa'),
          BottomNavigationBarItem(icon: Icon(Icons.receipt), label: 'Hóa đơn'),
          BottomNavigationBarItem(icon: Icon(Icons.account_balance_wallet), label: 'Sổ quỹ'),
          BottomNavigationBarItem(icon: Icon(Icons.more_horiz), label: 'Nhiều hơn'),
        ],
      ),
    );
  }
}
