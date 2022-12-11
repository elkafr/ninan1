import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:ninan1/components/app_repo/app_state.dart';
import 'package:ninan1/components/app_repo/navigation_state.dart';
import 'package:ninan1/components/app_repo/order_state.dart';
import 'package:ninan1/components/app_repo/progress_indicator_state.dart';
import 'package:ninan1/components/app_repo/store_state.dart';
import 'package:ninan1/components/app_repo/tab_state.dart';
import 'package:ninan1/components/buttons/custom_button.dart';
import 'package:ninan1/components/connectivity/network_indicator.dart';
import 'package:ninan1/components/gradient_app_bar/gradient_app_bar.dart';
import 'package:ninan1/components/no_data/no_data.dart';
import 'package:ninan1/components/response_handling/response_handling.dart';
import 'package:ninan1/components/safe_area/page_container.dart';
import 'package:ninan1/locale/localization.dart';
import 'package:ninan1/models/order.dart';
import 'package:ninan1/screens/orders/components/cancel_order_bottom_sheet.dart';
import 'package:ninan1/services/access_api.dart';
import 'package:ninan1/utils/app_colors.dart';
import 'package:ninan1/screens/order_details/add_new_product_to_order.dart';

class EditOrderDetailsScreen extends StatefulWidget {
  @override
  _EditOrderDetailsScreenState createState() => _EditOrderDetailsScreenState();
}

class _EditOrderDetailsScreenState extends State<EditOrderDetailsScreen> {
  bool _initialRun = true;
  OrderState _orderState;
  double _height, _width;
  Services _services = Services();
  ProgressIndicatorState _progressIndicatorState;

  AppState _appState;
  NavigationState _navigationState;
  StoreState _storeState;

  Future<Order> _orderDetails;

