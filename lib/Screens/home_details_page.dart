import 'package:first_app/Widgets/themes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:velocity_x/velocity_x.dart';
import '../Models/catalog.dart';

class HomeDetailPage extends StatefulWidget {
  final Item catalog;

  const HomeDetailPage({Key? key, required this.catalog}) : super(key: key);

  @override
  _HomeDetailPageState createState() => _HomeDetailPageState();
}

class _HomeDetailPageState extends State<HomeDetailPage> {
  double _scale = 1.0;
  double _previousScale = 1.0;

  void _shareItem() {
    Share.share('Check out this item: ${widget.catalog.name}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        leading: IconButton(
          icon: const Icon(CupertinoIcons.back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          IconButton(onPressed: _shareItem, icon: const Icon(Icons.share),iconSize: 32,),
        ],
      ),
      bottomNavigationBar: ButtonBar(
        alignment: MainAxisAlignment.spaceEvenly,
        buttonPadding: EdgeInsets.zero,
        children: [
          "\$${widget.catalog.price}".text.bold.xl4.red800.make(),
          ElevatedButton(
            onPressed: () {},
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Mytheme.darkblue),
              shape: MaterialStateProperty.all(StadiumBorder()),
            ),
            child: "Add to cart".text.make(),
          ).wh(120, 50),
        ],
      ).p16(),
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            GestureDetector(
              onScaleStart: (ScaleStartDetails details) {
                _previousScale = _scale;
                setState(() {});
              },
              onScaleUpdate: (ScaleUpdateDetails details) {
                _scale = _previousScale * details.scale;
                setState(() {});
              },
              onScaleEnd: (ScaleEndDetails details) {
                _previousScale = 1.0;
                setState(() {});
              },
              child: Hero(
                tag: Key(widget.catalog.id.toString()),
                child: Transform.scale(
                  scale: _scale,
                  child: Image.network(widget.catalog.image),
                ),
              ),
            ).h32(context),
            Expanded(
              child: VxArc(
                height: 30.0,
                arcType: VxArcType.convey,
                edge: VxEdge.top,
                child: Container(
                  color: Mytheme.creamColor,
                  width: context.screenWidth,
                  child: Column(
                    children: [
                      widget.catalog.name.text.xl4.bold.color(Mytheme.darkblue).make(),
                      widget.catalog.desc.text.xl.textStyle(context.captionStyle).make(),
                      10.heightBox,
                      generateDummyText(paragraphs: 1).text.textStyle(context.captionStyle).make().p16(),
                    ],
                  ).py64(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


String generateDummyText({int paragraphs = 1}) {
  const loremIpsumText =
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. '
      'Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. '
      'Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.';

  final List<String> paragraphsList = List<String>.generate(paragraphs, (_) => loremIpsumText);
  return paragraphsList.join('\n\n');
}
