class DeleteProjectResponse {
  final String? message;
  final String? error;

  DeleteProjectResponse({this.message, this.error});

  factory DeleteProjectResponse.fromJson(Map<String, dynamic> json) {
    return DeleteProjectResponse(
      message: json['message'],
      error: json['error'],
    );
  }
}