  Future<Order> _getOrderDetails() async {
    Map<String, dynamic> results = await _services.get(
        'https://ninanapp.com/app/api/show_buy?lang=${_appState.currentLang}&user_id=${_appState.currentUser.userId}&cartt_fatora=${_orderState.carttFatora}&cartt_seller=${_orderState.carttSeller}');
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
      _appState = Provider.of<AppState>(context);
      _orderState = Provider.of<OrderState>(context);
      _orderDetails = _getOrderDetails();
      _initialRun = false;
    }
  }

  Widget _buildCartList(Order order) {
    return LayoutBuilder(builder: (context, constraints) {
      return ListView.builder(
          shrinkWrap: true,
          physics: ClampingScrollPhysics(),
          itemCount: order.carttDetails.length,
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
                                  width: 1.0, color: Color(0xffEBEBEB)),
                              color: cWhite,
                              borderRadius: BorderRadius.circular(
                                10.0,
                              )),
                          child: Image.network(
                            order.carttDetails[index].carttPhoto,
                            height: constraints.maxHeight * 0.5,
                            width: constraints.maxWidth * 0.25,
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              width: _width * 0.5,
                              margin: EdgeInsets.only(top: 10, bottom: 5),
                              child: Text(
                                order.carttDetails[index].carttName,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            SizedBox(
                              height: constraints.maxHeight * 0.1,
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
                                    AppLocalizations.of(context).amount,
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  FloatingActionButton(
                                    elevation: 0,
                                    backgroundColor: cWhite,
                                    heroTag: 'btn45 $index',
                                    child: Icon(
                                      FontAwesomeIcons.plus,
                                      color: cPrimaryColor,
                                      size: 15,
                                    ),
                                    onPressed: () async {
                                      setState(() {
                                        order.carttDetails[index].carttAmount++;
                                      });
                                      await _services.get(
                                          'https://ninanapp.com/app/api/updateAmount1?cartt_amount=${order.carttDetails[index].carttAmount}&cartt_ads=${order.carttDetails[index].carttAds}&cartt_fatora=${order.carttFatora}&cartt_seller=${order.carttSeller}');
                                    },
                                  ),
                                  Container(
                                    width: 25,
                                    height: 25,
                                    child: Center(
                                      child: Text(
                                        order.carttDetails[index].carttAmount
                                            .toString(),
                                        style: TextStyle(
                                            fontSize: 14, color: Colors.white),
                                      ),
                                    ),
                                    decoration: BoxDecoration(
                                        color: cPrimaryColor,
                                        border: Border.all(
                                            color: cPrimaryColor, width: 1.0),
                                        shape: BoxShape.circle),
                                  ),
                                  FloatingActionButton(
                                    elevation: 0,
                                    backgroundColor: cWhite,
                                    heroTag: 'btn451 $index',
                                    child: Icon(
                                      FontAwesomeIcons.minus,
                                      color: cPrimaryColor,
                                      size: 15,
                                    ),
                                    onPressed: () async {
                                      if (order
                                              .carttDetails[index].carttAmount >
                                          0) {
                                        setState(() {
                                          order.carttDetails[index]
                                              .carttAmount--;
                                        });
                                        await _services.get(
                                            'https://ninanapp.com/app/api/updateAmount1?cartt_amount=${order.carttDetails[index].carttAmount}&cartt_ads=${order.carttDetails[index].carttAds}&cartt_fatora=${order.carttFatora}&cartt_seller=${order.carttSeller}');
                                      }
                                    },
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        order.carttDetails[index].carttPrice
                                            .toString(),
                                        style: TextStyle(
                                            color: cPrimaryColor,
                                            fontWeight: FontWeight.w700),
                                      ),
                                      Text(
                                     AppLocalizations.of(context).sr,
                                        style: TextStyle(
                                            color: cPrimaryColor,
                                            fontSize: 13,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ],
                                  )
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
                       left: _appState.currentLang == 'ar' ? 0 : constraints.maxWidth *0.8,
              right: _appState.currentLang != 'ar' ? 0 : constraints.maxWidth *0.8,
              top: 0,
                  child: GestureDetector(
                      onTap: () async {
                        _progressIndicatorState.setIsLoading(true);
                        var results = await _services.get(
                            'https://ninanapp.com/app/api/deleteFromRequest?cartt_ads=${order.carttDetails[index].carttAds}&cartt_fatora=${order.carttFatora}&cartt_seller=${order.carttSeller}&lang=${_appState.currentLang}');
                        _progressIndicatorState.setIsLoading(false);
                        if (results['response'] == '1') {
                          showToast(results['message'], context);
                          if (order.carttDetails.length == 1) {
                            _navigationState.upadateNavigationIndex(1);
                            Navigator.pushNamed(context, '/navigation');
                          } else {
                            Navigator.pushReplacementNamed(
                                context, '/edit_order_details_screen');
                          }
                        } else {
                          showErrorDialog(results['message'], context);
                        }
                      },
                      child: Image.asset('assets/images/delete.png')),
                )
              ],
            );
          });
    });
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
          Text(value,
              style: TextStyle(
                  fontSize: 15, fontWeight: FontWeight.w400, color: cBlack))
        ],
      ),
    );
  }

  Widget _buildBodyItem(Order order) {
    return ListView(
      children: <Widget>[
        SizedBox(
          height: 60,
        ),
        Container(
            height:50,
            child: _buildRow(AppLocalizations.of(context).orderNo, order.carttNumber)),
        Container(
            color: Color(0xffFBF6F6),
            height: 50,
            child: _buildRow(AppLocalizations.of(context).store, order.carttMtgerName)),
        Container(
          color: cWhite,
          width: _width,
          height: _height * 0.4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(
                    left: _width * 0.04,
                    right: _width * 0.04,
                    top: _height * 0.025),
                height: _height * 0.05,
                child: Text('${AppLocalizations.of(context).orderDetails} :',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: cBlack)),
              ),
              Container(
                color: cWhite,
                width: _width,
                height: _height * 0.3,
                child: _buildCartList(order),
              )
            ],
          ),
        ),
        Container(
            color: Color(0xffFBF6F6),
            height: 50,
            child: _buildRow(AppLocalizations.of(context).totalPrice, order.carttTotal.toString())),
        Container(
            color: cWhite,
            height: 50,
            child: _buildRow(AppLocalizations.of(context).orderDate, order.carttDate)),
        Container(
            color: Color(0xffFBF6F6),
            height: 50,
            child: _buildRow(AppLocalizations.of(context).orderStatus, order.carttState)),
        Divider(
          height: _height * 0.05,
        ),
        Row(
          children: <Widget>[
            Container(
                margin: EdgeInsets.only(bottom: _height * 0.01),
                height: 60,
                width: _width * 0.5,
                child: CustomButton(
                    btnStyle: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                        color: cWhite),
                    btnLbl: AppLocalizations.of(context).saveChanges,
                    onPressedFunction: () {
                      Navigator.pop(context);
                      Navigator.pushReplacementNamed(
                          context, '/order_details_screen');
                    })),
            Container(
                margin: EdgeInsets.only(bottom: _height * 0.01),
                height: 60,
                width: _width * 0.5,
                child: CustomButton(
                    btnStyle: TextStyle(
                      color: cPrimaryColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                    ),
                    hasGradientColor: false,
                    btnLbl: AppLocalizations.of(context).addNewProduct,
                    btnColor: cWhite,
                    onPressedFunction: () {
                      _storeState.setCurrentStoreId(order.carttSeller);
                       _storeState.setCurrentStoreTitle(order.carttMtgerName);
                       Navigator.pushNamed(context, '/add_new_product_to_order_screen');
                     
                    })),
          ],
        )
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
    _storeState = Provider.of<StoreState>(context);

    return NetworkIndicator(
        child: PageContainer(
      child: Scaffold(
          body: FutureBuilder<Order>(
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
                            appBarTitle: snapshot.data.carttFatora,
                           leading: _appState.currentLang == 'ar' ? IconButton(
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: cWhite,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ) :Container(),
              trailing: _appState.currentLang == 'en' ? IconButton(
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: cWhite,
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
