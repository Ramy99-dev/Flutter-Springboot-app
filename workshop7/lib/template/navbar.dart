

import 'package:flutter/material.dart';

class NavBar extends StatelessWidget implements PreferredSizeWidget {
  String navTitle ;
  NavBar(this.navTitle);
  @override



  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.pinkAccent,
      title : Text(navTitle),
      actions: [
        IconButton(icon:Icon(Icons.logout),onPressed: (){
            Navigator.of(context).popAndPushNamed('/login');
        },)
      ],
    );
  }
  Size get preferredSize => const Size.fromHeight(60);
}
