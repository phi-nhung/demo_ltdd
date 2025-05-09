class NhanVien {
  String manhanvien;
  String tennhanvien;
  String email;
  String sdt;
  String chucvu;

  NhanVien({required this.manhanvien, required this.tennhanvien, required this.email, required this.sdt, required this.chucvu
  });

  // Chuyển đổi NhanVien thành Map để lưu vào database
  Map<String, dynamic> toMap() {
    return {
      'manhanvien': manhanvien,
      'tennhanvien': tennhanvien,
      'email': email,
      'sdt': sdt,
      'chucvu': chucvu,
    };
  }

  // Tạo NhanVien từ Map lấy từ database
  factory NhanVien.fromMap(Map<String, dynamic> map) {
    return NhanVien(
      manhanvien: map['manhanvien'],
      tennhanvien: map['tennhanvien'],
      email: map['email'],
      sdt: map['sdt'],
      chucvu: map['chucvu'],
    );
  }
}
