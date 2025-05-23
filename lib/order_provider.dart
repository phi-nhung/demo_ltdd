import 'package:doan/database_helper.dart';
import 'package:doan/model/oder.dart';

class OrderService {
  final String _tableName = 'HOADON';
  final String _idColumn = 'MAHD';

  Future<List<Order>> fetchOrders({String? searchType, String? keyword}) async {
    final db = await DatabaseHelper.database;

    String whereClause = '';
    List<dynamic> whereArgs = [];

    if (keyword != null && keyword.isNotEmpty) {
      if (searchType == 'Mã hóa đơn') {
        whereClause = 'WHERE d.MAHD = ?';
        whereArgs.add(int.tryParse(keyword) ?? -1);
      } else if (searchType == 'Số điện thoại') {
        whereClause = 'WHERE k.SDT = ?';
        whereArgs.add(keyword);
      }
    }

    final result = await db.rawQuery('''
      SELECT d.*,
             k.HOTEN AS TENKHACHHANG,
             k.SDT AS SDTKH,
             nv.HOTEN AS HOTENNHANVIEN,
             b.SOBAN
      FROM HOADON d
      LEFT JOIN KHACHHANG k ON d.MAKH = k.MAKH -- Đã sửa: Thay đổi thành LEFT JOIN
      LEFT JOIN NHANVIEN nv ON d.MANV = nv.MANHANVIEN
      LEFT JOIN BAN b ON d.MABAN = b.MABAN
      $whereClause
      ORDER BY MAHD DESC
    ''', whereArgs);

    return result.map((row) => Order.fromMap(row)).toList();
  }


  Future<Order?> fetchOrderById(int id) async {
    try {
      final Map<String, dynamic>? result = await DatabaseHelper.getById(_tableName, id, idColumn: _idColumn);
      if (result != null) {
        return Order.fromMap(result);
      }
      return null;
    } catch (e) {
      print('Lỗi khi lấy chi tiết đơn hàng: $e');
      return null;
    }
  }

  Future<int> addOrder(Order order) async {
    try {
      final int result = await DatabaseHelper.insert(_tableName, order.toMap());
      return result;
    } catch (e) {
      print('Lỗi khi thêm đơn hàng: $e');
      return -1;
    }
  }

  Future<int> updateOrder(Order order) async {
    try {
      final int result = await DatabaseHelper.update(_tableName, order.mahd!, order.toMap(), idColumn: _idColumn);
      return result;
    } catch (e) {
      print('Lỗi khi cập nhật đơn hàng: $e');
      return -1;
    }
  }

  Future<int> deleteOrder(int id) async {
    try {
      final int result = await DatabaseHelper.delete(_tableName, id, idColumn: _idColumn);
      return result;
    } catch (e) {
      print('Lỗi khi xóa đơn hàng: $e');
      return -1;
    }
  }

  Future<List<Map<String, dynamic>>> rawQuery(String sql) async {
    try {
      final List<Map<String, dynamic>> result = await DatabaseHelper.rawQuery(sql);
      return result;
    } catch (e) {
      print('Lỗi rawQuery: $e');
      return [];
    }
  }
}
