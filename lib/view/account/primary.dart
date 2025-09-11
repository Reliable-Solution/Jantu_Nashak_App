// // flutter
// import 'package:flutter/material.dart';
//
// import 'package:image_picker/image_picker.dart';
// // package
// import 'package:get/get.dart';
// // // theme
// // import 'package:getxnative/Theme/nativeTheme.dart';
// // // constants
// // import 'package:getxnative/constants/colorConst.dart';
// // import 'package:getxnative/constants/imagesConst.dart';
// // // controllers
// // import 'package:getxnative/controllers/editProfileController.dart';
// // // widget
// // import 'package:getxnative/widget/dropDownWidget.dart';
// // import 'package:getxnative/widget/inputWidget.dart';
// // import 'package:getxnative/widget/textWidget.dart';
//
// import '../../Theme/nativeTheme.dart';
// import '../../constant/colorConst.dart';
// import '../../constant/imagesConst.dart';
// import '../../controller/editController.dart';
// import '../../widget/dropdownWidget.dart';
// import '../../widget/inputWidget.dart';
// import '../../widget/textWidget.dart';
//
// class PrimaryScreen extends StatelessWidget {
//   PrimaryScreen({Key? key}) : super(key: key);
//   final EditProfileController _controller = Get.find<EditProfileController>();
//
//   final otpInputDecoration = InputDecoration(
//     counterText: '',
//     alignLabelWithHint: true,
//   );
//   @override
//   Widget build(BuildContext context) {
//     final snackBar = SnackBar(
//       backgroundColor: COLOR.background,
//       content: SingleChildScrollView(
//         child: ListBody(
//           children: [
//             GestureDetector(
//               child: TextWiget(
//                   title: 'Gallary', style: Themes.light.textTheme.displayLarge),
//               onTap: () {
//                 _openGallary(context);
//               },
//             ),
//             const Padding(padding: EdgeInsets.all(10)),
//             GestureDetector(
//               child: TextWiget(
//                 title: 'Camera',
//                 style: Themes.light.textTheme.displayLarge,
//               ),
//               onTap: () {
//                 _openCamera(context);
//               },
//             )
//           ],
//         ),
//       ),
//     );
//
//     return GetBuilder<EditProfileController>(
//         builder: (_controller) => profileCard(context, _controller, snackBar)
//         //     IgnorePointer(
//         //   ignoring: true,
//         //   child: Card(
//         //     child: Container(
//         //       color: COLOR.background,
//         //       child: Padding(
//         //         padding: EdgeInsets.symmetric(horizontal: 15),
//         //         child: Form(
//         //           child: Column(
//         //             mainAxisAlignment: MainAxisAlignment.spaceAround,
//         //             children: <Widget>[
//         //               Padding(
//         //                 padding: const EdgeInsets.only(top: 40),
//         //                 child: Center(
//         //                   child: Container(
//         //                     width: 100,
//         //                     child: CircleAvatar(
//         //                       maxRadius: 40,
//         //                       backgroundImage: AssetImage(Images.profileicon),
//         //                       backgroundColor: COLOR.greyLight,
//         //                     ),
//         //                   ),
//         //                 ),
//         //               ),
//         //               Padding(
//         //                 padding: const EdgeInsets.only(top: 15),
//         //                 child: Center(
//         //                   child: GestureDetector(
//         //                     onTap: () {
//         //                       ScaffoldMessenger.of(context).showSnackBar(snackBar);
//         //                     },
//         //                     child: TextWiget(
//         //                       title: 'ADD PICTURE',
//         //                       style: Themes.light.textTheme.displaySmall!.copyWith(
//         //                         color: COLOR.pink,
//         //                         fontWeight: FontWeight.w600,
//         //                       ),
//         //                     ),
//         //                   ),
//         //                 ),
//         //               ),
//         //               Padding(
//         //                 padding: const EdgeInsets.only(top: 30),
//         //                 child: SizedBox(
//         //                   width: MediaQuery.of(context).size.width,
//         //                   child: InputFiledArea(
//         //                      controller: _controller.cFullName,
//         //                     labelText: 'Full Name*',
//         //                      focusNode: _controller.fFullName,
//         //                     keyboardType: TextInputType.text,
//         //                   ),
//         //                 ),
//         //               ),
//         //               Padding(
//         //                 padding: const EdgeInsets.only(top: 30),
//         //                 child: SizedBox(
//         //                   width: MediaQuery.of(context).size.width,
//         //                   child: InputFiledArea(
//         //                      controller: _controller.cPhoneNo,
//         //                     // focusNode: _controller.fPhoneNo,
//         //                     labelText: 'Phone Number*',
//         //                     keyboardType: TextInputType.text,
//         //                   ),
//         //                 ),
//         //               ),
//         //               Padding(
//         //                 padding: const EdgeInsets.only(top: 15),
//         //                 child: SizedBox(
//         //                   width: MediaQuery.of(context).size.width,
//         //                   child: InputFiledArea(
//         //                      controller: _controller.cEmail,
//         //                     // focusNode: _controller.fEmail,
//         //                     labelText: 'Email ID*',
//         //                     keyboardType: TextInputType.text,
//         //                   ),
//         //                 ),
//         //               ),
//         //               // Padding(
//         //               //   padding: const EdgeInsets.only(top: 15),
//         //               //   child: SizedBox(
//         //               //     width: MediaQuery.of(context).size.width,
//         //               //     child: GetBuilder<EditProfileController>(
//         //               //          builder: (_controller) => DropDownWidget(
//         //               //          focusNode: _controller.fGender,
//         //               //         label: 'Gender*',
//         //               //         onChanged: (String? newValue) {
//         //               //           _controller.changeGenderValue(newValue!);
//         //               //           print(
//         //               //             'Gender Name Value  : ${_controller.selectgender}',
//         //               //           );
//         //               //         },
//         //               //         dropdownInitialValue: _controller.selectgender.value,
//         //               //         items: _controller.genderList,
//         //               //       ),
//         //               //     ),
//         //               //   ),
//         //               // ),
//         //               // Padding(
//         //               //   padding: const EdgeInsets.only(top: 15),
//         //               //   child: SizedBox(
//         //               //     width: MediaQuery.of(context).size.width,
//         //               //     child: Obx(
//         //               //           () => DropDownWidget(
//         //               //          focusNode: _controller.fOccupation,
//         //               //         label: 'Occupation*',
//         //               //         onChanged: (String? newValue) {
//         //               //            _controller.changeOccupationValue(newValue!);
//         //               //            print(
//         //               //             'Occupation Name Value  : ${_controller.selectOccupation}',
//         //               //           );
//         //               //         },
//         //               //         dropdownInitialValue: _controller.selectOccupation.value,
//         //               //         items: _controller.occupationList,
//         //               //       ),
//         //               //     ),
//         //               //   ),
//         //               // ),
//         //               // Padding(
//         //               //   padding: const EdgeInsets.only(top: 15),
//         //               //   child: SizedBox(
//         //               //     width: MediaQuery.of(context).size.width,
//         //               //     child: InputFiledArea(
//         //               //       controller: _controller.cMyBusinessName,
//         //               //       focusNode: _controller.fMyBusinessName,
//         //               //       labelText: 'My Business Name*',
//         //               //       keyboardType: TextInputType.text,
//         //               //     ),
//         //               //   ),
//         //               // ),
//         //               // Padding(
//         //               //   padding: const EdgeInsets.only(top: 15),
//         //               //   child: SizedBox(
//         //               //     width: MediaQuery.of(context).size.width,
//         //               //     child: InputFiledArea(
//         //               //       controller: _controller.cPincode,
//         //               //       focusNode: _controller.fPincode,
//         //               //       labelText: 'Pin Code*',
//         //               //       keyboardType: TextInputType.text,
//         //               //     ),
//         //               //   ),
//         //               // ),
//         //               // Padding(
//         //               //   padding: const EdgeInsets.only(top: 15),
//         //               //   child: SizedBox(
//         //               //     width: MediaQuery.of(context).size.width,
//         //               //     child: InputFiledArea(
//         //               //       controller: _controller.cCity,
//         //               //       focusNode: _controller.fCity,
//         //               //       labelText: 'City*',
//         //               //       keyboardType: TextInputType.text,
//         //               //     ),
//         //               //   ),
//         //               // ),
//         //             ],
//         //           ),
//         //         ),
//         //       ),
//         //     ),
//         //   ),
//         // ),
//         );
//   }
//
//   Widget profileCard(BuildContext context, EditProfileController controller,
//       SnackBar snackBar) {
//     return GetBuilder<EditProfileController>(
//       builder: (_controller) => IgnorePointer(
//         ignoring: true,
//         child: Card(
//           child: Container(
//             color:
//                 Colors.grey[100], // Assuming COLOR.background is a light grey
//             child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 15),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 children: <Widget>[
//                   const SizedBox(height: 40),
//                   Center(
//                     child: SizedBox(
//                       width: 100,
//                       child: CircleAvatar(
//                         maxRadius: 40,
//                         backgroundColor:
//                             Colors.grey[300], // Assuming COLOR.greyLight
//                         child: Icon(
//                           Icons.person,
//                           size: 50,
//                           color: Colors.grey[600],
//                         ),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 15),
//                   // Center(
//                   //   child: GestureDetector(
//                   //     onTap: () {
//                   //       // Allow ADD PICTURE to work despite IgnorePointer
//                   //       ScaffoldMessenger.of(context).showSnackBar(snackBar);
//                   //     },
//                   //     child: Text(
//                   //       'ADD PICTURE',
//                   //       style: Theme.of(context).textTheme.titleMedium!.copyWith(
//                   //         color: Colors.pink, // Assuming COLOR.pink
//                   //         fontWeight: FontWeight.w600,
//                   //       ),
//                   //     ),
//                   //   ),
//                   // ),
//                   const SizedBox(height: 30),
//                   _buildInfoRow(
//                       context, 'Full Name*', _controller.m1!.customerName!),
//                   const SizedBox(height: 30),
//                   _buildInfoRow(context, 'Phone Number*',
//                       _controller.m1!.customerPhoneNo!),
//                   const SizedBox(height: 15),
//                   _buildInfoRow(
//                       context, 'Email ID*', _controller.m1!.customerEmailId!),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildInfoRow(BuildContext context, String label, String value) {
//     return SizedBox(
//       width: MediaQuery.of(context).size.width,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             label,
//             style: TextStyle(
//               color: Colors.grey[600],
//               fontSize: 14,
//               fontWeight: FontWeight.w500,
//             ),
//           ),
//           const SizedBox(height: 4),
//           Container(
//             width: double.infinity,
//             padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
//             decoration: BoxDecoration(
//               color: Colors.grey[200], // Mimicking input field style
//               borderRadius: BorderRadius.circular(8),
//             ),
//             child: Text(
//               value,
//               style: const TextStyle(
//                 color: Colors.black87,
//                 fontSize: 16,
//                 fontWeight: FontWeight.w400,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   _openGallary(BuildContext context) async {
//     final picker = ImagePicker();
//     var picture = await picker.pickImage(source: ImageSource.gallery);
//     if (picture == null) {
//       return;
//     }
//   }
//
//   _openCamera(BuildContext context) async {
//     final picker = ImagePicker();
//     var picture = await picker.pickImage(source: ImageSource.camera);
//     if (picture == null) {
//       return;
//     }
//   }
// }

