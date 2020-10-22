import 'package:e_shop/Store/storehome.dart';
import 'package:flutter/material.dart';
import 'login.dart';
import 'login.dart';
import 'register.dart';
import 'package:e_shop/Config/config.dart';

import 'register.dart';


class AuthenticScreen extends StatefulWidget {
  @override
  _AuthenticScreenState createState() => _AuthenticScreenState();
}

class _AuthenticScreenState extends State<AuthenticScreen> {

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          flexibleSpace: Container(
        decoration: new BoxDecoration(
          gradient: new LinearGradient(
            colors: [Color(theme),Color(theme)],
            begin: const FractionalOffset(0.0, 0.0),
            end: const FractionalOffset(1.0, 0.0),
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp,
            ),
           ),
          ),

          title: Text(
            "",
            style: TextStyle(fontSize: 65.0,color: Colors.black,fontFamily: "Signatra"),
          ),

          centerTitle: true,
          bottom: TabBar(labelColor: Colors.black,
            tabs: [
              Tab(
                icon: Icon(Icons.lock, color: Colors.black,),
                text: "Login",
              ),
              Tab(icon: Icon(Icons.perm_contact_calendar, color: Colors.black,),
                text: "Register",
              ),

            ],
            indicatorColor: Colors.black,
            indicatorWeight: 5.0,
          ),
        ),
        body: Container(
          decoration: BoxDecoration(
            gradient: new LinearGradient
              (colors: [Colors.white12, Colors.white12],
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            ),
          ),
          child: TabBarView(
            children: [
              Login(),
              Register(),
            ],
          ),
        ),
      ),
    );
  }
}
