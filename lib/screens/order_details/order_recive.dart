import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ninan1/components/app_repo/location_state.dart';
import 'dart:math' as math;
import 'package:ninan1/screens/order_details/add_fatora.dart';
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

class OrderReciveScreen extends StatefulWidget {



  @override
  _OrderReciveScreenState createState() => _OrderReciveScreenState();
}

class _OrderReciveScreenState extends State<OrderReciveScreen> {
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




  Widget _buildBodyItem(Order order) {
    return SingleChildScrollView(
      child: Container(
        width: _width,
        height: _height,
        child: Column(
          children: <Widget>[

            Container(
              height: _height*.24,
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 60,
                    ),





                    Container(

                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: cOmarColor,
                        borderRadius: BorderRadius.all(
                          const Radius.circular(6.00),
                        ),

                      ),
                      margin: EdgeInsets.only(right: _width*.02,left: _width*.02),
                      child: ListTile(
                        leading: ClipOval(
                          child: Image.network(order.carttMtgerPhoto,cacheWidth: 50,cacheHeight: 50,),
                        ),
                        title: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,

                          children: <Widget>[
                            Text("استلام الطلب من",style: TextStyle(color: cPrimaryColor,fontSize: 12),),
                            Spacer(),
                            GestureDetector(
                              child: Image.asset("assets/images/maps2.png"),
                              onTap: (){
                                launch(
                                    "http://www.google.com/maps/place/"+order.mtgerMapx+","+order.mtgerMapy+"");
                              },
                            )
                          ],
                        ),
                        subtitle: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(order.carttMtgerName,style: TextStyle(color: cText,fontSize: 14),),
                            Padding(padding: EdgeInsets.all(2)),
                            Text(order.mtgerAdress,style: TextStyle(color: Colors.grey[500],fontSize: 14),),
                            Padding(padding: EdgeInsets.all(2)),
                            Container(
                              child:  Row(


                                children: <Widget>[
                                  Image.asset("assets/images/maps1.png",color: cPrimaryColor,),
                                  Padding(padding: EdgeInsets.all(2)),
                                  Stack(
                                    children: <Widget>[
                                      Container(

                                        child: Text(order.distance1.toString(),style: TextStyle(color: cText,fontSize: 14),),
                                        height: 25,
                                        width: 35,
                                        padding: EdgeInsets.only(top: 10),
                                      ),
                                      Positioned(
                                          bottom: 11,
                                          left: -1,
                                          child: Text("كم",style: TextStyle(color: cText,fontSize: 11),)),
                                    ],
                                  )
                                ],
                              ),
                            )
                          ],
                        ),

                      ),
                    ),


                  ],
                ),
              ),
            ),

            SizedBox(height: _height*.01,),

            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  alignment: Alignment.centerRight,
                  margin: EdgeInsets.only(
                      left: _width * 0.04, right: _width * 0.04,),

                  child: Text("الطلب",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontSize: 15, fontWeight: FontWeight.w400, color: cText)),
                ),
                Container(
                  margin: EdgeInsets.only(
                    left: _width * 0.04, right: _width * 0.04,),
                  child: Row(
                    children: <Widget>[
                      Image.asset("assets/images/arrow1.png"),

                      GestureDetector(
                        onTap: (){

                          Navigator.pushReplacementNamed(
                              context, '/order_details_screen');
                        },
                        child: Text("تفاصيل الطلب",style: TextStyle(color: Color(0xff404040),fontSize: 15),),
                      ),



                    ],
                  ),
                )

              ],
            ),
            SizedBox(height: _height*.02,),
            Container(
              color: cOmarColor,
              margin: EdgeInsets.only(bottom: _height * 0.02),
              height: _height * 0.57,
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
Spacer(),
            Container(
              margin: EdgeInsets.symmetric(vertical: 10),

              height: 60,
              child: CustomButton(
                btnColor: cPrimaryColor,
                btnLbl: "استلام الطلب",
                onPressedFunction: () async {


                  _progressIndicatorState.setIsLoading(true);
                  var results = await _services.get(
                      'https://ninanapp.com/app/api/driver_updateRequestState?user_id=${_appState.currentUser.userId}&cartt_fatora=${order.carttFatora}&cartt_seller=${order.carttSeller}&cartt_done=2&lang=${_appState.currentLang}');
                  _progressIndicatorState.setIsLoading(false);
                  if (results['response'] == '1') {


                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AddFatoraScreen()));


                    setState(() {
                      showToast( results['message'], context);
                    });






                  } else {
                    showErrorDialog(
                        results['message'], context);
                  }


                },
              ),

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
                              appBarTitle: "استلام الطلب",
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
