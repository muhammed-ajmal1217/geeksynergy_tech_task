import 'package:flutter/material.dart';
import 'package:greeksinergy_tech_movie_app/utils/utils.dart';
import 'package:greeksinergy_tech_movie_app/model/get_model.dart';
import 'package:greeksinergy_tech_movie_app/service/api_service.dart';

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
      appBar: AppBar(
        title: Text('Movie Bucket'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: InkWell(
              onTap: () {
                logout(context);
              },
              child: Icon(Icons.logout),
            ),
          ),
        ],
      ),
      body: FutureBuilder(
        future: ApiService().fetchMovies(),
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
            return ListView.separated(
              separatorBuilder: (context, index) {
                return Divider();
              },
              itemCount: datas?.length ?? 0,
              itemBuilder: (context, index) {
                GetModel? data = datas?[index];
                return Padding(
                  padding: const EdgeInsets.only(left: 10, bottom: 10, top: 10),
                  child: Row(
                    children: [
                      Column(
                        children: [
                          Icon(Icons.arrow_drop_up),
                          SizedBox(
                              width: 30,
                              child: Center(
                                  child: Text(
                                '${data?.voting}',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w600),
                              ))),
                          Icon(Icons.arrow_drop_down),
                        ],
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Container(
                        height: 140,
                        width: 120,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(data?.poster ?? ''))),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                              width: 200,
                              child: Text(
                                data?.title ?? '',
                                style: TextStyle(
                                    fontWeight: FontWeight.w700, fontSize: 17),
                              )),
                          Text('${(data?.genre ?? []).join(',')}'),
                          Text('Director :${(data?.director ?? []).join(',')}',
                              style: TextStyle(fontSize: 12)),
                          Text(
                            'Actors : ${customText(20, (data?.stars ?? []).join(' | '))}',
                            style: TextStyle(fontSize: 12),
                          ),
                          Text(
                            '${data?.language} | ${formatTimestamp(data?.releasedDate ?? 0)}',
                            style: TextStyle(fontSize: 12),
                          ),
                          Text(
                            '${data?.pageViews} Views | Voted by ${data?.voting} people',
                            style: TextStyle(color: Colors.blue, fontSize: 12),
                          ),
                          Container(
                            width: 170,
                            height: 25,
                            decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(5)),
                            child: Center(
                                child: Text(
                              'Watch Trailer',
                              style: TextStyle(color: Colors.white),
                            )),
                          )
                        ],
                      )
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
