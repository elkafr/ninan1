import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ninan1/utils/app_colors.dart';
import 'package:provider/provider.dart';
import 'package:ninan1/components/app_repo/order_state.dart';
import 'package:ninan1/components/buttons/custom_button.dart';
import 'package:ninan1/locale/localization.dart';
import 'package:ninan1/models/order.dart';
import 'package:ninan1/screens/order_details/order_details.dart';
import 'package:ninan1/utils/app_colors.dart';

class DoneOrder extends StatefulWidget {
  final bool isCancelOrder;
  final Order order;

  const DoneOrder({Key key, this.isCancelOrder = false, this.order})
      : super(key: key);
  @override
  _DoneOrderState createState() => _DoneOrderState();
}

class _DoneOrderState extends State<DoneOrder> {
  @override
  Widget build(BuildContext context) {
    final orderState = Provider.of<OrderState>(context);
        return LayoutBuilder(builder: (context, constraints) {
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
              orderState.setCarttFatora(widget.order.carttFatora);
              orderState.setCarttSeller(widget.order.carttSeller);
              orderState.setCarttFatora(widget.order.carttFatora);
              orderState.setCarttSeller(widget.order.carttSeller);

              orderState.setIsWaitingOrder(false);
              Navigator.pushNamed(context,  '/order_follow_screen');

            },
            child: Row(
              children: <Widget>[

                ClipRRect(
                  borderRadius: BorderRadius.circular(50.0),
                  child: Image.network(widget.order.carttMtgerPhoto,width: 80,height: 80,),
                ),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                text: widget.order.carttMtgerName,
                                style: TextStyle(
                                    color: Color(0xff404040),
                                    fontWeight: FontWeight.w400,
                                    fontSize: 15,
                                    fontFamily: 'segoeui'),
                              ),
                            ],
                          ),
                        )),



                    SizedBox(height: 5,),

                    Container(
                        margin: EdgeInsets.only(
                            left: constraints.maxWidth * 0.04,
                            right: constraints.maxWidth * 0.04,
                            top: widget.isCancelOrder
                                ? constraints.maxHeight * 0.02
                                : 0,
                            bottom: constraints.maxHeight * 0.03),
                        child: RichText(
                          text: TextSpan(
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                color: cBlack,
                                fontSize: 15,
                                fontFamily: 'segoeui'),
                            children: <TextSpan>[

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
                                text: widget.order.carttDate,
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
                  child: Text(widget.order.carttTotal+" ريال"),
                )
              ],
            ),
          ));
    });
  }
}
