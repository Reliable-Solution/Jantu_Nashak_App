import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:keep_app/view/raise%20ticket/text_field/search_model.dart';

import '../../utils/string_res.dart';
import 'app_common_text.dart';
import 'app_style.dart';
import 'app_utils.dart';
//
// import 'package:flutter/material.dart';
// import 'package:suratjugaad/a_structure/constant/app_common_text.dart';
// import 'package:suratjugaad/a_structure/constant/app_styles.dart';
// import 'package:suratjugaad/a_structure/constant/app_utils.dart';
// import 'package:suratjugaad/a_structure/models/drop_down_model/search_drop_model.dart';

class SearchableDropDownWidget extends StatefulWidget {
  final String headingTitle;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? searchFieldPadding;
  final EdgeInsetsGeometry? listTileContentPadding;
  final TextStyle? titleStyle;
  final TextStyle? textStyle;
  final Color? cursorColor;
  final String? labelText;
  final List<SearchDropModel> listData;
  final ValueChanged<SearchDropModel> onDataChanged;

  const SearchableDropDownWidget({
    super.key,
    required this.headingTitle,
    required this.listData,
    required this.onDataChanged,
    this.padding,
    this.cursorColor,
    this.labelText,
    this.listTileContentPadding,
    this.searchFieldPadding,
    this.textStyle,
    this.titleStyle,
  });

  @override
  State<SearchableDropDownWidget> createState() =>
      _SearchableDropDownWidgetState();
}

class _SearchableDropDownWidgetState extends State<SearchableDropDownWidget> {
  late Size size;
  late List<SearchDropModel> _filterData;

  @override
  void initState() {
    super.initState();
    _filterData = widget.listData.toList();
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    const defaultHorizontalPadding = 16.0;
    const defaultVerticalPadding = 80.0;
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
      child: Dialog(
        insetPadding: const EdgeInsets.symmetric(
            vertical: defaultVerticalPadding,
            horizontal: defaultHorizontalPadding),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(0))),
        backgroundColor: AppStyles.white,
        child: Container(
          padding: widget.padding ?? const EdgeInsets.all(0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(vertical: size.height * 0.02),
                child: textSemiBold(
                  text: widget.headingTitle,
                  textAlign: TextAlign.center,
                  fontSize: 16,
                ),
              ),
              Padding(
                padding: widget.searchFieldPadding ??
                    const EdgeInsets.only(left: 12, right: 12),
                child: Container(
                  height: 45,
                  decoration: BoxDecoration(
                    color: AppStyles.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade300,
                        blurRadius: 5,
                        offset: const Offset(4, 4),
                      ),
                      BoxShadow(
                        color: Colors.grey.shade300,
                        blurRadius: 6,
                        offset: const Offset(-1, -1),
                      ),
                    ],
                  ),
                  child: TextFormField(
                    cursorColor: widget.cursorColor ?? AppStyles.primaryColor,
                    style: AppStyles.textFormFieldValueTextStyle,
                    decoration: InputDecoration(
                      focusedErrorBorder: InputBorder.none,
                      contentPadding: EdgeInsets.only(top: 10),
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      border: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      hintText: StringRes.searchHere,
                      hintStyle: AppStyles.textFormFieldValueTextStyle,
                      prefixIcon: const Icon(
                        Icons.search_outlined,
                        color: AppStyles.greyBorderDD,
                        size: 20,
                      ),
                    ),
                    onChanged: (val) {
                      // _filterData = widget.listData
                      //     .where((element) => element?.title!.toLowerCase().contains(val.toLowerCase())).toList();
                      setState(() {

                      });
                    },
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: _filterData.isEmpty ?  AppUtils.noRecordMsg(): ListView.builder(
                    shrinkWrap: true,
                    itemCount: _filterData.length,
                    itemBuilder: (ctx, index) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 2.0),
                        child: GestureDetector(
                          onTap: () {
                            widget.onDataChanged(_filterData[index]);
                            Navigator.of(context).pop();
                          },
                          child: Container(
                            width: size.width,
                            color: AppStyles.transparent,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 10),
                              child: textMedium(
                                  text: _filterData[index].title ?? "", fontSize: 14),
                            ),
                          ),
                        ),
                      );
                    }

                  // Column(
                  //   children: <Widget>[
                  //
                  //     ListTile(
                  //       contentPadding: widget.listTileContentPadding ??
                  //           const EdgeInsets.only(
                  //               left: 12, right: 12, top: 0, bottom: 0),
                  //       title: textMedium(
                  //           text: _filterData[index].title ?? "", fontSize: 14),
                  //       onTap: () {
                  //         widget.onDataChanged(_filterData[index]);
                  //         Navigator.of(context).pop();
                  //       },
                  //     ),
                  //     /*widget.style?.listTileDivider ??
                  //         const Divider(thickness: 1),*/
                  //   ],
                  // ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
