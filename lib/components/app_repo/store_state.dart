import 'package:flutter/material.dart';
import 'package:ninan1/models/store.dart';
import 'package:ninan1/services/access_api.dart';

class StoreState extends ChangeNotifier {
  Services _services = Services();
// to show details
  Store _currentStore;

  void setCurrentStore(Store store) {
    _currentStore = store;
    notifyListeners();
  }

  Store get currentStore => _currentStore;


  Map<String, int> _isFavouriteList = Map<String, int>();

  setIsFavourite(String id, int value) {
      _isFavouriteList[id] = value;
      notifyListeners();
  }

  void updateChangesOnFavouriteList(String id) {
   if(isFavouriteList[id] == 1){
     isFavouriteList[id] = 0;
   }else{
       isFavouriteList[id] = 1;
   }
    notifyListeners();
  }

  Map<String, int> get isFavouriteList => _isFavouriteList;


 String _currentStoreId;

  void setCurrentStoreId(String id) {
    _currentStoreId = id;
    notifyListeners();
  }

  String get currentStoreId => _currentStoreId;
  

   String _currentStoreTitle;

  void setCurrentStoreTitle(String title) {
    _currentStoreTitle = title;
    notifyListeners();
  }

  String get currentStoreTitle => _currentStoreTitle;


  // is_add_to_cart provider
  int _isAddToCart;
  void setCurrentIsAddToCart(int isAddToCart) {
    _isAddToCart= isAddToCart;
    notifyListeners();
  }
  int get isAddToCart => _isAddToCart;

  Future<String> getStoreCharge() async {
    final response =
    await _services.get(
        'https://ninanapp.com/app/api/mtger_portfolio?mtger_id=${_currentStore.mtgerId}');
    String aboutApp = '';
    if (response['response'] == '1') {
      aboutApp = response['details']['mtger_charge'];
    }
    return aboutApp;
  }

  Future<String> getStoreChargeState() async {
    final response =
    await _services.get(
        'https://ninanapp.com/app/api/mtger_portfolio?mtger_id=${_currentStore.mtgerId}');
    String aboutApp = '';
    if (response['response'] == '1') {
      aboutApp = response['details']['mtger_charge']+","+response['details']['setting_cancel_active'];
    }
    return aboutApp;
  }



  void  updateMtgerEmail(String newMtgerEmail){
    _currentStore.mtgerEmail = newMtgerEmail;
    notifyListeners();
  }

  void  updateMtgerPhone(String newMtgerPhone){
    _currentStore.mtgerPhone = newMtgerPhone;
    notifyListeners();
  }

  void  updateMtgerName(String newMtgerName){
    _currentStore.mtgerName = newMtgerName;
    notifyListeners();
  }

  void  updateMtgerState(String newMtgerState){
    _currentStore.mtgerState = newMtgerState;
    notifyListeners();
  }


}
