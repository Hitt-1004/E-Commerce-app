import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:mongo_dart/mongo_dart.dart' as M;
import 'package:new_application/MongoDBModel.dart';
import 'package:new_application/dbHelper/mongodb.dart';

class MongoDbInsert extends StatefulWidget {
  const MongoDbInsert({Key? key}) : super(key: key);

  @override
  State<MongoDbInsert> createState() => _MongoDbInsertState();
}

class _MongoDbInsertState extends State<MongoDbInsert> {
  var fnameController = new TextEditingController();
  var lnameController = new TextEditingController();
  var addressController = new TextEditingController();
  var passwordController = new TextEditingController();
  var emailController = new TextEditingController();
  var usernameController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(child: Padding(
      padding: const EdgeInsets.all(15.0),
      child: SingleChildScrollView(child: Column(
        children: [
          const Text("SignUp", style: TextStyle(fontSize: 20),),
          const SizedBox(height: 50,),
          TextField(controller: fnameController, decoration: const InputDecoration(labelText: "FirstName"),),
          TextField(controller: lnameController, decoration:const  InputDecoration(labelText: "LastName"),),
          TextField(controller: usernameController, decoration:const  InputDecoration(labelText: "Username"),),
          TextField(controller: emailController, decoration:const  InputDecoration(labelText: "Email"),),
          TextField(controller: passwordController, decoration:const  InputDecoration(labelText: "Password"), obscureText: true,),
          TextField(controller: addressController, minLines: 3, maxLines: 5, decoration: const InputDecoration(labelText: "Address"),),
          const SizedBox(height: 50,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [OutlinedButton(onPressed: (){_fakeData();}, child: const Text("Generate Data")),
          ElevatedButton(onPressed: (){
            _insertData(fnameController.text, lnameController.text,usernameController.text, emailController.text, passwordController.text, addressController.text);
            },
              child: const Text("SignUp"))],),
          const SizedBox(height: 50,),
          ElevatedButton(onPressed: ()=>Navigator.pushNamed(context, '/LogIn'), child: const Text("Login"))
        ],

      ),
    ))));
  }

  Future<void> _insertData(String fname, String lname, String username, String email, String password, String address) async{
    var id = M.ObjectId();
    final data = MongoDbModel(id: id, firstName: fname, lastName: lname,username: username, email: email, password: password, address: address);
    var result = await MongoDatabase.insert(data);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Inserted ID ${id.$oid}")));
    _clearAll();
  }

  void _clearAll(){
    fnameController.text = "";
    lnameController.text = "";
    usernameController.text = "";
    emailController.text = "";
    passwordController = "" as TextEditingController;
    addressController.text = "";
  }

  void _fakeData(){
      setState(() {
        fnameController.text = faker.person.firstName();
        lnameController.text = faker.person.lastName();
        usernameController.text = fnameController.text;
        emailController.text = "${fnameController.text}${lnameController.text}${faker.randomGenerator.integer(2100)}@gmail.com";
        passwordController.text = faker.randomGenerator.string(10, min: 8);
        addressController.text = "${faker.address.streetName()}\n${faker.address.streetAddress()}";
      });
  }
}
