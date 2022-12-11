import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ninan1/components/app_repo/store_state.dart';
import 'package:ninan1/components/drop_down_list_selector/drop_down_list_selector.dart';
import 'package:ninan1/models/category.dart';
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


class AddProductScreen extends StatefulWidget {
  AddProductScreen({Key key}) : super(key: key);

  @override
  _AddProductScreenState createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen>  with ValidationMixin{
  dynamic _pickImageError;
  final _picker = ImagePicker();
  double _height;
  double _width;
  final _formKey = GlobalKey<FormState>();
  String _adsMtgerName, _adsMtgerNameEn, _adsMtgerPrice, _adsMtgerCat, _adsMtgerDetails, _adsMtgerDetailsEn;
  Category _selectedCategory;
  Future<List<Category>> _categoryList;
  Services _services = Services();
  AppState _appState;
  StoreState _storeState;
  ProgressIndicatorState _progressIndicatorState;
  FocusNode _focusNode;
  File _imageFile;
  bool _initialRun = true;


  Future<List<Category>> _getCategoryItems() async {
    Map<String, dynamic> results = await _services.get(
        'https://ninanapp.com/app/api/mtger_edit_mtger_cat1?mtger_id=${_storeState.currentStore.mtgerId}&page=1&lang=${_appState.currentLang}');
    List<Category> storeList = List<Category>();
    if (results['response'] == '1') {
      Iterable iterable = results['results'];
      storeList = iterable.map((model) => Category.fromJson(model)).toList();
    } else {
      print('error');
    }
    return storeList;
  }


  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_initialRun) {
      _appState = Provider.of<AppState>(context);
      _storeState = Provider.of<StoreState>(context);
      _categoryList = _getCategoryItems();
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
            SizedBox(
              height: _height * 0.015,
            ),

            FutureBuilder<List<Category>>(
              future: _categoryList,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.hasData) {
                    var categoryList = snapshot.data.map((item) {

                      return new DropdownMenuItem<Category>(

                        child: new Text(item.mtgerCatName),
                        value: item,
                      );
                    }).toList();

                    return DropDownListSelector(
                      dropDownList: categoryList,
                      hint:"القسم",

                      onChangeFunc: (newValue) {
                        FocusScope.of(context).requestFocus( FocusNode());

                        setState(() {




                          _selectedCategory = newValue;




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
                hintTxt:"اسم المنتج باللغة العربية",
                validationFunc: (value) {
                  if (value.trim().length == 0) {
                    return "برجاء ادخال اسم المنتج بالعربية";
                  }
                  return null;
                },
                inputData: TextInputType.text,
                onChangedFunc: (String text) {
                  _adsMtgerName = text.toString();
                },
              ),
            ),



            Container(
              margin: EdgeInsets.only(
                  left: _width * 0.025,
                  bottom: _width * 0.025,
                  right: _width * 0.025),
              child: CustomTextFormField(

                hintTxt:"اسم المنتج باللغة الانجليزية",
                validationFunc: (value) {
                  if (value.trim().length == 0) {
                    return "برجاء ادخال اسم المنتج بالانجليزية";
                  }
                  return null;
                },
                inputData: TextInputType.text,
                onChangedFunc: (String text) {
                  _adsMtgerNameEn = text.toString();
                },
              ),
            ),





          Container(
            height: 100,
            margin: EdgeInsets.only(
                left: _width * 0.025,
                bottom: _width * 0.025,
                right: _width * 0.025),
            child: CustomTextFormField(

              hintTxt:"وصف المنتج باللغة العربية",
              validationFunc: (value) {
                if (value.trim().length == 0) {
                  return "برجاء ادخال وصف المنتج بالعربية";
                }
                return null;
              },
              inputData: TextInputType.text,
              onChangedFunc: (String text) {
                _adsMtgerDetails = text.toString();
              },
            ),
          ),



          Container(
            height: 100,
            margin: EdgeInsets.only(
                left: _width * 0.025,
                bottom: _width * 0.025,
                right: _width * 0.025),
            child: CustomTextFormField(

              hintTxt:"وصف المنتج باللغة الانجليزية",
              validationFunc: (value) {
                if (value.trim().length == 0) {
                  return "برجاء ادخال وصف المنتج بالانجليزية";
                }
                return null;
              },
              inputData: TextInputType.text,
              onChangedFunc: (String text) {
                _adsMtgerDetailsEn = text.toString();
              },
            ),
          ),

            Container(
              margin: EdgeInsets.only(
                  left: _width * 0.025,
                  bottom: _width * 0.025,
                  right: _width * 0.025),
              child: CustomTextFormField(
               suffixIcon: Container(
                 padding: EdgeInsets.only(top: 15),
                 child: Text("SAR",style: TextStyle(color: cPrimaryColor,fontSize: 14),),
               ),
                hintTxt:"سعر المنتج",
                validationFunc: (value) {
                  if (value.trim().length == 0) {
                    return "برجاء ادخال السعر";
                  }
                  return null;
                },
                inputData: TextInputType.number,
                onChangedFunc: (String text) {
                  _adsMtgerPrice = text.toString();
                },
              ),
            ),

            Container(
              margin: EdgeInsets.symmetric(vertical: _height * 0.02),
              height: 60,
              child: CustomButton(
                btnLbl: "اضافة منتج",
                onPressedFunction: () async {
                  if (_formKey.currentState.validate() &
                  checkAddProductValidation(context,
                      imgFile: _imageFile,
                      adMainCategory: _selectedCategory,
                  )
                  ) {
                    _progressIndicatorState.setIsLoading(true);
                    String fileName = (_imageFile!=null)?Path.basename(_imageFile.path):"";

                    FormData formData = new FormData.fromMap({
                      "ads_mtger_name":_adsMtgerName,
                      "ads_mtger_name_en": _adsMtgerNameEn,
                      "ads_mtger_price": _adsMtgerPrice,
                      "ads_mtger_cat":_selectedCategory.mtgerCatId,
                      "ads_mtger_details": _adsMtgerDetails,
                      "ads_mtger_details_en": _adsMtgerDetailsEn,
                      "ads_mtger_mtgerid":_storeState.currentStore.mtgerId,
                      "lang":_appState.currentLang,
                      "imgURL": (_imageFile!=null)?await MultipartFile.fromFile(_imageFile.path, filename: fileName):"",
                    });



                    final results = await _services
                        .postWithDio("https://ninanapp.com/app/api/mtger_add_mtger_ads", body: formData);

                    _progressIndicatorState.setIsLoading(false);
                    if (results['response'] == '1') {


                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProductsScreen()));

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
                        appBarTitle: "إضافة منتج جديد",
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
