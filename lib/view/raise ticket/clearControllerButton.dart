
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../constant/colorConst.dart';
// import 'package:suratjugaad/a_structure/constant/app_styles.dart';

class ClearControllerButtonWidget extends StatelessWidget {
  final VoidCallback? onPressed;
  const ClearControllerButtonWidget({super.key,this.onPressed,});

  Future<void> _handleButtonClick() async {
    // Call multiple functions here
    await HapticFeedback.mediumImpact();
    onPressed!();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _handleButtonClick,
      child: Container(
        height: 20,
        width: 20,
        decoration: BoxDecoration(
            color: COLOR.appBaseColor.withOpacity(0.15),
            shape: BoxShape.circle
        ),
        child:  Icon(
          Icons.close,
          color: COLOR.appBaseColor,
          size: 14,
        ),
      ),
    );
  }
}
