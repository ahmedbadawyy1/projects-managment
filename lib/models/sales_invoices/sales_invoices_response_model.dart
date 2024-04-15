class ExpenseSi {
  int? expenseIdsi;
  int? projectId;
  String? description;
  double? rate; // Changed to double
  double? amount; // Changed to double
  double? dollarAmount; // Changed to double
  double? total; // Changed to double
  String? username;
  String? date;


  ExpenseSi({
    this.expenseIdsi,
    this.projectId,
    this.description,
    this.rate,
    this.amount,
    this.dollarAmount,
    this.username,
    this.total,
    this.date,
  });

  factory ExpenseSi.fromJson(Map<String, dynamic> json) {
    return ExpenseSi(
      expenseIdsi: json['bill_id'] as int?, // Note: Key changed to 'receipt_id'
      projectId: json['project_id'] as int?,
      description: json['description'] as String?,
      rate: (json['rate'] as num?)?.toDouble(),
      amount: (json['amount'] as num?)?.toDouble(),
      dollarAmount: (json['dollar_amount'] as num?)?.toDouble(),
      total: (json['total'] as num?)?.toDouble(),
      username: json['username'] as String?,
      date: json['date'] as String?,
    );
  }
}

class TableSIResponseModel {
  List<ExpenseSi> expensessi;

  TableSIResponseModel({required this.expensessi});

  factory TableSIResponseModel.fromJson(List<dynamic> parsedJson) {
    List<ExpenseSi> expensessi = parsedJson.map((i) => ExpenseSi.fromJson(i)).toList();
    return TableSIResponseModel(expensessi: expensessi);
  }
}
