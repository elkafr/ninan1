import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ninan1/components/app_repo/store_state.dart';
import 'package:ninan1/screens/home/cancel1.dart';
import 'package:provider/provider.dart';
import 'package:ninan1/components/app_repo/app_state.dart';
import 'package:ninan1/components/no_data/no_data.dart';
import 'package:ninan1/locale/localization.dart';
import 'package:ninan1/models/order.dart';
import 'package:ninan1/screens/orders/components/mtger_done_order.dart';
import 'package:ninan1/services/access_api.dart';
import 'package:ninan1/utils/app_colors.dart';
import 'package:ninan1/components/app_repo/progress_indicator_state.dart';





import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ninan1/components/buttons/custom_button.dart';
import 'package:ninan1/utils/app_colors.dart';
import 'package:ninan1/utils/app_colors.dart';
import 'package:provider/provider.dart';
import 'package:ninan1/components/app_repo/order_state.dart';
import 'package:ninan1/components/buttons/custom_button.dart';
import 'package:ninan1/locale/localization.dart';
import 'package:ninan1/models/order.dart';
import 'package:ninan1/screens/order_details/mtger_order_details.dart';
import 'package:ninan1/utils/app_colors.dart';

import 'package:flutter/rendering.dart';
import 'package:ninan1/components/response_handling/response_handling.dart';




class MtgerDoneOrders extends StatefulWidget {
  @override
  _MtgerDoneOrdersState createState() => _MtgerDoneOrdersState();
}

class _MtgerDoneOrdersState extends State<MtgerDoneOrders> {
  bool _initialRun = true;
  AppState _appState;
  StoreState _storeState;
  OrderState _orderState;
  Services _services = Services();
  Future<List<Order>> _orderList;
  ProgressIndicatorState _progressIndicatorState;


  Future<List<Order>> _getOrderList() async {

    Map<String, dynamic> results = _appState.filterOrders==null || _appState.filterOrders==11?await _services.get(
        'https://ninanapp.com/app/api/mtger_dis_buy?lang=${_appState.currentLang}&mtger_id=${_storeState.currentStore.mtgerId}&page=1&done=0'):await _services.get(
        'https://ninanapp.com/app/api/mtger_dis_buy_filter?lang=${_appState.currentLang}&mtger_id=${_storeState.currentStore.mtgerId}&page=1&done=${_appState.filterOrders}');

    List orderList = List<Order>();
    if (results['response'] == '1') {

      if (results['cancel_active'] == '1'){

        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Cancel1Screen()));

      }else {
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
                  height: 110,
                ),
                Container(
                  height: height - 140 ,
                  width: width,
                  child: ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          height: 198,
                          child: LayoutBuilder(builder: (context, constraints) {
                            return Container(
                                padding: EdgeInsets.all(10),
                                margin: EdgeInsets.only(
                                    left: constraints.maxWidth * 0.03,
                                    right: constraints.maxWidth * 0.03,
                                    bottom: constraints.maxHeight * 0.09),
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
                                    Navigator.pushNamed(context,  '/mtger_order_details_screen');

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
                                                    vertical: constraints.maxHeight * 0.04),
                                                child: Text(
                                                  "#"+snapshot.data[index].carttFatora,
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      color: Color(0xff404040),
                                                      fontWeight: FontWeight.w700),
                                                ),
                                              ),





                                              SizedBox(height: 5,),

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

                                              SizedBox(height: 5,),
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
                                                              fontWeight: FontWeight.w400,
                                                              fontSize: 15,
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
                                        margin: EdgeInsets.only(top:10,bottom: 10),
                                        height: 1,
                                        color: Color(0xffefefef),
                                      ),

                                      Container(

                                        child: Row(
                                          children: <Widget>[
                                            Image.asset("assets/images/arrow.png"),

                                            GestureDetector(
                                              onTap: (){

                                                _orderState.setCarttFatora(snapshot.data[index].carttFatora);
                                                _orderState.setCarttSeller(snapshot.data[index].carttSeller);
                                                _orderState.setCarttFatora(snapshot.data[index].carttFatora);
                                                _orderState.setCarttSeller(snapshot.data[index].carttSeller);



                                                Navigator.pushReplacementNamed(
                                                    context, '/mtger_order_details_screen');
                                              },
                                              child: Text("تفاصيل الطلب",style: TextStyle(color: Color(0xff404040),fontSize: 15),),
                                            ),
                                            Spacer(),
                                            Container(

                                              margin: EdgeInsets.symmetric(vertical: 0),

                                              width: 100,
                                              height: 40,
                                              child: snapshot.data[index].rateToMtger==null?Container(
                                                padding: EdgeInsets.only(top: 13),
                                                child: Text("لم يتم التقييم",style: TextStyle(color: cPrimaryColor),),
                                              ):Container(
                                                padding: EdgeInsets.only(top: 13),
                                                child: Row(
                                                  children: <Widget>[
                                                    Icon(Icons.star),
                                                    Padding(padding: EdgeInsets.all(5),),
                                                    Text(snapshot.data[index].rateToMtger,style: TextStyle(color: cPrimaryColor),),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )

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