import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ninan1/components/app_repo/store_state.dart';
import 'package:ninan1/components/drop_down_list_selector/drop_down_list_selector.dart';
import 'package:ninan1/models/category.dart';
import 'package:ninan1/models/store.dart';
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


class EditCatScreen extends StatefulWidget {
  final Category cat;

  const EditCatScreen({Key key, this.cat}) : super(key: key);

  @override
  _EditCatScreenState createState() => _EditCatScreenState();
}

class _EditCatScreenState extends State<EditCatScreen>  with ValidationMixin{
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
  ProgressIndicatorState _progressIndicatorState;
  FocusNode _focusNode;
  File _imageFile;
  bool _initialRun = true;




  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_initialRun) {
      _appState = Provider.of<AppState>(context);
      _storeState = Provider.of<StoreState>(context);

      _mtgerCatName=widget.cat.mtgerCatName;
      _mtgerCatNameEn=widget.cat.mtgerCatNameEn;

      print("=========");
      print(_mtgerCatNameEn);
      print("=========");
      print(_mtgerCatNameEn);
      print("=========");
      print(_mtgerCatNameEn);
      print("=========");
      print(_mtgerCatNameEn);
      print("=========");

      _initialRun = false;
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
                              : Image.network(widget.cat.mtgerCatPhoto),
                        ),
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Text("صورة القسم",style: TextStyle(color: cText,fontSize: 15),),
                            Padding(padding: EdgeInsets.all(5)),
                            Text(" الصورة يجب ان تكون مربعة مثل 200 * 200 لتظهر بالشكل المناسب",style: TextStyle(color: Color(0xffABABAB),fontSize: 11),),
                          ],
                        ),
                      ),
                    )),


              ],
            ),
            SizedBox(
              height: _height * 0.015,
            ),




            Container(
              margin: EdgeInsets.only(

                  left: _width * 0.025,
                  bottom: _width * 0.025,
                  right: _width * 0.025),
              child: CustomTextFormField(
                hintTxt:"اسم القسم باللغة العربية",
                validationFunc: (value) {
                  if (value.trim().length == 0) {
                    return "برجاء ادخال اسم القسم بالعربية";
                  }
                  return null;
                },
                inputData: TextInputType.text,
                initialValue: _mtgerCatName,
                onChangedFunc: (String text) {
                  _mtgerCatName = text.toString();
                },

              ),
            ),



            Container(
              margin: EdgeInsets.only(
                  left: _width * 0.025,
                  bottom: _width * 0.025,
                  right: _width * 0.025),
              child: CustomTextFormField(

                hintTxt:"اسم القسم باللغة الانجليزية",
                validationFunc: (value) {
                  if (value.trim().length == 0) {
                    return "برجاء ادخال اسم القسم بالانجليزية";
                  }
                  return null;
                },
                inputData: TextInputType.text,
                initialValue: _mtgerCatNameEn,
                onChangedFunc: (String text) {
                  _mtgerCatNameEn = text.toString();
                },

              ),
            ),










            Container(
              margin: EdgeInsets.symmetric(vertical: _height * 0.02),
              height: 60,
              child: CustomButton(
                btnLbl: "تعديل قسم",
                onPressedFunction: () async {
                  if (_formKey.currentState.validate()
                  ) {
                    _progressIndicatorState.setIsLoading(true);
                    FormData formData ;
                    if(_imageFile != null) {
                      String fileName = (_imageFile != null) ? Path.basename(
                          _imageFile.path) : "";

                      formData = new FormData.fromMap({
                        "mtger_cat_id": widget.cat.mtgerCatId,
                        "mtger_cat_name": _mtgerCatName,
                        "mtger_cat_name_en": _mtgerCatNameEn,
                        "mtger_cat_mtgerId": _storeState.currentStore.mtgerId,
                        "lang": _appState.currentLang,
                        "imgURL": (_imageFile != null) ? await MultipartFile
                            .fromFile(_imageFile.path, filename: fileName) : "",
                      });
                    }else{



                      formData = new FormData.fromMap({
                        "mtger_cat_id":widget.cat.mtgerCatId,
                        "mtger_cat_name":_mtgerCatName,
                        "mtger_cat_name_en": _mtgerCatNameEn,
                        "mtger_cat_mtgerId":_storeState.currentStore.mtgerId,
                        "lang":_appState.currentLang,

                      });

                    }


                    final results = await _services
                        .postWithDio("https://ninanapp.com/app/api/mtger_do_edit_mtger_cat1", body: formData);

                    _progressIndicatorState.setIsLoading(false);
                    if (results['response'] == '1') {
                      showToast(results['message'], context);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CatsScreen()));
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
                        appBarTitle: "تعديل قسم",
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
