class AddAdminEXRequest {
  String? description;
  String? rate;
  String? amount;
  String? dollarAmount;
  String? username;
  String? date;

  AddAdminEXRequest(
      {this.description,
        this.rate,
        this.amount,
        this.dollarAmount,
        this.username,
        this.date
      });

  AddAdminEXRequest.fromJson(Map<String, dynamic> json) {
    description = json['description'];
    rate = json['rate'] is num ? json['rate'].toDouble() : null;
    amount =  json['amount'] is num ? json['amount'].toDouble() : null;
    dollarAmount =  json['dollar_amount'] is num ? json['dollar_amount'].toDouble() : null;
    username = json['username'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['description'] = this.description;
    data['rate'] = this.rate;
    data['amount'] = this.amount;
    data['dollar_amount'] = this.dollarAmount;
    data['username'] = this.username;
    data['date'] = this.date;
    return data;
  }
}







