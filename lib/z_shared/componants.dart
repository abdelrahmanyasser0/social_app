import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

Future<bool?> showToast({
  required String text,
  required ToastStates state,

})=> Fluttertoast.showToast(
    msg: text,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 5,
    backgroundColor:selectedToastColor(state) ,
    textColor: Colors.white,
    fontSize: 16.0
);

enum ToastStates {SUCCESS,ERROR,WARNIMG}

Color selectedToastColor(ToastStates state){
  Color color;
  switch(state){
    case  ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.ERROR:
      color = Colors.red ;
      break;
    case  ToastStates.WARNIMG:
      color = Colors.amberAccent ;
      break;
  }
  return color;

}


void navigatorAndFinish({required BuildContext context ,required widget})=>
    Navigator.pushAndRemoveUntil(context,MaterialPageRoute(builder: (context)=>widget), (route) => false);

void navigatorPush({required BuildContext context ,required widget})=>
    Navigator.push(context,MaterialPageRoute(builder: (context)=>widget));


Widget defaultTextForm({
  FormFieldValidator? function,
  required TextEditingController controller,
  Icon? prefIcon,
  required String label,
  required OutlineInputBorder border,
  required TextInputType inputType,
  Icon? suffIcon,
})=> TextFormField(
  controller: controller,
  validator: function,
  keyboardType: inputType,
  decoration:  InputDecoration(
    border: border,
    labelText: label,
    prefixIcon: prefIcon,
    suffixIcon: suffIcon,
  ),

);
