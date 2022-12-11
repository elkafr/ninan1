import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ninan1/components/app_repo/app_state.dart';
import 'package:ninan1/components/app_repo/chat_state.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:ninan1/components/custom_text_form_field/custom_text_form_field.dart';
import 'package:ninan1/components/no_data/no_data.dart';
import 'package:ninan1/components/safe_area/page_container.dart';
import 'package:ninan1/models/chat_message.dart';
import 'package:ninan1/models/chat_msg_between_members.dart';
import 'package:ninan1/screens/chat/widgets/chat_msg_item.dart';
import 'package:ninan1/utils/app_colors.dart';
import 'package:ninan1/utils/utils.dart';
import 'package:ninan1/utils/app_colors.dart';
import 'package:provider/provider.dart';
import 'dart:math' as math;
import 'package:url_launcher/url_launcher.dart';


import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
import 'package:ninan1/locale/localization.dart';
import 'package:ninan1/models/user.dart';
import 'package:ninan1/services/access_api.dart';
import 'package:ninan1/utils/app_colors.dart';
import 'package:ninan1/utils/utils.dart';
import 'package:ninan1/screens/auth/password_recovery_bottom_sheet.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:validators/validators.dart';

class ChatScreen extends StatefulWidget {
  final String senderId;
  final String senderName;
  final String senderImg;
  final String senderPhone;
  final String adsId;

  const ChatScreen(
      {Key key,
      this.senderId,
      this.senderName,
      this.senderImg,
      this.senderPhone,
        this.adsId,
      })
      : super(key: key);
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  double _height = 0, _width = 0;
  AppState _appState;
  TextEditingController _messageController = TextEditingController();
  Services _services = Services();

  Widget _buildBodyItem() {
    print(widget.senderPhone);
    return Column(
      children: <Widget>[
        Container(
          height: _height * 0.1,
          decoration: BoxDecoration(



            color:cOmarColor,


          ),
          child: ListTile(
            leading: Image.network(widget.senderImg!=null?widget.senderImg:""),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(widget.senderName,style: TextStyle(color: Color(0xff404040),fontSize: 15),),
                Padding(padding: EdgeInsets.all(5)),
                Row(
                  children: <Widget>[
                    Image.asset("assets/images/maps.png",color: cPrimaryColor,),
                    Padding(padding: EdgeInsets.all(5)),
                    Text("1.8 كم",style: TextStyle(color: Color(0xff404040),fontSize: 13),),
                    Padding(padding: EdgeInsets.all(15)),
                    Image.asset("assets/images/tawsil.png",color: cPrimaryColor,),
                    Text("15 ريال",style: TextStyle(color: Color(0xff404040),fontSize: 13),),
                  ],
                )
              ],
            ),
            trailing: GestureDetector(
              child: Image.asset("assets/images/popphone.png"),
              onTap: (){
                launch(
                    "tel://${widget.senderPhone}");
              },
            ),
          ),
        ),

        Expanded(
          child: FutureBuilder<List<ChatMsgBetweenMembers>>(
              future: Provider.of<ChatState>(context, listen: false)
                  .getChatMessageList(widget.senderId,widget.adsId,_appState.currentUser.userId),
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                    return SpinKitFadingCircle(color: cPrimaryColor);
                  case ConnectionState.active:
                    return Text('');
                  case ConnectionState.waiting:
                    return SpinKitFadingCircle(color: cPrimaryColor);
                  case ConnectionState.done:
                    if (snapshot.hasError) {
                      return Text(snapshot.error.toString());
                    } else {
                      if (snapshot.data.length > 0) {
                        return ListView.builder(
                            itemCount: snapshot.data.length,
                            itemBuilder: (context, index) {
                              return Container(
                                width: _width,
                                height: _height * 0.15,
                                child: ChatMsgItem(
                                  chatMessage: snapshot.data[index],
                                ),
                              );
                            });
                      } else {
                        return NoData(
                          message:
                          "لا يوجد رسائل",
                        );
                      }
                    }
                }
                return SpinKitFadingCircle(color: cPrimaryColor);
              }),
        ),
        Divider(),
        Container(
          height: 60,

          width: _width,
          child: CustomTextFormField(


            controller: _messageController,
            hintTxt: "ادخل رسالت هنا ..",
            onChangedFunc: (text){
              _messageController=text;
            },
            suffixIcon:  IconButton(
              icon: Icon(Icons.send,color: cPrimaryColor,),
              onPressed: () async {
                if (_messageController.text.trim().length > 0) {
                  FocusScope.of(context).requestFocus(FocusNode());



                  final results = await _services.get(
                  'https://ninanapp.com/app/api/send?message_sender=${_appState.currentUser.userId}&message_recever=${widget.senderId}&message_content=${_messageController.text}&lang=${_appState.currentLang}&message_ads=${widget.adsId}',
                );

                  if (results['response'] == "1") {
                    showToast(results['message'], context);


                    setState(() {
                      _messageController.clear();
                    });
                  } else {
                    showToast("cccccccccccc", context);
                  }
                } else {
                  showToast("يجب ادخال رسالة", context);
                }
              },
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      elevation: 0,

      leading: IconButton(
        icon: Image.asset(
          'assets/images/close.png',
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      title: Text("محادثة",
          style: TextStyle(color: Color(0xff404040),fontSize: 16)),
      centerTitle: true,
      backgroundColor: Colors.white,
    );
    _height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    _width = MediaQuery.of(context).size.width;

    _appState = Provider.of<AppState>(context);
    return PageContainer(
      child: RefreshIndicator(
        onRefresh: () async {
          setState(() {});
        },
        child: Scaffold(
          appBar: appBar,
          body: _buildBodyItem(),
        ),
      ),
    );
  }
}
