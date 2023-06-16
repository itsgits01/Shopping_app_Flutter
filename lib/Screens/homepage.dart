import 'package:first_app/Models/cart.dart';
import 'package:first_app/Models/catalog.dart';
import 'package:first_app/Screens/home_details_page.dart';
import 'package:first_app/Widgets/drawer.dart';
import 'package:first_app/Widgets/themes.dart';
import 'package:first_app/core/store.dart';
import 'package:first_app/utils/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import '../Widgets/ItemWidget.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:share/share.dart';
import '../Widgets/add_to_cart.dart';
import 'package:http/http.dart' as http;

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  bool isLoading = true;

  final url = '''https://api.jsonbin.io/b/604dbddb683e7e079c4eefd3''';

  @override
  void initState() {
    super.initState();
    loadData();
  }

  loadData() async {
    await Future.delayed(Duration(seconds: 2));
    final catalogJson =
    await rootBundle.loadString("assets/files/catalog.json");

    // final response = await http.get(Uri.parse(url));
    //
    // final catalogJson=response.body;


    final decodedData = jsonDecode(catalogJson);
    var productsData = decodedData["products"];
    CatalogModel.items = List.from(productsData)
        .map<Item>((item) => Item.fromMap(item))
        .toList();
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final _cart=(VxState.store as MyStore).cart;
    return Scaffold(


      floatingActionButton: VxBuilder(
        builder:(context,_,__)=> FloatingActionButton(
          onPressed: ()=> Navigator.pushNamed(context, MyRoutes.cartRoute),
          backgroundColor: Mytheme.darkblue,
        child: Icon(CupertinoIcons.cart),
        ).badge(color: Vx.red500,size: 20,count: _cart.items.length,textStyle: TextStyle(color: Colors.black,fontWeight: FontWeight.bold)), mutations: {AddMutation,RemoveMutation},
      ),
      body: SafeArea(
        child: Container(
          padding: Vx.m32,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CatalogHeader(),
              if(CatalogModel.items!=null && CatalogModel.items.isNotEmpty)
                CatalogList().expand()
              else
                CircularProgressIndicator().centered().expand(),
            ],
          ),
        ),
      ),
    );
  }
}

class CatalogHeader extends StatelessWidget {
  const CatalogHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        "Catalog App".text.xl5.bold.color(Mytheme.darkblue).make(),
        "Trending Products".text.xl2.make(),
        SearchBar1(),
      ],
    );
  }
}

class CatalogList extends StatelessWidget {
  const CatalogList({super.key});

  @override
  Widget build(BuildContext context) {
    return !context.isMobile?GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        shrinkWrap: true,
        itemCount: CatalogModel.items.length,
        itemBuilder: (context, index){
          final catalog=CatalogModel.items[index];
          return InkWell(
            onTap: ()=> Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context)=>HomeDetailPage(
                        catalog: catalog))),
            child: CatalogItem(catalog: catalog),
          );
        }
    ):
    ListView.builder(
      shrinkWrap: true,
        itemCount: CatalogModel.items.length,
        itemBuilder: (context, index){
          final catalog=CatalogModel.items[index];
          return InkWell(
            onTap: ()=> Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context)=>HomeDetailPage(
                        catalog: catalog))),
            child: CatalogItem(catalog: catalog),
          );
        }
    );
  }
}

class CatalogItem extends StatelessWidget {
  final Item catalog;

  const CatalogItem({super.key, required this.catalog});

  @override
  Widget build(BuildContext context) {
    return VxBox(
      child: Row(
        children: [
          Hero(
            tag: Key(catalog.id.toString()),
            child: CatalogImage(image: catalog.image)),
        Expanded(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            catalog.name.text.lg.bold.color(Mytheme.darkblue).make(),
            catalog.desc.text.textStyle(context.captionStyle).make(),
            10.heightBox,
            ButtonBar(
              alignment: MainAxisAlignment.spaceEvenly,
              buttonPadding: EdgeInsets.zero,
              children: [
                "\$${catalog.price}".text.bold.xl.make(),
                AddtoCart(catalog: catalog)
              ],
            )
          ],
        ))
      ]
      ),
    ).white.roundedLg.square(150).make().py12();
  }
}

class CatalogImage extends StatelessWidget {
  final String image;
  const CatalogImage({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Image.network(image
    ).box.rounded.make().p16().wPCT(context: context, widthPCT: context.isMobile?40 : 20);
  }
}

class SearchBar1 extends StatelessWidget {
  const SearchBar1({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: 'Search Products',
        prefixIcon: Icon(Icons.search),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      onChanged: (value){

      },
    );
  }
}







