



import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ninan1/components/app_repo/location_state.dart';
import 'package:ninan1/components/gradient_app_bar/gradient_app_bar.dart';
import 'package:ninan1/models/cart_details.dart';
import 'package:ninan1/screens/store/add_product_screen.dart';
import 'package:ninan1/screens/store/cats_screen.dart';
import 'package:ninan1/screens/store/edit_product_screen.dart';
import 'package:ninan1/screens/store/store_screen.dart';
import 'package:provider/provider.dart';
import 'package:ninan1/components/app_repo/app_state.dart';
import 'package:ninan1/components/app_repo/navigation_state.dart';
import 'package:ninan1/components/app_repo/product_state.dart';
import 'package:ninan1/components/app_repo/store_state.dart';
import 'package:ninan1/components/app_repo/progress_indicator_state.dart';
import 'package:ninan1/components/buttons/custom_button.dart';
import 'package:ninan1/components/connectivity/network_indicator.dart';
import 'package:ninan1/components/no_data/no_data.dart';
import 'package:ninan1/components/progress_indicator_component/progress_indicator_component.dart';
import 'package:ninan1/components/response_handling/response_handling.dart';
import 'package:ninan1/locale/localization.dart';
import 'package:ninan1/models/category.dart';
import 'package:ninan1/models/product.dart';
import 'package:ninan1/screens/store/components/store_appbar.dart';
import 'package:ninan1/components/safe_area/page_container.dart';
import 'package:ninan1/components/app_repo/store_state.dart';
import 'package:ninan1/services/access_api.dart';
import 'package:ninan1/utils/app_colors.dart';

class ProductsScreen extends StatefulWidget {
  @override
  _ProductsScreenState createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  bool _initialRun = true;
  double _height, _width;
  StoreState _storeState;
  AppState _appState;
  LocationState _locationState;
  ProductState _productState;
  Services _services = Services();
  Future<List<Category>> _categoriesList;
  Future<List<Product>> _productList;
  ProgressIndicatorState _progressIndicatorState;
  NavigationState _navigationState;
  Future<List<CartDetails>> _cartDetails;





