import 'package:flutter/material.dart';
import 'package:greeksinergy_tech_movie_app/views/home_page.dart';
import 'package:greeksinergy_tech_movie_app/views/login_page.dart';
import 'package:greeksinergy_tech_movie_app/views/widgets/auth_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthGatePage extends StatefulWidget {
  @override
  State<AuthGatePage> createState() => _AuthGatePageState();
}

class _AuthGatePageState extends State<AuthGatePage> {
  bool _isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    checkLoggedInStatus(); 
  }

  @override
  Widget build(BuildContext context) {
    return _isLoggedIn ? HomePage() : ToggleAuth();
  }

  void checkLoggedInStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? email = prefs.getString('email');
    String? password = prefs.getString('password');
    if (email != null && password != null) {
      setState(() {
        _isLoggedIn = true;
      });
    }
  }

  void toggleLoggedInStatus() {
    setState(() {
      _isLoggedIn = !_isLoggedIn;
    });
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomePage()));
  }
}
