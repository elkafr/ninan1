import 'package:flutter/material.dart';
import 'package:ninan1/models/chat_msg_between_members.dart';
import 'package:ninan1/components/app_repo/app_state.dart';
import 'package:ninan1/utils/app_colors.dart';

import 'package:provider/provider.dart';

class ChatMsgItem extends StatefulWidget {
  
  final ChatMsgBetweenMembers chatMessage;
  const ChatMsgItem({Key key, this.chatMessage}) : super(key: key);

  @override
  _ChatMsgItemState createState() => _ChatMsgItemState();
}

class _ChatMsgItemState extends State<ChatMsgItem> {
  AppState _appState;

  @override
  Widget build(BuildContext context) {
    _appState = Provider.of<AppState>(context);
    return LayoutBuilder(builder: (context, constraints) {
      return widget.chatMessage.senderUserId == _appState.currentUser.userId
          ? Container(
        padding: EdgeInsets.all(5),
              width: constraints.maxWidth * 0.4,
              margin: EdgeInsets.only(
                  top: constraints.maxHeight * 0.15,
                  right: constraints.maxWidth * 0.03,
                  left: constraints.maxWidth * 0.3),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Color(0xffBFBFBF),
                    blurRadius: 1.0,
                  ),
                ],
                border: Border.all(
                  width: 0.1,
                  color: Color(0xffBFBFBF),
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(12.0),
                ),
                color: Colors.grey[100],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[

                  
                    Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: constraints.maxWidth * 0.02,
                           ),
                        child: Text(widget.chatMessage.messageContent,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Color(0xff404040),
                              fontSize: 14,
                            )),
                      ),
                  Row(
      children: <Widget>[
   Container(
     margin: EdgeInsets.only(
                                                 right: _appState.currentLang == 'ar' ? constraints.maxWidth * 0.02 :0,
                            left: _appState.currentLang != 'ar' ? constraints.maxWidth * 0.02 :0,
                           ),
     child: Image.asset('assets/images/time.png',color: Color(0xffC5C5C5),
     height: 20,
     width: 20,
     ),
   ),
 Container(
  margin: EdgeInsets.only(right: _appState.currentLang == 'ar' ? 5 :0,
  left: _appState.currentLang != 'ar' ? 5 : 0),
  child:   Text(widget.chatMessage.messageDate,style: TextStyle(
     fontSize: 12,color: Color(0xffC5C5C5)
   ),))
      ],
    )
              
                
                ],
              ))
          : Container(
              width: constraints.maxWidth * 0.4,
              padding: EdgeInsets.all(5),
              margin: EdgeInsets.only(
                  top: constraints.maxHeight * 0.15,
                  left: constraints.maxWidth * 0.03,
                  right: constraints.maxWidth * 0.3),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: cOmarColor,
                    blurRadius: 1.0,
                  ),
                ],
                border: Border.all(
                  width: 0.1,
                  color: Color(0xffBFBFBF),
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(12.0),
                ),
                color: cPrimaryColor,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[


                    Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: constraints.maxWidth * 0.02,
                           ),
                        child: Text(widget.chatMessage.messageContent,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            )),
                      ),
                  Row(
      children: <Widget>[
   Container(
     margin: EdgeInsets.only(
                            right: _appState.currentLang == 'ar' ? constraints.maxWidth * 0.02 :0,
                            left: _appState.currentLang != 'ar' ? constraints.maxWidth * 0.02 :0,
                           ),
     child: Image.asset('assets/images/time.png',color: Color(0xffC5C5C5),
     height: 20,
     width: 20,
     ),
   ),
 Container(
  margin: EdgeInsets.only(right: _appState.currentLang == 'ar' ? 5 :0,
  left: _appState.currentLang != 'ar' ? 5 : 0),
  child:   Text(widget.chatMessage.messageDate,style: TextStyle(
     fontSize: 12,color: Color(0xffC5C5C5)
   ),))
      ],
    )
              
                
                ],
              ));
    });
  }
}
