import 'package:flutter/foundation.dart';
import 'package:e_shop/Config/config.dart';
import 'package:flutter/material.dart';

import '../Admin/adminOrderCard.dart';
import '../Config/config.dart';
import '../Config/config.dart';

class CartItemCounter extends ChangeNotifier

{
  int _counter = EcommerceApp.sharedPreferences.getStringList(EcommerceApp.userCartList).length-1;
  int get count => _counter;

  Future<void> displayResult() async

  {
    int _counter = EcommerceApp.sharedPreferences.getStringList(EcommerceApp.userCartList).length-1;

    await Future.delayed(const Duration(microseconds: 100),(){
      notifyListeners() ;
    });
  }

}