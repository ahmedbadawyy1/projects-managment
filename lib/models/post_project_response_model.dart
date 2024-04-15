class AddProjectResponseModel {
  String message;
  String? project_name;
  String? location;
  String? date;

  AddProjectResponseModel({
    required this.message,
    this.project_name,
    this.location,
    this.date,
  });

  factory AddProjectResponseModel.fromJson(Map<String, dynamic> json) {
    return AddProjectResponseModel(
      message: json['message'],
      project_name: json['project_name'],
      location: json['location'],
      date: json['date'],
    );
  }
}
