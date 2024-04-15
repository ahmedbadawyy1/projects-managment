class DeleteAdminExResponse {
  String? message;
  String? error;

  DeleteAdminExResponse({this.message, this.error});

  factory DeleteAdminExResponse.fromJson(Map<String, dynamic> json) {
    return DeleteAdminExResponse(
      message: json['message'],
      error: json['error'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.message != null) {
      data['message'] = this.message;
    }
    if (this.error != null) {
      data['error'] = this.error;
    }
    return data;
  }
}
