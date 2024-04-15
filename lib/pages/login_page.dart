import 'package:flutter/material.dart';
import '../models/login_request_model.dart';
import '../services/api_services.dart';
import '../services/shared_services.dart';
import '../widgets/text_field.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  bool isDesktop(BuildContext context) =>
      MediaQuery.of(context) . size. width >= 600;

  bool isMobile(BuildContext context) =>
      MediaQuery.of(context) . size. width < 600;

  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  void _login() async {
    String username = _usernameController.text;
    String password = _passwordController.text;

    LoginRequestModel requestModel = LoginRequestModel(username: username, password: password);
    ApiServices api = ApiServices();
    final response = await api.loginUser(requestModel);

    if (response?.message == 'Logged in successfully') {
      // Save username to shared preferences
      await SharedService.setUsername(username);
      print(username);
      Navigator.pushNamed(context, '/home_page');
    } else {
      String errorMessage = response?.message ?? 'Login failed. Please try again later.';
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(errorMessage)));
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body:isMobile(context)
          ? Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Welcome Back!",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 35,
                fontFamily: "fonts/Pacifico-Regular.ttf",
              ),
            ),
            SizedBox(height: 25),
            TextFormField(
              controller: _usernameController,
              keyboardType: TextInputType.emailAddress,
              decoration: textInputDecoration.copyWith(
                labelText: "User Name",
                prefixIcon: Icon(Icons.email_outlined, color: Colors.red),
              ),
            ),
            SizedBox(height: 25),
            TextFormField(
              controller: _passwordController,
              obscureText: true,
              decoration: textInputDecoration.copyWith(
                labelText: "Password",
                prefixIcon: Icon(Icons.password_outlined, color: Colors.red),
              ),
            ),
            SizedBox(height: 25),
            SizedBox(
              height: 50,
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  "Sign in",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: _login,
              ),
            ),
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
                child: Image.asset("images/logo.jpg"),
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
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Welcome Back!",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 35,
                      fontFamily: "fonts/Pacifico-Regular.ttf",
                    ),
                  ),
                  SizedBox(height: 25),
                  TextFormField(
                    controller: _usernameController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: textInputDecoration.copyWith(
                      labelText: "User Name",
                      prefixIcon: Icon(Icons.email_outlined, color: Colors.red),
                    ),
                  ),
                  SizedBox(height: 25),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: textInputDecoration.copyWith(
                      labelText: "Password",
                      prefixIcon: Icon(Icons.password_outlined, color: Colors.red),
                    ),
                  ),
                  SizedBox(height: 25),
                  SizedBox(
                    height: 50,
                    width: 350,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                        "Sign in",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onPressed: _login,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}