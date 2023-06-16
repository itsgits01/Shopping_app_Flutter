import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final imageURL=
        "https://www.deccanherald.com/sites/dh/files/styles/article_detail/public/article_images/2019/07/07/file75wl3lcdo6s323yga4s-1562485991.jpg?itok=zUHELi8t";

    return Drawer(
      child: Container(
        color: Colors.lightBlue,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              padding: EdgeInsets.zero,
              child: UserAccountsDrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.lightBlue,
                ),
                accountName: Text("Gitesh Ambre",style: TextStyle(color: Colors.white),),
                accountEmail: Text("giteshambre@gmail.com",style: TextStyle(color: Colors.white),),
                currentAccountPicture: CircleAvatar(backgroundImage: NetworkImage(imageURL),),
                margin: EdgeInsets.zero,
              ),
            ),

            ListTile(
              leading: Icon(CupertinoIcons.home,color: Colors.white,),
              title: Text("Home",textScaleFactor: 1.5,style: TextStyle(color: Colors.white),),
            ),

            ListTile(
              leading: Icon(CupertinoIcons.profile_circled,color: Colors.white,),
              title: Text("Profile",textScaleFactor: 1.5,style: TextStyle(color: Colors.white),),
            ),

            ListTile(
              leading: Icon(CupertinoIcons.mail_solid,color: Colors.white,),
              title: Text("Email me",textScaleFactor: 1.5,style: TextStyle(color: Colors.white),),
            )

          ],
        ),
      ),
      elevation: 20,
    );
  }
}
