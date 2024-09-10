import 'package:flutter/material.dart';
class SizeConfig{
  static MediaQueryData? _mediaQueryData;
  static double? screenWidth;
  static double? screnHeight;

  void init(BuildContext context){
    _mediaQueryData= MediaQuery.of(context);
    screenWidth=_mediaQueryData!.size.width;
    screnHeight=_mediaQueryData!.size.height;

  }
}