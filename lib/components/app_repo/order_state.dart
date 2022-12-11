import 'package:flutter/material.dart';
import 'package:ninan1/models/order.dart';


class OrderState extends ChangeNotifier {


  //   Order _currentOrder;

  // void setCurrentOrder(Order order) {
  //   _currentOrder = order;
  //   notifyListeners();
  // }

  // Order get currentOrder => _currentOrder;

   String _carttFatora;

  void setCarttFatora(String carttFatora) {
    _carttFatora = carttFatora;
    notifyListeners();
  }

  String get carttFatora => _carttFatora;


   String _carttSeller;

  void setCarttSeller(String carttSeller) {
    _carttSeller = carttSeller;
    notifyListeners();
  }

  String get carttSeller => _carttSeller;



  bool _waitingOrder = false;

  void setIsWaitingOrder(bool  value) {
    _waitingOrder = value;
    notifyListeners();
  }

  bool get isWaitingOrder => _waitingOrder;

  // void increaseAmountProduct(int index){
  //   _currentOrder.carttDetails[index].carttAmount++;
  //   notifyListeners();
  // }

  // void decreaseAmountProduct(int index){
  //   _currentOrder.carttDetails[index].carttAmount--;
  //   notifyListeners();
  // }

}