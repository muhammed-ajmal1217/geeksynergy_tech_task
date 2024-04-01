import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:greeksinergy_tech_movie_app/controler/provider.dart';
import 'package:greeksinergy_tech_movie_app/views/login_page.dart';
import 'package:greeksinergy_tech_movie_app/views/widgets/auth_gate.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await SharedPreferences.getInstance();
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => LoginProvider(),)
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: AuthGatePage(),
      ),
    );
  }
}