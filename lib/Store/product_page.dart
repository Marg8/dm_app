import 'dart:ui';

import 'package:e_shop/Store/storehome.dart';

import 'package:e_shop/Widgets/customAppBar.dart';
import 'package:e_shop/Widgets/myDrawer.dart';
import 'package:e_shop/Models/item.dart';
import 'package:flutter/material.dart';
import 'storehome.dart';


class ProductPage extends StatefulWidget
{
  final ItemModel itemModel;
  ProductPage({this.itemModel});
  @override
  _ProductPageState createState() => _ProductPageState();
}



class _ProductPageState extends State<ProductPage> {
  @override
  Widget build(BuildContext context)
  {
    Size screenSize = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: MyAppBar(),
        drawer: MyDrawer(),
        body: ListView(
          children: [
            Container(
              padding: EdgeInsets.all(8.0),
              width: MediaQuery.of(context).size.width,
              color: Colors.grey.shade200,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      Center(
                        child: Container(
                            child: Image.network(widget.itemModel.thumbnailUrl,),
                          width: 350,
                          height: 350,
                        ),
                      ),
                      Container(
                        color: Colors.grey[300],
                        child: SizedBox(
                          height: 1.0,
                          width: double.infinity,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.all(20.0),
                    child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          Text(
                            widget.itemModel.title,
                            style: boldTextStyle,
                          ),
                          SizedBox(
                            height: 10.0,
                          ),

                          Text(
                            widget.itemModel.longDescription,

                          ),
                          SizedBox(
                            height: 10.0,
                          ),

                          Text(
                            r"$" + widget.itemModel.price.toString() + " MXN",
                            style: boldTextStyle,

                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                        ],
                      ),
                    ),
                  ),
                  OnClickforAddToCart(widget: widget),
                  MultipleOptions(),

                ],
              ),
            ),
          ],
        ),

        ),
      );

  }

}

class OnClickforAddToCart extends StatelessWidget {
  const OnClickforAddToCart({
    Key key,
    @required this.widget,
  }) : super(key: key);

  final ProductPage widget;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(top: 8.0),
      child: Center(
        child: InkWell(
          onTap: () => checkItemInCart(widget.itemModel.shortInfo, context),
          child: AddToCartBottom(),
        ),
      ),
    );
  }
}

class MultipleOptions extends StatelessWidget {
  const MultipleOptions({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(40),
        topRight: Radius.circular(40),
      ),
      color: Colors.white,
      elevation: 10,
      child: Padding(
        padding: const EdgeInsets.only(
            top: 20, bottom: 0, left: 36, right: 36
        ),
        child: Column(
          children: <Widget>[
            TouchPill(),
            SizedBox(height: 16),
            Container(
              child: Text("Opcion de Colores"),
            ),
            SizedBox(height: 30),
            //controls
            Row(
              children:<Widget> [
                Expanded(
                  child: Option(),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: PurchaseCount(),
                ),
              ],
            ),
            SizedBox(height: 30),

          ],
        ),
      ),
    );
  }
}

class AddToCartBottom extends StatelessWidget {
  const AddToCartBottom({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width:150,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(48),
          gradient: LinearGradient(
              colors: [Colors.lightBlue, Colors.blueAccent],
          ),
        ),
        child: Text("Add to Cart", style: TextStyle(color: Colors.white, fontSize: 20),
        textAlign: TextAlign.center,),
      ),
    );
  }
}
class TouchPill extends StatelessWidget {
  const TouchPill({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 8,
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}

class PurchaseCount extends StatelessWidget {
  const PurchaseCount({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        border: Border.all(
          color: Colors.grey.shade300,
          width: 2,
        ),
      ),
      child: Row(
        children:<Widget> [
          CountButton(
            width: 52,
            height: 52,
            icon: Icons.remove,
          ),
          Expanded(
            child: Text("1",textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
          ),
          CountButton(
            width: 52,
            height: 52,
            icon: Icons.add,
          ),
        ],
      ),
    );
  }
}

class Option extends StatelessWidget {
  const Option({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        border: Border.all(
          color: Colors.grey.shade300,
          width: 2,
        ),
      ),
      child: Row(
        children:<Widget> [
          SizedBox(width: 8),
          Expanded(
            child: Text(
              "Termico",
              style: TextStyle(
                  color: Colors.grey,fontSize: 20
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              Icons.arrow_drop_down,
            ),
          ),
        ],
      ),
    );
  }
}

class CountButton extends StatelessWidget {
  const CountButton({
    Key key,
    this.width,
    this.height,
    this.icon,
  }) : super(key: key);

  final double width;
  final double height;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.grey.shade300,
      ),
      child: Center(
        child: Icon(
          icon,
          color: Colors.grey,
        ),
      ),
    );
  }
}


const boldTextStyle = TextStyle(fontWeight: FontWeight.bold, fontSize: 20);
const largeTextStyle = TextStyle(fontWeight: FontWeight.normal, fontSize: 20);
