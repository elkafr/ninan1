
import 'package:flutter/material.dart';
import 'package:ninan1/screens/account/account_screen.dart';
import 'package:ninan1/screens/cart/cart_screen.dart';
import 'package:ninan1/screens/favourite/favourite_screen.dart';
import 'package:ninan1/screens/home/home_screen.dart';
import 'package:ninan1/screens/offers/offers_screen.dart';
import 'package:ninan1/screens/orders/orders_screen.dart';


class NavigationState extends ChangeNotifier {

    int _navigationIndex = 0 ;


  void upadateNavigationIndex(int value ){
    _navigationIndex = value;
    notifyListeners();
  }

  int get navigationIndex => _navigationIndex;


    List<Widget> _screens = [
    HomeScreen(),
      HomeScreen(),
      HomeScreen(),
      HomeScreen(),

      HomeScreen()
  
  ];
  
  Widget get  selectedContent => _screens[_navigationIndex];

}