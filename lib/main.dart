import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:new_application/insert.dart';
import 'package:new_application/models/cart.dart';
import 'package:new_application/models/cartmodel.dart';
import 'package:new_application/models/catalog.dart';
import 'package:new_application/models/catalogList.dart';
import 'package:new_application/models/store.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dbHelper/mongodb.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await MongoDatabase.connect();

  runApp(VxState(
      store: MyStore(),
      child: Myapp()));
}

class Myapp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
        fontFamily: GoogleFonts.lato().fontFamily,
        cardColor: Colors.white,
        canvasColor: Colors.white70,
        accentColor: Colors.black,
        drawerTheme: DrawerThemeData(
          backgroundColor: Colors.tealAccent[400],
        ),
        appBarTheme: AppBarTheme(
          color: Colors.tealAccent[400],
          //elevation: 0.0,
          iconTheme: const IconThemeData(color: Colors.white),
            textTheme: context.textTheme,
        ),
      ),
      themeMode: ThemeMode.system,
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blueGrey,
        cardColor: Colors.black,
        canvasColor: Colors.grey[800],
        accentColor: Colors.white,
        drawerTheme: DrawerThemeData(
          backgroundColor: Colors.grey[900],
        ),
        appBarTheme: AppBarTheme(color: Colors.grey[600]),
      ),
      routes: {
        "/": (context)=> Loginpage(),
        "/SignUp": (context)=> MongoDbInsert(),
        "/LogIn": (context)=> Loginpage(),
        "/Home": (context)=> Home(),
        "/Cart": (context)=> const CartPage(),
      },
    );
  }
}

class AppDrawer extends StatelessWidget {
  String? Name;
  AppDrawer(String Name){this.Name = Name;}
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        // color: Color(context.cardColor),
        child: ListView(
          children: [
            DrawerHeader(
                padding: EdgeInsets.zero,
                child: UserAccountsDrawerHeader(
                  //decoration: BoxDecoration(color: Colors.black),
                  accountName: Text(Name.toString()),
                  accountEmail: const Text('hittbahal2003@gmail.com'),
                  currentAccountPicture: const CircleAvatar(backgroundImage: AssetImage('Assets/img_1.png'),),
                ),
            ),
            const ListTile(
              leading: Icon(CupertinoIcons.home),
              title: Text('Home', textScaleFactor: 1.3,),
            ),
            const ListTile(
              leading: Icon(CupertinoIcons.archivebox_fill),
              title: Text('Archives', textScaleFactor: 1.3,),
            ),
            const ListTile(
              leading: Icon(CupertinoIcons.mail),
              title: Text('Email', textScaleFactor: 1.3,),
            ),
          ],
        ),
      ),
    );
  }
}


class Loginpage extends StatefulWidget {
  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  String name = "";
  String pass ="";
  bool changeButton = false;

  final _formKey = GlobalKey<FormState>();

  moveToHome(BuildContext context) async {
    if(_formKey.currentState!.validate()){
      setState(() {
        changeButton = true;
      });
      await Future.delayed(const Duration(seconds: 1));
      await Navigator.pushNamed(context, "/Home", arguments: <String, String>{'Name': name});
      setState(() {
        changeButton = false;
      });
    }
  }

  bool check = false;
  void Toggle(){
      if(check == false) check = true; else check = false;
  }

  Widget _buildPopupDialog(BuildContext context) {
    return AlertDialog(
      title: const Text('Invalid email or password'),
      content: const Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("Enter a valid email and password"),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: 'Close'.text.teal400.make(),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 200.0),
            Image.asset("Assets/img.png",
                fit: BoxFit.cover),
            const SizedBox(height: 20.0),
             Text(
              'Welcome $name',
              style: const TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'GentiumBookPlus',
              ),
            ),
            const SizedBox(height: 20.0),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 40.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(
                        prefixIcon: Icon(CupertinoIcons.person_alt),
                        hintText: "Enter Username",
                        labelText: "Username",
                      ),
                      validator: (value) {
                        if(value!.isEmpty) {
                          return "Username cannot be empty";
                        }
                        return null;
                      },
                      onChanged: (value){name = value;
                        setState(() {});},
                    ),
                    TextFormField(
                      obscureText: !check,
                      decoration: InputDecoration(
                        prefixIcon: Icon(CupertinoIcons.lock_shield),
                        hintText: "Enter Password",
                        suffixIcon: IconButton(onPressed: (){Toggle(); setState(() {});},
                            icon: !check ? const Icon(CupertinoIcons.eye_slash) : const Icon(CupertinoIcons.eye)),
                        labelText: "Password",
                      ),
                      validator: (value) {
                        if(value!.isEmpty) {
                          return "Password cannot be empty";
                        }
                        else if(value.length<8){
                          return "Length of the password cannot be less than 8";
                        }
                        return null;
                      },
                      onChanged: (value){pass = value;
                      setState(() {});},
                    ),
                    const SizedBox(height: 40.0),
                    InkWell(
                      onTap: () => moveToHome(context),
                      child: AnimatedContainer(
                        duration: const Duration(seconds: 1),
                        width: changeButton ? 50 : 150,
                        height: 50,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(changeButton ? 50 : 10),
                        ),
                        child: changeButton ? const Icon(Icons.done, color: Colors.white,) : const Text('Login',
                        style: TextStyle(fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.white,)),
                      ),
                    ),
                    // ElevatedButton(onPressed: () async{
                    //   final data = MongoDatabase.getData(context, name, pass);
                    //   // if(data.toString() != "null"){
                    //   //   Navigator.pushNamedAndRemoveUntil(context, "/Home", (route) => false);
                    //   // }
                    //   // else{
                    //   //   showDialog(
                    //   //     context: context,
                    //   //     builder: (BuildContext context) =>
                    //   //         _buildPopupDialog(context),
                    //   //   );
                    //   //   print("Wrong credentials.");
                    //   //}
                    //
                    //   }, child: 'Login'.text.make()),
                      Row(
                        children: [
                          const Text("Don't have an account?", style: TextStyle(fontSize: 14,)),
                          TextButton(onPressed: ()=>Navigator.pushNamed(context, '/SignUp'),
                              child: const Text("SignUp", style: TextStyle(fontSize: 14, color: Colors.tealAccent),)),
                        ],
                      ).px(36),
                    // ElevatedButton(
                    //     onPressed: () {
                    //       Navigator.pushNamed(context, "/Home");
                    //     },
                    //     //style: TextButton.styleFrom(),
                    //     child: const Text('Login')),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ItemWidget extends StatelessWidget {
  final Item item;
  const ItemWidget({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      //shape:
      child: ListTile(
        onTap: () {print('${item.name} pressed');},
        leading: Image.network(item.image),
        title: Text(item.name),
        subtitle: Text(item.desc),
        trailing: Text("₹${item.price.toString()}",
        textScaleFactor: 1.5,
        style: const TextStyle(fontWeight: FontWeight.bold),),
      ),
    );
  }
}