  Future<List<Product>> _getProducts(String categoryId) async {
    Map<String, dynamic> results = await _services.get(
        'https://ninanapp.com/app/api/mtger_mtger_ads?lang=${_appState.currentLang}&page=1&mtger_id=${_storeState.currentStore.mtgerId}');
    List<Product> productList = List<Product>();
    if (results['response'] == '1') {
      Iterable iterable = results['results'];
      productList = iterable.map((model) => Product.fromJson(model)).toList();
    } else {
      print('error');
    }
    return productList;
  }






  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_initialRun) {
      _storeState = Provider.of<StoreState>(context);
      _appState = Provider.of<AppState>(context);
      _productState = Provider.of<ProductState>(context);
      _locationState = Provider.of<LocationState>(context);
      _productList = _getProducts('0');
      _initialRun = false;
    }
  }



  Widget _buildProducts() {
    return LayoutBuilder(builder: (context, constraints) {
      return FutureBuilder<List<Product>>(
        future: _productList,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.length > 0) {
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(

                      padding: EdgeInsets.only(top: 20,right: 10,left: 10),
                      margin: EdgeInsets.only(
                          top: 10,
                          left: 12,
                          right: 12,
                          bottom:
                          index == snapshot.data.length - 1 ? 20 : 0),
                      decoration: BoxDecoration(

                          color: Color(0xffF9F9F9),
                          borderRadius: BorderRadius.circular(
                            10.0,
                          )),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[


                          Container(


                            padding: EdgeInsets.symmetric(horizontal: 10),

                            child: Image.network(
                              snapshot.data[index].adsMtgerPhoto,
                              width:
                              _width*.25,
                              height: _width*.25,
                              fit: BoxFit.fill,
                            ),
                          ),
                          Spacer(),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                padding:
                                EdgeInsets.only(bottom: 10, right: 10 ,left: 10),
                                child: Text(
                                  snapshot.data[index].adsMtgerName,
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400,
                                      color: cText

                                  ),
                                ),
                              ),

                              Container(
                                width: _width*.55,
                                padding:
                                EdgeInsets.only(bottom: 10, right: 10 ,left: 10),
                                child: Text(
                                  snapshot.data[index].adsMtgerDetails,
                                  maxLines: 2,
                                  style: TextStyle(
                                      fontSize: 13,
                                      color: Color(0xffBEBEBE)

                                  ),
                                ),
                              ),


                              Container(
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 1.0, color: Color(0xffEBEBEB)),
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(
                                      3.0,
                                    )),
                                padding:
                                EdgeInsets.only(bottom: 10, right: 10 ,left: 10,top: 10),
                                child: Text(
                                  snapshot.data[index].adsMtgerCatName,
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400,
                                      color: cPrimaryColor

                                  ),
                                ),
                              ),
                              SizedBox(height: _width*.02,),


                              Container(
                                width: _width*.55,

                                child: Row(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      margin: EdgeInsets.only(
                                          top: 2,
                                          bottom: 5,
                                          right: 10),
                                      child: Image.asset(
                                        'assets/images/wheatsm.png',
                                        color: cPrimaryColor,
                                      ),
                                    ),
                                    Container(
                                        margin: EdgeInsets.only(
                                            right: 5, left: 5,
                                            top: 5
                                        ),
                                        child: Text(
                                          snapshot.data[index].adsMtgerPrice,
                                          style: TextStyle(
                                              color: cText,
                                              fontSize: 13

                                          ),
                                        )),
                                    Container(

                                      child: Text(
                                        AppLocalizations.of(context).sr,
                                        style: TextStyle(
                                            color: cPrimaryColor,
                                            fontSize: 13,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ),

                                      Spacer(),
                                    Container(
                                      child: Text(snapshot.data[index].adsMtgerActive=="0"?"مغلقة":"",style: TextStyle(color: Colors.red,fontSize: 14),),
                                    )

                                  ],
                                ),
                              ),

                            ],
                          ),


                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              GestureDetector(
                                child: Image.asset("assets/images/dots.png"),
                                onTap: (){
                                  _productState.setCurrentProduct(snapshot.data[index]);
                                  showModalBottomSheet<dynamic>(
                                      isScrollControlled: true,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(20),
                                              topRight: Radius.circular(20))),
                                      context: context,
                                      builder: (builder) {
                                        return Container(
                                          height: _height*.38,
                                          child: Padding(
                                              padding:
                                              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: <Widget>[

                                                  Container(
                                                    height: 30,
                                                    child: Image.asset('assets/images/bottomTop.png'),
                                                  ),

                                                  Container(
                                                    padding: EdgeInsets.only(right: 20),
                                                    child: Column(
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: <Widget>[
                                                        Text("خيارات الوجبة",style: TextStyle(color: cText,fontSize: 16,fontWeight: FontWeight.bold),),
                                                        Padding(padding: EdgeInsets.all(5)),
                                                        Text("جميع الخيارات الخاصة بالوجبية الحالية",style: TextStyle(color: cHintColor,fontSize: 13),),
                                                      ],
                                                    ),
                                                  ),
                                                  Padding(padding: EdgeInsets.all(8)),
                                                  Expanded(child: Column(
                                                    children: <Widget>[

                                                      ListTile(
                                                        title: GestureDetector(
                                                          child: Container(
                                                            alignment: Alignment.center,
                                                            padding: EdgeInsets.all(12),
                                                            child: Row(
                                                              children: <Widget>[
                                                                Image.asset("assets/images/edit.png"),
                                                                Padding(padding: EdgeInsets.all(5)),
                                                                Text("تعديل المنتج",style: TextStyle(color: cText,fontSize: 15),)
                                                              ],
                                                            ),
                                                          ),
                                                          onTap: () async{


                                                            Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder: (context) =>
                                                                        EditProductScreen(
                                                                          product: snapshot
                                                                              .data[index],
                                                                        )));


                                                          },
                                                        ),
                                                      ),

                                                      Container(
                                                        height: 10,
                                                      ),

                                                      ListTile(
                                                        title: GestureDetector(
                                                          child: Container(
                                                            alignment: Alignment.center,
                                                            padding: EdgeInsets.all(12),
                                                            child: Row(
                                                              children: <Widget>[
                                                                Image.asset("assets/images/canc.png",color: Colors.blue,),
                                                                Padding(padding: EdgeInsets.all(5)),
                                                                Text(snapshot.data[index].adsMtgerActive=="1"?"اغلاق المنتج":"فتح المنتج",style: TextStyle(color: cText,fontSize: 15),)
                                                              ],
                                                            ),
                                                          ),
                                                          onTap: () async{





                                                            Navigator.pop(context);
                                                            showDialog(
                                                                barrierDismissible: true,
                                                                context: context,
                                                                builder: (_) {
                                                                  return AlertDialog(
                                                                    shape: RoundedRectangleBorder(
                                                                        borderRadius: BorderRadius.all(Radius.circular(10.0))),
                                                                    content: SingleChildScrollView(
                                                                      child: Column(
                                                                        children: <Widget>[
                                                                          Container(
                                                                            padding: EdgeInsets.all(25),
                                                                            decoration: BoxDecoration(
                                                                                color: cOmarColor,
                                                                                borderRadius: BorderRadius.all(Radius.circular(50.00)),
                                                                                border: Border.all(color: cOmarColor)),
                                                                            child: Icon(Icons.not_interested,size: 40,color: Colors.blue,),
                                                                          ),
                                                                          SizedBox(
                                                                            height: 10,
                                                                          ),
                                                                          Text(
                                                                            snapshot.data[index].adsMtgerActive=="1"?"اغلاق المنتج":"فتح المنتج",
                                                                            textAlign: TextAlign.center,
                                                                            style:
                                                                            TextStyle(fontSize: 16, height: 1.5, fontFamily: 'segoeui',color: cText,fontWeight: FontWeight.bold),
                                                                          ),
                                                                          SizedBox(
                                                                            height: 10,
                                                                          ),
                                                                          Text(
                                                                            snapshot.data[index].adsMtgerActive=="1"?"هل تريد تأكيد غلق المنتج  ؟":"هل تريد تأكيد فتح المنتج  ؟",
                                                                            textAlign: TextAlign.center,
                                                                            style:
                                                                            TextStyle(fontSize: 15, height: 1.5, fontFamily: 'segoeui',color: Colors.grey),
                                                                          ),
                                                                          SizedBox(
                                                                            height: 10,
                                                                          ),

                                                                          SizedBox(
                                                                            height: 10,
                                                                          ),
                                                                          Row(
                                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                            children: <Widget>[


                                                                              GestureDetector(
                                                                                  onTap: () async{
                                                                                    _progressIndicatorState.setIsLoading(true);
                                                                                    var results = await _services.get(
                                                                                        'https://ninanapp.com/app/api/mtger_disactive_ads?mtger_id=${_storeState.currentStore.mtgerId}&ads_id=${_productState.currentProduct.adsMtgerId}&lang=${_appState.currentLang}');
                                                                                    _progressIndicatorState.setIsLoading(false);
                                                                                    if (results['response'] == '1') {

                                                                                      setState(() {
                                                                                        showToast( results['message'], context);
                                                                                        Navigator.pop(context);
                                                                                        _productList = _getProducts('0');
                                                                                      });
                                                                                    } else {
                                                                                      showErrorDialog(
                                                                                          results['message'], context);
                                                                                    }
                                                                                  },
                                                                                  child: Container(
                                                                                    alignment: Alignment.center,
                                                                                    width: MediaQuery.of(context).size.width*.30,
                                                                                    padding: EdgeInsets.only(left: 20,right: 20,top: 10,bottom: 10),
                                                                                    decoration: BoxDecoration(
                                                                                        color: cPrimaryColor,
                                                                                        borderRadius: BorderRadius.all(Radius.circular(6.00)),
                                                                                        border: Border.all(color: cPrimaryColor)),
                                                                                    child: Text("تأكيد",
                                                                                        style: TextStyle(
                                                                                            fontSize: 14,
                                                                                            fontFamily: 'segoeui',
                                                                                            color: Colors.white,
                                                                                            fontWeight: FontWeight.w500)),
                                                                                  )
                                                                              ),

                                                                              Padding(padding: EdgeInsets.all(5)),
                                                                              GestureDetector(
                                                                                  onTap: () {
                                                                                    Navigator.pop(context);
                                                                                  },
                                                                                  child: Container(
                                                                                    alignment: Alignment.center,
                                                                                    width: MediaQuery.of(context).size.width*.30,
                                                                                    padding: EdgeInsets.only(left: 20,right: 20,top: 10,bottom: 10),
                                                                                    decoration: BoxDecoration(
                                                                                        color: Colors.white,
                                                                                        borderRadius: BorderRadius.all(Radius.circular(6.00)),
                                                                                        border: Border.all(color: cPrimaryColor)),
                                                                                    child: Text("تراجع",
                                                                                        style: TextStyle(
                                                                                            fontSize: 14,
                                                                                            fontFamily: 'segoeui',
                                                                                            color: cPrimaryColor,
                                                                                            fontWeight: FontWeight.w500)),
                                                                                  )
                                                                              ),


                                                                            ],
                                                                          )
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  );
                                                                });












                                                          },
                                                        ),
                                                      ),


                                                      Container(
                                                        height: 10,
                                                      ),



                                                      ListTile(
                                                        title: GestureDetector(
                                                          child: Container(
                                                            alignment: Alignment.center,
                                                            padding: EdgeInsets.all(12),
                                                            child: Row(
                                                              children: <Widget>[
                                                                Image.asset("assets/images/delete.png"),
                                                                Padding(padding: EdgeInsets.all(5)),
                                                                Text("حذف المنتج",style: TextStyle(color: cText,fontSize: 15),)
                                                              ],
                                                            ),
                                                          ),
                                                          onTap: () async{



                                                             Navigator.pop(context);
                                                            showDialog(
                                                                barrierDismissible: true,
                                                                context: context,
                                                                builder: (_) {
                                                                  return AlertDialog(
                                                                    shape: RoundedRectangleBorder(
                                                                        borderRadius: BorderRadius.all(Radius.circular(10.0))),
                                                                    content: SingleChildScrollView(
                                                                      child: Column(
                                                                        children: <Widget>[
                                                                          Container(
                                                                            padding: EdgeInsets.all(25),
                                                                            decoration: BoxDecoration(
                                                                                color: cOmarColor,
                                                                                borderRadius: BorderRadius.all(Radius.circular(50.00)),
                                                                                border: Border.all(color: cOmarColor)),
                                                                            child: Icon(Icons.delete,size: 40,color: Colors.red,),
                                                                          ),
                                                                          SizedBox(
                                                                            height: 10,
                                                                          ),
                                                                          Text(
                                                                            "حذف المنتج",
                                                                            textAlign: TextAlign.center,
                                                                            style:
                                                                            TextStyle(fontSize: 16, height: 1.5, fontFamily: 'segoeui',color: cText,fontWeight: FontWeight.bold),
                                                                          ),
                                                                          SizedBox(
                                                                            height: 10,
                                                                          ),
                                                                          Text(
                                                                            "هل تريد تأكيد حذف المنتج نهائيا ؟",
                                                                            textAlign: TextAlign.center,
                                                                            style:
                                                                            TextStyle(fontSize: 15, height: 1.5, fontFamily: 'segoeui',color: Colors.grey),
                                                                          ),
                                                                          SizedBox(
                                                                            height: 10,
                                                                          ),

                                                                          SizedBox(
                                                                            height: 10,
                                                                          ),
                                                                          Row(
                                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                            children: <Widget>[


                                                                              GestureDetector(
                                                                                  onTap: () async{

                                                                                    _progressIndicatorState.setIsLoading(true);
                                                                                    var results = await _services.get(
                                                                                        'https://ninanapp.com/app/api/mtger_do_delete_mtger_ads?mtger_id=${_storeState.currentStore.mtgerId}&ads_mtger_id=${_productState.currentProduct.adsMtgerId}&lang=${_appState.currentLang}');
                                                                                    _progressIndicatorState.setIsLoading(false);
                                                                                    if (results['response'] == '1') {

                                                                                      setState(() {
                                                                                        showToast( results['message'], context);
                                                                                        Navigator.pop(context);
                                                                                        _productList = _getProducts('0');
                                                                                      });



                                                                                    } else {
                                                                                      showErrorDialog(
                                                                                          results['message'], context);
                                                                                    }
                                                                                  },
                                                                                  child: Container(
                                                                                    alignment: Alignment.center,
                                                                                    width: MediaQuery.of(context).size.width*.30,
                                                                                    padding: EdgeInsets.only(left: 20,right: 20,top: 10,bottom: 10),
                                                                                    decoration: BoxDecoration(
                                                                                        color: cPrimaryColor,
                                                                                        borderRadius: BorderRadius.all(Radius.circular(6.00)),
                                                                                        border: Border.all(color: cPrimaryColor)),
                                                                                    child: Text("تأكيد",
                                                                                        style: TextStyle(
                                                                                            fontSize: 14,
                                                                                            fontFamily: 'segoeui',
                                                                                            color: Colors.white,
                                                                                            fontWeight: FontWeight.w500)),
                                                                                  )
                                                                              ),

                                                                              Padding(padding: EdgeInsets.all(5)),
                                                                              GestureDetector(
                                                                                  onTap: () {
                                                                                    Navigator.pop(context);
                                                                                  },
                                                                                  child: Container(
                                                                                    alignment: Alignment.center,
                                                                                    width: MediaQuery.of(context).size.width*.30,
                                                                                    padding: EdgeInsets.only(left: 20,right: 20,top: 10,bottom: 10),
                                                                                    decoration: BoxDecoration(
                                                                                        color: Colors.white,
                                                                                        borderRadius: BorderRadius.all(Radius.circular(6.00)),
                                                                                        border: Border.all(color: cPrimaryColor)),
                                                                                    child: Text("تراجع",
                                                                                        style: TextStyle(
                                                                                            fontSize: 14,
                                                                                            fontFamily: 'segoeui',
                                                                                            color: cPrimaryColor,
                                                                                            fontWeight: FontWeight.w500)),
                                                                                  )
                                                                              ),


                                                                            ],
                                                                          )
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  );
                                                                });


                                                          },
                                                        ),
                                                      ),

                                                    ],
                                                  )

                                                  ),




                                                ],
                                              )),
                                        );
                                      });
                                },
                              ),


                            ],
                          ),
                          
                        ],
                      ),
                    );
                  });
            } else {
              return NoData(
                message: AppLocalizations.of(context).noResults
              );
            }
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }

          return Center(
              child: SpinKitThreeBounce(
            color: cPrimaryColor,
            size: 40,
          ));
        },
      );
    });
  }

  Widget _buildBodyItem() {
    return ListView(
      children: <Widget>[



        SizedBox(
          height: _height * 0.06,
        ),

        Container(
          margin: EdgeInsets.only(bottom: 7),
          height: _height-(_height * 0.06+60),
          child: _buildProducts(),

        ),


        Container(
          margin: EdgeInsets.only(bottom: 20),
          height: 50,
          child: CustomButton(
            btnColor: cPrimaryColor,
            prefixIcon: Image.asset("assets/images/add.png"),
            btnLbl: "إضافة منتج جديد",
            onPressedFunction: (){
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AddProductScreen()));
            },
          ),

        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    _height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    _width = MediaQuery.of(context).size.width;
    _progressIndicatorState = Provider.of<ProgressIndicatorState>(context);
    _navigationState = Provider.of<NavigationState>(context);
    return NetworkIndicator( child:PageContainer(
      child: Scaffold(
          body: Stack(
        children: <Widget>[

          _buildBodyItem(),




          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: GradientAppBar(
              appBarTitle:"المنتجات",
              leading:GestureDetector(
                onTap: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => StoreScreen()));
                },
                child: Container(
                  padding: EdgeInsets.only(top: 12,right: 10),
                  child: Image.asset('assets/images/back.png'),
                ),
              ),
              trailing:Container(),
            ),
          ),

          Center(
            child: ProgressIndicatorComponent(),
          )
        ],
      )),
    ));
  }
}
