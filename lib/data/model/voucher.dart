class Voucher {
  int id;
  String name;
  String svg;
  Voucher({
    required this.id,
    required this.name,
    required this.svg
  });
}

List<Voucher> voucherGrid = [
  Voucher(
    id: 1,
    name: 'Thành viên',
    svg: "assets/vectors/class.svg",
  ),
  Voucher(
    id: 2,
    name: 'Thay đổi hạt',
    svg: "assets/vectors/gift.svg"
  ),
  Voucher(
    id: 3,
    name: 'Lịch sủ',
    svg: "assets/vectors/bean.svg"
  ),
  Voucher(
    id: 4,
    name: 'Quyền lợi của bạn',
    svg: "assets/vectors/money.svg"
  ),
];