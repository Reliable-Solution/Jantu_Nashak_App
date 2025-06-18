import 'package:flutter/material.dart';
// import 'package:suratjugaad/a_structure/constant/app_common_text.dart';
// import 'package:suratjugaad/a_structure/constant/app_styles.dart';

import 'app_common_text.dart';
import 'app_style.dart';

class DropDownUIConst extends StatefulWidget {
  final String dropDownSelectionValue;
  final double? width;
  final String label;
  final double? valueFontSize;
  final VoidCallback onTap;
  final bool isFromTime;
  final IconData? leadingIcon;
  final Widget? suffixIcons;
  final bool isNotDropDownView;
  final bool isLabel;

  const DropDownUIConst(
      {super.key,
        required this.dropDownSelectionValue,
        this.width,
        required this.label,
        required this.onTap,
        this.valueFontSize,
        this.isFromTime = false,
        this.leadingIcon,
        this.suffixIcons,
        this.isNotDropDownView = false,
        this.isLabel = false});

  @override
  State<DropDownUIConst> createState() => _DropDownUIConstState();
}

class _DropDownUIConstState extends State<DropDownUIConst> {
  Future<void> _handleButtonClick() async {
    FocusScope.of(context).requestFocus(FocusNode());
    // await HapticFeedback.mediumImpact();
    widget.onTap();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.leadingIcon == null || widget.isLabel
            ? Padding(
          padding: const EdgeInsets.only(left: 4.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              textSemiBold(text: widget.label, fontSize: 14),
              // textMedium(text: " *",fontSize: 14,isNotLanguageConvert: true,fontColor: AppStyles.rejectColor)
            ],
          ),
        )
            : const SizedBox(),
        Padding(
          padding: const EdgeInsets.only(top: 4.0),
          child: InkWell(
            onTap: _handleButtonClick,
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: AppStyles.greyBorderDD)),
              width: widget.width ?? size.width,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10.0, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    widget.leadingIcon != null
                        ? Expanded(
                      flex: 1,
                      child: Row(
                        children: [
                          // Container(
                          //   color: AppStyles.transparent,
                          //   width: size.width * 0.12,
                          //   child: Center(
                          //     child: SvgPicture.asset(
                          //        ?? ImageConst.genderIconSVG,
                          //       height: 20,
                          //       width: 20,
                          //     ),
                          //   ),
                          // ),
                          Icon(
                            widget.leadingIcon,
                            size: 20,
                          ),
                          const VerticalDivider(
                            width: 2,
                            color: AppStyles.greyBorderDD,
                            thickness: 1,
                          )
                        ],
                      ),
                    )
                        : const SizedBox(),
                    Expanded(
                      flex: 5,
                      child:  Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: textRegular(
                                text: widget.dropDownSelectionValue.isEmpty
                                    ? widget.isFromTime
                                    ? "00:00"
                                    : widget.label
                                    : widget.dropDownSelectionValue,
                                fontSize: widget.valueFontSize ?? 14,
                                textOverflow: TextOverflow.ellipsis,

                                // fontColor: AppStyles.grey71,
                                isNotLanguageConvert: true),
                          ),
                          widget.isNotDropDownView
                              ? Container()
                              : widget.dropDownSelectionValue.isEmpty
                              ? const Icon(
                            Icons.keyboard_arrow_down_outlined,
                            color: AppStyles.greyBorderDD,
                          )
                              : widget.suffixIcons!
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
