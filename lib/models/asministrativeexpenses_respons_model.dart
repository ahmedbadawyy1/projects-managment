class Expense {
  int? expenseId;
  int? projectId;
  String? description;
  double? rate;
  double? amount;
  double? dollarAmount;
  double? total ;
  String? username;
  String? date;


  Expense({
    this.expenseId,
    this.projectId,
    this.description,
    this.rate,
    this.amount,
    this.dollarAmount,
    this.username,
    this.total,
    this.date
  });

  factory Expense.fromJson(Map<String, dynamic> json) {
    return Expense(
      expenseId: json['expense_id'] as int?,
      projectId: json['project_id'] as int?,
      description: json['description'] as String?,
      rate: (json['rate'] as num?)?.toDouble(),
      amount: (json['amount'] as num?)?.toDouble(),
      dollarAmount: (json['dollar_amount'] as num?)?.toDouble(),
      total: (json['total'] as num?)?.toDouble(),
      username: json['username'] as String?,
      date: json['date'] ,

    );
  }
}

class TableResponseModel {
  List<Expense> expenses;

  TableResponseModel({required this.expenses});

  factory TableResponseModel.fromJson(List<dynamic> parsedJson) {
    List<Expense> expenses = parsedJson.map((i) => Expense.fromJson(i)).toList();
    return TableResponseModel(expenses: expenses);
  }
}

