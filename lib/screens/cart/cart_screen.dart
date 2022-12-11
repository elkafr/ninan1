

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ninan1/models/cart_details.dart';
import 'package:ninan1/models/cart.dart';
import 'package:ninan1/screens/cart/components/add_cupon.dart';
import 'package:ninan1/screens/cart/components/add_note.dart';
import 'package:ninan1/screens/home/components/select_location.dart';
import 'package:provider/provider.dart';
import 'package:ninan1/components/app_repo/app_state.dart';
import 'package:ninan1/components/app_repo/location_state.dart';
import 'package:ninan1/components/app_repo/navigation_state.dart';
import 'package:ninan1/components/app_repo/progress_indicator_state.dart';
import 'package:ninan1/components/buttons/custom_button.dart';
import 'package:ninan1/components/connectivity/network_indicator.dart';
import 'package:ninan1/components/gradient_app_bar/gradient_app_bar.dart';
import 'package:ninan1/components/no_data/no_data.dart';
import 'package:ninan1/components/not_registered/not_registered.dart';
import 'package:ninan1/components/progress_indicator_component/progress_indicator_component.dart';
import 'package:ninan1/components/response_handling/response_handling.dart';
import 'package:ninan1/components/safe_area/page_container.dart';
import 'package:ninan1/screens/cart/components/select_pay.dart';
import 'package:ninan1/locale/localization.dart';
import 'package:ninan1/services/access_api.dart';
import 'package:ninan1/utils/app_colors.dart';
import 'package:ninan1/models/cart_item.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  double _height, _width;
  ProgressIndicatorState _progressIndicatorState;
  NavigationState _navigationState;
  AppState _appState;
  LocationState _locationState;
  int _totalPrice = 0, _totalAmount = 0;
  Services _services = Services();
  bool _initialRun = true;
  Future<List<Cart>> _cartList;
  Future<List<CartDetails>> _cartDetails;
  bool _enableToBuy = false;
  String payMethod ;
  String from_time="0";
  String to_time="0";
  String price;
  String delivery;
  String cupone;
  String mtger_percent;
  String vat;
  String total;

  Future<List<Cart>> _getCartItems() async {
    Map<String, dynamic> results = await _services.get(
        'https://ninanapp.com/app/api/last_cart?user_id=${_appState.currentUser.userId}&user_mapx=${_locationState.locationLatitude}&user_mapy=${_locationState.locationlongitude}&lang=${_appState.currentLang}&cupone_value=${_appState.cupone}');
    List<Cart> cartList = List<Cart>();
    if (results['response'] == '1') {
      Iterable iterable = results['ads'];
      cartList = iterable.map((model) => Cart.fromJson(model)).toList();
      if (cartList.length > 0) {
        _enableToBuy = true;
      }

      setState(() {
        for (int i = 0; i < cartList.length; i++) {
          _totalPrice += cartList[i].price;
          _totalAmount += cartList[i].cartAmount;
        }
      });

      print('cart amount :$_totalAmount');
    } else {
      print('error');
    }
    return cartList;
  }


  Future<List<CartDetails>> _getCartDetails() async {
    Map<String, dynamic> results = await _services.get(
        'https://ninanapp.com/app/api/last_cart?user_id=${_appState.currentUser.userId}&user_mapx=${_locationState.locationLatitude}&user_mapy=${_locationState.locationlongitude}&lang=${_appState.currentLang}');
    List<CartDetails> cartDetails = List<CartDetails>();
    if (results['response'] == '1') {
      Iterable iterable = results['details'];
      cartDetails= iterable.map((model) => CartDetails.fromJson(model)).toList();
     setState(() {

       from_time= cartDetails[0].fromTime.toString();
       to_time= cartDetails[0].total.toString();
       price= cartDetails[0].price.toString();
       delivery= cartDetails[0].delivery.toString();
       cupone= cartDetails[0].cupone.toString();
       mtger_percent= cartDetails[0].mtgerPercent.toString();
       vat= cartDetails[0].vat.toString();
       total= cartDetails[0].total.toString();

   // print('sssssss'+xxx);
     });


    } else {
      print('error');
    }
    return cartDetails;
  }

  Widget _buildCartList() {
    if(_appState.payMethod=="1"){
      payMethod="عند الاستلام";
    }else if(_appState.payMethod=="2"){
      payMethod="المحفظة";
    }else if(_appState.payMethod=="3"){
      payMethod="البطاقة الائئتمانية";
    }
    return LayoutBuilder(builder: (context, constraints) {
      return FutureBuilder<List<Cart>>(
          future: _cartList,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data.length > 0) {
                return ListView.builder(
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Stack(
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 1.0,
                                            color: Color(0xffEBEBEB)),
                                        color: cWhite,
                                        borderRadius: BorderRadius.circular(
                                          10.0,
                                        )),
                                    child: Image.network(
                                      snapshot.data[index].adsMtgerPhoto,
                                      height: constraints.maxHeight * 0.25,
                                      width: constraints.maxWidth * 0.25,
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        width: _width * 0.5,
                                        margin:
                                            EdgeInsets.only(top: 10, bottom: 5),
                                        child: Text(
                                          snapshot.data[index].title,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      SizedBox(
                                        height: constraints.maxHeight * 0.035,
                                      ),
                                      // Image.asset(
                                      //   'assets/images/logo.png',
                                      //   height: constraints.maxHeight * 0.1,
                                      //   width: constraints.maxWidth * 0.1,
                                      // ),
                                      Container(
                                        height: _height * 0.05,
                                        child: Row(
                                          children: <Widget>[
                                            Text(
                                              AppLocalizations.of(context)
                                                  .amount,
                                              style: TextStyle(
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                            FloatingActionButton(
                                              elevation: 0,
                                              backgroundColor: cWhite,
                                              heroTag: 'btn $index',
                                              child: Icon(
                                                FontAwesomeIcons.plus,
                                                color: cPrimaryColor,
                                                size: 15,
                                              ),
                                              onPressed: () async {
                                                print('amount');
                                                setState(() {
                                                  snapshot
                                                      .data[index].cartAmount++;
                                                  _totalAmount++;


                                                  _cartDetails= _getCartDetails();

                                                });
                                                await _services.get(
                                                    'https://ninanapp.com/app/api/updateAmount?cart_amount=${snapshot.data[index].cartAmount}&cart_id=${snapshot.data[index].cartId}');
                                              },
                                            ),
                                            Container(
                                              width: 25,
                                              height: 25,
                                              child: Center(
                                                child: Text(
                                                  snapshot
                                                      .data[index].cartAmount
                                                      .toString(),
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.white),
                                                ),
                                              ),
                                              decoration: BoxDecoration(
                                                  color: cPrimaryColor,
                                                  border: Border.all(
                                                      color: cPrimaryColor,
                                                      width: 1.0),
                                                  shape: BoxShape.circle),
                                            ),
                                            FloatingActionButton(
                                              elevation: 0,
                                              backgroundColor: cWhite,
                                              heroTag: 'btn1 $index',
                                              child: Icon(
                                                FontAwesomeIcons.minus,
                                                color: cPrimaryColor,
                                                size: 15,
                                              ),
                                              onPressed: () async {
                                                setState(() {
                                                  if (snapshot.data[index]
                                                          .cartAmount >
                                                      0) {
                                                    snapshot.data[index]
                                                        .cartAmount--;
                                                    _totalAmount--;

                                                    _cartDetails= _getCartDetails();

                                                  }
                                                });
                                                if (snapshot.data[index]
                                                        .cartAmount >
                                                    0) {
                                                  await _services.get(
                                                      'https://ninanapp.com/app/api/updateAmount?cart_amount=${snapshot.data[index].cartAmount}&cart_id=${snapshot.data[index].cartId}');
                                                }
                                              },
                                            ),
                                            Text(
                                              '${snapshot.data[index].cartPrice.toString()} ${AppLocalizations.of(context).sr}',
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                              Divider(),
                            ],
                          ),
                          Positioned(
                            left: _appState.currentLang == 'ar'
                                ? 0
                                : constraints.maxWidth * 0.8,
                            right: _appState.currentLang != 'ar'
                                ? 0
                                : constraints.maxWidth * 0.8,
                            top: 0,
                            child: GestureDetector(
                                onTap: () async {


                                  _progressIndicatorState.setIsLoading(true);
                                  var results = await _services.get(
                                      'https://ninanapp.com/app/api/delete_cart?user_id=${_appState.currentUser.userId}&cart_id=${snapshot.data[index].cartId}&lang=${_appState.currentLang}');
                                  _progressIndicatorState.setIsLoading(false);
                                  if (results['response'] == '1') {

                                    setState(() {

                                      _cartList = _getCartItems();
                                      _cartDetails= _getCartDetails();

                                    });

                                    showToast(results['message'], context);


                                  } else {
                                    showErrorDialog(
                                        results['message'], context);
                                  }


                                },
                                child: Image.asset('assets/images/delete.png')),
                          )
                        ],
                      );
                    });
              } else {
                return NoData(
                    message: AppLocalizations.of(context).noResultIntoCart);
              }
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }

            return Center(
                child: SpinKitSquareCircle(color: cPrimaryColor, size: 25));
          });
    });
  }

  Widget _buildBodyItem() {
    return SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child: Container(
            height: _height,
            width: _width,
            child: Column(
              children: <Widget>[


                SizedBox(
                  height: _height * 0.08,
                ),
                Container(
                  margin: EdgeInsets.only(right: _width*.02),
                  alignment: Alignment.centerRight,
                  child: Text("طلبك",style: TextStyle(color: cText,fontSize: 16),),
                ),
                SizedBox(
                  height: _height * 0.02,
                ),
                Expanded(
                    child: Container(
                  color: Color(0xffF9F9F9),
                  width: _width,
                  // height: _height * 0.65,
                  child: _buildCartList(),
                )),

                SizedBox(
                  height: _height * 0.01,
                ),
            Container(
              height: _height * 0.066,
              child: ListTile(
                title: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: <Widget>[
                    Text("طريقة الدفع",style: TextStyle(color: cText,fontSize: 16,fontFamily: "segoeui",fontWeight: FontWeight.bold),),
                    SizedBox(
                      height: _height * 0.01,
                    ),
                    Row(
                      children: <Widget>[
                       Image.asset("assets/images/pay.png"),
                        Padding(padding: EdgeInsets.all(2)),
                        Text(_appState.payMethod!=null?payMethod:"لم يتم التحديد",style: TextStyle(color: cText,fontSize: 15),)
                      ],
                    )
                  ],
                ),
                trailing: GestureDetector(
                  onTap: (){


                    showModalBottomSheet<dynamic>(
                        isScrollControlled: true,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20))),
                        context: context,
                        builder: (builder) {
                          return Container(
                            height: _height*.5,
                            child: SelectPay(),
                          );
                        });


                  },
                  child: Container(
                    padding: EdgeInsets.only(right: 15,left: 15,top: 6,bottom: 6),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(6.00),
                      ),
                      color: cWhite,
                      border: Border.all(color: cPrimaryColor, width: 1.0),
                    ),
                    child: Text("تغيير",style: TextStyle(color: cText,fontSize: 14),),
                  ),
                ),
              ),
            ),

                Container(
                    margin: EdgeInsets.symmetric(vertical: 1),
                    child: Divider()),




                Container(
                  height: _height * 0.066,
                  child: ListTile(
                    title: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: <Widget>[
                        Text("طريقة التوصيل",style: TextStyle(color: cText,fontSize: 16,fontWeight: FontWeight.bold,fontFamily: "segoeui"),),
                        SizedBox(
                          height: _height * 0.01,
                        ),
                        Row(
                          children: <Widget>[
                            Image.asset("assets/images/pay.png"),
                            Padding(padding: EdgeInsets.all(2)),
                            Text(_appState.payMethod!=null?payMethod:"لم يتم التحديد",style: TextStyle(color: cText,fontSize: 15),)
                          ],
                        )
                      ],
                    ),
                    trailing: GestureDetector(
                      onTap: (){


                        showModalBottomSheet<dynamic>(
                            isScrollControlled: true,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20))),
                            context: context,
                            builder: (builder) {
                              return Container(
                                height: _height*.5,
                                child: SelectLocation(),
                              );
                            });


                      },
                      child: Container(
                        padding: EdgeInsets.only(right: 15,left: 15,top: 6,bottom: 6),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(6.00),
                          ),
                          color: cWhite,
                          border: Border.all(color: cPrimaryColor, width: 1.0),
                        ),
                        child: Text("تغيير",style: TextStyle(color: cText,fontSize: 14),),
                      ),
                    ),
                  ),
                ),



                Container(
                    margin: EdgeInsets.symmetric(vertical: 1),
                    child: Divider()),



                Container(
                  margin: EdgeInsets.only(top: 0, left: 15, right: 15),
                  height: _height * 0.061,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("مدة التوصيل المتوقعة",style: TextStyle(color: cText,fontSize: 16,fontFamily: "segoeui",fontWeight: FontWeight.bold),),
                      SizedBox(
                        height: _height * 0.01,
                      ),
                      Row(
                        children: <Widget>[
                          Image.asset("assets/images/time.png"),
                          Padding(padding: EdgeInsets.all(2)),
                          Text(from_time+" - "+to_time+" "+"دقائق")
                        ],
                      )
                    ],
                  ),
                ),




                Container(
                    margin: EdgeInsets.symmetric(vertical: 1),
                    child: Divider()),




                Container(
                  margin: EdgeInsets.only(top: 0, left: 15, right: 15),
                  height: _height * 0.035,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text("قسيمة الخصم",style: TextStyle(color: cText,fontSize: 16,fontFamily: "segoeui",fontWeight: FontWeight.bold),),
                          GestureDetector(
                            child: Row(
                              children: <Widget>[
                                Icon(Icons.add,color: cPrimaryColor,),
                                Text("اضف كوبون",style: TextStyle(color: cPrimaryColor,fontSize: 15,fontFamily: "segoeui"),),
                              ],
                            ),
                            onTap: (){
                              showModalBottomSheet<dynamic>(
                                  isScrollControlled: true,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(20),
                                          topRight: Radius.circular(20))),
                                  context: context,
                                  builder: (builder) {
                                    return Container(
                                      height: _height*.3,
                                      child: AddCupone(),
                                    );
                                  });
                            },
                          )
                        ],
                      )
                    ],
                  ),
                ),

                Container(
                    margin: EdgeInsets.symmetric(vertical: 1),
                    child: Divider()),

                Container(
                  height: _height * 0.021,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(top: 0, left: 10, right: 10),
                        child: Text(
                          AppLocalizations.of(context).productsNo,
                          style: TextStyle(
                              color: cBlack,
                              fontSize: 15,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 0, left: 10, right: 10),
                        child: Text(
                          _totalAmount.toString(),
                          style: TextStyle(
                              color: cPrimaryColor,
                              fontSize: 17,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                ),
                FutureBuilder<List<Cart>>(
                    future: _cartList,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Container(
                            height: _height * 0.035,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.only(
                                      top: 0, left: 10, right: 10),
                                  child: Text(
                                    "قيمة الطلب",
                                    style: TextStyle(
                                      color: cBlack,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: 'segoeui',
                                    ),
                                  ),
                                ),
                                Container(
                                    margin: EdgeInsets.only(
                                        top: 0, left: 10, right: 10),
                                    child: RichText(
                                      text: TextSpan(
                                        style: TextStyle(
                                          color: cPrimaryColor,
                                          fontSize: 17,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: 'segoeui',
                                        ),
                                        children: <TextSpan>[
                                          new TextSpan(
                                              text:
                                                  '$price'),
                                          new TextSpan(
                                              text: AppLocalizations.of(context)
                                                  .sr,
                                              style: new TextStyle(
                                                color: cPrimaryColor,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 14,
                                                fontFamily: 'segoeui',
                                              )),
                                        ],
                                      ),
                                    )),
                              ],
                            ));
                      } else if (snapshot.hasError) {
                        return Text("${snapshot.error}");
                      }

                      return Center(
                          child: SpinKitSquareCircle(
                              color: cPrimaryColor, size: 25));
                    }),



                FutureBuilder<List<CartDetails>>(
                    future: _cartDetails,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Container(
                            height: _height * 0.111,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Container(
                                      margin: EdgeInsets.only(
                                          top: 0, left: 10, right: 10),
                                      child: Text(
                                        "رسوم التوصيل",
                                        style: TextStyle(
                                          color: cBlack,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400,
                                          fontFamily: 'segoeui',
                                        ),
                                      ),
                                    ),
                                    Container(
                                        margin: EdgeInsets.only(
                                            top: 0, left: 10, right: 10),
                                        child: RichText(
                                          text: TextSpan(
                                            style: TextStyle(
                                              color: cPrimaryColor,
                                              fontSize: 17,
                                              fontWeight: FontWeight.w600,
                                              fontFamily: 'segoeui',
                                            ),
                                            children: <TextSpan>[
                                              new TextSpan(
                                                  text:
                                                  '$delivery'),
                                              new TextSpan(
                                                  text: AppLocalizations.of(context)
                                                      .sr,
                                                  style: new TextStyle(
                                                    color: cPrimaryColor,
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 14,
                                                    fontFamily: 'segoeui',
                                                  )),
                                            ],
                                          ),
                                        )),
                                  ],
                                ),





                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Container(
                                      margin: EdgeInsets.only(
                                          top: 2, left: 10, right: 10),
                                      child: Text(
                                        "الضريبة",
                                        style: TextStyle(
                                          color: cBlack,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400,
                                          fontFamily: 'segoeui',
                                        ),
                                      ),
                                    ),
                                    Container(
                                        margin: EdgeInsets.only(
                                            top: 2, left: 10, right: 10),
                                        child: RichText(
                                          text: TextSpan(
                                            style: TextStyle(
                                              color: cPrimaryColor,
                                              fontSize: 17,
                                              fontWeight: FontWeight.w600,
                                              fontFamily: 'segoeui',
                                            ),
                                            children: <TextSpan>[
                                              new TextSpan(
                                                  text:
                                                  vat!='null'?'$vat':'0'),
                                              new TextSpan(
                                                  text: AppLocalizations.of(context)
                                                      .sr,
                                                  style: new TextStyle(
                                                    color: cPrimaryColor,
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 14,
                                                    fontFamily: 'segoeui',
                                                  )),
                                            ],
                                          ),
                                        )),
                                  ],
                                ),




                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Container(
                                      margin: EdgeInsets.only(
                                          top: 2, left: 10, right: 10),
                                      child: Text(
                                        "الخصم",
                                        style: TextStyle(
                                          color: cBlack,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400,
                                          fontFamily: 'segoeui',
                                        ),
                                      ),
                                    ),
                                    Container(
                                        margin: EdgeInsets.only(
                                            top: 2, left: 10, right: 10),
                                        child: RichText(
                                          text: TextSpan(
                                            style: TextStyle(
                                              color: cPrimaryColor,
                                              fontSize: 17,
                                              fontWeight: FontWeight.w600,
                                              fontFamily: 'segoeui',
                                            ),
                                            children: <TextSpan>[
                                              new TextSpan(
                                                  text:
                                                  cupone!='null'?'$cupone':"0"),
                                              new TextSpan(
                                                  text: AppLocalizations.of(context)
                                                      .sr,
                                                  style: new TextStyle(
                                                    color: cPrimaryColor,
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 14,
                                                    fontFamily: 'segoeui',
                                                  )),
                                            ],
                                          ),
                                        )),
                                  ],
                                ),






                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Container(
                                      margin: EdgeInsets.only(
                                          top: 2, left: 10, right: 10),
                                      child: Text(
                                        "اجمالي الطلب",
                                        style: TextStyle(
                                          color: cBlack,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400,
                                          fontFamily: 'segoeui',
                                        ),
                                      ),
                                    ),
                                    Container(
                                        margin: EdgeInsets.only(
                                            top: 2, left: 10, right: 10),
                                        child: RichText(
                                          text: TextSpan(
                                            style: TextStyle(
                                              color: cPrimaryColor,
                                              fontSize: 17,
                                              fontWeight: FontWeight.w600,
                                              fontFamily: 'segoeui',
                                            ),
                                            children: <TextSpan>[
                                              new TextSpan(
                                                  text:
                                                  '$total'),
                                              new TextSpan(
                                                  text: AppLocalizations.of(context)
                                                      .sr,
                                                  style: new TextStyle(
                                                    color: cPrimaryColor,
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 14,
                                                    fontFamily: 'segoeui',
                                                  )),
                                            ],
                                          ),
                                        )),
                                  ],
                                )



                              ],
                            ));
                      } else if (snapshot.hasError) {
                        return Text("${snapshot.error}");
                      }

                      return Center(
                          child: SpinKitSquareCircle(
                              color: cPrimaryColor, size: 25));
                    }),



                Container(
                    margin: EdgeInsets.symmetric(vertical: 5),
                    child: Divider()),
                Center(
                  child: Text(
                    AppLocalizations.of(context).applicationValue,
                    style: TextStyle(color: Color(0xffC5C5C5), fontSize: 12),
                  ),
                ),

















                Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    height: 60,
                    child: CustomButton(
                        btnLbl: AppLocalizations.of(context).completePurchase,
                        onPressedFunction: () async {


                          if(_appState.payMethod!=null){


                            if (_enableToBuy) {
                              _progressIndicatorState.setIsLoading(true);
                              var results = await _services.get(
                                //'https://ninanapp.com/app/api/cash?user_id=${_appState.currentUser.userId}&lang=${_appState.currentLang}&from_time=$from_time&to_time=$to_time&price=$price&cupone=$cupone&total=$total&cupone_value=${_appState.cupone!=null?_appState.cupone:""}&delivery_type=2&notes=${_appState.note!=null?_appState.note:""}&user_mapx=${_locationState.locationLatitude.toString()}&user_mapy=${_locationState.locationlongitude.toString()}&user_adress=3333333&mtger_percent=10'
                                  'https://ninanapp.com/app/api/cash?user_id=${_appState.currentUser.userId}&from_time=$from_time&to_time=$to_time&price=$price&delivery=$delivery&cupone=$cupone&total=$total&cupone_value=${_appState.cupone!=null?_appState.cupone:""}&delivery_type=2&notes=${_appState.note!=null?_appState.note:""}&user_mapx=${_locationState.locationLatitude.toString()}&user_mapy=${_locationState.locationlongitude.toString()}&user_adress=${_locationState.address.toString()}&mtger_percent=10'
                              );
                              print(results);
                              _progressIndicatorState.setIsLoading(false);
                              if (results['response'] == '1') {
                                showModalBottomSheet(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(20),
                                          topLeft: Radius.circular(20)),
                                    ),
                                    context: context,
                                    builder: (builder) {
                                      return Container(
                                        height: _height * 0.25,
                                        child: Column(
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                          children: <Widget>[
                                            Image.asset(
                                                'assets/images/check.png'),
                                            Text(
                                              AppLocalizations.of(context)
                                                  .purchaseRequestHasSentSuccessfully,
                                              style: TextStyle(
                                                  color: cBlack,
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.w600),
                                            )
                                          ],
                                        ),
                                      );
                                    });
                                Future.delayed(const Duration(seconds: 1), () {
                                  _navigationState.upadateNavigationIndex(1);
                                  Navigator.pushNamed(context, '/navigation');
                                });
                              } else {
                                showErrorDialog(results['message'], context);
                              }
                            } else {
                              showToast(
                                  AppLocalizations.of(context).noResultIntoCart,
                                  context);
                            }



                          }else{
                            showErrorDialog("يجب  اختيار طريقة الدفع اولا", context);
                          }






                        }))
              ],
            )));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_initialRun) {
      _initialRun = false;
      _appState = Provider.of<AppState>(context);
      _locationState = Provider.of<LocationState>(context);
      if (_appState.currentUser != null) {
        _cartList = _getCartItems();
        _cartDetails= _getCartDetails();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    _height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    _width = MediaQuery.of(context).size.width;
    _progressIndicatorState = Provider.of<ProgressIndicatorState>(context);
    _navigationState = Provider.of<NavigationState>(context);
    return NetworkIndicator(
        child: PageContainer(
      child: Scaffold(
          resizeToAvoidBottomPadding: true,
          backgroundColor: Colors.white,
          body: Stack(
            children: <Widget>[
              Consumer<AppState>(builder: (context, appState, child) {
                return appState.currentUser != null
                    ? _buildBodyItem()
                    : NotRegistered();
              }),
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: GradientAppBar(
                  appBarTitle: AppLocalizations.of(context).cart,
                  leading: IconButton(
                    icon: Image.asset("assets/images/back.png"),
                    onPressed: () {
                      Navigator.pushNamed(context, '/store_screen');
                    },
                  ),
                  trailing: IconButton(
                    icon: Image.asset("assets/images/note.png"),
                    onPressed: () {
                      showModalBottomSheet<dynamic>(
                          isScrollControlled: true,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20))),
                          context: context,
                          builder: (builder) {
                            return Container(
                              height: _height*.4,
                              child: AddNote(),
                            );
                          });
                    },
                  ),
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
