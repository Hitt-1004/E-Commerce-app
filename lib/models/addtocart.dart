import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:new_application/models/store.dart';
import 'package:velocity_x/velocity_x.dart';
import 'cartmodel.dart';
import 'catalog.dart';

class AddtoCart extends StatelessWidget {
  final Item catalog;
  AddtoCart({Key? key, required this.catalog}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    VxState.watch(context, on: [AddMutation, RemoveMutation]);
    final CartModel _cart = (VxState.store as MyStore).cart;
   // final CatalogModel _catalog = (VxState.store as MyStore).catalog;
    bool isinCart = _cart.items.contains(catalog) ?? false;
    return ElevatedButton(
      onPressed: () {
        if(!isinCart){
          //isinCart = isinCart.toggle();
          //_cart.catalog = _catalog;
         // _cart.add(catalog);
          AddMutation(catalog);
        }},
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.greenAccent[200])
      ),
      child: isinCart? const Icon(Icons.done): const Icon(CupertinoIcons.cart_badge_plus),);
  }
}

