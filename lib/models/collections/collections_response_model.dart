class ExpenseCo {
  int? expenseIdco;
  int? projectId;
  String? description;
  double? rate; // Changed to double
  double? amount; // Changed to double
  double? dollarAmount; // Changed to double
  double? total; // Changed to double
  String? username;
  String? date;

  ExpenseCo({
    this.expenseIdco,
    this.projectId,
    this.description,
    this.rate,
    this.amount,
    this.dollarAmount,
    this.username,
    this.total,
    this.date,
  });

  factory ExpenseCo.fromJson(Map<String, dynamic> json) {
    return ExpenseCo(
      expenseIdco: json['collection_id'] as int?, // Note: Key changed to 'receipt_id'
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

class TableCOResponseModel {
  List<ExpenseCo> expensesco;

  TableCOResponseModel({required this.expensesco});

  factory TableCOResponseModel.fromJson(List<dynamic> parsedJson) {
    List<ExpenseCo> expensesco = parsedJson.map((i) => ExpenseCo.fromJson(i)).toList();
    return TableCOResponseModel(expensesco: expensesco);
  }
}
