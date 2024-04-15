import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:manageprojects/models/add_adminex_request_model.dart';
import '../models/asministrativeexpenses_respons_model.dart';
import '../models/project_totals_response_model.dart';
import '../models/sales_invoices/sales_invoices_response_model.dart';
import '../services/api_services.dart';
import '../services/shared_services.dart';
import '../widgets/text_field.dart';

class SalesInvoices extends StatefulWidget {
  final int projectId;
  const SalesInvoices({Key? key, required this.projectId}) : super(key: key);

  @override
  State<SalesInvoices> createState() => _SalesInvoicesState();
}

class _SalesInvoicesState extends State<SalesInvoices> {

  bool isDesktop(BuildContext context) =>
      MediaQuery.of(context) . size. width >= 600;

  bool isMobile(BuildContext context) =>
      MediaQuery.of(context) . size. width < 600;

  List<ExpenseSi> expensessi = [];
  bool isLoading = true;
  final ApiServices _apiServices = ApiServices();
  ProjectTotalsResponse? projectTotals;
  final ScrollController _verticalScrollController = ScrollController();
  final ScrollController _horizontalScrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    getSalesInvoices();
    fetchProjectTotals();
  }

  Future<void> getSalesInvoices() async {
    var apiService = ApiServices();
    var response = await apiService.getSalesInvoices(widget.projectId);

    if (response != null && response.expensessi != null) {
      setState(() {
        expensessi = response.expensessi;
        isLoading = false;
      });
    }
  }
  fetchProjectTotals() async {
    var apiService = ApiServices();
    var totalsResponse = await apiService.getProjectTotals(widget.projectId);

    if (totalsResponse != null) {
      setState(() {
        projectTotals = totalsResponse;
      });
    }
  }

  void _showAddRowDialog() {
    String? username = SharedService.getUsername(); // Retrieve username from shared preferences

    final _descriptionController = TextEditingController();
    final _amountController = TextEditingController();
    final _dollarAmountController = TextEditingController();
    final _rateController = TextEditingController();
    final _dateController = TextEditingController();

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (context, setModalState) {
              return AlertDialog(
          title: const Text('Add New Sales Invoices'),
          content: Container(
            width: double.maxFinite,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _descriptionController,
                            decoration: textInputDecoration.copyWith(
                              labelText: 'Description',
                              prefixIcon: Icon(
                                  Icons.description, color: Colors.red
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _amountController,
                            decoration:textInputDecoration.copyWith(
                              labelText: 'Amount EGP',
                              prefixIcon: Icon(
                                  Icons.money, color: Colors.red
                              ),
                            ),
                            keyboardType: TextInputType.number,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(child: TextField(
                          controller: _dollarAmountController,
                          decoration:textInputDecoration.copyWith(
                            labelText: 'Amount USD',
                            prefixIcon: Icon(
                                Icons.monetization_on_outlined, color: Colors.red
                            ),
                          ),
                          keyboardType: TextInputType.number,
                        ),),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(child: TextField(
                          controller: _rateController,
                          decoration:textInputDecoration.copyWith(
                            labelText: 'Rate',
                            prefixIcon: Icon(
                                Icons.monetization_on_outlined, color: Colors.red
                            ),
                          ),
                          keyboardType: TextInputType.number,
                        ),),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () async {
                              final DateTime? pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2000),
                                  lastDate: DateTime(2101));
                              if (pickedDate != null) {
                                setModalState(() {
                                  _dateController.text = "${pickedDate.toLocal()}".split(' ')[0];
                                });
                              }
                            },
                            child: AbsorbPointer(
                              child: TextFormField(
                                controller: _dateController,
                                decoration: textInputDecoration.copyWith(
                                    labelText: 'Select Date',
                                    prefixIcon: Icon(
                                      Icons.date_range_outlined,
                                      color: Colors.red,
                                    )),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
          ),
          actions: <Widget>[
            SizedBox(
              width: 100,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.lightGreen,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text('Add'),
                onPressed: () async {
                  String rate = _rateController.text.isEmpty ? '0' : _rateController.text;
                  String amount = _amountController.text.isEmpty ? '0' : _amountController.text;
                  String dollarAmount = _dollarAmountController.text.isEmpty ? '0' : _dollarAmountController.text;
                  String date = _dateController.text.isEmpty ? '0' : _dateController.text;

                if (_descriptionController.text.isNotEmpty) {
                  AddAdminEXRequest newExpense = AddAdminEXRequest(
                      description: _descriptionController.text,
                      rate: rate,
                      amount: amount,
                      dollarAmount: dollarAmount,
                      username: username,
                      date: date // Use the retrieved username
                  );

                  var response = await _apiServices.addSalesInvoices(newExpense, widget.projectId);

                  if (response != null) {
                    // Assuming response contains the added expense details.
                    ExpenseSi addedExpenseSi = ExpenseSi.fromJson(response.toJson());
                    expensessi.add(addedExpenseSi);
                    setState(() {});
                    await getSalesInvoices() ;
                    await fetchProjectTotals();
                  }
                  Navigator.of(context).pop();
                } else {
                }
                }
              ),
            ),
          ],
              );
            },
          );
        },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: const BackButton(color: Colors.red),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : _buildContent(),
    );
  }
  Widget _buildContent() {
    return isMobile(context) ?
    Column(
      children: [
        Expanded(
          child: Row(
            children: [
              _buildTotalExpensesCard(),
              const VerticalDivider(color: Colors.grey, thickness: 1, width: 1),
              _buildAddNewExpenseSection(),
            ],
          ),
        ),
        const Divider(color: Colors.grey, thickness: 1, height: 1),
        Expanded(flex: 5, child: _buildExpensesSheet()),
      ],
    )
        : Row(
      children: [
        Expanded(
          child: Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Center(
                    child: SizedBox(
                      width: 350,
                      height: 155,
                      child: Image.asset("images/logo.jpg"),
                    ),
                  ),
                ),
              ),
              const Divider(color: Colors.black, thickness: 1, height: 1),
              _buildTotalExpensesCard(),
              const Divider(color: Colors.black, thickness: 1, height: 1),
              _buildAddNewExpenseSection(),
            ],
          ),
        ),
        const VerticalDivider(color: Colors.black, thickness: 1, width: 1),
        Expanded(flex: 3, child: _buildExpensesSheet()),
      ],
    );
  }

  Widget _buildTotalExpensesCard() {
    return isMobile(context) ? Padding(
      padding:  EdgeInsets.all(MediaQuery.of(context).size.width * 0.06),
      child: Card(
        color: Colors.grey.shade300,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 5,
        child: Padding(
          padding:  EdgeInsets.all(MediaQuery.of(context).size.width * 0.02),
          child: Column(
            children: [
              Text(
                "Sales Invoices Total ",
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                " ${projectTotals?.billOfSaleTotal ?? 'Loading...'} EGP",
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
              )
            ],
          ),
        ),
      ),
    ) : Padding(
      padding: const EdgeInsets.all(15.0),
      child: Card(
        color: Colors.grey.shade300,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text(
                "Sales Invoices Total ",
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                " ${projectTotals?.billOfSaleTotal ?? 'Loading...'} EGP",
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
              )
            ],
          ),
        ),
      ),
    );
  }
  Widget _buildAddNewExpenseSection() {
    return   isMobile(context) ? Expanded(
      flex: 2,
      child: Padding(
        padding:  EdgeInsets.all(MediaQuery.of(context).size.width * 0.01),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
             Text(
              "Add New Sales Invoices",
              style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.04, fontWeight: FontWeight.bold),
            ),
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
                  children: const [
                    Icon(Icons.add, color: Colors.white),
                    Text(
                      "Add",
                      style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                onPressed: () => _showAddRowDialog(),
              ),
            ),
          ],
        ),
      ),
    ) : Expanded(
      flex: 2,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Text(
              "Add New Sales Invoices",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
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
                  children: const [
                    Icon(Icons.add, color: Colors.white),
                    Text(
                      "Add",
                      style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                onPressed: () => _showAddRowDialog(),
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget _buildExpensesSheet() {
    return Padding(
      padding:  EdgeInsets.all(MediaQuery.of(context).size.width *0.03),
      child: Column(
        children: [
          const Text(
            "Sales Invoices Sheet",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 25),
          _buildExpensesTable(),
        ],
      ),
    );
  }
  Widget _buildExpensesTable() {
    // Sort the expenses list by date
    expensessi.sort((a, b) {
      // Check if dates are null and provide a fallback value if so
      var dateAString = a.date ?? "1900-01-01"; // Example fallback value
      var dateBString = b.date ?? "1900-01-01"; // Example fallback value

      // Convert 'DD-MM-YYYY' string to 'YYYY-MM-DD' for easy parsing, if needed
      // Assuming date format is 'YYYY-MM-DD' which is directly parsable
      // Adjust this if your format is different (e.g., 'DD-MM-YYYY')
      DateTime dateA = DateTime.parse(dateAString);
      DateTime dateB = DateTime.parse(dateBString);

      return dateA.compareTo(dateB);
    });
    return Expanded(
      child: Scrollbar(
        controller: _horizontalScrollController, // Assign horizontal ScrollController
        thumbVisibility: true,
        trackVisibility: true,
        child: SingleChildScrollView(
          controller: _horizontalScrollController, // Use the same controller here
          scrollDirection: Axis.horizontal,
          child: Scrollbar(
            controller: _verticalScrollController, // Assign vertical ScrollController
            thumbVisibility: true,
            trackVisibility: true,
            child: SingleChildScrollView(
              controller: _verticalScrollController, // Use the same controller here
              scrollDirection: Axis.vertical,
              child: DataTable(
                columns: const [
                  DataColumn(label: Text('#')),
                  DataColumn(label: Text('Description')),
                  DataColumn(label: Text('Amount EGP')),
                  DataColumn(label: Text('Amount \$')),
                  DataColumn(label: Text('Rate')),
                  DataColumn(label: Text('Total EGP')),
                  DataColumn(label: Text('User')),
                  DataColumn(label: Text('Date')),
                  DataColumn(label: Text('Actions')),
                ],
                rows: expensessi.asMap().entries.map(
                      (entry) {
                    final expensesi = entry.value;  // Corrected here
                    return DataRow(
                      cells: [
                        DataCell(Text('${entry.key + 1}')),
                        DataCell(
                          InkWell(
                            onTap: () {
                              // Pass the description of the current entry to the dialog display function
                              _showFullDescription(context, entry.value.description ?? 'N/A');
                            },
                            child: ConstrainedBox(
                              constraints: BoxConstraints(
                                maxWidth: 300,  // Adjust the width as needed.
                              ),
                              child: Text(
                                entry.value.description ?? 'N/A',
                                softWrap: true,
                                overflow: TextOverflow.ellipsis,  // Now using ellipsis to hint at more content.
                                style: TextStyle(
                                  // decoration: TextDecoration.underline,  // Optionally underline to indicate tappable.
                                  color: Colors.black,  // Optionally change color to indicate tappable.
                                ),
                              ),
                            ),
                          ),
                        ),
                        DataCell(Text('${expensesi.amount ?? '0'} EGP')),
                        DataCell(Text('${expensesi.dollarAmount ?? '0'} \$')),
                        DataCell(Text('${expensesi.rate ?? '0'}')),
                        DataCell(Text('${expensesi.total ?? '0'} EGP')),
                        DataCell(Text(expensesi.username ?? 'N/A')),
                        DataCell(Text(formatUtcToLocalDateString(expensesi.date))),
                        DataCell(
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.delete, color: Colors.red),
                                onPressed: () => _deleteExpense(expensesi.expenseIdsi, entry.key),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ).toList(),
              ),
            ),
          ),
        ),
      ),
    );
  }
  Future<void> _deleteExpense(int? expenseIdsi, int index) async {
    if (expenseIdsi == null) return;

    final response = await _apiServices.deleteBillOfSales(expenseIdsi);
    if (response?.message != null) {
      setState(() {
        expensessi.removeAt(index);
      });
      await fetchProjectTotals();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(response?.error ?? 'Error occurred while deleting expense.')),
      );
    }
  }
  void _showFullDescription(BuildContext context, String description) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Full Description'),
          content: SingleChildScrollView(child: Text(description)),
          actions: <Widget>[
            TextButton(
              child: const Text('Close'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      },
    );
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
