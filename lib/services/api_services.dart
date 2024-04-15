import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/add_adminex_request_model.dart';
import '../models/add_adminex_response_model.dart';
import '../models/all_projects_response_model.dart';
import '../models/asministrativeexpenses_respons_model.dart';
import '../models/collections/collections_response_model.dart';
import '../models/collections/delete_item_collections_model.dart';
import '../models/delete_item_response_mode.dart';
import '../models/delete_project_response_model.dart';
import '../models/login_request_model.dart';
import '../models/login_response_model.dart';
import '../models/post_project_request_model.dart';
import '../models/post_project_response_model.dart';
import '../models/project_totals_response_model.dart';
import '../models/purchase_invoices/delete_item_purchase_invoices_model.dart';
import '../models/purchase_invoices/purchase_invoices_response_model.dart';
import '../models/sales_invoices/delete_item_sales_invoices_model.dart';
import '../models/sales_invoices/sales_invoices_response_model.dart';


final String api = "192.168.1.3";

class ApiServices {

  Future<LoginResponseModel?> loginUser(LoginRequestModel requestModel) async {
    final url = Uri.parse('http://${api}:3000/login');

    try {
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(requestModel.toJson()),
      );

      if (response.statusCode == 200) {
        return LoginResponseModel.fromJson(json.decode(response.body));
      } else {
        print("Error with response: ${response.body}");
        return null;
      }
    } catch (e) {
      print("Error: $e");
      return null;
    }
  }
  Future<ProjectsResponseModel?> getProjects() async {
    final url = Uri.parse('http://${api}:3000/allprojects');

    try {
      final response = await http.get(url, headers: <String, String>{
        'Content-Type': 'application/json',
      });

      if (response.statusCode == 200) {
        // Assuming the body is a list of projects
        return ProjectsResponseModel.fromJson(json.decode(response.body));
      } else {
        print("Error with response: ${response.body}");
        return null;
      }
    } catch (e) {
      print("Error: $e");
      return null;
    }
  }
  Future<AddProjectResponseModel?> addProject(AddProjectRequestModel requestModel) async {
    final url = Uri.parse('http://${api}:3000/addproject');

    try {
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(requestModel.toJson()),
      );

      if (response.statusCode == 200) {
        return AddProjectResponseModel.fromJson(json.decode(response.body));
      } else {
        print("Error with response: ${response.body}");
        return null;
      }
    } catch (e) {
      print("Error: $e");
      return null;
    }
  }
  Future<ProjectTotalsResponse?> getProjectTotals(int projectId) async {
    final url = Uri.parse('http://${api}:3000/api/totals/$projectId');

    try {
      final response = await http.get(url, headers: <String, String>{
        'Content-Type': 'application/json',
      });

      if (response.statusCode == 200) {
        return ProjectTotalsResponse.fromJson(json.decode(response.body));
      } else {
        print("Error with response: ${response.body}");
        return null;
      }
    } catch (e) {
      print("Error: $e");
      return null;
    }
  }
  Future<DeleteProjectResponse?> deleteProject(int projectId) async {
    final url = Uri.parse('http://$api:3000/deleteproject/$projectId');

    try {
      final response = await http.delete(url);

      if (response.statusCode == 200 || response.statusCode == 404) {
        // Either successfully deleted or not found are considered valid responses (for parsing)
        return DeleteProjectResponse.fromJson(json.decode(response.body));
      } else {
        // Handle unexpected status code by logging or throwing
        print("Unexpected status code: ${response.statusCode}");
        print("Error response body: ${response.body}");
        return null;  // You may choose to throw an exception or return a custom error message
      }
    } catch (e) {
      print("Error when attempting to delete receipt of buy: $e");
      return null;  // Handle exception by logging or UI feedback
    }
  }

  Future<TableResponseModel?> getAdministrativeexpenses(int projectId) async {
    final url = Uri.parse('http://${api}:3000/administrative_expenses/$projectId');

    try {
      final response = await http.get(url, headers: <String, String>{
        'Content-Type': 'application/json',
      });

      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = json.decode(response.body);
        return TableResponseModel.fromJson(jsonResponse);
      } else {
        print("Error with response: ${response.body}");
        return null;
      }
    } catch (e) {
      print("Error: $e");
      return null;
    }
  }
  Future<AddAdminEXResponse?> addAdministrativeExpense(AddAdminEXRequest requestModel, int projectId) async {
    final url = Uri.parse('http://${api}:3000/administrative_expenses/$projectId');

    try {
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(requestModel.toJson()),
      );

      if (response.statusCode == 200) {
        return AddAdminEXResponse.fromJson(json.decode(response.body));
      } else {
        print("Error with response: ${response.body}");
        return null;
      }
    } catch (e) {
      print("Error: $e");
      return null;
    }
  }

  Future<DeleteAdminExResponse?> deleteAdministrativeExpense(int expenseId) async {
    final url = Uri.parse('http://${api}:3000/delete_administrative_expenses/$expenseId');

    try {
      final response = await http.delete(url);

      if (response.statusCode == 200) {
        return DeleteAdminExResponse.fromJson(json.decode(response.body));
      } else {
        // Error handling based on your API structure
        print("Error: ${response.body}");
        return DeleteAdminExResponse.fromJson(json.decode(response.body));
      }
    } catch (e) {
      print("Error: $e");
      return null; // Or handle the error appropriately
    }
  }


  Future<TablePIResponseModel?> getPurchaseInvoices(int projectId) async {
    final url = Uri.parse('http://${api}:3000/receipt_of_buy/$projectId');

    try {
      final response = await http.get(url, headers: <String, String>{
        'Content-Type': 'application/json',
      });

      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = json.decode(response.body);
        return TablePIResponseModel.fromJson(jsonResponse);
      } else {
        print("Error with response: ${response.body}");
        return null;
      }
    } catch (e) {
      print("Error: $e");
      return null;
    }
  }
  Future<AddAdminEXResponse?> addPurchaseInvoices(AddAdminEXRequest requestModel, int projectId) async {
    final url = Uri.parse(
        'http://${api}:3000/receipt_of_buy/$projectId');

    try {
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(requestModel.toJson()),
      );

      if (response.statusCode == 200) {
        return AddAdminEXResponse.fromJson(json.decode(response.body));
      } else {
        print("Error with response: ${response.body}");
        return null;
      }
    } catch (e) {
      print("Error: $e");
      return null;
    }
  }
  Future<DeleteReceiptOfBuyResponse?> deleteReceiptOfBuy(int receiptId) async {
    final url = Uri.parse('http://$api:3000/delete_receipt_of_buy/$receiptId');

    try {
      final response = await http.delete(url);

      if (response.statusCode == 200 || response.statusCode == 404) {
        // Either successfully deleted or not found are considered valid responses (for parsing)
        return DeleteReceiptOfBuyResponse.fromJson(json.decode(response.body));
      } else {
        // Handle unexpected status code by logging or throwing
        print("Unexpected status code: ${response.statusCode}");
        print("Error response body: ${response.body}");
        return null;  // You may choose to throw an exception or return a custom error message
      }
    } catch (e) {
      print("Error when attempting to delete receipt of buy: $e");
      return null;  // Handle exception by logging or UI feedback
    }
  }


  Future<TableSIResponseModel?> getSalesInvoices(int projectId) async {
    final url = Uri.parse('http://${api}:3000/bill_of_sale/$projectId');

    try {
      final response = await http.get(url, headers: <String, String>{
        'Content-Type': 'application/json',
      });

      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = json.decode(response.body);
        return TableSIResponseModel.fromJson(jsonResponse);
      } else {
        print("Error with response: ${response.body}");
        return null;
      }
    } catch (e) {
      print("Error: $e");
      return null;
    }
  }
  Future<AddAdminEXResponse?> addSalesInvoices(AddAdminEXRequest requestModel, int projectId) async {
    final url = Uri.parse(
        'http://${api}:3000/bill_of_sale/$projectId');

    try {
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(requestModel.toJson()),
      );

      if (response.statusCode == 200) {
        return AddAdminEXResponse.fromJson(json.decode(response.body));
      } else {
        print("Error with response: ${response.body}");
        return null;
      }
    } catch (e) {
      print("Error: $e");
      return null;
    }
  }
  Future<DeleteBillOfSaleResponse ?> deleteBillOfSales(int billId) async {
    final url = Uri.parse('http://$api:3000/delete_bill_of_sale/$billId');

    try {
      final response = await http.delete(url);

      if (response.statusCode == 200 || response.statusCode == 404) {
        // Either successfully deleted or not found are considered valid responses (for parsing)
        return DeleteBillOfSaleResponse.fromJson(json.decode(response.body));
      } else {
        // Handle unexpected status code by logging or throwing
        print("Unexpected status code: ${response.statusCode}");
        print("Error response body: ${response.body}");
        return null;  // You may choose to throw an exception or return a custom error message
      }
    } catch (e) {
      print("Error when attempting to delete receipt of buy: $e");
      return null;  // Handle exception by logging or UI feedback
    }
  }

  Future<TableCOResponseModel?> getCollections(int projectId) async {
    final url = Uri.parse('http://${api}:3000/collections/$projectId');

    try {
      final response = await http.get(url, headers: <String, String>{
        'Content-Type': 'application/json',
      });

      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = json.decode(response.body);
        return TableCOResponseModel.fromJson(jsonResponse);
      } else {
        print("Error with response: ${response.body}");
        return null;
      }
    } catch (e) {
      print("Error: $e");
      return null;
    }
  }
  Future<AddAdminEXResponse?> addCollections(AddAdminEXRequest requestModel, int projectId) async {
    final url = Uri.parse(
        'http://${api}:3000/collections/$projectId');

    try {
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(requestModel.toJson()),
      );

      if (response.statusCode == 200) {
        return AddAdminEXResponse.fromJson(json.decode(response.body));
      } else {
        print("Error with response: ${response.body}");
        return null;
      }
    } catch (e) {
      print("Error: $e");
      return null;
    }
  }
  Future<DeleteCollectionsResponse?> deleteCollections(int billId) async {
    final url = Uri.parse('http://$api:3000/delete_collections/$billId');

    try {
      final response = await http.delete(url);

      if (response.statusCode == 200 || response.statusCode == 404) {
        // Either successfully deleted or not found are considered valid responses (for parsing)
        return DeleteCollectionsResponse.fromJson(json.decode(response.body));
      } else {
        // Handle unexpected status code by logging or throwing
        print("Unexpected status code: ${response.statusCode}");
        print("Error response body: ${response.body}");
        return null;  // You may choose to throw an exception or return a custom error message
      }
    } catch (e) {
      print("Error when attempting to delete receipt of buy: $e");
      return null;  // Handle exception by logging or UI feedback
    }
  }


}
