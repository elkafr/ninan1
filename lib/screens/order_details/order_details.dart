import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ninan1/components/app_repo/location_state.dart';
import 'package:ninan1/screens/orders/orders_screen.dart';
import 'package:provider/provider.dart';
import 'package:ninan1/components/app_repo/app_state.dart';
import 'package:ninan1/components/app_repo/navigation_state.dart';
import 'package:ninan1/components/app_repo/order_state.dart';
import 'package:ninan1/components/app_repo/progress_indicator_state.dart';
import 'package:ninan1/components/app_repo/tab_state.dart';
import 'package:ninan1/components/buttons/custom_button.dart';
import 'package:ninan1/components/connectivity/network_indicator.dart';
import 'package:ninan1/components/gradient_app_bar/gradient_app_bar.dart';
import 'package:ninan1/components/response_handling/response_handling.dart';
import 'package:ninan1/components/safe_area/page_container.dart';
import 'package:ninan1/locale/localization.dart';
import 'package:ninan1/models/order.dart';
import 'package:ninan1/screens/order_details/edit_order_details.dart';
import 'package:ninan1/screens/orders/components/cancel_order_bottom_sheet.dart';
import 'package:ninan1/services/access_api.dart';
import 'package:ninan1/utils/app_colors.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:math' as math;


class OrderDetailsScreen extends StatefulWidget {



  @override
  _OrderDetailsScreenState createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  bool _initialRun = true;
  OrderState _orderState;
  double _height, _width;
  Services _services = Services();
  ProgressIndicatorState _progressIndicatorState;
  AppState _appState;
  LocationState _locationState;
  TabState _tabState;
  NavigationState _navigationState;
  Future<Order> _orderDetails;

