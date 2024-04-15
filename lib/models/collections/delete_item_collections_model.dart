class DeleteCollectionsResponse {
  final String? message;
  final String? error;

  DeleteCollectionsResponse({this.message, this.error});

  factory DeleteCollectionsResponse.fromJson(Map<String, dynamic> json) {
    return DeleteCollectionsResponse(
      message: json['message'],
      error: json['error'],
    );
  }
}
