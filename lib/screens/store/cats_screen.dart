



import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ninan1/components/app_repo/location_state.dart';
import 'package:ninan1/components/gradient_app_bar/gradient_app_bar.dart';
import 'package:ninan1/models/cart_details.dart';
import 'package:ninan1/screens/store/add_cat_screen.dart';
import 'package:ninan1/screens/store/edit_cat_screen.dart';
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

class CatsScreen extends StatefulWidget {
  @override
  _CatsScreenState createState() => _CatsScreenState();
}

class _CatsScreenState extends State<CatsScreen> {
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









  Future<List<Category>> _getCategories() async {
    Map<String, dynamic> results = await _services.get(
        'https://ninanapp.com/app/api/show_mtger_cats?id=${_storeState.currentStore.mtgerId}&lang=${_appState.currentLang}');
    List categoryList = List<Category>();
    if (results['response'] == '1') {
      Iterable iterable = results['cat'];
      categoryList = iterable.map((model) => Category.fromJson(model)).toList();
      if (categoryList.length > 0) {
        categoryList[0].isSelected = true;
        categoryList.removeAt(0);

      }
    } else {
      print('error');
    }
    return categoryList;
  }




  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_initialRun) {
      _storeState = Provider.of<StoreState>(context);
      _appState = Provider.of<AppState>(context);
      _productState = Provider.of<ProductState>(context);
      _locationState = Provider.of<LocationState>(context);
      _categoriesList = _getCategories();
      _initialRun = false;
    }
  }



  Widget _buildProducts() {
    return LayoutBuilder(builder: (context, constraints) {
      return FutureBuilder<List<Category>>(
        future: _categoriesList,
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
                              snapshot.data[index].mtgerCatPhoto,
                              width:
                              50,
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
                                  snapshot.data[index].mtgerCatName,
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
                                  snapshot.data[index].mtgerCatDetails!=null?snapshot.data[index].mtgerCatDetails:"",
                                  maxLines: 2,
                                  style: TextStyle(
                                      fontSize: 13,
                                      color: Color(0xffBEBEBE)

                                  ),
                                ),
                              ),




                              SizedBox(height: _width*.02,),



                            ],
                          ),


                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              GestureDetector(
                                child: Image.asset("assets/images/edit.png"),
                                onTap: (){

                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              EditCatScreen(
                                                cat: snapshot
                                                    .data[index],
                                              )));

                                },
                              ),

                              Padding(padding: EdgeInsets.all(5)),

                              GestureDetector(
                                child: Image.asset("assets/images/delete.png"),
                                onTap: () async{

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
                                                  "حذف القسم",
                                                  textAlign: TextAlign.center,
                                                  style:
                                                  TextStyle(fontSize: 16, height: 1.5, fontFamily: 'segoeui',color: cText,fontWeight: FontWeight.bold),
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Text(
                                                  "هل تريد تأكيد حذف القسم نهائيا ؟",
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
                                                         Navigator.pop(context);
                                                          _progressIndicatorState.setIsLoading(true);
                                                          var results = await _services.get(
                                                              'https://ninanapp.com/app/api/mtger_do_delete_mtger_cat1?mtger_id=${_storeState.currentStore.mtgerId}&mtger_cat_id=${snapshot.data[index].mtgerCatId}&lang=${_appState.currentLang}');
                                                          _progressIndicatorState.setIsLoading(false);
                                                          if (results['response'] == '1') {

                                                            setState(() {
                                                              showToast( results['message'], context);
                                                              _categoriesList = _getCategories();
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
                              )


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
            btnLbl: "قسم جديد",
            onPressedFunction: (){
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AddCatScreen()));
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
                  appBarTitle:"أقسام المنتجات",
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