  Future<Order> _getOrderDetails() async {
    Map<String, dynamic> results = await _services.get(
        'https://ninanapp.com/app/api/mtger_show_buy?lang=${_appState.currentLang}&cartt_fatora=${_orderState.carttFatora}&cartt_seller=${_orderState.carttSeller}&driverMapx=${_locationState.locationLatitude.toString()}&driverMapy=${_locationState.locationlongitude.toString()}');
    Order orderDetails = Order();
    if (results['response'] == '1') {
      orderDetails = Order.fromJson(results['result']);
    } else {
      print('error');
    }
    return orderDetails;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_initialRun) {
      _initialRun = false;
      _appState = Provider.of<AppState>(context);
      _locationState = Provider.of<LocationState>(context);
      _orderState = Provider.of<OrderState>(context);
      _orderDetails = _getOrderDetails();
    }
  }

  Widget _buildRow(String title, String value) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: _width * 0.04),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
                fontSize: 15, fontWeight: FontWeight.w400, color: cBlack),
          ),
          Text(value!=null?value:"",
              style: TextStyle(
                  fontSize: 15, fontWeight: FontWeight.w400, color: cBlack))
        ],
      ),
    );
  }

  Widget _buildBodyItem(Order order) {
    return SingleChildScrollView(
      child: Container(
        width: _width,
        height: _height,
        child: Column(
          children: <Widget>[

            Container(
            height: _height*.58,
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 60,
                    ),
                    Container(
                        height: 50,
                        child:
                        _buildRow(AppLocalizations.of(context).orderNo, order.carttNumber)),

                    Container(
                        color: Color(0xffFBF6F6),
                        height: 50,
                        child:
                        _buildRow(AppLocalizations.of(context).orderDate, order.carttDate)),



                    Container(
                        height:50,
                        child: _buildRow('${AppLocalizations.of(context).totalPrice}',
                            order.carttTotal.toString()+" ريال ")),



                    Container(
                        color: Color(0xffFBF6F6),
                        height: 50,
                        child: _buildRow(AppLocalizations.of(context).store, order.carttMtgerName)),

                    Container(
                        margin: EdgeInsets.only(right: _width*.04,left:  _width*.04),
                        height:50,
                        child: Row(
                          children: <Widget>[
                            Text("لوكيشن المتجر",style: TextStyle(color: cText,fontSize: 15),),
                            Spacer(),
                            GestureDetector(
                              child: Text("اضغط هنا",style: TextStyle(color: cPrimaryColor,fontSize: 15),),
                              onTap: (){
                                launch(
                                    "http://www.google.com/maps/place/"+order.mtgerMapx+","+order.mtgerMapy+"");
                              },
                            )
                          ],
                        )
                    ),

                    Container(

                        height: 50,
                        child:
                        _buildRow("التوصيل ل", order.carttLocation)),

                    Container(
                        margin: EdgeInsets.only(right: _width*.04,left:  _width*.04),
                        height:50,
                        child: Row(
                          children: <Widget>[
                            Text("لوكيشن العميل",style: TextStyle(color: cText,fontSize: 15),),
                            Spacer(),

                            GestureDetector(
                              child: Text("اضغط هنا",style: TextStyle(color: cPrimaryColor,fontSize: 15),),
                              onTap: (){
                                launch(
                                    "http://www.google.com/maps/place/"+order.userMapx+","+order.userMapy+"");
                              },
                            )
                          ],
                        )
                    ),







                    Container(

                        height: 50,
                        child:
                        _buildRow(AppLocalizations.of(context).orderStatus, order.carttState)),



                    Container(
                        color: Color(0xffFBF6F6),
                        height: 50,
                        child:
                        _buildRow("مدة الطلب", order.fromTime+" - "+order.toTime+" دقيقة ")),

                    Container(

                        height: 50,
                        child:
                        _buildRow("طريقة الدفع", order.carttType)),
                  ],
                ),
              ),
            ),

            Container(

              margin: EdgeInsets.only(
                  left: _width * 0.04, right: _width * 0.04, top: _height * 0.025),
              height: _height * 0.04,
              child: Text(AppLocalizations.of(context).orderDetails,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      fontSize: 15, fontWeight: FontWeight.w400, color: cText)),
            ),
            Container(
              color: cOmarColor,
              margin: EdgeInsets.only(bottom: _height * 0.02),
              height: order.carttDetails.length > 2
                  ? _height * 0.33
                  : _height * 0.15,
              child: ListView.builder(
                  itemCount: order.carttDetails.length,
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.only(top: _height * 0.02),

                      child: ListTile(
                        leading: Container(
                          padding: EdgeInsets.all(7),
                          color: Colors.white,
                          child: Text(" X "+order.carttDetails[0].carttAmount.toString(),style: TextStyle(fontSize: 14,color: cPrimaryColor),),

                        ),
                        title:  Text(order.carttDetails[0].carttName.toString(),style: TextStyle(color: cText,fontSize: 15),),
                        subtitle:   Column(
                          children: <Widget>[
                            Padding(padding: EdgeInsets.all(5)),
                            Text(order.carttDetails[0].carttDetails.toString(),style: TextStyle(color: Color(0xffBEBEBE),fontSize: 14),maxLines: 1,),
                            Container(
                              margin: EdgeInsets.only(top: 5),
                              child:  Row(


                                children: <Widget>[
                                  Image.asset("assets/images/wheatsm.png",color: cPrimaryColor,),
                                  Padding(padding: EdgeInsets.all(2)),
                                  Stack(
                                    children: <Widget>[
                                      Container(

                                        child: Text(order.carttDetails[0].carttPrice.toString(),style: TextStyle(color: cText,fontSize: 15),),
                                        height: 25,
                                        width: 35,
                                        padding: EdgeInsets.only(top: 10),
                                      ),
                                      Positioned(
                                          bottom: 11,
                                          left: -1,
                                          child: Text("ريال",style: TextStyle(color: cText,fontSize: 14),)),
                                    ],
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  }),
            ),



          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    _height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    _width = MediaQuery.of(context).size.width;
    _progressIndicatorState = Provider.of<ProgressIndicatorState>(context);
    _tabState = Provider.of<TabState>(context);
    _navigationState = Provider.of<NavigationState>(context);

    return NetworkIndicator(
        child: PageContainer(
      child: Scaffold(
          body:FutureBuilder<Order>(
              future: _orderDetails,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Stack(
                    children: <Widget>[
                      _buildBodyItem(snapshot.data),
                      Positioned(
                        top: 0,
                        left: 0,
                        right: 0,
                        child: GradientAppBar(
                            appBarTitle: "تفاصيل الطلب",

       leading: _appState.currentLang == 'ar' ? IconButton(
                icon: Image.asset('assets/images/back.png'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ) :Container(),
              trailing: _appState.currentLang == 'en' ? IconButton(
                icon: Transform.rotate(
                   angle: -math.pi / 1,
                child: Image.asset('assets/images/back.png'),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ) :Container(),

                        ),
                      ),
                    ],
                  );
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }

                return Center(
                    child: SpinKitThreeBounce(
                  color: cPrimaryColor,
                  size: 40,
                ));
              })),
    ));
  }
}
