class DeleteReceiptOfBuyResponse {
  final String? message;
  final String? error;

  DeleteReceiptOfBuyResponse({this.message, this.error});

  factory DeleteReceiptOfBuyResponse.fromJson(Map<String, dynamic> json) {
    return DeleteReceiptOfBuyResponse(
      message: json['message'],
      error: json['error'],
    );
  }
}
