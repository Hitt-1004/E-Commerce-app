import 'package:flutter/material.dart';
import 'package:new_application/models/cartmodel.dart';
import 'package:new_application/models/store.dart';
import 'package:velocity_x/velocity_x.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent,
      title: 'Cart'.text.bold.xl3.make(),
      centerTitle: true,
      ),
      body: Column(
        children: [
          _CartList().p32().expand(),
          const Divider(),
          _CartTotal(),
        ],
      ),
    );
  }
}

class _CartTotal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final CartModel _cart = (VxState.store as MyStore).cart;
    return SizedBox(
      height: 200,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          VxConsumer(builder: (context, dynamic, _)=> '₹${_cart.totalPrice}'.text.xl4.color(context.accentColor).make(),
              mutations: const {RemoveMutation}),
          //'₹${_cart.totalPrice}'.text.xl4.color(context.accentColor).make(),
          30.widthBox,
          ElevatedButton(
              onPressed: (){
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: 'Buying not supported yet.'.text.make()));
              },
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.greenAccent[200])
              ),
              child: 'Buy'.text.xl.white.make(),
          ),
        ],
      ),
    );
  }
}

class _CartList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    VxState.watch(context, on: [RemoveMutation]);
    final CartModel _cart = (VxState.store as MyStore).cart;
    return _cart.items!.isEmpty ? 'Cart is empty.'.text.xl2.makeCentered() :ListView.builder(
        itemCount: _cart.items?.length,
        itemBuilder: (context, index)=> ListTile(
          leading: const Icon(Icons.done),
          trailing: IconButton(
            icon: const Icon(Icons.remove_circle_outline),
            onPressed: () => RemoveMutation(_cart.items[index]),
         ),
          title: _cart.items[index].name.text.make(),
        ));
    }
}


