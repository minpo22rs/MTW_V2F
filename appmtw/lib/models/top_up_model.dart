class TopUp {
  int id;
  String payment;
  String name;
  int amount;
  int refno;
  String topup;
  String type;

  TopUp({
    required this.id,
    required this.payment,
    required this.name,
    required this.amount,
    required this.refno,
    required this.topup,
    required this.type,
  });

  factory TopUp.fromJson(Map<String, dynamic> json) {
    return TopUp(
      id: json['id'],
      payment: json['payment'],
      name: json['detail'],
      amount: json['price'],
      refno: json['refno'] ?? 0,
      topup: json['status'],
      type: json['type'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['payment'] = this.payment;
    data['detail'] = this.name;
    data['price'] = this.amount;
    data['refno'] = this.refno;
    data['status'] = this.topup;
    data['type'] = this.type;
    return data;
  }
}

// List<TopUp> topups = [
//   TopUp(payment: 'Payment', name: 'ชื่อรายการ', amount: 190, topup: false),
//   TopUp(payment: 'Payment', name: 'ชื่อรายการ', amount: 290, topup: false),
//   TopUp(payment: 'Payment', name: 'ชื่อรายการ', amount: 390, topup: false),
//   TopUp(payment: 'Payment', name: 'ชื่อรายการ', amount: 490, topup: true),
//   TopUp(payment: 'Payment', name: 'ชื่อรายการ', amount: 590, topup: false),
//   TopUp(payment: 'Payment', name: 'ชื่อรายการ', amount: 690, topup: false),
//   TopUp(payment: 'Payment', name: 'ชื่อรายการ', amount: 790, topup: true),
//   TopUp(payment: 'Payment', name: 'ชื่อรายการ', amount: 890, topup: true),
//   TopUp(payment: 'Payment', name: 'ชื่อรายการ', amount: 990, topup: true),
//   TopUp(payment: 'Payment', name: 'ชื่อรายการ', amount: 1090, topup: true),
// ];
