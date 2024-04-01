
import 'package:flutter/material.dart';
import 'package:greeksinergy_tech_movie_app/controler/provider.dart';
import 'package:greeksinergy_tech_movie_app/views/login_page.dart';
import 'package:greeksinergy_tech_movie_app/views/sign_up_page.dart';
import 'package:provider/provider.dart';


class ToggleAuth extends StatefulWidget {
  const ToggleAuth({super.key});

  @override
  State<ToggleAuth> createState() => _ToggleAuthState();
}

class _ToggleAuthState extends State<ToggleAuth> {
  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<LoginProvider>(context);
    if (loginProvider.showLogin) {
      return LoginPage(
        showSignUp: loginProvider.toggleScreen,
      );
    } else {
      return SignUpPage(
        showLogin: loginProvider.toggleScreen,
      );
    }
  }
}