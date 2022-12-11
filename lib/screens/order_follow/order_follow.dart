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


class OrderFollowScreen extends StatefulWidget {



  @override
  _OrderFollowScreenState createState() => _OrderFollowScreenState();
}

class _OrderFollowScreenState extends State<OrderFollowScreen> {
  bool _initialRun = true;
  OrderState _orderState;
  double _height, _width;
  final _formKey = GlobalKey<FormState>();
  Services _services = Services();
  ProgressIndicatorState _progressIndicatorState;
  AppState _appState;
  TabState _tabState;
  NavigationState _navigationState;
  Future<Order> _orderDetails;

  String _rateContent='',_rateMtgerValue='',_rateDriverValue='',_reportContent='';


  int _currentStep = 0;
  StepperType stepperType = StepperType.horizontal;

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
      _initialRun = false;
      _appState = Provider.of<AppState>(context);
      _orderState = Provider.of<OrderState>(context);
      _orderDetails = _getOrderDetails();
    }
  }







  Widget _buildBodyItem(Order order) {
    print(order.carttStateNumber);
    return SingleChildScrollView(
      child: Container(
        width: _width,
        height: _height,
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 60,
            ),

          Container(
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.only(right: _width*.02,left: _width*.02),
            decoration: BoxDecoration(
              color: Color(0xff4E62B5),
                borderRadius: BorderRadius.all(Radius.circular(5)),
            ),

            child: ListTile(
              leading: Image.asset("assets/images/moto.png"),
              title: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("وقت التوصيل المتوقع",style: TextStyle(color: cWhite,fontSize: 13),),

                  Text(order.carttState,style: TextStyle(color: Color(0xffB0D41B),fontSize: 13),),
                ],
              ),
            ),
            ),

           SizedBox(height: _width*.03,),
            Container(
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.only(right: _width*.02,left: _width*.02),
              decoration: BoxDecoration(
                color: cOmarColor,
                borderRadius: BorderRadius.all(Radius.circular(5)),
              ),

              child: ListTile(
                leading:    ClipRRect(
                  borderRadius: BorderRadius.circular(50.0),
                  child: Image.network(order.carttMtgerPhoto,width: 80,height: 80,),
                ),
                title: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(""),
                    SizedBox(height: _width*.03,),
                    Text("#"+order.carttNumber,style: TextStyle(color: Color(0xffABABAB),fontSize: 13),),
                  ],
                ),
                trailing: GestureDetector(
                  onTap: (){
                    Navigator.pushNamed(context,  '/order_details_screen');
                  },
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        border: Border.all(
                            width: 1.0, color: Color(0xff77A20A)),
                        color: cWhite,
                        borderRadius: BorderRadius.circular(
                          6.0,
                        )),
                    child: Text("تفاصيل الطلب",style: TextStyle(color: Color(0xff77A20A),fontSize: 12),),
                  ),
                ),
              ),
            ),





            // first step
            SizedBox(height: _width*.07,),
            Container(
              padding: EdgeInsets.all(0),
              margin: EdgeInsets.only(right: _width*.02,left: _width*.02),

              child: ListTile(
                leading: order.carttStateNumber=="0" || order.carttStateNumber=="1" || order.carttStateNumber=="2" || order.carttStateNumber=="3" || order.carttStateNumber=="4"?Image.asset("assets/images/step1.png"):Image.asset("assets/images/step1G.png",),
                title: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("تم ارسال الطلب",style: TextStyle(color: order.carttStateNumber=="0" || order.carttStateNumber=="1" || order.carttStateNumber=="2" || order.carttStateNumber=="3" || order.carttStateNumber=="4"?cBlack:Color(0xffBEBEBE),fontSize: 15),),
                    SizedBox(height: _width*.03,),
                    Text("تم ارسال الطلب الى المتجر للتجهيز",style: TextStyle(color: order.carttStateNumber=="0" || order.carttStateNumber=="1" || order.carttStateNumber=="2" || order.carttStateNumber=="3" || order.carttStateNumber=="4"?Color(0xffABABAB):Color(0xffBEBEBE),fontSize: 13),),
                  ],
                ),
                trailing: order.carttStateNumber=="0" || order.carttStateNumber=="1" || order.carttStateNumber=="2" || order.carttStateNumber=="3" || order.carttStateNumber=="4"?Image.asset("assets/images/true.png"):Text(""),
              ),
            ),


            // second step
            SizedBox(height: _width*.06,),
            Container(
              padding: EdgeInsets.all(0),
              margin: EdgeInsets.only(right: _width*.02,left: _width*.02),

              child: ListTile(
                leading:  order.carttStateNumber=="1" || order.carttStateNumber=="2" || order.carttStateNumber=="3" || order.carttStateNumber=="4"?Image.asset("assets/images/step2.png"):Image.asset("assets/images/step2G.png"),
                title: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("قيد التجهيز",style: TextStyle(color: order.carttStateNumber=="1" || order.carttStateNumber=="2" || order.carttStateNumber=="3" || order.carttStateNumber=="4"?cBlack:Color(0xffBEBEBE),fontSize: 15),),
                    SizedBox(height: _width*.03,),
                    Text("يتم تجهيز الطلب الأن من قبل المتجر",style: TextStyle(color: order.carttStateNumber=="1" || order.carttStateNumber=="2" || order.carttStateNumber=="3" || order.carttStateNumber=="4"?Color(0xffABABAB):Color(0xffBEBEBE),fontSize: 13),),
                  ],
                ),
                trailing: order.carttStateNumber=="1" || order.carttStateNumber=="2" || order.carttStateNumber=="3" || order.carttStateNumber=="4"?Image.asset("assets/images/true.png"):Text(""),
              ),
            ),



            // third step
            SizedBox(height: _width*.06,),
            Container(
              padding: EdgeInsets.all(0),
              margin: EdgeInsets.only(right: _width*.02,left: _width*.02),

              child: ListTile(
                leading: order.carttStateNumber=="2" || order.carttStateNumber=="3" || order.carttStateNumber=="4"?Image.asset("assets/images/step3.png"):Image.asset("assets/images/step3G.png"),
                title: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("استلم المندوب طلبك",style: TextStyle(color: order.carttStateNumber=="2" || order.carttStateNumber=="3" || order.carttStateNumber=="4"?cBlack:Color(0xffBEBEBE),fontSize: 15),),
                    SizedBox(height: _width*.03,),
                    Text("المندوب قد استلم الطلب من المتجر",style: TextStyle(color: order.carttStateNumber=="2" || order.carttStateNumber=="3" || order.carttStateNumber=="4"?Color(0xffABABAB):Color(0xffBEBEBE),fontSize: 13),),
                  ],
                ),
                trailing: order.carttStateNumber=="2" || order.carttStateNumber=="3" || order.carttStateNumber=="4"?Image.asset("assets/images/true.png"):Text(""),
              ),
            ),



            // fourth step
            SizedBox(height: _width*.06,),
            Container(
              padding: EdgeInsets.all(0),
              margin: EdgeInsets.only(right: _width*.02,left: _width*.02),

              child: ListTile(
                leading: order.carttStateNumber=="3" || order.carttStateNumber=="4"?Image.asset("assets/images/step4.png"):Image.asset("assets/images/step4G.png"),
                title: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("قيد التوصيل",style: TextStyle(color: order.carttStateNumber=="3" || order.carttStateNumber=="4"?cBlack:Color(0xffBEBEBE),fontSize: 15),),
                    SizedBox(height: _width*.03,),
                    Text("طلبك قيد التوصيل الأن",style: TextStyle(color: order.carttStateNumber=="3" || order.carttStateNumber=="4"?Color(0xffABABAB):Color(0xffBEBEBE),fontSize: 13),),
                  ],
                ),
                trailing: order.carttStateNumber=="3" || order.carttStateNumber=="4"?Image.asset("assets/images/true.png"):Text(""),
              ),
            ),








            // fifth step
            SizedBox(height: _width*.06,),
            Container(
              padding: EdgeInsets.all(0),
              margin: EdgeInsets.only(right: _width*.02,left: _width*.02),

              child: ListTile(
                leading: order.carttStateNumber=="4"?Image.asset("assets/images/step5.png"):Image.asset("assets/images/step5G.png"),
                title: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("تم استلام الطلب",style: TextStyle(color: order.carttStateNumber=="4"?cBlack:Color(0xffBEBEBE),fontSize: 15),),
                    SizedBox(height: _width*.03,),
                    Text("تم استلام الطلب من قبل العميل فقيم التجربة",style: TextStyle(color: order.carttStateNumber=="4"?Color(0xffABABAB):Color(0xffBEBEBE),fontSize: 13),),
                  ],
                ),
                trailing: order.carttStateNumber=="4"?Image.asset("assets/images/true.png"):Text(""),
              ),
            ),

            SizedBox(height: _width*.02,),

           /* Container(
                margin: EdgeInsets.only(bottom: 10),
                height: 60,
                width: _width * 0.5,
                child: CustomButton(
                    btnStyle: TextStyle(
                      color: cPrimaryColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                    ),
                    hasGradientColor: false,
                    btnLbl: AppLocalizations.of(context).editOrder,
                    btnColor: cBlack,
                    onPressedFunction: () {
                      Navigator.pushNamed(context,  '/edit_order_details_screen');
                    }))
            */






