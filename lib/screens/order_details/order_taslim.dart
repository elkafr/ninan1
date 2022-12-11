import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ninan1/components/app_repo/location_state.dart';
import 'package:ninan1/screens/chat/chat_screen.dart';
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



import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
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
import 'package:ninan1/screens/chat/chat_screen.dart';
import 'package:ninan1/screens/chat/widgets/chat_msg_item.dart';
import 'package:ninan1/components/custom_text_form_field/custom_text_form_field.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';


class OrderTaslimScreen extends StatefulWidget {



  @override
  _OrderTaslimScreenState createState() => _OrderTaslimScreenState();
}

class _OrderTaslimScreenState extends State<OrderTaslimScreen> {
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
  final _formKey = GlobalKey<FormState>();
  String _rateContent='',_rateMtgerValue='',_rateDriverValue='',_reportContent='';
  bool _value = false;
  int val = -1;

  void _handleRadioValueChange(int value) {
    setState(() {
      val = value;
    });
  }


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
           Container(

             child:  Row(
               children: <Widget>[
                 Container(
                   margin: EdgeInsets.symmetric(vertical: 10),
                   width: _width*.60,
                   height: 60,
                   child: CustomButton(
                     btnColor: cPrimaryColor,
                     btnLbl: "تسليم الطلب",
                     onPressedFunction: () async {


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
                                       child: Icon(Icons.input,size: 40,color: Colors.red,),
                                     ),
                                     SizedBox(
                                       height: 10,
                                     ),
                                     Text(
                                       "تحصيل المبلغ",
                                       textAlign: TextAlign.center,
                                       style:
                                       TextStyle(fontSize: 16, height: 1.5, fontFamily: 'segoeui',color: cText,fontWeight: FontWeight.bold),
                                     ),
                                     SizedBox(
                                       height: 10,
                                     ),
                                     Text(
                                       "المبلغ المراد تحصيله من العميل",
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
                                                   'https://ninanapp.com/app/api/driver_updateRequestState?user_id=${_appState.currentUser.userId}&cartt_fatora=${order.carttFatora}&cartt_seller=${order.carttSeller}&cartt_done=4&lang=${_appState.currentLang}');
                                               _progressIndicatorState.setIsLoading(false);
                                               if (results['response'] == '1') {


                                                 Navigator.push(
                                                     context,
                                                     MaterialPageRoute(
                                                         builder: (context) => OrdersScreen()));


                                                 setState(() {
                                                   showToast( results['message'], context);
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
                                               showModalBottomSheet<dynamic>(
                                                   isScrollControlled: true,
                                                   shape: RoundedRectangleBorder(
                                                       borderRadius: BorderRadius.only(
                                                           topLeft: Radius.circular(20),
                                                           topRight: Radius.circular(20))),
                                                   context: context,
                                                   builder: (builder) {
                                                     return StatefulBuilder(
                                                         builder: (BuildContext context, StateSetter setState /*You can rename this!*/) {
                                                     return Container(
                                                       height: _height*.65,
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
                                                                     Text("شكوى / ابلاغ",style: TextStyle(color: cText,fontSize: 16,fontWeight: FontWeight.bold),),
                                                                     Padding(padding: EdgeInsets.all(5)),
                                                                     Text("في حالة كان الطلب به أي شكوى",style: TextStyle(color: cHintColor,fontSize: 13),),
                                                                   ],
                                                                 ),
                                                               ),
                                                               Padding(padding: EdgeInsets.all(8)),
                                                               Expanded(child: Column(
                                                                 children: <Widget>[

                                                                   Form(
                                                                     key: _formKey,
                                                                     child: Column(
                                                                       children: <Widget>[






                                                                         ListTile(
                                                                           title: Text("لم يستلم العميل الطلب"),
                                                                           leading: Radio(
                                                                             value: 1,
                                                                             groupValue: val,
                                                                             onChanged: (value) {
                                                                               setState(() {
                                                                                 val = value;
                                                                                 _reportContent="لم يستلم العميل الطلب";

                                                                               });
                                                                               _handleRadioValueChange(value);
                                                                             },
                                                                             activeColor: Colors.green,
                                                                           ),
                                                                         ),
                                                                         ListTile(
                                                                           title: Text("اعتراض من العميل"),
                                                                           leading: Radio(
                                                                             value: 2,
                                                                             groupValue: val,
                                                                             onChanged: (value) {
                                                                               setState(() {
                                                                                 val = value;
                                                                                 _reportContent="اعتراض من العميل";
                                                                               });
                                                                               _handleRadioValueChange(value);
                                                                             },
                                                                             activeColor: Colors.green,
                                                                           ),
                                                                         ),

                                                                         ListTile(
                                                                           title: Text("لم يروق له الطلب"),
                                                                           leading: Radio(
                                                                             value: 3,
                                                                             groupValue: val,
                                                                             onChanged: (value) {
                                                                               setState(() {
                                                                                 val = value;
                                                                                 _reportContent="لم يروق له الطلب";
                                                                               });
                                                                               _handleRadioValueChange(value);
                                                                             },
                                                                             activeColor: Colors.green,
                                                                           ),
                                                                         ),

                                                                         ListTile(
                                                                           title: Text("سبب اخر"),
                                                                           leading: Radio(
                                                                             value: 4,
                                                                             groupValue: val,
                                                                             onChanged: (value) {
                                                                               setState(() {
                                                                                 val = value;

                                                                               });
                                                                               _handleRadioValueChange(value);
                                                                             },
                                                                             activeColor: Colors.green,
                                                                           ),
                                                                         ),

                                                                         Container(
                                                                           height: 100,
                                                                           child: CustomTextFormField(


                                                                               hintTxt: " اكتب بلاغك او شكوتك هنا...",

                                                                               inputData: TextInputType.text,
                                                                               maxLines: 4,
                                                                               onChangedFunc: (String text) {
                                                                                 _reportContent= text.toString();
                                                                               },

                                                                               ),
                                                                         ),


                                                                         Container(
                                                                           width: _width,
                                                                           child: Row(
                                                                             mainAxisAlignment: MainAxisAlignment.center,
                                                                             children: <Widget>[
                                                                               Container(
                                                                                 margin: EdgeInsets.symmetric(vertical: _height * 0.02),
                                                                                 width: _width*.49,
                                                                                 height: 60,
                                                                                 child: CustomButton(
                                                                                   btnLbl: "إرسال",
                                                                                   onPressedFunction: () async {
                                                                                     if (_formKey.currentState.validate()) {
                                                                                       _progressIndicatorState.setIsLoading(true);

                                                                                       var results = await _services.get(
                                                                                         'https://ninanapp.com/app/api/driver_addReport?report_user=${_appState.currentUser.userId}&report_content=$_reportContent&report_type=1&report_number=${order.carttNumber}&lang=${_appState.currentLang}',
                                                                                       );
                                                                                       _progressIndicatorState.setIsLoading(false);
                                                                                       if (results['response'] == '1') {
                                                                                         showToast(results['message'], context);
                                                                                         Navigator.pop(context);
                                                                                       } else {
                                                                                         showErrorDialog(results['message'], context);
                                                                                       }
                                                                                     }
                                                                                   },
                                                                                 ),
                                                                               ),


                                                                               Container(


                                                                                 margin: EdgeInsets.symmetric(vertical: _height * 0.02),
                                                                                 width: _width*.49,
                                                                                 height: 60,
                                                                                 child: CustomButton(

                                                                                   btnLbl: "تراجع",
                                                                                   onPressedFunction: ()  {

                                                                                     Navigator.pop(context);

                                                                                   },
                                                                                   btnColor: cWhite,
                                                                                   btnStyle: TextStyle(color: Color(0xffABABAB)),
                                                                                 ),
                                                                               )


                                                                             ],
                                                                           ),
                                                                         ),



                                                                       ],
                                                                     ),
                                                                   )






                                                                 ],
                                                               )

                                                               ),




                                                             ],
                                                           )),
                                                     );
    });
                                                   });


                                             },
                                             child: Container(
                                               alignment: Alignment.center,
                                               width: MediaQuery.of(context).size.width*.30,
                                               padding: EdgeInsets.only(left: 20,right: 20,top: 10,bottom: 10),
                                               decoration: BoxDecoration(
                                                   color: Colors.white,
                                                   borderRadius: BorderRadius.all(Radius.circular(6.00)),
                                                   border: Border.all(color: cPrimaryColor)),
                                               child: Text("ابلاغ",
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
                   width: _width*.20,
                   child: GestureDetector(
                     child: Image.asset("assets/images/phone1.png"),
                     onTap: (){

                     },
                   ),
                 ),

                 Container(
                   width: _width*.20,
                   child: GestureDetector(
                     child: Image.asset("assets/images/message.png"),
                     onTap: (){


                       Navigator.push(context, MaterialPageRoute
                         (builder: (context)=> ChatScreen(
                         senderId: order.clientId,
                         senderImg: order.clientPhoto,
                         senderName:order.clientName,
                         senderPhone:order.clientPhone,
                         adsId:order.carttNumber,

                       )
                       ));

                     },
                   ),
                 ),


               ],
             ),
           )

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
                              appBarTitle: "تسليم الطلب",

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
