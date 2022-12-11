



import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ninan1/components/app_repo/location_state.dart';
import 'package:ninan1/models/cart_details.dart';
import 'package:ninan1/screens/store/cats_screen.dart';
import 'package:ninan1/screens/store/products_screen.dart';
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

class StoreScreen extends StatefulWidget {
  @override
  _StoreScreenState createState() => _StoreScreenState();
}

class _StoreScreenState extends State<StoreScreen> {
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









  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_initialRun) {
      _storeState = Provider.of<StoreState>(context);
      _appState = Provider.of<AppState>(context);
      _productState = Provider.of<ProductState>(context);
      _locationState = Provider.of<LocationState>(context);
      _initialRun = false;
    }
  }





  Widget _buildBodyItem() {
    return Padding(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            Spacer(flex: 1,),
            Row(
              children: <Widget>[
                GestureDetector(
                  onTap: (){
                  Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProductsScreen()));
                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: _width*.45,
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: cOmarColor,
                      border: Border.all(color: Color(0xff1F61301A), width: 1.0),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Image.asset("assets/images/products.png"),
                        Padding(padding: EdgeInsets.all(10)),
                        Text("المنتجات",style: TextStyle(color: Color(0xff404040),fontSize: 16),),
                      ],
                    ),
                  ),
                ),



                Padding(
                  padding: EdgeInsets.all(_width*.02),
                ),


                GestureDetector(
                  onTap: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CatsScreen()));
                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: _width*.45,
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: cOmarColor,
                      border: Border.all(color: Color(0xff1F61301A), width: 1.0),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Image.asset("assets/images/cats.png"),
                        Padding(padding: EdgeInsets.all(10)),
                        Text("أقسام المنتجات",style: TextStyle(color: Color(0xff404040),fontSize: 16),),
                      ],
                    ),
                  ),
                )



              ],
            ),

            Spacer(flex: 2,),
          ],
        )
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

          AnimatedPositioned(
              duration: Duration(seconds: 5),
              top: 0, left: 0, right: 0, child: StoreAppBar()
          ),
          AnimatedPositioned(
             duration: Duration(microseconds: 500),
              top: 37,
              left: MediaQuery.of(context).size.width * 0.36,
              child:
                  Consumer<StoreState>(builder: (context, storeState, child) {
    
              return
                Container(

                  padding: EdgeInsets.all(15),

                    decoration: new BoxDecoration(
                      color: Colors.white,
                        border:
                        Border.all(color: Color(0xff1F61301A), width: 1.0),
                   ),

                  child:  Container(
                      width: 80,
                      height: 80,
                    alignment: Alignment.center,
                      decoration: new BoxDecoration(
                          border:
                          Border.all(color: Color(0xff1F61301A), width: 1.0),
                          shape: BoxShape.circle,
                          image:  DecorationImage(
                              fit: BoxFit.fill,
                              image: new NetworkImage(
                                storeState.currentStore.mtgerPhoto,
                              )))),
                );
     
              })),


          Center(
            child: ProgressIndicatorComponent(),
          )
        ],
      )),
    ));
  }
}
