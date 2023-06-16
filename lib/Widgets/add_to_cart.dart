import 'package:first_app/Widgets/themes.dart';
import 'package:first_app/core/store.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';


import '../Models/cart.dart';
import '../Models/catalog.dart';

class AddtoCart extends StatelessWidget {
  final Item catalog;
  AddtoCart({super.key,required this.catalog});

  @override
  Widget build(BuildContext context) {
    VxState.watch(context,on:[AddMutation,RemoveMutation]);
    final CartModel _cart=(VxState.store as MyStore).cart;

    bool isInCart=_cart.items.contains(catalog) ?? false;
    return  ElevatedButton(
        onPressed: (){


          if(!isInCart) {
            AddMutation(catalog);
          }
        },
        style: ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(Mytheme.darkblue),
            shape: MaterialStatePropertyAll(StadiumBorder())
        ),
        child: isInCart ? Icon(Icons.done): Icon(CupertinoIcons.cart_badge_plus),
    );
  }
}
