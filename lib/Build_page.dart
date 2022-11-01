import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


Widget createColumnTextWidget({
  String textName1 = "",
  String textName2 = "",
  double? spaceBeweent,
  double? fontSize2,
  double? fontSize1

}) {
  return Column(
    // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      Text(textName1,
      textDirection: TextDirection.rtl ,
          style: TextStyle(
            
              color: Colors.white, fontSize: fontSize1, fontWeight: FontWeight.bold)),
      SizedBox(height: spaceBeweent),
      Text(textName2,
          style: TextStyle(
            shadows: <Shadow>[
      Shadow(
        offset: Offset(0, 1),
        blurRadius: 20,
        color: Colors.white.withOpacity(0.5),
      ),],
              color: Colors.white, fontSize: fontSize2, fontWeight: FontWeight.bold))
    ],
  );
}


Widget createTextWidget({
  String name = "",
}) {
  return Text(name,
      style: TextStyle(color: Colors.white,fontSize: 20, fontWeight: FontWeight.bold ));
}


Widget createTextFieldWidget({
  String? hintText,
  Icon? preFixIcon,
  required controller,
  required keyboardType,
  
}) {
  
  return Container(
    
    decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(5)),
    child: TextField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        border: InputBorder.none,
        contentPadding: EdgeInsets.symmetric(vertical: 11, horizontal:5),
          fillColor: Colors.black, hintText: hintText, prefixIcon: preFixIcon),
      textAlign: TextAlign.end,
      style: TextStyle(
          fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
    ),
  );
}






