class ProjectTotalsResponse {

  double? administrativeExpensesTotal;
  double? billOfSaleTotal;
  double? collectionsTotal;
  double? receiptOfBuyTotal;
  String? projectName;

  ProjectTotalsResponse({
    this.administrativeExpensesTotal,
    this.billOfSaleTotal,
    this.collectionsTotal,
    this.receiptOfBuyTotal,
    this.projectName,
  });

  ProjectTotalsResponse.fromJson(Map<String, dynamic> json) {
    administrativeExpensesTotal = json['administrativeExpensesTotal'] is num ? json['administrativeExpensesTotal'].toDouble() : null;
    billOfSaleTotal = json['billOfSaleTotal'] is num ? json['billOfSaleTotal'].toDouble() : null;
    collectionsTotal = json['collectionsTotal'] is num ? json['collectionsTotal'].toDouble() : null;
    receiptOfBuyTotal = json['receiptOfBuyTotal'] is num ? json['receiptOfBuyTotal'].toDouble() : null;
    projectName = json['projectName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['administrativeExpensesTotal'] = this.administrativeExpensesTotal;
    data['billOfSaleTotal'] = this.billOfSaleTotal;
    data['collectionsTotal'] = this.collectionsTotal;
    data['receiptOfBuyTotal'] = this.receiptOfBuyTotal;
    data['projectName'] = this.projectName;
    return data;
  }

}


