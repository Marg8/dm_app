import 'package:e_shop/Config/config.dart';
import 'package:e_shop/Widgets/customAppBar.dart';
import 'package:e_shop/Models/address.dart';
import 'package:e_shop/Widgets/myDrawer.dart';
import 'package:flutter/material.dart';

class AddAddress extends StatelessWidget
{
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final cName = TextEditingController();
  final cPhoneNumber = TextEditingController();
  final cFlatHomeNumber = TextEditingController();
  final cCity = TextEditingController();
  final cState = TextEditingController();
  final cPinCode = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: scaffoldKey,
        appBar: MyAppBar(),
        drawer: MyDrawer(),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: ()
          {
            if(formKey.currentState.validate())
              {
                final model = AddressModel(
                  name: cName.text.trim(),
                  state: cState.text.trim(),
                  pincode: cPinCode.text,
                  phoneNumber: cPhoneNumber.text,
                  flatNumber: cFlatHomeNumber.text,
                  city: cCity.text.trim(),
                ).toJson();

                //add to firebase
                EcommerceApp.firestore.collection(EcommerceApp.collectionUser)
                .document(EcommerceApp.sharedPreferences.getString(EcommerceApp.userUID))
                .collection(EcommerceApp.subCollectionAddress)
                .document(DateTime.now().millisecondsSinceEpoch.toString())
                .setData(model)
                .then((value) {
                  final snack = SnackBar(content: Text("New Address added successfully."));
                  scaffoldKey.currentState.showSnackBar(snack);
                  FocusScope.of(context).requestFocus(FocusNode());
                  formKey.currentState.reset();
                });


              }
          },
          label: Text("Done"),
          backgroundColor: Colors.black,
          icon: Icon(Icons.check),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Add New Address",
                    style: TextStyle(color: Colors.black, fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Form(
                key: formKey,
                child: Column(
                  children: [
                    MyTextField(
                      hint: "Name",
                      controller: cName,
                    ),
                    Divider(
                      height: 10.0,
                      color: Colors.black,
                    ),
                    MyTextField(
                      hint: "Phone Number",
                      controller: cPhoneNumber,
                    ),
                    Divider(
                      height: 10.0,
                      color: Colors.black,
                    ),
                    MyTextField(
                      hint: "Flat Number / House Number",
                      controller: cFlatHomeNumber,
                    ),
                    Divider(
                      height: 10.0,
                      color: Colors.black,
                    ),
                    MyTextField(
                      hint: "City",
                      controller: cCity,
                    ),
                    Divider(
                      height: 10.0,
                      color: Colors.black,
                    ),
                    MyTextField(
                      hint: "State/Country",
                      controller: cState,
                    ),
                    Divider(
                      height: 10.0,
                      color: Colors.black,
                    ),
                    MyTextField(
                      hint: "Pin Code",
                      controller: cPinCode,
                    ),
                    Divider(
                      height: 10.0,
                      color: Colors.black,
                    ),

                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class MyTextField extends StatelessWidget
{
  final String hint;
  final TextEditingController controller;

  MyTextField({Key key, this.hint, this.controller,}) : super (key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration.collapsed(hintText: hint),
        validator: (val) => val.isEmpty ? "Field can not be empty" : null,
      ),

    );
  }
}
