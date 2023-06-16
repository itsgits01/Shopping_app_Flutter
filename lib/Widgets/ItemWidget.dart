import 'package:flutter/material.dart';

import '../Models/catalog.dart';

class ItemWidget extends StatelessWidget {
  final Item item;

  const ItemWidget({super.key, required this.item}):assert(item!=null);

  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: Colors.white70,

      elevation: 10,
      child: ListTile(
        onTap: (){
          print("${item.name} Selected");
        },
        leading: Image.network(item.image),
        title: Text(item.name),
        subtitle: Text(item.desc),
        trailing: Text(textScaleFactor: 1.3,"\$${item.price}",style: TextStyle(color: Colors.lightBlue,fontWeight: FontWeight.bold),),
      ),
    );
  }
}

