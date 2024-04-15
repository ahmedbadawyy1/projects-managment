import 'package:flutter/material.dart';

const textInputDecoration = InputDecoration(
  fillColor: Color(0x3de0ebff), // Set the background color here
  filled: true,
  labelStyle: TextStyle(color: Color(0xff000000),),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(
        Radius.circular(10)
    ),
    borderSide: BorderSide(color: Color(0xffFF204E),width: 1),

  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Color(0xff000000),width: 2),
    borderRadius: BorderRadius.all(
        Radius.circular(10)
    ),

  ),
  errorBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Color(0xc89879d3) ,width: 2),//color: Colors.green
    borderRadius: BorderRadius.all(
        Radius.circular(10)
    ),
//0xff407BFF
  ),
);
