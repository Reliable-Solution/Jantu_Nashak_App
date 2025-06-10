// flutter
import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';
// package
import 'package:get/get.dart';
// // theme
// import 'package:getxnative/Theme/nativeTheme.dart';
// // constants
// import 'package:getxnative/constants/colorConst.dart';
// import 'package:getxnative/constants/imagesConst.dart';
// // controllers
// import 'package:getxnative/controllers/editProfileController.dart';
// // widget
// import 'package:getxnative/widget/dropDownWidget.dart';
// import 'package:getxnative/widget/inputWidget.dart';
// import 'package:getxnative/widget/textWidget.dart';

import '../../Theme/nativeTheme.dart';
import '../../constant/colorConst.dart';
import '../../constant/imagesConst.dart';
import '../../controller/editController.dart';
import '../../widget/dropdownWidget.dart';
import '../../widget/inputWidget.dart';
import '../../widget/textWidget.dart';

class PrimaryScreen extends StatelessWidget {
  PrimaryScreen({Key? key}) : super(key: key);
   final EditProfileController _controller = Get.find<EditProfileController>();

  final otpInputDecoration = InputDecoration(
    counterText: '',
    alignLabelWithHint: true,
  );
  @override
  Widget build(BuildContext context) {
    final snackBar = SnackBar(
      backgroundColor: COLOR.background,
      content: SingleChildScrollView(
        child: ListBody(
          children: [
            GestureDetector(
              child: TextWiget(title: 'Gallary', style: Themes.light.textTheme.displayLarge),
              onTap: () {
                _openGallary(context);
              },
            ),
            const Padding(padding: EdgeInsets.all(10)),
            GestureDetector(
              child: TextWiget(
                title: 'Camera',
                style: Themes.light.textTheme.displayLarge,
              ),
              onTap: () {
                _openCamera(context);
              },
            )
          ],
        ),
      ),
    );

    return GetBuilder<EditProfileController>(
      builder: (_controller) =>
          profileCard(context, _controller, snackBar)
      //     IgnorePointer(
      //   ignoring: true,
      //   child: Card(
      //     child: Container(
      //       color: COLOR.background,
      //       child: Padding(
      //         padding: EdgeInsets.symmetric(horizontal: 15),
      //         child: Form(
      //           child: Column(
      //             mainAxisAlignment: MainAxisAlignment.spaceAround,
      //             children: <Widget>[
      //               Padding(
      //                 padding: const EdgeInsets.only(top: 40),
      //                 child: Center(
      //                   child: Container(
      //                     width: 100,
      //                     child: CircleAvatar(
      //                       maxRadius: 40,
      //                       backgroundImage: AssetImage(Images.profileicon),
      //                       backgroundColor: COLOR.greyLight,
      //                     ),
      //                   ),
      //                 ),
      //               ),
      //               Padding(
      //                 padding: const EdgeInsets.only(top: 15),
      //                 child: Center(
      //                   child: GestureDetector(
      //                     onTap: () {
      //                       ScaffoldMessenger.of(context).showSnackBar(snackBar);
      //                     },
      //                     child: TextWiget(
      //                       title: 'ADD PICTURE',
      //                       style: Themes.light.textTheme.displaySmall!.copyWith(
      //                         color: COLOR.pink,
      //                         fontWeight: FontWeight.w600,
      //                       ),
      //                     ),
      //                   ),
      //                 ),
      //               ),
      //               Padding(
      //                 padding: const EdgeInsets.only(top: 30),
      //                 child: SizedBox(
      //                   width: MediaQuery.of(context).size.width,
      //                   child: InputFiledArea(
      //                      controller: _controller.cFullName,
      //                     labelText: 'Full Name*',
      //                      focusNode: _controller.fFullName,
      //                     keyboardType: TextInputType.text,
      //                   ),
      //                 ),
      //               ),
      //               Padding(
      //                 padding: const EdgeInsets.only(top: 30),
      //                 child: SizedBox(
      //                   width: MediaQuery.of(context).size.width,
      //                   child: InputFiledArea(
      //                      controller: _controller.cPhoneNo,
      //                     // focusNode: _controller.fPhoneNo,
      //                     labelText: 'Phone Number*',
      //                     keyboardType: TextInputType.text,
      //                   ),
      //                 ),
      //               ),
      //               Padding(
      //                 padding: const EdgeInsets.only(top: 15),
      //                 child: SizedBox(
      //                   width: MediaQuery.of(context).size.width,
      //                   child: InputFiledArea(
      //                      controller: _controller.cEmail,
      //                     // focusNode: _controller.fEmail,
      //                     labelText: 'Email ID*',
      //                     keyboardType: TextInputType.text,
      //                   ),
      //                 ),
      //               ),
      //               // Padding(
      //               //   padding: const EdgeInsets.only(top: 15),
      //               //   child: SizedBox(
      //               //     width: MediaQuery.of(context).size.width,
      //               //     child: GetBuilder<EditProfileController>(
      //               //          builder: (_controller) => DropDownWidget(
      //               //          focusNode: _controller.fGender,
      //               //         label: 'Gender*',
      //               //         onChanged: (String? newValue) {
      //               //           _controller.changeGenderValue(newValue!);
      //               //           print(
      //               //             'Gender Name Value  : ${_controller.selectgender}',
      //               //           );
      //               //         },
      //               //         dropdownInitialValue: _controller.selectgender.value,
      //               //         items: _controller.genderList,
      //               //       ),
      //               //     ),
      //               //   ),
      //               // ),
      //               // Padding(
      //               //   padding: const EdgeInsets.only(top: 15),
      //               //   child: SizedBox(
      //               //     width: MediaQuery.of(context).size.width,
      //               //     child: Obx(
      //               //           () => DropDownWidget(
      //               //          focusNode: _controller.fOccupation,
      //               //         label: 'Occupation*',
      //               //         onChanged: (String? newValue) {
      //               //            _controller.changeOccupationValue(newValue!);
      //               //            print(
      //               //             'Occupation Name Value  : ${_controller.selectOccupation}',
      //               //           );
      //               //         },
      //               //         dropdownInitialValue: _controller.selectOccupation.value,
      //               //         items: _controller.occupationList,
      //               //       ),
      //               //     ),
      //               //   ),
      //               // ),
      //               // Padding(
      //               //   padding: const EdgeInsets.only(top: 15),
      //               //   child: SizedBox(
      //               //     width: MediaQuery.of(context).size.width,
      //               //     child: InputFiledArea(
      //               //       controller: _controller.cMyBusinessName,
      //               //       focusNode: _controller.fMyBusinessName,
      //               //       labelText: 'My Business Name*',
      //               //       keyboardType: TextInputType.text,
      //               //     ),
      //               //   ),
      //               // ),
      //               // Padding(
      //               //   padding: const EdgeInsets.only(top: 15),
      //               //   child: SizedBox(
      //               //     width: MediaQuery.of(context).size.width,
      //               //     child: InputFiledArea(
      //               //       controller: _controller.cPincode,
      //               //       focusNode: _controller.fPincode,
      //               //       labelText: 'Pin Code*',
      //               //       keyboardType: TextInputType.text,
      //               //     ),
      //               //   ),
      //               // ),
      //               // Padding(
      //               //   padding: const EdgeInsets.only(top: 15),
      //               //   child: SizedBox(
      //               //     width: MediaQuery.of(context).size.width,
      //               //     child: InputFiledArea(
      //               //       controller: _controller.cCity,
      //               //       focusNode: _controller.fCity,
      //               //       labelText: 'City*',
      //               //       keyboardType: TextInputType.text,
      //               //     ),
      //               //   ),
      //               // ),
      //             ],
      //           ),
      //         ),
      //       ),
      //     ),
      //   ),
      // ),
    );
  }

