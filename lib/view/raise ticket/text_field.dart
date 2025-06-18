

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constant/colorConst.dart';
// import 'package:suratjugaad/a_structure/constant/app_styles.dart';
//
// import '../Common/Colors.dart';

class TextFormFieldConst extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final Widget? prefixIcon;
  final Function(String)? onChanged;
  final TextInputType? keyboardType;
  final double? height;
  final int? maxLine;
  const TextFormFieldConst({Key? key,this.controller,this.height,this.maxLine,this.hintText,this.prefixIcon,this.onChanged,this.keyboardType}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
        height: height ?? size.height * 0.07,
        decoration: BoxDecoration(
          // color: Colors.white,
            borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.only(
              top: 10, left: 10.0, right: 10.0, bottom: 3.0),
          child: TextFormField(
            maxLines: maxLine ?? 1,
            textAlign: TextAlign.start,
            controller: controller,

            keyboardType: keyboardType,
            style: GoogleFonts.lato(
              color: COLOR.appBaseColor,
            ),
            onChanged: onChanged,
            textInputAction: TextInputAction.done,
            cursorColor: appPrimaryMaterialColor2,
            autofocus: false,
            decoration: new InputDecoration(
              contentPadding: const EdgeInsets.symmetric(horizontal: 1,vertical: 15),
              hintText: hintText,
              hintStyle: TextStyle(fontSize: 13),
              prefixIcon: prefixIcon,
              //suffixIcon: Icon(Icons.search, color: appPrimaryMaterialColor2, size: 20),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6.0),
                  borderSide: BorderSide.none),
              filled: true,
              fillColor: Colors.grey.withOpacity(0.25),
            ),
          ),
        ));
  }
}


class TextFormFieldConstWithLabel extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText,label;
  final Widget? prefixIcon;
  final Function(String)? onChanged;
  final TextInputType? keyboardType;
  final Border? border;
  const TextFormFieldConstWithLabel({Key? key,this.label,this.border,this.controller,this.hintText,this.prefixIcon,this.onChanged,this.keyboardType}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding:  const EdgeInsets.only(left: 12,right: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 5,top: 12,bottom: 8),
            child: Text(
              label!,
              style: TextStyle(fontSize: 14,fontWeight: FontWeight.w700,color:COLOR.appBaseColor),
            ),
          ),
          Container(
              height: size.height * 0.06,
              decoration: BoxDecoration(
                // color: Colors.white,
                  borderRadius: BorderRadius.circular(10),border: border),
              child: Padding(
                padding: const EdgeInsets.only(
                    top:2, left: 0.0, right: 0.0, bottom: 3.0),
                child: TextFormField(
                  textAlign: TextAlign.start,
                  controller: controller,
                  keyboardType:  keyboardType ?? TextInputType.text,
                  style: GoogleFonts.lato(
                    color: COLOR.appBaseColor,
                  ),
                  onChanged: onChanged,
                  textInputAction: TextInputAction.done,
                  cursorColor: appPrimaryMaterialColor2,
                  autofocus: false,
                  decoration: new InputDecoration(
                    contentPadding:  EdgeInsets.only(left: 12),
                    hintText: hintText,
                    hintStyle: TextStyle(fontSize: 13),
                    prefixIcon: prefixIcon,
                    //suffixIcon: Icon(Icons.search, color: appPrimaryMaterialColor2, size: 20),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6.0),
                        borderSide: BorderSide.none),
                    filled: true,

                    fillColor: border != null ? Colors.white : Colors.grey.withOpacity(0.25),
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
