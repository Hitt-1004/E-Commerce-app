import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:new_application/MongoDBModel.dart';
import 'constant.dart';

class MongoDatabase{
  static var db, userCollection;
  static connect() async{
    db = await Db.create(mongo_conn_url);
    await db.open();
    inspect(db);
    userCollection = db.collection(user_collection);
  }

  static Future<List<Map<String, dynamic>>?> getData(BuildContext context, String username, String pass) async{
    final data = await userCollection.find(where.eq('username', username).eq('password', pass)).toList();
    //return data!.firstWhere((element) => element.password == pass, orElse: null);
    final decodedData = jsonDecode(data.toString());
    if(decodedData.username == username && decodedData.password == pass) {
      Navigator.pushNamedAndRemoveUntil(context, "/Home", (route) => false);
    }
    else print("can't login");
    return data;
  }

  static Future<String> insert(MongoDbModel data) async{
    try{
      var result = userCollection.insertOne(data.toJson());
      if(result.isSuccess){return "Data Inserted.";}
      else {return "Something went wrong while inserting data.";}
    }
        catch(e){
          print(e.toString());
          return e.toString();
        }
  }
}