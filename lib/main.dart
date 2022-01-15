import 'package:flutter/material.dart';
import 'package:mongoapp/db.dart';
import 'package:mongoapp/home.dart';
import 'package:mongo_dart/mongo_dart.dart';

void main() async {
  await MongoDb.connect();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  var count = 0;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Scaffold(
          appBar: AppBar(
            title: Text('Maa ki chu!' + count.toString()),
          ),
          body: Column(
            children: [
              Flexible(
                  flex: 5,
                  child: FutureBuilder(
                    future: MongoDb.getDocuments(),
                    builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Container(
                          child: CircularProgressIndicator(color: Colors.black),
                        );
                      } else if (snapshot.hasError) {
                        return Container(
                          child: Text(snapshot.error.toString()),
                        );
                      } else {
                        return ListView.builder(
                            itemCount: snapshot.data?.length,
                            itemBuilder: ((context, int index) {
                              return Container(
                                child: Center(
                                    child: Text(snapshot.data?[index]['name'])),
                              );
                            }));
                      }
                    },
                  )),
              TextButton(
                  onPressed: () async {
                    var data = await MongoDb.getDocuments();
                    count = data.length;
                  },
                  child: Text('get')),
              TextButton(
                  onPressed: () async {
                    await MongoDb.insertDoc(
                        {"_id": new ObjectId(), "name": "sunandaaa"});
                  },
                  child: Text('Add')),
              TextButton(onPressed: () async {}, child: Text('delete')),
              TextButton(
                  onPressed: () async {
                    await MongoDb.updateDocuments();
                  },
                  child: Text('update')),
            ],
          ),
        ));
  }
}