  Widget profileCard(BuildContext context, EditProfileController controller, SnackBar snackBar) {
    return GetBuilder<EditProfileController>(
      builder: (_controller) => IgnorePointer(
        ignoring: true,
        child: Card(
          child: Container(
            color: Colors.grey[100], // Assuming COLOR.background is a light grey
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  const SizedBox(height: 40),
                  Center(
                    child: SizedBox(
                      width: 100,
                      child: CircleAvatar(
                        maxRadius: 40,
                        backgroundColor: Colors.grey[300], // Assuming COLOR.greyLight
                        child: Icon(
                          Icons.person,
                          size: 50,
                          color: Colors.grey[600],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  // Center(
                  //   child: GestureDetector(
                  //     onTap: () {
                  //       // Allow ADD PICTURE to work despite IgnorePointer
                  //       ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  //     },
                  //     child: Text(
                  //       'ADD PICTURE',
                  //       style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  //         color: Colors.pink, // Assuming COLOR.pink
                  //         fontWeight: FontWeight.w600,
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  const SizedBox(height: 30),
                  _buildInfoRow(context, 'Full Name*', _controller.m1!.customerName!),
                  const SizedBox(height: 30),
                  _buildInfoRow(context, 'Phone Number*', _controller.m1!.customerPhoneNo!),
                  const SizedBox(height: 15),
                  _buildInfoRow(context, 'Email ID*', _controller.m1!.customerEmailId!),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(BuildContext context, String label, String value) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 4),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              color: Colors.grey[200], // Mimicking input field style
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              value,
              style: const TextStyle(
                color: Colors.black87,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }


  _openGallary(BuildContext context) async {
    final picker = ImagePicker();
    var picture = await picker.pickImage(source: ImageSource.gallery);
    if (picture == null) {
      return;
    }
  }

  _openCamera(BuildContext context) async {
    final picker = ImagePicker();
    var picture = await picker.pickImage(source: ImageSource.camera);
    if (picture == null) {
      return;
    }
  }
}
