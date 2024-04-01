import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:greeksinergy_tech_movie_app/model/get_model.dart';
import 'package:greeksinergy_tech_movie_app/model/post_model.dart';
import 'package:greeksinergy_tech_movie_app/service/api_service.dart';
import 'package:greeksinergy_tech_movie_app/views/widgets/auth_gate.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 100,),
          InkWell(
            onTap: (){
              logout(context);
            },
            child: Text('Logout'),
          ),
          Expanded(
            child: FutureBuilder(
              future: ApiService().fetchMovies(), // Fetch movies
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  print('Error: ${snapshot.error}');
                  return Text('Error: ${snapshot.error}');
                } else {
                  final datas = snapshot.data;
                  return ListView.builder(
                    itemCount: datas?.length,
                    itemBuilder: (context, index) {
                      GetModel? data = datas?[index];
                      return ListTile(
                        title: Text(data!.title),
                        subtitle: Text(data.director.join(', ')),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

  void logout(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('email');
    await prefs.remove('password');
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => AuthGatePage(),
    ));
  }
