import 'package:flutter/material.dart';
import 'package:rawaqsouq/models/category.dart';

class HomeState extends ChangeNotifier{

    List<Category> _categoriesList;

  void setCategoriesList(List<Category> categoriesList) {
    _categoriesList = categoriesList;
    notifyListeners();
  } 

  List<Category> get categoriesList => _categoriesList;


  Category  _lastSelectedCategory ;

  void setLastSelectedCategory(Category category){
        _lastSelectedCategory = category;
    notifyListeners();
  } 

  Category  get lastSelectedCategory => _lastSelectedCategory;

  void updateChangesOnCategoriesList(int index ){ 
    if(lastSelectedCategory != null){
  _lastSelectedCategory.isSelected = false;
    }
  _categoriesList[index].isSelected = true;
  _lastSelectedCategory = _categoriesList[index];
    notifyListeners();
  }


  //  Future<List<Sacrifice>> _sacrificesList;

  // void setSacrificesList(Future<List<Sacrifice>> sacrificesList) {
  //   _sacrificesList = sacrificesList;
  //   // notifyListeners();
  // } 

  // Future<List<Sacrifice>> get sacrificesList => _sacrificesList;
}