
class AddAdminEXResponse {
  final String? message;
  final int? projectId;
  final String? description;
  final double? rate;
  final double? amount;
  final double? dollarAmount;
  final String? username;
  final String? date;

  AddAdminEXResponse({
    this.message,
    this.projectId,
    this.description,
    this.rate,
    this.amount,
    this.dollarAmount,
    this.username,
    this.date
  });

  factory AddAdminEXResponse.fromJson(Map<String, dynamic> json) {
    return AddAdminEXResponse(
      message: json['message'],
      projectId: json['project_id'] is num ? json['project_id'].toInt() : null,
      description: json['description'],
      rate: json['rate'] is num ? json['rate'].toDouble() : null,
      amount: json['amount'] is num ? json['amount'].toDouble() : null,
      dollarAmount: json['dollar_amount'] is num ? json['dollar_amount'].toDouble() : null,
      username: json['username'],
      date: json['date'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'project_id': projectId,
      'description': description,
      'rate': rate,
      'amount': amount,
      'dollar_amount': dollarAmount,
      'username': username,
      'date': date,
    };
  }
}



