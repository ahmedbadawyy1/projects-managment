class DeleteBillOfSaleResponse {
  final String? message;
  final String? error;

  DeleteBillOfSaleResponse({this.message, this.error});

  factory DeleteBillOfSaleResponse.fromJson(Map<String, dynamic> json) {
    return DeleteBillOfSaleResponse(
      message: json['message'],
      error: json['error'],
    );
  }
}
