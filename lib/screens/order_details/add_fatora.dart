import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ninan1/components/app_repo/order_state.dart';
import 'package:ninan1/components/app_repo/store_state.dart';
import 'package:ninan1/components/drop_down_list_selector/drop_down_list_selector.dart';
import 'package:ninan1/components/gradient_app_bar/gradient_app_bar2.dart';
import 'package:ninan1/models/category.dart';
import 'package:ninan1/screens/order_details/order_taslim.dart';
import 'package:ninan1/screens/store/cats_screen.dart';
import 'package:ninan1/screens/store/products_screen.dart';
import 'package:provider/provider.dart';
import 'package:ninan1/components/app_data/shared_preferences_helper.dart';
import 'package:ninan1/components/app_repo/app_state.dart';
import 'package:ninan1/components/app_repo/progress_indicator_state.dart';
import 'package:ninan1/components/buttons/custom_button.dart';
import 'package:ninan1/components/connectivity/network_indicator.dart';
import 'package:ninan1/components/custom_text_form_field/custom_text_form_field.dart';
import 'package:ninan1/components/gradient_app_bar/gradient_app_bar.dart';
import 'package:ninan1/components/horizontal_divider/horizontal_divider.dart';
import 'package:ninan1/components/progress_indicator_component/progress_indicator_component.dart';
import 'package:ninan1/components/response_handling/response_handling.dart';
import 'package:ninan1/components/safe_area/page_container.dart';
import 'package:ninan1/components/custom_text_form_field/validation_mixin.dart';
import 'package:ninan1/locale/localization.dart';
import 'package:ninan1/models/user.dart';
import 'package:ninan1/services/access_api.dart';
import 'package:ninan1/utils/app_colors.dart';
import 'package:ninan1/utils/utils.dart';
import 'package:ninan1/screens/auth/password_recovery_bottom_sheet.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:validators/validators.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as Path;
import 'dart:math' as math;
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';


class AddFatoraScreen extends StatefulWidget {
  AddFatoraScreen({Key key}) : super(key: key);

  @override
  _AddFatoraScreenState createState() => _AddFatoraScreenState();
}

class _AddFatoraScreenState extends State<AddFatoraScreen>  with ValidationMixin{
  dynamic _pickImageError;
  final _picker = ImagePicker();
  double _height;
  double _width;
  final _formKey = GlobalKey<FormState>();
  String _mtgerCatName, _mtgerCatNameEn;
  Category _selectedCategory;
  Services _services = Services();
  AppState _appState;
  StoreState _storeState;
  OrderState _orderState;
  ProgressIndicatorState _progressIndicatorState;
  FocusNode _focusNode;
  File _imageFile;
  bool _initialRun = true;




  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_initialRun) {
      _appState = Provider.of<AppState>(context);
      _orderState = Provider.of<OrderState>(context);

    }
  }


  @override
  void initState() {
    super.initState();

    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    _focusNode.dispose();
    super.dispose();
  }


  void _onImageButtonPressed(ImageSource source, {BuildContext context}) async {
    try {
      final pickedFile = await _picker.getImage(source: source);
      _imageFile = File(pickedFile.path);
      setState(() {});
    } catch (e) {
      _pickImageError = e;
      print(_pickImageError);
    }
  }


  void _settingModalBottomSheet(context){
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc){
          return Container(
            child: new Wrap(
              children: <Widget>[
                new ListTile(
                    leading: new Icon(Icons.subject),
                    title: new Text('Gallery'),
                    onTap: (){
                      _onImageButtonPressed(ImageSource.gallery,
                          context: context);
                      Navigator.pop(context);
                    }
                ),
                new ListTile(
                    leading: new Icon(Icons.camera),
                    title: new Text('Camera'),
                    onTap: (){
                      _onImageButtonPressed(ImageSource.camera,
                          context: context);
                      Navigator.pop(context);
                    }
                ),
              ],
            ),
          );
        }
    );
  }

  Widget _buildBodyItem() {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            SizedBox(
              height: _height * 0.1,
            ),


            Stack(
              children: <Widget>[
                GestureDetector(
                    onTap: (){

                      _settingModalBottomSheet(context);
                    },
                    child: Container(
                      color: cOmarColor,
                      padding: EdgeInsets.all(6),
                      margin: EdgeInsets.only(right: _width*.05,left:  _width*.05),
                      child: ListTile(
                        leading: Container(





                          child: _imageFile != null
                              ?Image.file(
                            _imageFile,
                            // fit: BoxFit.fill,
                          )
                              : Image.asset('assets/images/newadd.png'),
                        ),
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Text("فاتورة الطلب",style: TextStyle(color: cText,fontSize: 15),),
                            Padding(padding: EdgeInsets.all(5)),
                            Text(" التقط صورة للايصال ( الفاتورة )",style: TextStyle(color: Color(0xffABABAB),fontSize: 11),),
                            Padding(padding: EdgeInsets.all(5)),
                            Text("اجباري *",style: TextStyle(color: Colors.red,fontSize: 14),),
                          ],
                        ),
                      ),
                    )),

                Positioned(
                    right: _width*.07,
                    top: 5,
                    child: GestureDetector(
                      child: Icon(Icons.delete_forever),
                      onTap: (){
                        setState(() {
                          _imageFile=null;
                        });
                      },

                    ))
              ],
            ),
            SizedBox(
              height: _height * 0.67,
            ),


















            Container(
              margin: EdgeInsets.symmetric(vertical: _height * 0.02),
              height: 60,
              child: CustomButton(
                btnLbl: "تأكيد استلام الطلب",
                onPressedFunction: () async {
                  if (_formKey.currentState.validate() &
                  checkAddCatValidation(context,
                    imgFile: _imageFile,
                  )
                  ) {
                    _progressIndicatorState.setIsLoading(true);
                    String fileName = (_imageFile!=null)?Path.basename(_imageFile.path):"";

                    FormData formData = new FormData.fromMap({
                      "cartt_fatora":_orderState.carttFatora,
                      "cartt_seller": _orderState.carttSeller,
                      "user_id":_appState.currentUser.userId,
                      "lang":_appState.currentLang,
                      "imgURL": (_imageFile!=null)?await MultipartFile.fromFile(_imageFile.path, filename: fileName):"",
                    });



                    final results = await _services
                        .postWithDio("https://ninanapp.com/app/api/driver_uploadFatora", body: formData);

                    _progressIndicatorState.setIsLoading(false);
                    if (results['response'] == '1') {
                      showToast(results['message'], context);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => OrderTaslimScreen()));
                    } else {
                      showErrorDialog(results['message'], context);
                    }
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
    _appState = Provider.of<AppState>(context);
    return NetworkIndicator(
        child: PageContainer(
          child: Scaffold(
              body: SingleChildScrollView(
                reverse: true,
                child: Stack(
                  children: <Widget>[
                    _buildBodyItem(),
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      child: GradientAppBar2(
                        appBarTitle: Container(
                          padding: EdgeInsets.only(top: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Text("تأكيد استلام الطلب",style: TextStyle(color: cText,fontSize: 15),),
                              Padding(padding: EdgeInsets.all(2)),
                              Text("طلب رقم "+_orderState.carttFatora,style: TextStyle(color: Colors.grey[500],fontSize: 15),),
                            ],
                          ),
                        ),
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
                    Center(
                      child: ProgressIndicatorComponent(),
                    )
                  ],
                ),
              )),
        ));
  }
}
