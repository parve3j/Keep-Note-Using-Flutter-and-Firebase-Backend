import 'package:flutter/material.dart';

class Responsive extends StatelessWidget {
  final Widget mobile;
  final Widget desktop;
  const Responsive({super.key, required this.mobile, required this.desktop});

  @override
  Widget build(BuildContext context) {
    final Size size= MediaQuery.sizeOf(context);
    if(size.width<600){
      return mobile;
    }else{
      return desktop;
    }
  }
}