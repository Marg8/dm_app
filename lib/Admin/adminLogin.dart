

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_shop/Admin/uploadItems.dart';
import 'package:e_shop/Authentication/authenication.dart';
import 'package:e_shop/Store/storehome.dart';
import 'package:e_shop/Widgets/customTextField.dart';
import 'package:e_shop/DialogBox/errorDialog.dart';
import 'package:flutter/material.dart';




class AdminSignInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            "dm Regalos",
            style: TextStyle(fontSize: 55.0,color: Colors.black,fontFamily: "Signatra"),
          ),
          centerTitle: true,
        ),
      body: AdminSignInScreen(),
    );

  }
}


class AdminSignInScreen extends StatefulWidget {
  @override
  _AdminSignInScreenState createState() => _AdminSignInScreenState();
}

class _AdminSignInScreenState extends State<AdminSignInScreen>
{

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _adminIDTextEditingController = TextEditingController();
  final TextEditingController _passwordTextEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    double _screenWidth = MediaQuery.of(context).size.width, _screenHeigh = MediaQuery.of(context).size.height;

    return SingleChildScrollView(
      child: Container(
        decoration: new BoxDecoration(
          gradient: new LinearGradient(
            colors: [Color(theme),Color(theme)],
            begin: const FractionalOffset(0.0, 0.0),
            end: const FractionalOffset(1.0, 0.0),
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              alignment: Alignment.bottomCenter,
              child: Image.asset("images/dm.png",
                height: 240.0,
                width: 240.0,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text("Admin",
                  style: TextStyle(color: Colors.black, fontSize: 28.0, fontWeight: FontWeight.bold),
              ),
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [

                  CustomTextField(
                    controller: _adminIDTextEditingController,
                    data: Icons.person,
                    hintText: "id",
                    isObsecure: false,
                  ),
                  CustomTextField(
                    controller: _passwordTextEditingController,
                    data: Icons.person,
                    hintText: "Password",
                    isObsecure: true,
                  ),
                ],
              ),
            ),
            SizedBox(height: 70.0,),
            RaisedButton(
              onPressed: () {
                _adminIDTextEditingController.text.isNotEmpty &&
                    _passwordTextEditingController.text.isNotEmpty ?
                loginAdmin(): showDialog(context: context,
                    builder: (c)
                    {
                      return ErrorAlertDialog (message: "Please write email and password.",);
                    }
                );
              },
              color: Colors.black,
              child: Text("Login", style: TextStyle(color: Colors.white),),
            ),
            SizedBox(
              height: 50.0,
            ),
            Container(
              height: 4.0,
              width: _screenWidth * 0.8,
              color: Colors.black,
            ),
            SizedBox(
              height: 10.0,
            ),
            FlatButton.icon(
              onPressed: () =>
                  Navigator.push(context, MaterialPageRoute(builder: (context) => AuthenticScreen())),
              icon: (Icon(Icons.nature_people, color: Colors.black,)),
              label: Text("i'm not admin", style: TextStyle(
                  color: Colors.black, fontWeight: FontWeight.bold),),
            ),
            SizedBox(
              height: 50.0,
            ),
          ],
        ),
      ),
    );
  }

  loginAdmin()
  {
    Firestore.instance.collection("admins").getDocuments().then((snapshot){
      snapshot.documents.forEach((result){
        if(result.data["id"] != _adminIDTextEditingController.text.trim())
          {
            Scaffold.of(context).showSnackBar(SnackBar(content: Text("your id is not correct."),));
          }
        else if(result.data["password"] != _passwordTextEditingController.text.trim())
        {
          Scaffold.of(context).showSnackBar(SnackBar(content: Text("your password is not correct."),));
        }
        else
          {
            Scaffold.of(context).showSnackBar(SnackBar(content: Text("Welcome Big Boss." + result.data["name"]),));

            setState(() {
              _adminIDTextEditingController.text = "";
              _passwordTextEditingController.text = "";
            });
            Route route = MaterialPageRoute(builder: (c) => UploadPage());
            Navigator.pushReplacement(context, route);
          }
      });
    });
  }
}
