import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_shop/Admin/adminShiftOrders.dart';
import 'package:e_shop/Store/storehome.dart';
import 'package:e_shop/Widgets/loadingWidget.dart';
import 'package:e_shop/main.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image/image.dart' as ImD;


class UploadPage extends StatefulWidget
{
  @override
  _UploadPageState createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> with AutomaticKeepAliveClientMixin<UploadPage>
{
  bool get wantKeepAlive => true;
  File file;
  TextEditingController _descriptionTextEditingController = TextEditingController();
  TextEditingController _priceTextEditingController = TextEditingController();
  TextEditingController _titleTextEditingController = TextEditingController();
  TextEditingController _shortInfoTextEditingController = TextEditingController();
  String productId = DateTime.now().millisecondsSinceEpoch.toString();
  bool uploading = false;

  @override
  Widget build(BuildContext context) {
    return file == null ? displayAdminHomeScreen() : displayAdminUploadFormScreem();
  }

  displayAdminHomeScreen() {
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
        leading: IconButton(
          icon: Icon(Icons.border_color, color: Colors.black,),
          onPressed: () {
            Route route = MaterialPageRoute(builder: (c) => AdminShiftOrders());
            Navigator.push(context, route);
          },
        ),

        actions: [
          FlatButton(
            child: Text("Logout", style: TextStyle(color: Colors.black,
              fontSize: 16.0,
              fontWeight: FontWeight.bold,),),
            onPressed: () {
              Route route = MaterialPageRoute(builder: (c) => SplashScreen());
              Navigator.push(context, route);
            },
          ),
        ],
      ),
      body: getAdminHomeScreenBody(),
    );
  }

  getAdminHomeScreenBody() {
    return Container(
      decoration: new BoxDecoration(
        gradient: new LinearGradient(
          colors: [Color(theme),Color(theme)],
          begin: const FractionalOffset(0.0, 0.0),
          end: const FractionalOffset(1.0, 0.0),
          stops: [0.0, 1.0],
          tileMode: TileMode.clamp,
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.shop_two, color: Colors.black, size: 200.0,),
            Padding(
              padding: EdgeInsets.only(top: 20.0),
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(9.0)),
                child: Text("Add New Product",
                  style: TextStyle(fontSize: 20.0, color: Colors.white),),
                color: Colors.black,
                onPressed: () => takeImage(context),
              ),
            )
          ],
        ),
      ),
    );
  }

  takeImage(mContext) {
    return showDialog(
        context: mContext,
        builder: (con) {
          return SimpleDialog(
            title: Text("Item Image", style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold),),
            children: [
              SimpleDialogOption(
                child: Text("Capture with Camera", style: TextStyle(
                  color: Colors.black, fontWeight: FontWeight.bold,)),
                onPressed: capturePhotoWithCamera,
              ),
              SimpleDialogOption(
                child: Text("Select from Galery", style: TextStyle(
                  color: Colors.black, fontWeight: FontWeight.bold,)),
                onPressed: pickPhotoFromGalery,
              ),
              SimpleDialogOption(
                child: Text("Cancel", style: TextStyle(
                  color: Colors.black, fontWeight: FontWeight.bold,)),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        }
    );
  }

  capturePhotoWithCamera() async
  {
    Navigator.pop(context);
    File imageFile = await ImagePicker.pickImage(
        source: ImageSource.camera, maxHeight: 680.0, maxWidth: 970.0);

    setState(() {
      file = imageFile;
    });
  }

  pickPhotoFromGalery() async
  {
    Navigator.pop(context);
    File imageFile = await ImagePicker.pickImage(source: ImageSource.gallery,);

    setState(() {
      file = imageFile;
    });
  }

  displayAdminUploadFormScreem()
  {
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
       leading: IconButton(icon: Icon(Icons.arrow_back, color: Colors.black,),
       onPressed: clearFormInfo),
       title: Text("New Product", style: TextStyle(color: Colors.black, fontSize: 24.0, fontWeight: FontWeight.bold,),),
       actions: [
         FlatButton(
           onPressed: uploading ? null : () => uploadImageAndSaveItemInfo(),
           child: Text("Add", style: TextStyle(color: Colors.black, fontSize: 16.0, fontWeight: FontWeight.bold,),),
         )
       ],
     ),
     body: ListView(
       children: [
         uploading ? linearProgress() : Text(""),
         Container(
           height: 230.0,
           width: MediaQuery.of(context).size.width * 0.8,
           child: Center(
             child: AspectRatio(
               aspectRatio: 16/9,
               child: Container(
                 decoration: BoxDecoration(image: DecorationImage(image: FileImage(file), fit: BoxFit.cover)),
               ),
             ),
           ),
         ),
         Padding(padding: EdgeInsets.only(top: 12.0)),

         ListTile(
           leading: Icon(Icons.perm_device_information, color: Colors.black,),
           title: Container(
             width: 250.0,
             child: TextField(
               style: TextStyle(color: Colors.black),
               controller: _shortInfoTextEditingController,
               decoration: InputDecoration(
                 hintText: "short Info",
                 hintStyle: TextStyle(color: Colors.grey),
                 border: InputBorder.none,
               ),
             ),
           ),
         ),
         Divider(color: Colors.black,),

         ListTile(
           leading: Icon(Icons.perm_device_information, color: Colors.black,),
           title: Container(
             width: 250.0,
             child: TextField(
               style: TextStyle(color: Colors.black),
               controller: _titleTextEditingController,
               decoration: InputDecoration(
                 hintText: "Title",
                 hintStyle: TextStyle(color: Colors.grey),
                 border: InputBorder.none,
               ),
             ),
           ),
         ),
         Divider(color: Colors.black,),

         ListTile(
           leading: Icon(Icons.perm_device_information, color: Colors.black,),
           title: Container(
             width: 250.0,
             child: TextField(
               style: TextStyle(color: Colors.black),
               controller: _descriptionTextEditingController,
               decoration: InputDecoration(
                 hintText: "description",
                 hintStyle: TextStyle(color: Colors.grey),
                 border: InputBorder.none,
               ),
             ),
           ),
         ),
         Divider(color: Colors.black,),

         ListTile(
           leading: Icon(Icons.perm_device_information, color: Colors.black,),
           title: Container(
             width: 250.0,
             child: TextField(
               keyboardType: TextInputType.number,
               style: TextStyle(color: Colors.black),
               controller: _priceTextEditingController,
               decoration: InputDecoration(
                 hintText: "price",
                 hintStyle: TextStyle(color: Colors.grey),
                 border: InputBorder.none,
               ),
             ),
           ),
         ),
         Divider(color: Colors.black,),
       ],

     ),
   );
  }

  clearFormInfo()
  {
    setState(() {
      file = null;
      _descriptionTextEditingController.clear();
      _titleTextEditingController.clear();
      _priceTextEditingController.clear();
      _descriptionTextEditingController.clear();
    });
  }

  uploadImageAndSaveItemInfo()async
  {
    setState(() {
      uploading = true;
    });

    String imageDownloadUrl =  await uploadItemImage(file);

    saveItemInfo(imageDownloadUrl);
  }
  Future<String> uploadItemImage(mFileImage) async
  {
    final StorageReference storageReference =  FirebaseStorage.instance.ref().child("Items");
    StorageUploadTask uploadTask = storageReference.child("Product_$productId.jpg").putFile(mFileImage);
    StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
    String downloadUrl = await taskSnapshot.ref.getDownloadURL();
    return downloadUrl;
  }
  saveItemInfo(String downloadUrl)
  {
    final itemsRef = Firestore.instance.collection("items");
    itemsRef.document(productId).setData({
      "shortInfo": _shortInfoTextEditingController.text.trim(),
      "longDescription": _descriptionTextEditingController.text.trim(),
      "price": int.parse(_priceTextEditingController.text),
      "publishedDate": DateTime.now(),
      "status": "available",
      "thumbnailUrl": downloadUrl,
      "title": _titleTextEditingController.text.trim(),
    });
    setState(() {
      file = null;
      uploading = false;
      productId =DateTime.now().millisecondsSinceEpoch.toString();
      _descriptionTextEditingController.clear();
      _titleTextEditingController.clear();
      _priceTextEditingController.clear();
      _descriptionTextEditingController.clear();
    });
  }
}