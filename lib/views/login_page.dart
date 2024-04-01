import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:greeksinergy_tech_movie_app/model/get_model.dart';
import 'package:greeksinergy_tech_movie_app/model/post_model.dart';
import 'package:greeksinergy_tech_movie_app/service/api_service.dart';
import 'package:greeksinergy_tech_movie_app/views/home_page.dart';
import 'package:greeksinergy_tech_movie_app/views/widgets/text_field.dart';
import 'package:greeksinergy_tech_movie_app/views/widgets/toggle_signup_login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  final VoidCallback showSignUp;
  const LoginPage({Key? key, required this.showSignUp}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    checkLoggedInStatus();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Login',
              style: TextStyle(
                  color: Colors.blue,
                  fontSize: 25,
                  fontWeight: FontWeight.bold)),
          Text('Please Enter the E-mail and password'),
          TextFieldWidgets(controller: emailController, hintText: 'E-mail'),
          TextFieldWidgets(
              controller: passwordController, hintText: 'Password'),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: _login,
                child: Text('Login'),
              ),
              SizedBox(width: screenWidth * 0.05),
              ToggleScreen(
                screenHeight: screenHeight,
                screenWidth: screenWidth,
                text1: 'Create New Account',
                text2: 'Sign up',
                toggleScreen: () => widget.showSignUp(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void checkLoggedInStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? storedEmail = prefs.getString('email');
    String? storedPassword = prefs.getString('password');
    if (storedEmail != null && storedPassword != null) {
      _login();
    }
  }

void _login() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? storedEmail = prefs.getString('email');
  String? storedPassword = prefs.getString('password');
  String enteredEmail = emailController.text;
  String enteredPassword = passwordController.text;
  if (storedEmail == enteredEmail && storedPassword == enteredPassword) {
    try {
      PostModel post = PostModel(
        category: "movies",
        language: "kannada",
        genre: "all",
        sort: "voting",
      );
      await ApiService().postData(post); 
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomePage()));
    } catch (e) {
      print('Error fetching movies: $e');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Failed to fetch movies'),
      ));
    }
  } else {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Login failed'),
    ));
  }
}
}
