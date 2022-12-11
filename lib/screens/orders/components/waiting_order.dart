import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ninan1/components/app_repo/app_state.dart';
import 'package:ninan1/components/app_repo/navigation_state.dart';
import 'package:ninan1/components/app_repo/order_state.dart';
import 'package:ninan1/components/app_repo/progress_indicator_state.dart';
import 'package:ninan1/components/app_repo/tab_state.dart';
import 'package:ninan1/components/buttons/custom_button.dart';
import 'package:ninan1/components/response_handling/response_handling.dart';
import 'package:ninan1/locale/localization.dart';
import 'package:ninan1/models/order.dart';
import 'package:ninan1/screens/order_details/edit_order_details.dart';
import 'package:ninan1/screens/order_details/order_details.dart';
import 'package:ninan1/screens/orders/components/cancel_order_bottom_sheet.dart';
import 'package:ninan1/services/access_api.dart';
import 'package:ninan1/utils/app_colors.dart';

class WaitingOrder extends StatefulWidget {
  final Order order;

  const WaitingOrder({Key key, this.order}) : super(key: key);
  @override
  _WaitingOrderState createState() => _WaitingOrderState();
}

class _WaitingOrderState extends State<WaitingOrder> {
  Services _services = Services();

  @override
  Widget build(BuildContext context) {
    final progressIndicatorState = Provider.of<ProgressIndicatorState>(context);
    final tabState = Provider.of<TabState>(context);
    final navigationState = Provider.of<NavigationState>(context);
    final orderState = Provider.of<OrderState>(context);
    final appState = Provider.of<AppState>(context);
    return LayoutBuilder(builder: (context, constraints) {
      return Container(
          margin: EdgeInsets.only(
              left: constraints.maxWidth * 0.05,
              right: constraints.maxWidth * 0.05,
              bottom: constraints.maxHeight * 0.07),
          height: constraints.maxHeight,
          decoration: BoxDecoration(
              border: Border.all(width: 1.0, color: Color(0xffEBEBEB)),
              color: cWhite,
              borderRadius: BorderRadius.circular(
                15.0,
              )),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.symmetric(
                        horizontal: constraints.maxWidth * 0.04,
                        vertical: constraints.maxHeight * 0.04),
                    child: Text(
                      widget.order.carttFatora,
                      style: TextStyle(
                          fontSize: 15,
                          color: cPrimaryColor,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                       orderState.setCarttFatora(widget.order.carttFatora);
                      orderState.setCarttSeller(widget.order.carttSeller);
                      Navigator.pushNamed(context, '/edit_order_details_screen');
                  
                    },
                    child: Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: constraints.maxWidth * 0.04,
                            vertical: constraints.maxHeight * 0.04),
                        child: Icon(
                          Icons.edit,
                          color: cLightLemon,
                        )),
                  )
                ],
              ),
              Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: constraints.maxWidth * 0.04,
                  ),
                  child: RichText(
                    text: TextSpan(
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: cBlack,
                          fontSize: 15,
                          fontFamily: 'segoeui'),
                      children: <TextSpan>[
                        TextSpan(text: '${AppLocalizations.of(context).store}  :  '),
                        TextSpan(
                          text: widget.order.carttMtgerName,
                          style: TextStyle(
                              color: cPrimaryColor,
                              fontWeight: FontWeight.w400,
                              fontSize: 15,
                              fontFamily: 'segoeui'),
                        ),
                      ],
                    ),
                  )),
              Container(
                  margin: EdgeInsets.only(
                      left: constraints.maxWidth * 0.04,
                      right: constraints.maxWidth * 0.04,
                      top: constraints.maxHeight * 0.02),
                  child: RichText(
                    text: TextSpan(
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: cBlack,
                          fontSize: 15,
                          fontFamily: 'segoeui'),
                      children: <TextSpan>[
                        TextSpan(text: '${AppLocalizations.of(context).totalPrice}  :  '),
                        TextSpan(
                          text: '${widget.order.carttTotal} ${AppLocalizations.of(context).sr}',
                          style: TextStyle(
                              color: cPrimaryColor,
                              fontWeight: FontWeight.w400,
                              fontSize: 15,
                              fontFamily: 'segoeui'),
                        ),
                      ],
                    ),
                  )),
              Container(
                  margin: EdgeInsets.only(
                      left: constraints.maxWidth * 0.04,
                      right: constraints.maxWidth * 0.04,
                      top: constraints.maxHeight * 0.02),
                  child: RichText(
                    text: TextSpan(
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: cBlack,
                          fontSize: 15,
                          fontFamily: 'segoeui'),
                      children: <TextSpan>[
                        TextSpan(text: '${AppLocalizations.of(context).orderDate}  :  '),
                        TextSpan(
                          text: widget.order.carttDate,
                          style: TextStyle(
                              color: cPrimaryColor,
                              fontWeight: FontWeight.w400,
                              fontSize: 15,
                              fontFamily: 'segoeui'),
                        ),
                      ],
                    ),
                  )),
              Container(
                  margin: EdgeInsets.only(
                      left: constraints.maxWidth * 0.04,
                      right: constraints.maxWidth * 0.04,
                      top: constraints.maxHeight * 0.02,
                      bottom: constraints.maxHeight * 0.03),
                  child: RichText(
                    text: TextSpan(
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: cBlack,
                          fontSize: 15,
                          fontFamily: 'segoeui'),
                      children: <TextSpan>[
                        TextSpan(text: '${AppLocalizations.of(context).orderStatus}   :  '),
                        TextSpan(
                          text: widget.order.carttState,
                          style: TextStyle(
                              color: cPrimaryColor,
                              fontWeight: FontWeight.w400,
                              fontSize: 15,
                              fontFamily: 'segoeui'),
                        ),
                      ],
                    ),
                  )),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Container(
                    width: constraints.maxWidth * 0.35,
                    height: 50,
                    child: CustomButton(
                        btnStyle: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            color: cWhite),
                        btnLbl:AppLocalizations.of(context).orderDetails,
                        onPressedFunction: () {
                       orderState.setCarttFatora(widget.order.carttFatora);
                      orderState.setCarttSeller(widget.order.carttSeller);
                         orderState.setIsWaitingOrder(true);
                        Navigator.pushNamed(context,  '/order_details_screen'); 
                        }),
                  ),
                  Container(
                    width: constraints.maxWidth * 0.35,
                    height: 50,
                    child: CustomButton(
                      btnStyle: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: cPrimaryColor),
                      hasGradientColor: false,
                      btnLbl: AppLocalizations.of(context).cancelOrder,
                      btnColor: cWhite,
                      onPressedFunction: () {
                        showModalBottomSheet(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(topLeft: Radius.circular(20),
                              topRight: Radius.circular(20)),
                            ),
                            context: context,
                            builder: (builder) {
                              return Container(
                                height: constraints.maxHeight,
                                width: constraints.maxWidth,
                                child: CancelOrderBottomSheet(
                                  onPressedConfirmation: () async {
                                    progressIndicatorState.setIsLoading(true);
                                    var results = await _services.get(
                                        'https://ninanapp.com/app/api/do_dis_buy?cartt_fatora=${widget.order.carttFatora}&cartt_seller=${widget.order.carttSeller}&lang=${appState.currentLang}');
                                    progressIndicatorState.setIsLoading(false);
                                    if (results['response'] == '1') {
                                      showToast(results['message'], context);
                                      Navigator.pop(context);
                                      tabState.upadateInitialIndex(3);
                                      navigationState.upadateNavigationIndex(1);
                                      Navigator.pushReplacementNamed(
                                          context, '/navigation');
                                    } else {
                                      showErrorDialog(
                                          results['message'], context);
                                    }
                                  },
                                ),
                              );
                            });
                      },
                    ),
                  )
                ],
              )
            ],
          ));
    });
  }
}
