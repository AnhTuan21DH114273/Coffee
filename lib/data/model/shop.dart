class Shop {
  int id;
  String name;
  String address;
  Shop({
    required this.id,
    required this.name,
    required this.address,
  });
}

List<Shop> shopList = [
  Shop(
    id: 1,
    name: 'HCM Cao Thắng',
    address: '40 Cao Thắng, Quận 3, Hồ Chí Minh, Việt Nam',
  ),
  Shop(
    id: 2,
    name: 'HCM Võ Văn Tần',
    address: '223 Võ Văn Tần, Phường 5, Quận 3, Hồ Chí Minh',
  ),
  Shop(
    id: 3,
    name: 'HCM Sư Vạn Hạnh',
    address: '828 Đ. Sư Vạn Hạnh, Phường 12, Quận 10, Hồ Chí Minh',
  ),
  Shop(
    id: 4,
    name: 'HCM Ngô Thời Nhiệm',
    address: '49 Ngô Thời Nhiệm, Phường 6, Quận 3, Hồ Chí Minh',
  ),
  Shop(
    id: 5,
    name: 'HCM Trần Hưng Đạo',
    address: '603 Đ. Trần Hưng Đạo, Cầu Kho, Quận 1, Hồ Chí Minh',
  ),
  Shop(
    id: 6,
    name: 'HCM Ba Tháng Hai',
    address: '27A Đ. 3 Tháng 2, Phường 11, Quận 10, Hồ Chí Minh',
  ),
];