// class Loginpage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Material(
//       child: SingleChildScrollView(
//         child: Column(
//           children: [
//             const SizedBox(height: 200.0),
//             Image.asset("Assets/login image.jpg",
//             fit: BoxFit.cover),
//             const SizedBox(height: 20.0),
//             const Text(
//               'Welcome',
//               style: TextStyle(
//                 fontSize: 30.0,
//                 fontWeight: FontWeight.bold,
//                 fontFamily: 'GentiumBookPlus',
//               ),
//             ),
//             const SizedBox(height: 20.0),
//             Padding(
//               padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 40.0),
//               child: Column(
//                 children: [
//                   TextFormField(
//                     decoration: const InputDecoration(
//                       hintText: "Enter Username",
//                       labelText: "Username",
//                     ),
//                   ),
//                   TextFormField(
//                     obscureText: true,
//                     decoration: const InputDecoration(
//                       hintText: "Enter Password",
//                       labelText: "Password",
//                     ),
//                   ),
//                   const SizedBox(height: 40.0),
//                   ElevatedButton(
//                       onPressed: () {
//                         Navigator.pushNamed(context, "/Home");
//                       },
//                       //style: TextButton.styleFrom(),
//                       child: const Text('Login'))
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
 // @override
  void initState() {
    // TODO: implement initState
    super.initState();
    data();
  }

  //final url = 'https://api.jsonbin.io/b/604dbddb683e7e079c4eefd3';

  Future<void> data() async {
   await Future.delayed(const Duration(seconds: 2));
   final catalog = await rootBundle.loadString("Assets/files/Catalog.json");
   // final response = await http.get(Uri.parse(url));
   // final catalog = response.body;
   final decodedData = await jsonDecode(catalog);
   final productsData = decodedData["products"];
    setState(() {CatalogModel.products = List.from(productsData).map<Item>((item) => Item.fromMap(item)).toList();});
  }

  @override
  Widget build(BuildContext context) {
    //final dummylist = List.generate(20, (index) => CatalogModel.products[0]);
    final routeData =
    ModalRoute.of(context)?.settings.arguments as Map<String, String>;
     final Name = routeData['Name'];
    // final Email = routeData['Email'];
    final _cart = (VxState.store as MyStore).cart;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
        centerTitle: true,
        //backgroundColor: Colors.tealAccent[400],
      ),
    body: SafeArea(
      child: Container(
        padding: Vx.m32,
        child: Column(
          children: [
            if(CatalogModel.products != null && CatalogModel.products!.isNotEmpty)
              CatalogList().expand()
            else Center(child: const CircularProgressIndicator().centered().expand(),)
          ],
        ),
      ),
    ),
    //   body: Padding(
    //     padding: const EdgeInsets.all(20),
    //     child: (CatalogModel.products!= null && CatalogModel.products!.isNotEmpty) ?
    //     // ListView.builder(itemCount: CatalogModel.products!.length,itemBuilder: (context , index){
    //     //   return ItemWidget(item: CatalogModel.products![index]);}
    //     GridView.builder(
    //       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
    //         crossAxisCount: 2,
    //         mainAxisSpacing: 14,
    //         crossAxisSpacing: 14,
    //       ),
    //         itemBuilder: (context, index){
    //       final item = CatalogModel.products![index];
    //       return Card(
    //           clipBehavior: Clip.antiAlias,
    //           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    //           child: GridTile(
    //               header: Container(
    //                 decoration: const BoxDecoration(color: Colors.black),
    //               padding: const EdgeInsets.all(14),
    //                 child: Text(item.name),
    //               ),
    //               footer: Container(
    //                   decoration: const BoxDecoration(color: Colors.black),
    //                   padding: const EdgeInsets.all(14),
    //                   child: Text(item.price.toString())),
    //               child: Image.network(item.image)));},
    //       itemCount: CatalogModel.products!.length,
    //     ) :const Center(
    //         child: CircularProgressIndicator(),
    // )),
      floatingActionButton: VxBuilder(
        mutations: const {AddMutation, RemoveMutation},
        builder: (ctx, dynamic, _)=> FloatingActionButton(
          onPressed: ()=>Navigator.pushNamed(context, '/Cart'),
          backgroundColor: Colors.tealAccent[400],
          child: const Icon(CupertinoIcons.cart),
        ).badge(size: 20, count: _cart.items.length, textStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
      ),
      drawer: AppDrawer(Name.toString()),
    );
  }
}

