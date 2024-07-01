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
    name: 'Class Membership',
    svg: "assets/vectors/class.svg",
  ),
  Voucher(
    id: 2,
    name: 'Bean Exchange',
    svg: "assets/vectors/gift.svg"
  ),
  Voucher(
    id: 3,
    name: 'Bean History',
    svg: "assets/vectors/bean.svg"
  ),
  Voucher(
    id: 4,
    name: 'Your Rights',
    svg: "assets/vectors/money.svg"
  ),
];