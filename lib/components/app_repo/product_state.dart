import 'package:flutter/material.dart';
import 'package:ninan1/models/product.dart';

class ProductState extends ChangeNotifier {


    Product _currentProduct;

  void setCurrentProduct(Product product) {
    _currentProduct = product;
    notifyListeners();
  }

  Product get currentProduct => _currentProduct;


}