class ProjectsResponseModel {
  List<Project>? projects;

  ProjectsResponseModel({this.projects});

  factory ProjectsResponseModel.fromJson(List<dynamic> jsonList) {
    List<Project> projects = jsonList.map((json) => Project.fromJson(json)).toList();
    return ProjectsResponseModel(projects: projects);
  }

  List<Map<String, dynamic>> toJson() {
    return projects != null ? projects!.map((project) => project.toJson()).toList() : [];
  }
}

class Project {
  int? projectId;
  String? projectName;
  String? location;
  String? date;

  Project({this.projectId, this.projectName, this.location, this.date});

  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      projectId: json['project_id'],
      projectName: json['project_name'],
      location: json['location'],
      date: json['date'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['project_id'] = this.projectId;
    data['project_name'] = this.projectName;
    data['location'] = this.location;
    data['date'] = this.date;
    return data;
  }
}