// flutter
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:image_picker/image_picker.dart';

// package
import 'package:get/get.dart';
import 'package:keep_app/utils/string_res.dart';

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
import '../../constant/app_constant.dart';
import '../../constant/colorConst.dart';
import '../../constant/imagesConst.dart';
import '../../controller/editController.dart';
import '../../widget/alignWidget.dart';
import '../../widget/buttonWidget.dart';
import '../../widget/dividerWidgets.dart';
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
              child: TextWiget(
                  title: StringRes.gallery,
                  style: Themes.light.textTheme.displayLarge),
              onTap: () async {
                _controller.path!.value = await _openGallary(context);
                if (_controller.path!.value != null) {
                  print("Image Path in Gallery: ${_controller.path!.value}");
                }
                // String path ;
                // path = _openGallary(context);
                // print("Image Path in Camera ${path}");
              },
            ),
            const Padding(padding: EdgeInsets.all(10)),
            GestureDetector(
              child: TextWiget(
                title: StringRes.camera,
                style: Themes.light.textTheme.displayLarge,
              ),
              onTap: () async {
                _controller.path!.value = await _openCamera(context);
                if (_controller.path!.value != null) {
                  print("Image Path in Gallery: ${_controller.path!.value}");
                }
              },
            )
          ],
        ),
      ),
    );

    return GetBuilder<EditProfileController>(builder: (_controller) {
      return profileCard(context, _controller, snackBar);
    }

    );
  }

  Widget profileCard(BuildContext context, EditProfileController controller,
      SnackBar snackBar) {
    controller.cPhoneNo.text = controller.m1.value!.customerPhoneNo!;
    return GetBuilder<EditProfileController>(
      builder: (_controller) =>
          Card(
            child: Container(
              color: Colors.grey[100],
              // Assuming COLOR.background is a light grey
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    const SizedBox(height: 40),
                    Obx(() {
                      final localPath = _controller.path!.value;

                      // If user just picked a new image, show that
                      if (localPath.isNotEmpty) {
                        return CircleAvatar(
                          radius: 40,
                          backgroundImage: FileImage(File(localPath)),
                          backgroundColor: Colors.grey[300],
                        );
                      }

                      // Else show from server
                      final networkImage = _controller.m1?.value?.customerImage;
                      if (networkImage != null && networkImage.isNotEmpty) {
                        return CircleAvatar(
                          radius: 40,
                          backgroundImage: NetworkImage(IMAGE_URL +
                              networkImage),
                          backgroundColor: Colors.grey[300],
                        );
                      }

                      // Default placeholder
                      return CircleAvatar(
                        radius: 40,
                        backgroundColor: Colors.grey[300],
                        child: Icon(
                            Icons.person, size: 40, color: Colors.grey[600]),
                      );
                    }),


                    Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Center(
                        child: GestureDetector(
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(12)),
                              ),
                              backgroundColor: Colors.white,
                              isScrollControlled: false,
                              // Ye pura page cover nahi karega
                              constraints: const BoxConstraints(
                                maxHeight: 200, // Fixed height for compact look
                              ),
                              builder: (context) =>
                                  Padding(
                                    padding: const EdgeInsets.all(16),
                                    child: EditPhotoBottomSheet(
                                      onImageSelected: (path) {
                                        if (path != null) {
                                          _controller.path!.value = path;
                                          print("Selected image path: $path");
                                        }
                                      },
                                    ),
                                  ),
                            );

                          },
                          child: TextWiget(
                            title:
                            StringRes.addPicture,
                            // "Add Picture",
                            style: Themes.light.textTheme.displaySmall!
                                .copyWith(
                              color: COLOR.appBaseColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                    // const SizedBox(height: 15),


                    // TextWiget(title: "Customer Referral Code ${_controller.m1.value!.customerReferCode}",),
                    Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: SizedBox(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width,
                        child: InputFiledArea(
                          controller: _controller.cFullName,
                          labelText: StringRes.fullName,
                          focusNode: _controller.fFullName,
                          keyboardType: TextInputType.text,

                          validator: (value) {
                            if (value!.isEmpty) return StringRes.fullNameRequired;
                            if (value.length < 3) return StringRes.fullNameInvalid;
                            return null;
                          },
                        ),
                      ),
                    ),

                    const SizedBox(height: 30),
                    _buildInfoRow(context, StringRes.phoneNumber,
                        _controller.m1!.value!.customerPhoneNo!),
                    Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: SizedBox(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width,
                        child: InputFiledArea(
                          controller: _controller.cEmail,
                          focusNode: _controller.fEmail,
                          labelText: StringRes.email,
                          keyboardType: TextInputType.text,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery
                          .sizeOf(context)
                          .height * 0.02,
                    ),
                    Container(
                      height: MediaQuery
                          .of(context)
                          .size
                          .height * 0.14,
                      // color: COLOR.background,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // DividerWidget(thickness: 1, height: 0),
                          Expanded(
                            child: AlignWidget(
                              alignment: Alignment.center,
                              child: Container(
                                height: MediaQuery
                                    .of(context)
                                    .size
                                    .height * 0.08,
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 8),
                                child: ButtonWidgets(
                                  title: StringRes.save,
                                  voidCallback: () {
                                    if (_controller.cFullName.text.isNotEmpty) {
                                      _controller.EditProfile(
                                        customerId: _controller.m1!.value!
                                            .customerId!,
                                        email: _controller.cEmail.text ?? "" ,
                                        gender: "Male",
                                        name: _controller.cFullName.text,
                                        path: _controller.path!.value,
                                      );
                                    }
                                    else if(_controller.cFullName.text.isEmpty){
                                      Fluttertoast
                                          .showToast(
                                          msg: "Name is Required",
                                          gravity: ToastGravity.BOTTOM);
                                    }
                                    // else if(_controller.cEmail.text.isEmpty){
                                    // Fluttertoast
                                    //     .showToast(
                                    // msg: "Profile Edited Successfully",
                                    // gravity: ToastGravity.BOTTOM);
                                    // }

                                  },
                                  color: COLOR.appBaseColor,
                                  style: Themes.light.textTheme.displayLarge!
                                      .copyWith(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )

                  ],
                ),
              ),
            ),
          ),
    );
  }

  Widget _buildInfoRow(BuildContext context, String label, String value) {
    return SizedBox(
      width: MediaQuery
          .of(context)
          .size
          .width,
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
    final XFile? picture = await picker.pickImage(source: ImageSource.gallery);

    if (picture == null) {
      return null; // If no image selected
    }

    return picture.path;
    // final picker = ImagePicker();
    // var picture = await picker.pickImage(source: ImageSource.gallery);
    // if (picture == null) {
    //   return;
    // }
  }

  _openCamera(BuildContext context) async {
    final picker = ImagePicker();
    final XFile? picture = await picker.pickImage(source: ImageSource.camera);
    if (picture == null) {
      return;
    }

    return picture.path;
  }
}



class EditPhotoBottomSheet extends StatelessWidget {
  final Function(String?) onImageSelected;

  const EditPhotoBottomSheet({Key? key, required this.onImageSelected})
      : super(key: key);

  Future<void> _pickImage(ImageSource source, BuildContext context) async {
    final picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: source);
    if (image != null) {
      onImageSelected(image.path);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 100,
      // width: 100,
      color: Colors.white,

      padding: const EdgeInsets.all(16),
      child: ListView(
        // mainAxisSize: MainAxisSize.min,
        // crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
           " StringRes.editPhoto",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () => _pickImage(ImageSource.gallery, context),
                child: Column(
                  children: [
                    Icon(Icons.photo_library, size: 40),
                    SizedBox(height: 8),
                    Text(StringRes.gallery, style: TextStyle(fontSize: 14)),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () => _pickImage(ImageSource.camera, context),
                child: Column(
                  children: [
                    Icon(Icons.camera_alt, size: 40),
                    SizedBox(height: 8),
                    Text(StringRes.camera, style: TextStyle(fontSize: 14)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(StringRes.cancel, style: TextStyle(color: Colors.grey)),
          ),
        ],
      ),
    );
  }
}