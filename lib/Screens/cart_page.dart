import 'package:first_app/Screens/home_details_page.dart';
import 'package:first_app/Widgets/themes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

import '../Models/cart.dart';
import '../core/store.dart';

class cartPage extends StatelessWidget {
  const cartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          color: Colors.black,
          icon: Icon(CupertinoIcons.back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        backgroundColor: Colors.transparent,
        title: "Cart".text.make(),
      ),
      body: Column(
        children: [
          _CartList().p32().expand(),
          Divider(),
          _CartTotal(),
        ],
      ),
    );
  }
}

class _CartTotal extends StatelessWidget {
  const _CartTotal({super.key});

  @override
  Widget build(BuildContext context) {
    final CartModel _cart=(VxState.store as MyStore).cart;
    return SizedBox(
      height: 200,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          VxConsumer(notifications:{},builder: (context,_, __){return "\$${_cart.totalPrice}.".text.xl5.color(Mytheme.darkblue).make();
            },
              mutations: {RemoveMutation}),
          30.widthBox,
          ElevatedButton(
              onPressed: (){
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: "Buying Not Supported Yet".text.make()));
              },
              style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Mytheme.darkblue)),
              child: "Buy".text.make()
          )
        ],
      ),
    );
  }
}

class _CartList extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    VxState.watch(context, on: [RemoveMutation]);
    final CartModel _cart=(VxState.store as MyStore).cart;
    return _cart.items.isEmpty?"Nothing to Show".text.makeCentered():
    ListView.builder(
        itemCount:  _cart.items?.length,
        itemBuilder: (context, index)=>GestureDetector(
          onTap: (){
            Navigator.push(context,
                MaterialPageRoute(builder: (context)=>HomeDetailPage(catalog: _cart.items[index])),
            );
          },
          child: ListTile(
            leading: Icon(Icons.done),
            trailing: IconButton(icon: Icon(Icons.remove_circle_outline),
              onPressed: () {
              RemoveMutation(_cart.items[index]);
              },
            ),
            title: _cart.items[index].name.text.make(),
          ),
        ),

    );
  }
}


