import 'package:flutter/material.dart';
import 'package:manageprojects/pages/administrativeexpenses_page.dart';
import 'package:manageprojects/pages/collections_page.dart';
import 'package:manageprojects/pages/home_page.dart';
import 'package:manageprojects/pages/login_page.dart';
import 'package:manageprojects/pages/project_details.dart';
import 'package:manageprojects/pages/projects_page.dart';
import 'package:manageprojects/pages/purchaseinvoices_page.dart';
import 'package:manageprojects/pages/salesinvoices_page.dart';
import 'package:manageprojects/services/shared_services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedService.initialize();
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
      ),
      routes: {
        '/': (context) => LoginPage(),
        '/home_page' : (context) => HomePage(),
        '/projects_page' : (context) => ProjectsPage(),
        '/project_details': (context) {
          // Extracting projectId from the route arguments
          final projectId = ModalRoute.of(context)!.settings.arguments as int;  // Cast to the correct type as needed
          return ProjectDetails(projectId: projectId);
        },
        '/administrativeexpenses_page' : (context) {
          final projectId = ModalRoute.of(context)!.settings.arguments as int;  // Cast to the correct type as needed
          return AdministrativeExpenses(projectId: projectId);
        },
        '/purchaseinvoices_page' :  (context) {
          final projectId = ModalRoute.of(context)!.settings.arguments as int;  // Cast to the correct type as needed
          return PurchaseInvoices(projectId: projectId);
        },
        '/salesinvoices_page' : (context) {
          final projectId = ModalRoute
              .of(context)!
              .settings
              .arguments as int; // Cast to the correct type as needed
          return SalesInvoices(projectId: projectId);
        },
        '/collections_page' : (context) {
          final projectId = ModalRoute
              .of(context)!
              .settings
              .arguments as int; // Cast to the correct type as needed
          return Collections(projectId: projectId);
        },


      },
    );
  }
}

