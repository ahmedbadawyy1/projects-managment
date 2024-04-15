class AddProjectRequestModel {
  String project_name;
  String location;
  String date;

  AddProjectRequestModel({
    required this.project_name,
    required this.location,
    required this.date,
  });

  Map<String, dynamic> toJson() {
    return {
      'project_name': project_name,
      'location': location,
      'date': date,
    };
  }
}
