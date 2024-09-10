import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../const/app_colors.dart';

Widget customFormField(
    keyboardtype,
    controller,
    context,
    hinttext,
    validator, {
      prefixIcon,
      readOnly = false,
      RxBool? isObscure,
      count = 0,
      VoidCallback? onSuffixIconPressed,
    }) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 10),
    child: TextFormField(
      cursorColor: AppColors.appColor,
      keyboardType: keyboardtype,
      readOnly: readOnly,
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
      controller: controller,
      obscureText: isObscure?.value ?? false,
      textInputAction: TextInputAction.next,
      validator: validator,
      decoration: InputDecoration(
        prefixIcon: Padding(
          padding: const EdgeInsets.only(
            left: 5,
            top: 5,
            bottom: 5,
            right: 10,
          ),
          child: Container(
            width: 40,
            decoration: BoxDecoration(
              color: const Color(0xFFFDF2EE),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              prefixIcon,
              color: AppColors.appColor,
              size: 20,
            ),
          ),
        ),
        suffixIcon: count == 1
            ? IconButton(
          icon: Icon(
            size: 18,
            isObscure?.value ?? false
                ? Icons.visibility_off_outlined
                : Icons.visibility_outlined,
          ),
          onPressed: onSuffixIconPressed,
        )
            : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.transparent),
          borderRadius: BorderRadius.circular(8),
        ),
        fillColor: Colors.white,
        filled: true,
        hintText: hinttext,
        hintStyle: const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w400,
        ),
      ),
    ),
  );
}