Spacer(),


                     Row(
                    children: <Widget>[




                      order.carttStateNumber=="0" || order.carttStateNumber=="1"?Container(
                          margin: EdgeInsets.only(bottom: 10),
                          height: 60,
                          width: _width,
                          child: CustomButton(
                            btnColor: Color(0xffEB1B1B),
                              prefixIcon: Icon(Icons.block,color: cWhite,size: 22,),
                              btnStyle: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15,
                                  color: cWhite),
                              btnLbl: AppLocalizations.of(context).cancelOrder,
                              onPressedFunction: () {
                                showModalBottomSheet(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                    context: context,
                                    builder: (builder) {
                                      return Container(
                                        height: _height * 0.35,
                                        width: _width,
                                        child: CancelOrderBottomSheet(
                                          onPressedConfirmation: () async {
                                            _progressIndicatorState
                                                .setIsLoading(true);
                                            var results = await _services.get(
                                                'https://ninanapp.com/app/api/do_dis_buy?cartt_fatora=${order.carttFatora}&cartt_seller=${order.carttSeller}&lang=${_appState.currentLang}');
                                            _progressIndicatorState
                                                .setIsLoading(false);
                                            if (results['response'] == '1') {
                                              showToast(
                                                  results['message'], context);
                                              Navigator.pop(context);
                                              _tabState.upadateInitialIndex(3);
                                              _navigationState
                                                  .upadateNavigationIndex(1);
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
                              })):Text("",style: TextStyle(height: 0),),







                      order.carttStateNumber=="2" || order.carttStateNumber=="3"?Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          margin: EdgeInsets.only(bottom: 10),
                          height: 60,
                          width: _width*.65,
                          child: CustomButton(

                              btnColor: Color(0xffEB1B1B),
                              prefixIcon: Image.asset("assets/images/maps.png"),
                              btnStyle: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15,
                                  color: cWhite),
                              btnLbl:"تتبع المندوب",
                              onPressedFunction: () {

                                launch(
                                    "https://maps.google.com?q=${order.driverMapx},${order.driverMapy}");

                              })):Text("",style: TextStyle(height: 0),),




                      order.carttStateNumber=="2" || order.carttStateNumber=="3"?Container(

                          decoration: BoxDecoration(
                            color: Color(0xffB0D41B),
                            borderRadius: BorderRadius.all(Radius.circular(6)),
                          ),
                          margin: EdgeInsets.only(bottom: 10,left: 10),
                          height: 49,
                          width: _width*.15,
                          child: GestureDetector(
                            child: Image.asset("assets/images/call.png",color: cWhite,),
                            onTap: (){
                              launch(
                                  "tel://${order.driverPhone}");
                            },
                          )):Text("",style: TextStyle(height: 0),),




                      order.carttStateNumber=="2" || order.carttStateNumber=="3"?Container(
                          decoration: BoxDecoration(
                            color: Color(0xff848484),
                            borderRadius: BorderRadius.all(Radius.circular(6)),
                          ),
                          margin: EdgeInsets.only(bottom: 10),
                          height: 49,
                          width: _width*.15,
                          child: GestureDetector(
                            child: Image.asset("assets/images/note.png",color: cWhite,),
                            onTap: (){


                              Navigator.push(context, MaterialPageRoute
                                (builder: (context)=> ChatScreen(
                                senderId: order.carttDriver,
                                senderImg: order.driverPhoto,
                                senderName:order.driverName,
                                senderPhone:order.driverPhoto,
                                adsId:order.carttNumber,

                              )
                              ));

                            },
                          )):Text("",style: TextStyle(height: 0),),





                     order.carttStateNumber=="4"?Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          margin: EdgeInsets.only(bottom: 10),
                          height: 60,
                          width: _width*.49,
                          child: CustomButton(

                              btnColor: cPrimaryColor,

                              btnStyle: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15,
                                  color: cWhite),
                              btnLbl:"تقييم الطلب",
                              onPressedFunction: () {


                                showModalBottomSheet<dynamic>(
                                    isScrollControlled: true,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(20),
                                            topRight: Radius.circular(20))),
                                    context: context,
                                    builder: (builder) {
                                      return Container(
                                        height: _height*.90,
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
                                                      Text("تقييم الطلب",style: TextStyle(color: cText,fontSize: 16,fontWeight: FontWeight.bold),),
                                                      Padding(padding: EdgeInsets.all(5)),
                                                      Text("استلمت طلبك بنجاح , شارك تجربتك الان",style: TextStyle(color: cHintColor,fontSize: 13),),
                                                    ],
                                                  ),
                                                ),
                                                Padding(padding: EdgeInsets.all(8)),
                                                Expanded(child: Column(
                                                  children: <Widget>[

                                                   SingleChildScrollView(
                                                     reverse: true,
                                                     child:  Form(
                                                       key: _formKey,
                                                       child: Column(
                                                         children: <Widget>[


                                                           ClipOval(
                                                             child: Image.network(
                                                               order.carttMtgerPhoto,
                                                               height: 100,
                                                               width: 100,
                                                               fit: BoxFit.fill,
                                                             ),
                                                           ),
                                                           SizedBox(height: _width*.02,),
                                                           Text(order.carttMtgerName,style: TextStyle(color: cBlack,fontSize: 16),),

                                                           SizedBox(height: _width*.03,),

                                                           RatingBar.builder(
                                                             initialRating: 0,
                                                             minRating: 1,
                                                             direction: Axis.horizontal,
                                                             allowHalfRating: true,
                                                             itemCount: 5,
                                                             itemPadding: EdgeInsets.all(0),
                                                             itemSize: 35,
                                                             itemBuilder: (context, _) => Icon(
                                                               Icons.star,
                                                               color: Colors.amber,
                                                             ),
                                                             onRatingUpdate: (rating) async {

                                                               _rateMtgerValue=rating.toString();

                                                             },
                                                           ),
                                                           SizedBox(height: _width*.03,),
                                                           Divider(),
                                                           SizedBox(height: _width*.03,),
                                                           ClipOval(
                                                             child: Image.network(
                                                               order.driverPhoto,
                                                               height: 100,
                                                               width: 100,
                                                               fit: BoxFit.fill,
                                                             ),
                                                           ),
                                                           SizedBox(height: _width*.02,),
                                                           Text(order.driverName,style: TextStyle(color: cBlack,fontSize: 16),),

                                                           SizedBox(height: _width*.03,),
                                                           RatingBar.builder(
                                                             initialRating: 0,
                                                             minRating: 1,
                                                             direction: Axis.horizontal,
                                                             allowHalfRating: true,
                                                             itemCount: 5,
                                                             itemPadding: EdgeInsets.all(0),
                                                             itemSize: 35,
                                                             itemBuilder: (context, _) => Icon(
                                                               Icons.star,
                                                               color: Colors.amber,
                                                             ),
                                                             onRatingUpdate: (rating) async {

                                                               _rateDriverValue=rating.toString();

                                                             },
                                                           ),

                                                           SizedBox(height: _width*.05,),
                                                           Container(
                                                             height: 100,
                                                             child: CustomTextFormField(


                                                                 hintTxt: " شارك تجربتك...",

                                                                 inputData: TextInputType.text,
                                                                 maxLines: 4,
                                                                 onChangedFunc: (String text) {
                                                                   _rateContent = text.toString();
                                                                 },
                                                                 validationFunc: (value) {
                                                                   if (value.trim().length == 0) {
                                                                     return AppLocalizations.of(context).textValidation;
                                                                   }
                                                                   return null;
                                                                 }),
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
                                                                     btnLbl: "إضافة تقييم",
                                                                     onPressedFunction: () async {
                                                                       if (_formKey.currentState.validate()) {
                                                                         _progressIndicatorState.setIsLoading(true);

                                                                         var results = await _services.get(
                                                                           'https://ninanapp.com/app/api/addRate?rate_user=${_appState.currentUser.userId}&rate_content=$_rateContent&rate_mtger=${order.carttMtgerId}&rate_mtger_value=$_rateMtgerValue&rate_driver=${order.carttDriver}&rate_driver_value=$_rateDriverValue&rate_number=${order.carttNumber}&lang=${_appState.currentLang}',
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
                                                     ),
                                                   )






                                                  ],
                                                )

                                                ),




                                              ],
                                            )),
                                      );
                                    });



                              })):Text("",style: TextStyle(height: 0),),






                      order.carttStateNumber=="4"?Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          margin: EdgeInsets.only(bottom: 10),
                          height: 60,
                          width: _width*.49,
                          child: CustomButton(

                              btnColor: Color(0xffEB1B1B),

                              btnStyle: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15,
                                  color: cWhite),
                              btnLbl:"شكوى / ابلاغ",
                              onPressedFunction: () {


                                showModalBottomSheet<dynamic>(
                                    isScrollControlled: true,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(20),
                                            topRight: Radius.circular(20))),
                                    context: context,
                                    builder: (builder) {
                                      return Container(
                                        height: _height*.45,
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



                                                          Container(
                                                            height: 100,
                                                            child: CustomTextFormField(


                                                                hintTxt: " اكتب بلاغك هنا...",

                                                                inputData: TextInputType.text,
                                                                maxLines: 4,
                                                                onChangedFunc: (String text) {
                                                                  _reportContent= text.toString();
                                                                },
                                                                validationFunc: (value) {
                                                                  if (value.trim().length == 0) {
                                                                    return AppLocalizations.of(context).textValidation;
                                                                  }
                                                                  return null;
                                                                }),
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
                                                                          'https://ninanapp.com/app/api/addReport?report_user=${_appState.currentUser.userId}&report_content=$_reportContent&report_type=1&report_number=${order.carttNumber}&lang=${_appState.currentLang}',
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



                              })):Text("",style: TextStyle(height: 0),),




                    ],
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
                            appBarTitle: "تتبع الطلب",
                           
                            leading: _appState.currentLang == 'ar' ? IconButton(
                icon: Image.asset("assets/images/close.png"),
                onPressed: () {
                  Navigator.pop(context);
                },
              ) :Container(),
              trailing: _appState.currentLang == 'en' ? IconButton(
                icon: Image.asset("assets/images/close.png"),
                onPressed: () {
                  Navigator.pop(context);
                },
              ) :Container(),),
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
