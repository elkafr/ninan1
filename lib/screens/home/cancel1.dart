import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ninan1/components/MainDrawer.dart';
import 'package:ninan1/components/app_repo/store_state.dart';
import 'package:ninan1/screens/orders/components/done_orders.dart';
import 'package:ninan1/screens/orders/components/filter_done_orders.dart';
import 'package:ninan1/screens/orders/components/filter_processing_orders.dart';
import 'package:ninan1/screens/orders/components/mtger_filter_done_orders.dart';
import 'package:ninan1/screens/orders/components/mtger_filter_processing_orders.dart';
import 'package:ninan1/screens/orders/components/processing_orders.dart';
import 'package:provider/provider.dart';
import 'package:ninan1/components/app_repo/app_state.dart';
import 'package:ninan1/components/app_repo/tab_state.dart';
import 'package:ninan1/components/connectivity/network_indicator.dart';
import 'package:ninan1/components/gradient_app_bar/gradient_app_bar1.dart';
import 'package:ninan1/components/not_registered/not_registered.dart';
import 'package:ninan1/components/progress_indicator_component/progress_indicator_component.dart';
import 'package:ninan1/components/safe_area/page_container.dart';
import 'package:ninan1/locale/localization.dart';
import 'package:ninan1/screens/orders/components/mtger_done_orders.dart';
import 'package:ninan1/screens/orders/components/mtger_processing_orders.dart';
import 'package:ninan1/utils/app_colors.dart';
import 'package:ninan1/components/MtgerMainDrawer.dart';





import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ninan1/components/app_repo/location_state.dart';
import 'package:ninan1/components/gradient_app_bar/gradient_app_bar.dart';
import 'package:ninan1/models/cart_details.dart';
import 'package:ninan1/models/request.dart';
import 'package:ninan1/screens/mtger_wallet/add_convert.dart';
import 'package:ninan1/screens/wallet/add_request.dart';
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

class Cancel1Screen extends StatefulWidget {
  @override
  _Cancel1ScreenState createState() => _Cancel1ScreenState();
}

class _Cancel1ScreenState extends State<Cancel1Screen> {
  double _height,_width;
  var _scaffoldKey = GlobalKey<ScaffoldState>();

  Widget _buildBodyItem() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: _height*.3,),
          Image.asset("assets/images/cancelActive.png"),
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(_width*.04),
            child: Center(child: Text("عفواً , تم إيقاف حسابك مؤقتاً يرجى تسديد ما عليك أولاً لإستكمال عملك",style: TextStyle(color: cText,fontSize: 16,fontWeight: FontWeight.bold),),),
          ),
          SizedBox(height: _width*.6,),
          Container(
            height: 50,
            child: CustomButton(
              btnColor: cPrimaryColor,
              btnLbl:"تحويل الرصيد",
              onPressedFunction: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AddConvertScreen()));
              },
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    _height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    _width = MediaQuery.of(context).size.width;
    TabState tabState = Provider.of<TabState>(context);
    AppState appState = Provider.of<AppState>(context);
    StoreState storeState = Provider.of<StoreState>(context);

    return  NetworkIndicator( child:PageContainer(
      child: RefreshIndicator(child:Scaffold(
          key: _scaffoldKey, //

          body: Stack(

            children: <Widget>[
              _buildBodyItem(),
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: GradientAppBar1(


                  appBarTitle: AppLocalizations.of(context).orders,



                ),
              ),


            ],
          )),
        onRefresh: () async {
          setState(() {});
        },
      ),
    ));
  }
}
