import 'package:flutter/material.dart';
import 'colors.dart';
import 'login_screen.dart';
import 'constant.dart';

class DrawerMenu extends StatefulWidget {
  const DrawerMenu({Key? key}) : super(key: key);

  @override
  State<DrawerMenu> createState() => _DrawerMenuState();
}

class _DrawerMenuState extends State<DrawerMenu> {
  @override
  Widget build(BuildContext context) {
    late String email;
    late String user;
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
           primaryColor,Colors.blue,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: ListView(
          children: [
            const UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage(
                  "https://images.pexels.com/photos/6829574/pexels-photo-6829574.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"
                ),
              ),
              decoration: BoxDecoration(
                color: Colors.transparent,
              ),
                accountName: Text("UserName"), accountEmail: Text("Email-Id"
            )
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: MenuList(title: "orders",iconName: Icons.border_color,onTap: (){}),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: MenuList(title: "Address",iconName: Icons.bookmark,onTap: (){}),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: MenuList(title: "Notification",iconName: Icons.notifications,onTap: (){}),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: MenuList(title: "Help",iconName: Icons.help,onTap: (){},),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: MenuList(title: "About",iconName: Icons.account_box,onTap: (){},),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: MenuList(title: "Rate Us",iconName: Icons.star_half,onTap:(){}, ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: MenuList(title: "Log Out",iconName: Icons.exit_to_app,onTap: (){

              }
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class MenuList extends StatelessWidget {
  String title;
  IconData iconName;
  dynamic onTap;
  MenuList({
    required this.title, required this.iconName , required this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: (){

      },
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white24,
        ),
        child:Icon(
          iconName,
          color: Colors.white,
          size: 25,
        ),
        ),
      title: Text( title ,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 18,
        fontWeight: FontWeight.bold
      ),),
      );
  }
}
