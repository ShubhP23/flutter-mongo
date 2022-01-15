import 'dart:async';
import 'package:mongo_dart/mongo_dart.dart';

class MongoDb {
  static var datacCollection;
  static connect() async {
    var db = await Db.create(
        'mongodb+srv://sunanda:sunanda@cluster0.rhumu.mongodb.net/myFirstDatabase?retryWrites=true&w=majority');
    await db.open().then((value) => print('db connected baby!'));
    datacCollection = db.collection('sunanda');
  }

  static Future<List<dynamic>> getDocuments() async {
    var data = await datacCollection.find().toList();
    print(data);
    return data;
  }

  static updateDocuments() async {
    try {
      var updateData = await datacCollection.updateOne(
          where.eq("_id", ObjectId.fromHexString('61e1dc7fabe7f0acb4c7cfd6')),
          modify.set("name", 'Mohjshdjhsjhdjshd'));
      return updateData;
    } catch (e) {
      print(e);
      return e;
    }
  }

  static insertDoc(data) async {
    var doc = await datacCollection.insert(data);
    print(doc);
  }
}
