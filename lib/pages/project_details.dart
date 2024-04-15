import 'package:flutter/material.dart';
import '../models/project_totals_response_model.dart';
import '../services/api_services.dart';



// Defining a stateful widget for ProjectDetails.
class ProjectDetails extends StatefulWidget {
  final int projectId;
  const ProjectDetails({Key? key, required this.projectId}) : super(key: key);

  @override
  State<ProjectDetails> createState() => _ProjectDetailsState();
}

class _ProjectDetailsState extends State<ProjectDetails> {

  bool isDesktop(BuildContext context) =>
      MediaQuery.of(context) . size. width >= 600;

  bool isMobile(BuildContext context) =>
      MediaQuery.of(context) . size. width < 600;


  ProjectTotalsResponse? projectTotals;
  final ScrollController _verticalScrollController = ScrollController();
  final ScrollController _horizontalScrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    fetchProjectTotals();

  }

  void fetchProjectTotals() async {
    var apiService = ApiServices();
    var totalsResponse = await apiService.getProjectTotals(widget.projectId);
    print(totalsResponse);
    if (totalsResponse != null) {
      setState(() {
        projectTotals = totalsResponse;
      });
    }
  }

  @override
  Widget build(BuildContext context) {

   double totalProfitAndLoss = ((projectTotals?.billOfSaleTotal ?? 0) - ((projectTotals?.administrativeExpensesTotal ?? 0) +
       (projectTotals?.receiptOfBuyTotal ?? 0))
        ).toDouble();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.red),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: isMobile(context) ? Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              flex:2,
              child: Column(
                children: [
                  Expanded(
                    flex: 3,
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                             Row(
                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                               children: [
                                 Text(
                                  projectTotals?.projectName ?? "Project Name Unavailable",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 30,
                                    color: Colors.black,
                                  ),
                            ),
                                 ElevatedButton(
                                   style: ElevatedButton.styleFrom(
                                     backgroundColor: Colors.lightGreen,
                                     elevation: 0,
                                     shape: RoundedRectangleBorder(
                                       borderRadius: BorderRadius.circular(10),
                                     ),
                                   ),
                                     onPressed: () async {
                                    fetchProjectTotals();
                                     },
                                     child: Icon(
                                         Icons.refresh_outlined,
                                     ),)
                               ],
                             ),
                            const SizedBox(height: 15),
                            Padding(
                              padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.0),
                              child: Card(
                                color: Colors.white54,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                elevation: 5,
                                child: Padding(
                                  padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.02),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 2,
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                 Text(
                                                  "Administrative expenses:",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                    fontSize: MediaQuery.of(context).size.width * 0.04,
                                                  ),
                                                ),
                                                SizedBox(width: 20),
                                                Text(
                                                  "${projectTotals?.administrativeExpensesTotal  ?.toDouble() ??'Loading...'} EGP",
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: MediaQuery.of(context).size.width * 0.04,
                                                  ),
                                                )
                                              ],
                                            ),
                                            SizedBox(height: 5),
                                            Row(
                                              children: [
                                               Text(
                                                  "Purchase invoices:",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                    fontSize: MediaQuery.of(context).size.width * 0.04,
                                                  ),
                                                ),
                                                SizedBox(width: 20),
                                                Text(
                                                  "${projectTotals?.receiptOfBuyTotal  ?.toDouble() ?? 'Loading...'} EGP",
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: MediaQuery.of(context).size.width * 0.04,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 5),
                                            Row(
                                              children: [
                                                Text(
                                                  "Sales invoices:",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                    fontSize: MediaQuery.of(context).size.width * 0.04,
                                                  ),
                                                ),
                                                SizedBox(width: 20),
                                                Text(
                                                  "${projectTotals?.billOfSaleTotal ?.toDouble() ?? 'Loading...'} EGP",
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: MediaQuery.of(context).size.width * 0.04,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 5),
                                            Row(
                                              children: [
                                               Text(
                                                  "Collections:",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                    fontSize: MediaQuery.of(context).size.width * 0.04,
                                                  ),
                                                ),
                                                SizedBox(width: 20),
                                                Text(
                                                  "${projectTotals?.collectionsTotal?.toDouble() ?? 'Loading...'} EGP",
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: MediaQuery.of(context).size.width * 0.04,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      const Divider(
                                        color: Colors.black,
                                        thickness: 1,
                                        height: 1,
                                      ),
                                      // Expanded(
                                      //   child: Column(
                                      //     children: [
                                      //      Text(
                                      //         "AE&PI: ", //AD&PI
                                      //         style: TextStyle(
                                      //        //   fontWeight: FontWeight.bold,
                                      //           color: Colors.black,
                                      //       fontSize: MediaQuery.of(context).size.width * 0.05,
                                      //         ),
                                      //       ),
                                      //       SizedBox(width:MediaQuery.of(context).size.width * 0.05,),
                                      //       Text(
                                      //         "${(projectTotals?.administrativeExpensesTotal ?? 0) + (projectTotals?.receiptOfBuyTotal ?? 0)  } EGP",
                                      //         style: TextStyle(
                                      //           color: Colors.black,
                                      //           fontSize: MediaQuery.of(context).size.width * 0.05,
                                      //         ),
                                      //       ),
                                      //     ],
                                      //   ),
                                      // ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.01),
                              child: Card(
                                color: Colors.white54,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                               elevation: 5,
                                child: Padding(
                                  padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.01),
                                  child: Padding(
                                    padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.01),
                                    child: ListTile(
                                      title: Text(
                                        "Profit and Loss",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: MediaQuery.of(context).size.width * 0.05,
                                        ),
                                      ),
                                      subtitle: Text(
                                        "Total: ${totalProfitAndLoss.toString()} EGP  ",
                                        style: TextStyle(
                                          fontSize:MediaQuery.of(context).size.width * 0.04,
                                          color: totalProfitAndLoss >= 0 ? Colors.green : Colors.red,
                                        ),
                                      ),
                                      trailing: Text(
                                        totalProfitAndLoss >= 0 ? "Profit" : "Loss",
                                        style: TextStyle(
                                          fontSize: MediaQuery.of(context).size.width * 0.05,
                                          color: totalProfitAndLoss >= 0 ? Colors.green : Colors.red,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Divider(
              color: Colors.black,
              thickness: 1,
              height: 1,
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding:  EdgeInsets.all(MediaQuery.of(context).size.width * 0.03),
                child: Scrollbar(
                  controller: _verticalScrollController, // Assign vertical ScrollController
                  thumbVisibility: true,
                  trackVisibility: true,
                  child: SingleChildScrollView(
                    controller: _verticalScrollController, // Use the same controller here
                    scrollDirection: Axis.vertical,
                    child: GridView(
                      shrinkWrap: true, // Ensures that the GridView occupies only the necessary space
                      physics: NeverScrollableScrollPhysics(), // Disables scrolling of the GridView
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 1, // Number of columns in the grid
                        childAspectRatio: 7, // Aspect ratio (width / height) of each grid item
                        crossAxisSpacing: 20, // Spacing between columns
                        mainAxisSpacing: 20, // Spacing between rows
                      ),
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Text(
                            "Administrative expenses",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onPressed: () {
                            Navigator.pushNamed(
                              context,
                              '/administrativeexpenses_page',
                              arguments: widget.projectId,
                            );
                          },
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Text(
                            "Purchase invoices",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onPressed: () {
                            Navigator.pushNamed(
                              context,
                              '/purchaseinvoices_page',
                              arguments: widget.projectId,
                            );
                          },
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black87,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Text(
                            "Sales invoices",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onPressed: () {
                            Navigator.pushNamed(
                              context,
                              '/salesinvoices_page',
                              arguments: widget.projectId,
                            );
                          },
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.brown,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Text(
                            "Collections",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onPressed: () {
                            Navigator.pushNamed(
                              context,
                              '/collections_page',
                              arguments: widget.projectId,
                            );
                          },
                        ),
                      ],
                    ),

                  ),
                ),
              ),)
          ],
        ),
      ) : Row(
        children: [
          Expanded(
            flex: 2,
            child: Column(
              children: [
                Expanded(
                  child: Center(
                    child: SizedBox(
                      width: 300,
                      height: 200,
                      child: Image.asset("images/logo.jpg"),
                    ),
                  ),
                ),
                const Divider(
                  color: Colors.black,
                  thickness: 1,
                  height: 1,
                ),
                Expanded(
                  flex: 3,
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                projectTotals?.projectName ?? "Project Name Unavailable",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30,
                                  color: Colors.black,
                                ),
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.lightGreen,
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                onPressed: () async {
                                  fetchProjectTotals();
                                },
                                child: Icon(
                                  Icons.refresh_outlined,
                                ),)
                            ],
                          ),
                          const SizedBox(height: 15),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Card(
                              color: Colors.white54,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              elevation: 5,
                              child: Padding(
                                padding: EdgeInsets.all(15.0),
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              const Text(
                                                "Administrative expenses: ",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                  fontSize: 15,
                                                ),
                                              ),
                                              SizedBox(width: 20),
                                              Text(
                                                "${projectTotals?.administrativeExpensesTotal  ?.toDouble() ??'Loading...'} EGP",
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 15,
                                                ),
                                              )
                                            ],
                                          ),
                                          SizedBox(height: 5),
                                          Row(
                                            children: [
                                              const Text(
                                                "Purchase invoices: ",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                  fontSize: 15,
                                                ),
                                              ),
                                              SizedBox(width: 20),
                                              Text(
                                                "${projectTotals?.receiptOfBuyTotal  ?.toDouble() ?? 'Loading...'} EGP",
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 15,
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 5),
                                          Row(
                                            children: [
                                              const Text(
                                                "Sales invoices: ",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                  fontSize: 15,
                                                ),
                                              ),
                                              SizedBox(width: 20),
                                              Text(
                                                "${projectTotals?.billOfSaleTotal ?.toDouble() ?? 'Loading...'} EGP",
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 15,
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 5),
                                          Row(
                                            children: [
                                              const Text(
                                                "Collections: ",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                  fontSize: 15,
                                                ),
                                              ),
                                              SizedBox(width: 20),
                                              Text(
                                                "${projectTotals?.collectionsTotal?.toDouble() ?? 'Loading...'} EGP",
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 15,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    const VerticalDivider(
                                      color: Colors.black,
                                      thickness: 1,
                                      width: 1,
                                    ),
                                    Expanded(
                                      child: Row(
                                        children: [
                                          const Text(
                                            "Total: ", //AD&PI
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                              fontSize: 25,
                                            ),
                                          ),
                                          SizedBox(width: 20),
                                          Text(
                                            "${(projectTotals?.administrativeExpensesTotal ?? 0) + (projectTotals?.receiptOfBuyTotal ?? 0)  } EGP",
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 15,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(30.0),
                            child: Card(
                              color: Colors.white54,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              elevation: 5,
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: ListTile(
                                  title: Text(
                                    "Profit and Loss",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w300,
                                      fontSize: 25,
                                    ),
                                  ),
                                  subtitle: Text(
                                    "Total: ${totalProfitAndLoss.toString()} EGP  ",
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: totalProfitAndLoss >= 0 ? Colors.green : Colors.red,
                                    ),
                                  ),
                                  trailing: Text(
                                    totalProfitAndLoss >= 0 ? "Profit" : "Loss",
                                    style: TextStyle(
                                      fontSize: 25,
                                      color: totalProfitAndLoss >= 0 ? Colors.green : Colors.red,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const VerticalDivider(
            color: Colors.black,
            thickness: 1,
            width: 1,
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Scrollbar(
                controller: _verticalScrollController, // Assign vertical ScrollController
                thumbVisibility: true,
                trackVisibility: true,
                child: SingleChildScrollView(
                  controller: _verticalScrollController, // Use the same controller here
                  scrollDirection: Axis.vertical,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 80,
                        width: 500,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Text(
                            "Administrative expenses",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onPressed: () {
                            Navigator.pushNamed(context,
                              '/administrativeexpenses_page',
                              arguments:widget.projectId,
                            );

                          },
                        ),
                      ),
                      SizedBox(
                        height: 35,
                      ),
                      SizedBox(
                        height: 80,
                        width: 500,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Text(
                            "Purchase invoices",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onPressed: () {
                            Navigator.pushNamed(context,
                              '/purchaseinvoices_page',
                              arguments:widget.projectId,
                            );
                          },
                        ),
                      ),
                      SizedBox(
                        height: 35,
                      ),
                      SizedBox(
                        height: 80,
                        width: 500,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black87,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Text(
                            "Sales invoices",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onPressed: () {
                            Navigator.pushNamed(context,
                              '/salesinvoices_page',
                              arguments:widget.projectId,
                            );
                          },
                        ),
                      ),
                      SizedBox(
                        height: 35,
                      ),
                      SizedBox(
                        height: 80,
                        width: 500,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.brown,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Text(
                            "Collections",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onPressed: () {
                            Navigator.pushNamed(context,
                              '/collections_page',
                              arguments:widget.projectId,);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),)
        ],
      ),
    );
  }
}
