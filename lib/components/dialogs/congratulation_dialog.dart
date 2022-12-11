import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ninan1/components/buttons/custom_button.dart';
import 'package:ninan1/locale/localization.dart';
import 'package:ninan1/utils/app_colors.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class CongratulationDialog extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    
    return  LayoutBuilder(builder: (context,constraints){
 return AlertDialog(
   contentPadding: EdgeInsets.fromLTRB(0.0,0.0,0.0,0.0),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15.0))),
      content: SingleChildScrollView(
        child:  Column(
        
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
              
              Container(
          margin: EdgeInsets.only(top: 15),
                child: Icon(Icons.check_circle,color: cAccentColor,size: 80,))
           ,Text(AppLocalizations.of(context).congratulation,style: TextStyle(
             color: cBlack,fontWeight: FontWeight.w700,fontSize: 16
           ),),
          Container(
            margin: EdgeInsets.only(bottom: 10),
            child:  Text(AppLocalizations.of(context).accountCreatedSuccessFully,style: TextStyle(
             color: cHintColor,fontSize: 13
           ),),
          )
          ],
        )),
      
    );
    });
  }
}
