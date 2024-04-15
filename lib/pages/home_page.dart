import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  bool isDesktop(BuildContext context) =>
      MediaQuery.of(context) . size. width >= 600;

  bool isMobile(BuildContext context) =>
      MediaQuery.of(context) . size. width < 600;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
            body: isMobile(context)
                ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
              children: [
                  Expanded(
                    child: Center(
                      child: SizedBox(
                        width: 350,
                        height: 155,
                        child: Image.asset(
                          "images/logo.jpg",
                        ),
                      ),
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
                            "Projects",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onPressed: () {
                            Navigator.pushNamed(context, '/projects_page' );

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
                            "Site survey",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onPressed: () {
                    //        Navigator.pushNamed(context, '/home_page');
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
                            "Auctions",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onPressed: () {
                           // Navigator.pushNamed(context, '/home_page');
                          },
                        ),
                      ),
                    ],
                  ),)
              ],
            ),
                )
                : Row(
              children: [
                Expanded(
                  child: Center(
                    child: SizedBox(
                      width: 350,
                      height: 155,
                      child: Image.asset(
                        "images/logo.jpg",
                      ),
                    ),
                  ),
                ),
                VerticalDivider(
                  color: Colors.black,
                  thickness: 1,
                  width: 1,
                ),
                Expanded(
                  flex: 2,
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
                            "Projects",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onPressed: () {
                            Navigator.pushNamed(context, '/projects_page' );

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
                            "Site survey",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onPressed: () {
                            //        Navigator.pushNamed(context, '/home_page');
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
                            "Auctions",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onPressed: () {
                            // Navigator.pushNamed(context, '/home_page');
                          },
                        ),
                      ),
                    ],
                  ),)
              ],
            )
    );
  }
}
