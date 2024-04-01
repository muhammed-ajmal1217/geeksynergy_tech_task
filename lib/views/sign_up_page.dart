import 'package:flutter/material.dart';
import 'package:greeksinergy_tech_movie_app/views/widgets/toggle_signup_login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:greeksinergy_tech_movie_app/views/widgets/text_field.dart';

class SignUpPage extends StatelessWidget {
  final VoidCallback showLogin;
  SignUpPage({Key? key, required this.showLogin}) : super(key: key);

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Sign up',
            style: TextStyle(
                color: Colors.blue, fontSize: 25, fontWeight: FontWeight.bold),
          ),
          Text('Please fill out the following required fields'),
          TextFieldWidgets(hintText: 'Name', controller: nameController),
          TextFieldWidgets(hintText: 'E-mail', controller: emailController),
          TextFieldWidgets(
              hintText: 'Password', controller: passwordController),
          TextFieldWidgets(
              hintText: 'Confirm password', controller: confirmController),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  _signUp(context);
                },
                child: Text('Sign up'),
              ),
              SizedBox(
                width: width * 0.05,
              ),
              ToggleScreen(
                screenHeight: height,
                screenWidth: width,
                toggleScreen: () => showLogin(),
                text1: 'login with an existing account',
                text2: 'Login',
              ),
            ],
          )
        ],
      ),
    );
  }

  void _signUp(BuildContext context) async {
    try {
      if (passwordController.text.isEmpty ||
          confirmController.text.isEmpty ||
          passwordController.text != confirmController.text) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Password does not matching'),
        ));
      } else {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('name', nameController.text);
        await prefs.setString('email', emailController.text);
        await prefs.setString('password', passwordController.text);
        String? name = prefs.getString('name');
        String? email = prefs.getString('email');
        String? password = prefs.getString('password');
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Signed up successfully!'),
        ));
        print('Name: $name');
        print('Email: $email');
        print('Password: $password');
      }
    } catch (error) {
      print('Error: $error');
    }
  }
}
