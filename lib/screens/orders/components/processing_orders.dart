import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ninan1/components/app_repo/location_state.dart';
import 'package:ninan1/components/app_repo/store_state.dart';
import 'package:ninan1/screens/home/cancel.dart';
import 'package:ninan1/screens/order_details/order_recive.dart';
import 'package:provider/provider.dart';
import 'package:ninan1/components/app_repo/app_state.dart';
import 'package:ninan1/components/no_data/no_data.dart';
import 'package:ninan1/locale/localization.dart';
import 'package:ninan1/models/order.dart';

import 'package:ninan1/services/access_api.dart';
import 'package:ninan1/utils/app_colors.dart';
import 'package:ninan1/components/app_repo/progress_indicator_state.dart';





import 'package:flutter/cupertino.dart';
import 'package:ninan1/components/buttons/custom_button.dart';

import 'package:ninan1/components/app_repo/order_state.dart';
import 'package:ninan1/screens/order_details/order_details.dart';

import 'package:flutter/rendering.dart';
import 'package:ninan1/components/response_handling/response_handling.dart';




class ProcessingOrders extends StatefulWidget {
  @override
  _ProcessingOrdersState createState() => _ProcessingOrdersState();
}

class _ProcessingOrdersState extends State<ProcessingOrders> {
  bool _initialRun = true;
  AppState _appState;
  StoreState _storeState;
  OrderState _orderState;
  LocationState _locationState;
  Services _services = Services();
  Future<List<Order>> _orderList;
  ProgressIndicatorState _progressIndicatorState;
  double _height,_width;


