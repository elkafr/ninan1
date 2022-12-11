import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ninan1/components/app_repo/store_state.dart';
import 'package:ninan1/components/drop_down_list_selector/drop_down_list_selector.dart';
import 'package:ninan1/models/bank.dart';
import 'package:ninan1/models/category.dart';
import 'package:ninan1/screens/wallet/wallet_screen.dart';
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


class AddRequestScreen extends StatefulWidget {
  AddRequestScreen({Key key}) : super(key: key);

  @override
  _AddRequestScreenState createState() => _AddRequestScreenState();
}

class _AddRequestScreenState extends State<AddRequestScreen>  with ValidationMixin{
  dynamic _pickImageError;
  final _picker = ImagePicker();
  double _height;
  double _width;
  final _formKey = GlobalKey<FormState>();
  String _requestBank, _requestName, _requestNumber;
  Bank _selectedBank;
  Future<List<Bank>> _bankList;
  Services _services = Services();
  AppState _appState;
  StoreState _storeState;
  ProgressIndicatorState _progressIndicatorState;
  FocusNode _focusNode;
  File _imageFile;
  bool _initialRun = true;


  Future<List<Bank>> _getBankItems() async {
    Map<String, dynamic> results = await _services.get(
        'https://ninanapp.com/app/api/getBanks?lang=${_appState.currentLang}');
    List<Bank> bankList = List<Bank>();
    if (results['response'] == '1') {
      Iterable iterable = results['results'];
      bankList = iterable.map((model) => Bank.fromJson(model)).toList();
    } else {
      print('error');
    }
    return bankList;
  }


  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_initialRun) {
      _appState = Provider.of<AppState>(context);
      _storeState = Provider.of<StoreState>(context);
      _bankList = _getBankItems();
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
              height: _height * 0.08,
            ),

           /* Stack(
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
                            Text("صورة المنتج",style: TextStyle(color: cText,fontSize: 15),),
                            Padding(padding: EdgeInsets.all(5)),
                            Text(" الصورة يجب ان تكون مربعة مثل 200 * 200 لتظهر بالشكل المناسب",style: TextStyle(color: Color(0xffABABAB),fontSize: 11),),
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
            */
            Image.asset("assets/images/request1.png"),
            SizedBox(
              height: _height * 0.04,
            ),
            Container(
              margin: EdgeInsets.only(right: _width*.04),
              alignment: Alignment.centerRight,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text("بيانات التحويل",style: TextStyle(color: cText,fontSize: 15),),
                  Padding(padding:EdgeInsets.all(5)),
                  Text("ادخل بيانات حساب التحويل الخاص بك",style: TextStyle(color: Color(0xffBEBEBE),fontSize: 14),),
                ],
              ),
            ),

            SizedBox(
              height: _height * 0.04,
            ),

            FutureBuilder<List<Bank>>(
              future: _bankList,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.hasData) {
                    var categoryList = snapshot.data.map((item) {

                      return new DropdownMenuItem<Bank>(

                        child: new Text(item.bankTitle),
                        value: item,
                      );
                    }).toList();

                    return DropDownListSelector(
                      dropDownList: categoryList,
                      hint:"اختر البنك",

                      onChangeFunc: (newValue) {
                        FocusScope.of(context).requestFocus( FocusNode());

                        setState(() {




                          _selectedBank = newValue;




                        });
                      },
                      value:null,
                    );
                  } else if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  }
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }

                return Center(child: CircularProgressIndicator());
              },
            ),


            Container(
              margin: EdgeInsets.only(

                  left: _width * 0.025,
                  bottom: _width * 0.025,
                  right: _width * 0.025),
              child: CustomTextFormField(
                hintTxt:"اسم صاحب الحساب",
                validationFunc: (value) {
                  if (value.trim().length == 0) {
                    return "برجاء ادخال اسم صاحب الحساب";
                  }
                  return null;
                },
                inputData: TextInputType.text,
                onChangedFunc: (String text) {
                  _requestName = text.toString();
                },
              ),
            ),



            Container(
              margin: EdgeInsets.only(
                  left: _width * 0.025,
                  bottom: _width * 0.025,
                  right: _width * 0.025),
              child: CustomTextFormField(

                hintTxt:"رقم الحساب",
                validationFunc: (value) {
                  if (value.trim().length == 0) {
                    return "برجاء ادخال رقم الحساب";
                  }
                  return null;
                },
                inputData: TextInputType.text,
                onChangedFunc: (String text) {
                  _requestNumber = text.toString();
                },
              ),
            ),




            SizedBox(height: _width*.6,),



            Container(
              margin: EdgeInsets.symmetric(vertical: _height * 0.02),
              height: 60,
              child: CustomButton(
                btnLbl: "تأكيد سحب الرصيد",
                onPressedFunction: () async {
                  if (_formKey.currentState.validate() &
                  checkAddRequestValidation(context,
                    adMainBank: _selectedBank,
                  )
                  ) {
                    _progressIndicatorState.setIsLoading(true);
                    String fileName = (_imageFile!=null)?Path.basename(_imageFile.path):"";

                    FormData formData = new FormData.fromMap({
                      "request_name": _requestName,
                      "request_number": _requestNumber,
                      "request_bank":_selectedBank.bankId,
                      "request_mtger":_appState.currentUser.userId,
                      "lang":_appState.currentLang,
                     // "imgURL": (_imageFile!=null)?await MultipartFile.fromFile(_imageFile.path, filename: fileName):"",
                    });



                    final results = await _services
                        .postWithDio("https://ninanapp.com/app/api/driver_add_request", body: formData);

                    _progressIndicatorState.setIsLoading(false);
                    if (results['response'] == '1') {


                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => WalletScreen()));

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
                                    Image.asset("assets/images/true1.png"),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      results['message'],
                                      textAlign: TextAlign.center,
                                      style:
                                      TextStyle(fontSize: 16, height: 1.5, fontFamily: 'segoeui',color: cText,fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),


                                  ],
                                ),
                              ),
                            );
                          });





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
                      child: GradientAppBar(
                        appBarTitle: "طلب سحب رصيد",
                        leading: _appState.currentLang == 'ar'
                            ? IconButton(
                          icon: Image.asset('assets/images/back.png'),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        )
                            : Container(),
                        trailing: _appState.currentLang == 'en'
                            ? IconButton(
                          icon: Icon(
                            Icons.arrow_back_ios,
                            color: cWhite,
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        )
                            : Container(),
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
