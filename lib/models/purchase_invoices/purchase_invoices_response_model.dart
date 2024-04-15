class ExpensePi {
  int? expenseIdip;
  int? projectId;
  String? description;
  double? rate; // Changed to double
  double? amount; // Changed to double
  double? dollarAmount; // Changed to double
  double? total; // Changed to double
  String? username;
  String? date;

  ExpensePi({
    this.expenseIdip,
    this.projectId,
    this.description,
    this.rate,
    this.amount,
    this.dollarAmount,
    this.username,
    this.total,
    this.date
  });

  factory ExpensePi.fromJson(Map<String, dynamic> json) {
    return ExpensePi(
      expenseIdip: json['receipt_id'] as int?, // Note: Key changed to 'receipt_id'
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

class TablePIResponseModel {
  List<ExpensePi> expensespi;

  TablePIResponseModel({required this.expensespi});

  factory TablePIResponseModel.fromJson(List<dynamic> parsedJson) {
    List<ExpensePi> expensespi = parsedJson.map((i) => ExpensePi.fromJson(i)).toList();
    return TablePIResponseModel(expensespi: expensespi);
  }
}