  Future<List<Order>> _getOrderList() async {


    Map<String, dynamic> results = _appState.filterOrders==null || _appState.filterOrders==10?await _services.get(
        'https://ninanapp.com/app/api/driver_dis_buy?lang=${_appState.currentLang}&user_id=${_appState.currentUser.userId}&driverMapx=${_locationState.locationLatitude.toString()}&driverMapy=${_locationState.locationlongitude.toString()}&page=1&done=1'):await _services.get(
        'https://ninanapp.com/app/api/driver_dis_buy?lang=${_appState.currentLang}&user_id=${_appState.currentUser.userId}&driverMapx=${_locationState.locationLatitude.toString()}&driverMapy=${_locationState.locationlongitude.toString()}&page=1&done=${_appState.filterOrders}');

    List orderList = List<Order>();
    if (results['response'] == '1') {

      if (results['cancel_active'] == '1'){

        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CancelScreen()));

      }else{
        Iterable iterable = results['result'];
        orderList = iterable.map((model) => Order.fromJson(model)).toList();
      }


    } else {
      print('error');
    }
    return orderList;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_initialRun) {
      _appState = Provider.of<AppState>(context);
      _storeState = Provider.of<StoreState>(context);
      _orderState = Provider.of<OrderState>(context);
      _locationState = Provider.of<LocationState>(context);
      _progressIndicatorState = Provider.of<ProgressIndicatorState>(context);
      _orderList = _getOrderList();
      _initialRun = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;


    return FutureBuilder<List<Order>>(
      future: _orderList,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data.length > 0) {
            return Column(
              children: <Widget>[
                SizedBox(
                  height: width*.24,
                ),
                Container(
                  height: height - ( width*.3) ,
                  width: width,
                  child: ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          height: width*.91,
                          child: LayoutBuilder(builder: (context, constraints) {
                            return Container(
                                padding: EdgeInsets.all(10),
                                margin: EdgeInsets.only(
                                    left: constraints.maxWidth * 0.03,
                                    right: constraints.maxWidth * 0.03,
                                    bottom: constraints.maxHeight * 0.03),
                                height: constraints.maxHeight,
                                decoration: BoxDecoration(
                                    border: Border.all(width: 1.0, color: Color(0xffEBEBEB)),
                                    color: Color(0xffF9F9F9),
                                    borderRadius: BorderRadius.circular(
                                      6.0,
                                    )),
                                child: GestureDetector(
                                  onTap: (){
                                    _orderState.setCarttFatora(snapshot.data[index].carttFatora);
                                    _orderState.setCarttSeller(snapshot.data[index].carttSeller);
                                    _orderState.setCarttFatora(snapshot.data[index].carttFatora);
                                    _orderState.setCarttSeller(snapshot.data[index].carttSeller);


                                    _orderState.setIsWaitingOrder(false);
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => OrderDetailsScreen()));

                                  },
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: <Widget>[

                                          Image.asset("assets/images/order.png"),

                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Container(
                                                margin: EdgeInsets.symmetric(
                                                    horizontal: constraints.maxWidth * 0.04,
                                                    vertical: constraints.maxHeight * 0.01)
                                                ,
                                                child: Text(
                                                  "#"+snapshot.data[index].carttFatora,
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      color: Color(0xff404040),
                                                      fontWeight: FontWeight.w700),
                                                ),
                                              ),





                                              SizedBox(height: 2,),

                                              Container(
                                                  margin: EdgeInsets.only(
                                                      left: constraints.maxWidth * 0.04,
                                                      right: constraints.maxWidth * 0.04,
                                                      top:  0,
                                                      bottom: constraints.maxHeight * 0.03),
                                                  child: Row(
                                                    children: <Widget>[
                                                      snapshot.data[index].carttTypeId=="1"?Image.asset("assets/images/cash.png"):snapshot.data[index].carttTypeId=="2"?Image.asset("assets/images/credit.walletIcon"):Image.asset("assets/images/credit.png"),
                                                      Padding(padding: EdgeInsets.all(2),),
                                                      RichText(
                                                        text: TextSpan(
                                                          style: TextStyle(
                                                              fontWeight: FontWeight.w400,
                                                              color: cBlack,
                                                              fontSize: 15,
                                                              fontFamily: 'segoeui'),
                                                          children: <TextSpan>[

                                                            TextSpan(
                                                              text: snapshot.data[index].carttType,
                                                              style: TextStyle(
                                                                  color: cPrimaryColor,
                                                                  fontWeight: FontWeight.w400,
                                                                  fontSize: 15,
                                                                  fontFamily: 'segoeui'),
                                                            ),
                                                          ],
                                                        ),
                                                      )
                                                    ],
                                                  )),

                                              SizedBox(height: 1,),
                                              Container(
                                                  margin: EdgeInsets.symmetric(
                                                    horizontal: constraints.maxWidth * 0.04,
                                                    // vertical: constraints.maxHeight *0.04
                                                  ),
                                                  child: RichText(
                                                    text: TextSpan(
                                                      style: TextStyle(
                                                          fontWeight: FontWeight.w400,
                                                          color: cBlack,
                                                          fontSize: 15,
                                                          fontFamily: 'segoeui'),
                                                      children: <TextSpan>[

                                                        TextSpan(
                                                          text: snapshot.data[index].carttDate,
                                                          style: TextStyle(
                                                              color: Color(0xffABABAB),
                                                              fontSize: 14,
                                                              fontFamily: 'segoeui'),
                                                        ),
                                                      ],
                                                    ),
                                                  )),





                                            ],
                                          ),

                                          Spacer(),

                                          Container(
                                            padding: EdgeInsets.only(top: 8),
                                            alignment: Alignment.topCenter,
                                            child: Text(snapshot.data[index].carttTotal+" ريال"),
                                          )
                                        ],
                                      ),


                                      Container(
                                        margin: EdgeInsets.only(top:9,bottom: 3),
                                        height: 1,
                                        color: Color(0xffefefef),
                                      ),

                                    Container(
                                      child: ListTile(
                                        leading: ClipOval(
                                          child: Image.network(snapshot.data[index].carttMtgerPhoto,cacheWidth: 50,cacheHeight: 50,),
                                        ),
                                        title: Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.start,

                                          children: <Widget>[
                                            Text("استلام الطلب من",style: TextStyle(color: cPrimaryColor,fontSize: 12),),
                                            Spacer(),
                                           Container(
                                             child:  Row(


                                               children: <Widget>[
                                                 Image.asset("assets/images/maps1.png",color: cPrimaryColor,),
                                                 Padding(padding: EdgeInsets.all(2)),
                                                 Stack(
                                                   children: <Widget>[
                                                     Container(

                                                       child: Text(snapshot.data[index].distance1.toString(),style: TextStyle(color: cText,fontSize: 14),),
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
                                        subtitle: Text(snapshot.data[index].carttMtgerName,style: TextStyle(color: cText,fontSize: 14),),

                                      ),
                                      ),



                                      Container(
                                        margin: EdgeInsets.only(top:1,bottom: 1),
                                        height: 1,
                                        color: Color(0xffefefef),
                                      ),

                                      Container(
                                        child: ListTile(
                                          leading: ClipOval(
                                            child: Image.network(snapshot.data[index].clientPhoto,cacheWidth: 50,cacheHeight: 50,),
                                          ),
                                          title: Row(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            mainAxisAlignment: MainAxisAlignment.center,

                                            children: <Widget>[
                                              Text("تسليم الطلب الى",style: TextStyle(color: cPrimaryColor,fontSize: 12),),
                                              Spacer(),
                                              Container(
                                                child:  Row(


                                                  children: <Widget>[
                                                    Image.asset("assets/images/maps1.png",color: cPrimaryColor,),
                                                    Padding(padding: EdgeInsets.all(2)),
                                                    Stack(
                                                      children: <Widget>[
                                                        Container(

                                                          child: Text(snapshot.data[index].distance.toString(),style: TextStyle(color: cText,fontSize: 14),),
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
                                          subtitle: Text(snapshot.data[index].clientName,style: TextStyle(color: cText,fontSize: 14),),

                                        ),
                                      ),

                                      Container(
                                        margin: EdgeInsets.only(top:1,bottom: 5),
                                        height: 1,
                                        color: Color(0xffefefef),
                                      ),

                                      SizedBox(height: width*.03,),
                                      Container(

                                        child: Row(
                                          children: <Widget>[
                                            Image.asset("assets/images/arrow1.png"),

                                            GestureDetector(
                                              onTap: (){

                                                _orderState.setCarttFatora(snapshot.data[index].carttFatora);
                                                _orderState.setCarttSeller(snapshot.data[index].carttSeller);
                                                _orderState.setCarttFatora(snapshot.data[index].carttFatora);
                                                _orderState.setCarttSeller(snapshot.data[index].carttSeller);



                                                Navigator.pushReplacementNamed(
                                                    context, '/order_details_screen');
                                              },
                                              child: Text("تفاصيل الطلب",style: TextStyle(color: Color(0xff404040),fontSize: 15),),
                                            ),
                                            Spacer(),

                                            Row(
                                              children: <Widget>[
                                                Text("ستكسب من المال ",style: TextStyle(color: cText,fontSize: 13),),
                                                Padding(padding: EdgeInsets.all(1)),
                                                Text(snapshot.data[index].deliveryPrice!=null?snapshot.data[index].deliveryPrice:"",style: TextStyle(color: cPrimaryColor,fontSize: 15,fontWeight: FontWeight.bold),),
                                                Padding(padding: EdgeInsets.all(1)),
                                                Text(
                                                  AppLocalizations.of(context).sr,
                                                  style: TextStyle(
                                                      color: cText,
                                                      fontSize: 13,
                                                      fontWeight: FontWeight.w400),
                                                )
                                              ],
                                            )

                                          ],
                                        ),
                                      ),

                                      SizedBox(height: width*.03,),

                                      snapshot.data[index].carttStateId=="1" && snapshot.data[index].carttDriver=="0"?Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Container(
                                            margin: EdgeInsets.symmetric(vertical: 0),
                                            width: width*.44,
                                            height: 45,
                                            child: CustomButton(
                                              btnColor: cPrimaryColor,
                                              btnLbl: "قبول الطلب",
                                              onPressedFunction: () async {


                                                _progressIndicatorState.setIsLoading(true);
                                                var results = await _services.get(
                                                    'https://ninanapp.com/app/api/driver_accept_request?user_id=${_appState.currentUser.userId}&cartt_fatora=${snapshot.data[index].carttFatora}&cartt_seller=${snapshot.data[index].carttSeller}&lang=${_appState.currentLang}');
                                                _progressIndicatorState.setIsLoading(false);
                                                if (results['response'] == '1') {

                                                  _orderList = _getOrderList();

                                                  setState(() {
                                                    showToast( results['message'], context);
                                                  });



                                                } else {
                                                  showErrorDialog(
                                                      results['message'], context);
                                                }


                                                _orderState.setCarttFatora(snapshot.data[index].carttFatora);
                                                _orderState.setCarttSeller(snapshot.data[index].carttSeller);
                                                _orderState.setCarttFatora(snapshot.data[index].carttFatora);
                                                _orderState.setCarttSeller(snapshot.data[index].carttSeller);



                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) => OrderReciveScreen()));

                                              },
                                            ),

                                          ),



                                          Container(
                                            margin: EdgeInsets.symmetric(vertical: 0),
                                            width: width*.44,
                                            height: 45,
                                            child: CustomButton(
                                              btnColor: Color(0xffEB1B1B),
                                              btnLbl: "رفض الطلب",
                                              onPressedFunction: () async {


                                                _progressIndicatorState.setIsLoading(true);
                                                var results = await _services.get(
                                                    'https://ninanapp.com/app/api/driver_cancel_request?user_id=${_appState.currentUser.userId}&cartt_fatora=${snapshot.data[index].carttFatora}&cartt_seller=${snapshot.data[index].carttSeller}&lang=${_appState.currentLang}');
                                                _progressIndicatorState.setIsLoading(false);
                                                if (results['response'] == '1') {

                                                  _orderList = _getOrderList();

                                                  setState(() {
                                                    showToast( results['message'], context);
                                                  });



                                                } else {
                                                  showErrorDialog(
                                                      results['message'], context);
                                                }



                                              },
                                            ),
                                          )



                                        ],
                                      ):Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Container(
                                            margin: EdgeInsets.symmetric(vertical: 0),
                                            width: width*.44,
                                            height: 45,
                                            child: CustomButton(
                                              btnColor: cPrimaryColor,
                                              btnLbl: "استلام الطلب",
                                              onPressedFunction: () async {


                                                _progressIndicatorState.setIsLoading(true);
                                                var results = await _services.get(
                                                    'https://ninanapp.com/app/api/driver_accept_request?user_id=${_appState.currentUser.userId}&cartt_fatora=${snapshot.data[index].carttFatora}&cartt_seller=${snapshot.data[index].carttSeller}&lang=${_appState.currentLang}');
                                                _progressIndicatorState.setIsLoading(false);
                                                if (results['response'] == '1') {

                                                  _orderList = _getOrderList();

                                                  setState(() {
                                                    showToast( results['message'], context);
                                                  });



                                                } else {
                                                  showErrorDialog(
                                                      results['message'], context);
                                                }


                                                _orderState.setCarttFatora(snapshot.data[index].carttFatora);
                                                _orderState.setCarttSeller(snapshot.data[index].carttSeller);
                                                _orderState.setCarttFatora(snapshot.data[index].carttFatora);
                                                _orderState.setCarttSeller(snapshot.data[index].carttSeller);


                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) => OrderReciveScreen()));


                                              },
                                            ),

                                          ),






                                        ],
                                      ),






                                    ],
                                  ),
                                ));
                          }),
                        );
                      }),
                )
              ],
            );

          } else {
            return NoData(
              message: AppLocalizations.of(context).noResults,
            );
          }
        } else if (snapshot.hasError) {
          return Center(child: Text("${snapshot.error}"));
        }

        return Center(
            child: SpinKitThreeBounce(
              color: cPrimaryColor,
              size: 40,
            ));
      },
    );
  }
}