import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:manageprojects/models/delete_project_response_model.dart';
import '../models/all_projects_response_model.dart';
import '../models/post_project_request_model.dart';
import '../models/post_project_response_model.dart';
import '../services/api_services.dart';
import '../widgets/text_field.dart';
import 'package:flutter/cupertino.dart';

class ProjectsPage extends StatefulWidget {
  const ProjectsPage({Key? key}) : super(key: key);

  @override
  State<ProjectsPage> createState() => _ProjectsPageState();
}

class _ProjectsPageState extends State<ProjectsPage> {
  bool isDesktop(BuildContext context) =>
      MediaQuery.of(context) . size. width >= 600;

  bool isMobile(BuildContext context) =>
      MediaQuery.of(context) . size. width < 600;

  ProjectsResponseModel? projectsResponse;
  bool isLoading = true;
  List<Project>? filteredProjects;

  TextEditingController searchController = TextEditingController();
  TextEditingController projectNameController = TextEditingController();
  TextEditingController projectLocationController = TextEditingController();
  TextEditingController projectDateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadProjects();
  }

  _loadProjects() async {
    var apiServices = ApiServices();
    var loadedProjects = await apiServices.getProjects();
    if (loadedProjects != null) {
      setState(() {
        projectsResponse = loadedProjects;
        filteredProjects = loadedProjects.projects;
        isLoading = false;
      });
    }
  }
  void _filterProjects(String query) {
    // Always set filteredProjects from the full list initially.
    List<Project>? baseProjects = projectsResponse?.projects;

    // If the search query is not empty, filter the projects.
    if (query.isNotEmpty) {
      setState(() {
        filteredProjects = baseProjects?.where((project) {
          // Convert both strings to lowercase to make the search case-insensitive.
          String searchLower = query.toLowerCase();
          String projectNameLower = project.projectName?.toLowerCase() ?? "";
          String projectLocationLower = project.location?.toLowerCase() ?? "";

          // Return true if either name or location matches the query, false otherwise.
          return projectNameLower.contains(searchLower) || projectLocationLower.contains(searchLower);
        }).toList();
      });
    } else {
      // If the query is empty, show all projects.
      setState(() {
        filteredProjects = baseProjects;
      });
    }
  }


  @override
  void dispose() {
    searchController.dispose();
    projectNameController.dispose();
    projectLocationController.dispose();
    projectDateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: BackButton(color: Colors.red),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : isMobile(context) ? Column(
        children: [
          Expanded(
            flex: 0,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                   Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextField(
                                controller: searchController,
                                decoration: textInputDecoration.copyWith(
                                  labelText: "Search by Project name or location",
                                  prefixIcon: Icon(Icons.search, color: Colors.red),
                                ),
                                onChanged: (value) => _filterProjects(value),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 50,
                              width: 150,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.lightGreen,
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.add,
                                      color: Colors.white,
                                    ),
                                    Text(
                                      "Add",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                onPressed: () {
                                  // Define controllers to capture input text
                                  TextEditingController projectNameController = TextEditingController();
                                  TextEditingController projectLocationController = TextEditingController();
                                  TextEditingController projectDateController = TextEditingController();

                                  showModalBottomSheet(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return StatefulBuilder(  // Allows the modal to have its own mutable state
                                        builder: (BuildContext context, StateSetter setModalState) {
                                          return Container(
                                            padding: EdgeInsets.all(10),
                                            height: 500,  // Adjust height as necessary
                                            child: Padding(
                                              padding: const EdgeInsets.all(16.0),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: <Widget>[
                                                  Text(
                                                    "Add New Project",
                                                    style: TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 24,
                                                    ),
                                                  ),
                                                  SizedBox(height: 15),
                                                  Row(
                                                    children: <Widget>[
                                                      Expanded(
                                                        child: TextFormField(
                                                          controller: projectNameController,
                                                          keyboardType: TextInputType.name,
                                                          decoration: textInputDecoration.copyWith(
                                                            labelText: "Project Name",
                                                            prefixIcon: Icon(Icons.drive_file_rename_outline, color: Colors.red),
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(width: 10),
                                                      Expanded(
                                                        child: TextFormField(
                                                          controller: projectLocationController,
                                                          keyboardType: TextInputType.name,
                                                          decoration: textInputDecoration.copyWith(
                                                            labelText: "Project Place",
                                                            prefixIcon: Icon(Icons.place_outlined, color: Colors.red),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(height: 15),
                                                  GestureDetector(
                                                    onTap: () async {
                                                      final DateTime? pickedDate = await showDatePicker(
                                                          context: context,
                                                          initialDate: DateTime.now(),
                                                          firstDate: DateTime(2000),
                                                          lastDate: DateTime(2101));
                                                      if (pickedDate != null) {
                                                        setModalState(() {
                                                          projectDateController.text = "${pickedDate.toLocal()}".split(' ')[0];
                                                        });
                                                      }
                                                    },
                                                    child: AbsorbPointer(
                                                      child: TextFormField(
                                                        controller: projectDateController,
                                                        decoration: textInputDecoration.copyWith(
                                                            labelText: 'Select Date',
                                                            prefixIcon: Icon(
                                                              Icons.date_range_outlined,
                                                              color: Colors.red,
                                                            )),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(height: 20),
                                                  SizedBox(
                                                    height: 50,
                                                    width: 250,
                                                    child: ElevatedButton(
                                                      style: ElevatedButton.styleFrom(
                                                        backgroundColor: Colors.lightGreen,
                                                        elevation: 0,
                                                        shape: RoundedRectangleBorder(
                                                          borderRadius: BorderRadius.circular(10),
                                                        ),
                                                      ),
                                                      child: Text(
                                                        "Ok Add Project",
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 16,
                                                          fontWeight: FontWeight.bold,
                                                        ),
                                                      ),
                                                      onPressed: () async {
                                                        if (projectNameController.text.isEmpty ||
                                                            projectLocationController.text.isEmpty ||
                                                            projectDateController.text.isEmpty) {
                                                          ScaffoldMessenger.of(context).showSnackBar(
                                                            SnackBar(
                                                              content: Text('Please fill all the fields'),
                                                              duration: Duration(seconds: 2),
                                                            ),
                                                          );
                                                        } else {
                                                          AddProjectRequestModel requestModel = AddProjectRequestModel(
                                                            project_name: projectNameController.text,
                                                            location: projectLocationController.text,
                                                            date: projectDateController.text,
                                                          );

                                                          ApiServices apiServices = ApiServices();
                                                          AddProjectResponseModel? response = await apiServices.addProject(requestModel);

                                                          if (response != null && Navigator.canPop(context)) {
                                                            Navigator.pop(context);  // Close the modal on success
                                                            _loadProjects();
                                                            // Show a success message
                                                            ScaffoldMessenger.of(context).showSnackBar(
                                                              SnackBar(
                                                                content: Text('Project added successfully'),
                                                                duration: Duration(seconds: 2),
                                                              ),
                                                            );
                                                          }
                                                        }
                                                      },
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    },
                                  );
                                },
                              ),
                            ),
                          ],
                        ),),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Divider(color: Colors.black, thickness: 1, height: 1),
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: ListView.builder(
                itemCount: filteredProjects?.length ?? 0,
                itemBuilder: (context, index) {
                  var project = filteredProjects![index];
                  return InkWell(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        '/project_details',
                        arguments: project.projectId,
                      );
                    },
                    child: Card(
                      color: Colors.grey,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      elevation: 5,
                      child: Padding(
                        padding: EdgeInsets.all(15.0),
                        child: ListTile(
                          leading: Icon(Icons.task_outlined, color: Colors.red),
                          title: Text(project.projectName ?? "N/A", style: TextStyle(color: Colors.black)),
                          subtitle: Text("Date: ${formatUtcToLocalDateString(project.date)}", style: TextStyle(color: Colors.black)),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text("Location: ${project.location}", style: TextStyle(color: Colors.black)),
                              IconButton(
                                  icon: Icon(Icons.delete, color: Colors.red),
                                  onPressed: () => _confirmDeleteProject(context, project.projectId!)
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ) : Row(
        children: [
          Expanded(
            child: Column(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Center(
                        child: SizedBox(
                          width: 350,
                          height: 155,
                          child: Image.asset(
                            "images/logo.jpg",
                          ),
                        ),
                      ),
                    ],
                  ),),
                Divider(
                  color: Colors.black,
                  thickness: 1,
                  height: 1,
                ),
                Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          controller: searchController,
                          decoration: textInputDecoration.copyWith(
                            labelText: "Search by Project name or location",
                            prefixIcon: Icon(Icons.search, color: Colors.red),
                          ),
                          onChanged: (value) => _filterProjects(value),
                        ),
                      ),
                      Divider(
                        color: Colors.black,
                        thickness: 1,
                        height: 1,
                      ),
                      Expanded(
                        flex: 2,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 50,
                              width: 150,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.lightGreen,
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.add,
                                      color: Colors.white,
                                    ),
                                    Text(
                                      "Add",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                onPressed: () {
                                  // Define controllers to capture input text
                                  TextEditingController projectNameController = TextEditingController();
                                  TextEditingController projectLocationController = TextEditingController();
                                  TextEditingController projectDateController = TextEditingController();

                                  showModalBottomSheet(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return StatefulBuilder(  // Allows the modal to have its own mutable state
                                        builder: (BuildContext context, StateSetter setModalState) {
                                          return Container(
                                            padding: EdgeInsets.all(10),
                                            height: 500,  // Adjust height as necessary
                                            child: Padding(
                                              padding: const EdgeInsets.all(16.0),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: <Widget>[
                                                  Text(
                                                    "Add New Project",
                                                    style: TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 24,
                                                    ),
                                                  ),
                                                  SizedBox(height: 15),
                                                  Row(
                                                    children: <Widget>[
                                                      Expanded(
                                                        child: TextFormField(
                                                          controller: projectNameController,
                                                          keyboardType: TextInputType.name,
                                                          decoration: textInputDecoration.copyWith(
                                                            labelText: "Project Name",
                                                            prefixIcon: Icon(Icons.drive_file_rename_outline, color: Colors.red),
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(width: 10),
                                                      Expanded(
                                                        child: TextFormField(
                                                          controller: projectLocationController,
                                                          keyboardType: TextInputType.name,
                                                          decoration: textInputDecoration.copyWith(
                                                            labelText: "Project Place",
                                                            prefixIcon: Icon(Icons.place_outlined, color: Colors.red),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(height: 15),
                                                  GestureDetector(
                                                    onTap: () async {
                                                      final DateTime? pickedDate = await showDatePicker(
                                                          context: context,
                                                          initialDate: DateTime.now(),
                                                          firstDate: DateTime(2000),
                                                          lastDate: DateTime(2101));
                                                      if (pickedDate != null) {
                                                        setModalState(() {
                                                          projectDateController.text = "${pickedDate.toLocal()}".split(' ')[0];
                                                        });
                                                      }
                                                    },
                                                    child: AbsorbPointer(
                                                      child: TextFormField(
                                                        controller: projectDateController,
                                                        decoration: textInputDecoration.copyWith(
                                                            labelText: 'Select Date',
                                                            prefixIcon: Icon(
                                                              Icons.date_range_outlined,
                                                              color: Colors.red,
                                                            )),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(height: 20),
                                                  SizedBox(
                                                    height: 50,
                                                    width: 250,
                                                    child: ElevatedButton(
                                                      style: ElevatedButton.styleFrom(
                                                        backgroundColor: Colors.lightGreen,
                                                        elevation: 0,
                                                        shape: RoundedRectangleBorder(
                                                          borderRadius: BorderRadius.circular(10),
                                                        ),
                                                      ),
                                                      child: Text(
                                                        "Ok Add Project",
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 16,
                                                          fontWeight: FontWeight.bold,
                                                        ),
                                                      ),
                                                      onPressed: () async {
                                                        if (projectNameController.text.isEmpty ||
                                                            projectLocationController.text.isEmpty ||
                                                            projectDateController.text.isEmpty) {
                                                          ScaffoldMessenger.of(context).showSnackBar(
                                                            SnackBar(
                                                              content: Text('Please fill all the fields'),
                                                              duration: Duration(seconds: 2),
                                                            ),
                                                          );
                                                        } else {
                                                          AddProjectRequestModel requestModel = AddProjectRequestModel(
                                                            project_name: projectNameController.text,
                                                            location: projectLocationController.text,
                                                            date: projectDateController.text,
                                                          );

                                                          ApiServices apiServices = ApiServices();
                                                          AddProjectResponseModel? response = await apiServices.addProject(requestModel);

                                                          if (response != null && Navigator.canPop(context)) {
                                                            Navigator.pop(context);  // Close the modal on success
                                                            _loadProjects();
                                                            // Show a success message
                                                            ScaffoldMessenger.of(context).showSnackBar(
                                                              SnackBar(
                                                                content: Text('Project added successfully'),
                                                                duration: Duration(seconds: 2),
                                                              ),
                                                            );
                                                          }
                                                        }
                                                      },
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    },
                                  );
                                },
                              ),
                            ),
                          ],
                        ),),
                    ],
                  ),
                ),
              ],
            ),
          ),

          VerticalDivider(color: Colors.black, thickness: 1, width: 1),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: ListView.builder(
                itemCount: filteredProjects?.length ?? 0,
                itemBuilder: (context, index) {
                  var project = filteredProjects![index];
                  return InkWell(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        '/project_details',
                        arguments: project.projectId,
                      );
                    },
                    child: Card(
                      color: Colors.grey,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      elevation: 5,
                      child: Padding(
                        padding: EdgeInsets.all(15.0),
                        child: ListTile(
                          leading: Icon(Icons.task_outlined, color: Colors.red),
                          title: Text(project.projectName ?? "N/A", style: TextStyle(color: Colors.black)),
                          subtitle: Text("Date: ${formatUtcToLocalDateString(project.date)}", style: TextStyle(color: Colors.black)),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text("Location: ${project.location}", style: TextStyle(color: Colors.black)),
                              IconButton(
                                  icon: Icon(Icons.delete, color: Colors.red),
                                  onPressed: () => _confirmDeleteProject(context, project.projectId!)
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
  void _confirmDeleteProject(BuildContext context, int projectId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Delete Project"),
          content: Text("Are you sure you want to delete this project?"),
          actions: <Widget>[
            TextButton(
              child: Text(
                  "Cancel",
              style: TextStyle(
                 color: Colors.lightGreen
              ),
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: Text(
                  "Delete",
                style: TextStyle(
                    color: Colors.red
                ),
              ),
              onPressed: () async {
                Navigator.of(context).pop(); // Close the dialog
                _deleteProject(projectId);
              },
            ),
          ],
        );
      },
    );
  }
  void _deleteProject(int projectId) async {
    var apiServices = ApiServices();
    try {
      DeleteProjectResponse? isDeleted = await apiServices.deleteProject(projectId);
      if (isDeleted != null && isDeleted.message != null) {
        _loadProjects(); // Refresh the projects list
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Project deleted successfully')),
        );
      } else if (isDeleted != null && isDeleted.error != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(isDeleted.error!)),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Unknown error occurred')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error deleting project: $e')),
      );
    }
  }
  String formatUtcToLocalDateString(String? utcDateString) {
    if (utcDateString == null || utcDateString.isEmpty) {
      return 'N/A'; // Return a default or error string if the input is null or empty.
    }
    // Parse the date string to a DateTime object assuming it's in UTC.
    DateTime utcDate = DateTime.parse(utcDateString).toUtc();
    // Convert the UTC DateTime object to the local time zone.
    DateTime localDate = utcDate.toLocal();
    // Format the local DateTime object to a string for display. Adjust the pattern as needed.
    return DateFormat('yyyy-MM-dd').format(localDate); // Use 'import 'package:intl/intl.dart';' for DateFormat.
  }
}