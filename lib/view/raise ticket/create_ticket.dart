//
// // import 'dart:js_interop';
//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:keep_app/view/raise%20ticket/search_dropDownWidget.dart';
// import 'package:keep_app/view/raise%20ticket/search_dropdown.dart';
// import 'package:keep_app/view/raise%20ticket/text_field.dart';
//
// import '../../Theme/nativeTheme.dart';
// import '../../constant/colorConst.dart';
// import '../../controller/ticketController.dart';
// import '../../utils/services/services.dart';
// import '../../utils/string_res.dart';
// import '../../widget/appBarWidget.dart';
// import '../../widget/show_snackbar.dart';
// import '../../widget/textWidget.dart';
// import 'app_style.dart';
// import 'app_utils.dart';
// import 'clearControllerButton.dart';
// import 'container_cost.dart';
// import 'dropDownUIConst.dart';
// import 'package:intl/intl.dart';
//
//
// class CreateComplainScreen extends StatelessWidget {
//   const CreateComplainScreen({super.key});
//
//   static Widget create() {
//     Get.put(TicketController());
//     return const CreateComplainScreen();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final controller = Get.find<TicketController>();
//     final size = MediaQuery.of(context).size;
//
//     return SafeArea(
//       top: false,
//       child: Scaffold(
//         appBar: MyCustomAppBar(
//           leading: InkWell(
//             onTap: () {
//               Get.back();
//             },
//             child: Icon(
//               Icons.arrow_back_ios,
//               color: COLOR.greyback,
//               size: 20,
//             ),
//           ),
//
//           // leading: SizedBox(),
//           // action: [],
//           actionPadding: 10,
//           height: 90,
//           appbarPadding: 0,
//           title: TextWiget(
//             title: 'Help Desk',
//             style: Themes.light.textTheme.displayLarge,
//           ),
//           elevation: 1,
//         ),
//
//         body: Obx(() => controller.isGetTicketAreaProblemLoading.value
//             ? AppUtils.circularLoaderData()
//             : SingleChildScrollView(
//           child: Column(
//             children: [
//               _imagePicketSection(controller, size),
//               if (controller.userName.value == "") ...[_titleDetailsSection(controller, size)],
//               _facingSection(controller),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 10.0),
//                 child: Column(
//                   children: [
//                     _ticketAreaProblemWidget(controller),
//                     _ticketSubAreaProblemWidget(controller,context),
//                     _ticketPriorityWidget(controller),
//                   ],
//                 ),
//               ),
//               _descriptionDetailsSection(controller, size),
//               _submitButton(controller, size,context),
//             ],
//           ),
//         )),
//       ),
//     );
//   }
//
//   Widget _imagePicketSection(TicketController controller, Size size) {
//     return Column(
//       children: [
//         SizedBox(height: 20),
//         _getImageWidget(controller),
//         SizedBox(height: 20),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             InkWell(
//               child: Row(
//                 mainAxisSize: MainAxisSize.min,
//                 children: <Widget>[
//                   Icon(
//                     Icons.camera_alt,
//                     color: COLOR.appBaseColor,
//                     size: 40,
//                   ),
//                   SizedBox(width: 10),
//                   Text('Camera'),
//                 ],
//               ),
//               onTap: () async {
//                 bool permission = await Services().askCameraPermission();
//                 if (permission) {
//                   controller.getImage(ImageSource.camera);
//                 }
//               },
//             ),
//             Container(width: 20),
//             InkWell(
//               child: Row(
//                 mainAxisSize: MainAxisSize.min,
//                 children: <Widget>[
//                   Icon(
//                     Icons.photo,
//                     color: COLOR.appBaseColor,
//                     size: 40,
//                   ),
//                   SizedBox(width: 10),
//                   Text('Gallery'),
//                 ],
//               ),
//               onTap: () async {
//                 bool permission = await Services().askPhotosPermission();
//                 if (permission) {
//                   controller.getImage(ImageSource.gallery);
//                 }
//               },
//             ),
//           ],
//         ),
//         Obx(() => controller.inProcess.value
//             ? Container(
//           color: Colors.white,
//           height: MediaQuery.of(Get.context!).size.height,
//           child: Center(child: CircularProgressIndicator()),
//         )
//             : Center()),
//       ],
//     );
//   }
//
//   Widget _getImageWidget(TicketController controller) {
//     return Obx(() => controller.selectedFile.value != null
//         ? ClipOval(
//       child: Image.file(
//         controller.selectedFile.value!,
//         width: 120,
//         height: 120,
//         fit: BoxFit.contain,
//       ),
//     )
//         : ClipOval(
//       child: Image.asset(
//         'assets/complaint.png',
//         width: 120,
//         height: 120,
//         fit: BoxFit.fill,
//       ),
//     ));
//   }
//
//   Widget _titleDetailsSection(TicketController controller, Size size) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         SizedBox(height: 20),
//         Padding(
//           padding: EdgeInsets.only(left: 10, bottom: 0),
//           child: Text(StringRes.ticketUserName),
//         ),
//         TextFormFieldConst(
//           controller: controller.userNameController,
//           hintText: StringRes.enterTicketUserName,
//           keyboardType: TextInputType.text,
//           maxLine: 1,
//           prefixIcon: Icon(Icons.ad_units, color: COLOR.appBaseColor, size: 20),
//         ),
//       ],
//     );
//   }
//
//   Widget _facingSection(TicketController controller) {
//     return Padding(
//       padding: const EdgeInsets.only(left: 12.0, right: 12.0, top: 8),
//       child: DropDownUIConst(
//         label: StringRes.facingIssueSince,
//         dropDownSelectionValue: controller.facingDate.value ?? "",
//         suffixIcons: ClearControllerButtonWidget(
//           onPressed: () {
//             HapticFeedback.mediumImpact();
//             controller.facingDate.value = null;
//           },
//         ),
//         valueFontSize: 15,
//         onTap: () {
//           showDatePicker(
//             context: Get.context!,
//             initialDate: DateTime.now(),
//             firstDate: DateTime(2020),
//             lastDate: DateTime(2100),
//             builder: (context, child) {
//               return Theme(
//                 data: ThemeData.light().copyWith(
//                   colorScheme: ColorScheme.light(
//                     primary: COLOR.appBaseColor,
//                     onPrimary: COLOR.background,
//                     onSurface: AppStyles.black,
//                   ),
//                   dialogBackgroundColor: COLOR.background,
//                 ),
//                 child: child!,
//               );
//             },
//           ).then((pickedDate) {
//             if (pickedDate != null) {
//               controller.facingDate.value = DateFormat("dd MMM, yyyy").format(pickedDate);
//             }
//           });
//         },
//       ),
//     );
//   }
//
//   Widget _descriptionDetailsSection(TicketController controller, Size size) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         SizedBox(height: 20),
//         Padding(
//           padding: EdgeInsets.only(left: 10, bottom: 0),
//           child: Text(StringRes.description),
//         ),
//         TextFormFieldConst(
//           height: size.height * 0.20,
//           controller: controller.descriptionController,
//           hintText: StringRes.enterDescription,
//           keyboardType: TextInputType.text,
//           maxLine: 5,
//           prefixIcon: Icon(Icons.description, color: COLOR.appBaseColor, size: 20),
//         ),
//       ],
//     );
//   }
//
//   Widget _ticketAreaProblemWidget(TicketController controller) {
//     return Padding(
//       padding: const EdgeInsets.only(top: 12.0),
//       child: SearchDropUiWidget(
//         label: StringRes.problemArea,
//         title: controller.selectedTicketAreaProblem.value ?? StringRes.problemArea,
//         suffixIcons: ClearControllerButtonWidget(
//           onPressed: () {
//             HapticFeedback.mediumImpact();
//             controller.selectedTicketAreaProblem.value = null;
//             controller.selectedTicketSubAreaProblem.value = null;
//           },
//         ),
//         isValueSelected: controller.selectedTicketAreaProblem.value != null,
//         onTap: () async {
//           await showDialog(
//             context: Get.context!,
//             useRootNavigator: false,
//             builder: (context) => SearchableDropDownWidget(
//               headingTitle: StringRes.problemArea,
//               listData: controller.searchTicketAreaProblemList,
//               onDataChanged: (value) {
//                 if (controller.selectedTicketAreaProblem.value != value?.title) {
//                   controller.selectedTicketSubAreaProblem.value = null;
//                 }
//                 controller.selectedTicketAreaProblem.value = value.title;
//                 controller.selectedTicketAreaProblemID.value = value.id;
//                 controller.getTicketSubAreaProblemAPI();
//               },
//             ),
//           );
//         },
//       ),
//     );
//   }
//
//   Widget _ticketSubAreaProblemWidget(TicketController controller,BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(top: 12.0),
//       child: SearchDropUiWidget(
//         label: StringRes.problemSubArea,
//         title: controller.selectedTicketSubAreaProblem.value ?? StringRes.problemSubArea,
//         suffixIcons: ClearControllerButtonWidget(
//           onPressed: () {
//             HapticFeedback.mediumImpact();
//             controller.selectedTicketSubAreaProblem.value = null;
//           },
//         ),
//         isValueSelected: controller.selectedTicketSubAreaProblem.value != null,
//         onTap: controller.getTicketSubAreaProblemList.isEmpty
//             ? () {
//           showSnackBar(
//             msg: "Please first select the problem area",
//             isError: true, context: context,
//           );
//         }
//             : () async {
//           await showDialog(
//             context: Get.context!,
//             useRootNavigator: false,
//             builder: (context) => SearchableDropDownWidget(
//               headingTitle: StringRes.problemSubArea,
//               listData: controller.searchTicketSubAreaProblemList,
//               onDataChanged: (value) {
//                 controller.selectedTicketSubAreaProblem.value = value.title;
//                 controller.selectedTicketSubAreaProblemID.value = value.id;
//               },
//             ),
//           );
//         },
//       ),
//     );
//   }
//
//   Widget _ticketPriorityWidget(TicketController controller) {
//     return Padding(
//       padding: const EdgeInsets.only(top: 12.0),
//       child: SearchDropUiWidget(
//         label: StringRes.ticketPriority,
//         title: controller.selectedTicketPriority.value ?? StringRes.ticketPriority,
//         suffixIcons: ClearControllerButtonWidget(
//           onPressed: () {
//             HapticFeedback.mediumImpact();
//             controller.selectedTicketPriority.value = null;
//           },
//         ),
//         isValueSelected: controller.selectedTicketPriority.value != null,
//         onTap: () async {
//           await showDialog(
//             context: Get.context!,
//             useRootNavigator: false,
//             builder: (context) => SearchableDropDownWidget(
//               headingTitle: StringRes.ticketPriority,
//               listData: controller.searchTicketPriorityList,
//               onDataChanged: (value) {
//                 controller.selectedTicketPriority.value = value.title;
//                 controller.selectedTicketPriorityID.value = value.id;
//               },
//             ),
//           );
//         },
//       ),
//     );
//   }
//
//   Widget _submitButton(TicketController controller, Size size,BuildContext context) {
//     return Obx(() => controller.isAddTicketLoading.value
//         ? Padding(
//       padding: EdgeInsets.only(bottom: size.height * 0.02),
//       child: AppUtils.circularLoaderData(),
//     )
//         : ContainerConst(
//       onTap: () {
//         controller.validateDetails(context);
//       },
//       height: 50,
//       width: size.width,
//       color: appPrimaryMaterialColorcard,
//       topPadding: size.height * 0.01,
//       bottomPadding: size.height * 0.02,
//       child: Center(
//         child: Text(
//           "Create Ticket",
//           style: TextStyle(
//             color: Colors.white,
//             fontSize: 16,
//             fontWeight: FontWeight.w700,
//           ),
//         ),
//       ),
//     ));
//   }
// }
import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:keep_app/view/raise%20ticket/app_common_text.dart';
import 'package:keep_app/view/raise%20ticket/search_dropDownWidget.dart';
import 'package:keep_app/view/raise%20ticket/search_dropdown.dart';
import 'package:keep_app/view/raise%20ticket/text_field.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
// import 'package:suratjugaad/Common/Colors.dart';
// import 'package:suratjugaad/Common/constants.dart';
// import 'package:suratjugaad/Common/services.dart';
// import 'package:suratjugaad/a_structure/constant/app_styles.dart';
// import 'package:suratjugaad/a_structure/constant/app_utils.dart';
// import 'package:suratjugaad/a_structure/models/drop_down_model/search_drop_model.dart';
// import 'package:suratjugaad/a_structure/preferences/shared_pref_const.dart';
// import 'package:suratjugaad/a_structure/preferences/shared_prefs_data.dart';
// import 'package:suratjugaad/screen_const/container_const.dart';
// import 'package:suratjugaad/screen_const/show_snack_bar.dart';
// import 'package:suratjugaad/screen_const/text_form_field_const.dart';
// import 'package:suratjugaad/widgets/clear_controller_button_widget.dart';
// import 'package:suratjugaad/widgets/drop_down_widget/drop_down_ui_const.dart';
// import 'package:suratjugaad/widgets/drop_down_widget/search_drop_UI_widget.dart';
// import 'package:suratjugaad/widgets/drop_down_widget/searchable_drop_down_widget.dart';
// import '../../../Common/StringRes.dart';
import '../../constant/colorConst.dart';
import '../../controller/ticketController.dart';
import '../../utils/services/services.dart';
import '../../utils/string_res.dart';
import '../../widget/show_snackbar.dart';
import 'app_style.dart';
import 'app_utils.dart';
import 'clearControllerButton.dart';
import 'container_cost.dart';
import 'dropDownUIConst.dart';
// import 'ticket_controller.dart';

class CreateComplainScreen extends StatelessWidget {
  const CreateComplainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TicketController controller = Get.find<TicketController>();
    final Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        body: Obx(() => controller.isGetTicketAreaProblemLoading.value
            ? AppUtils.circularLoaderData()
            : SingleChildScrollView(
                child: Column(
                  children: [
                    _imagePicketSection(controller, context),
                    _titleDetailsSection(controller),

                    // if (controller.userNameController.text.isEmpty) ...[_titleDetailsSection(controller)],
                    _facingSection(controller),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Column(
                        children: [
                          // _titleDetailsSection(controller)
                          // _ticketAreaProblemWidget(controller, context),
                          // _ticketSubAreaProblemWidget(controller, context),
                          // _ticketPriorityWidget(controller, context),
                        ],
                      ),
                    ),
                    _descriptionDetailsSection(controller, size),
                    _submitButton(controller, size, context),
                  ],
                ),
              )),
      ),
    );
  }

  Widget _imagePicketSection(
      TicketController controller, BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 20),
        _getImageWidget(controller),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            InkWell(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Icon(
                    Icons.camera_alt,
                    color: AppStyles.primaryColor,
                    size: 40,
                  ),
                  SizedBox(width: 10),
                  Text(StringRes.camera
                      // 'Camera'
                  ),
                ],
              ),
              onTap: () async {
                print("Camera Permission called");
                bool permission = await Services().askCameraPermission();
                if (permission) {
                  controller.getImage(ImageSource.camera);
                }
              },
            ),
            Container(width: 20),
            InkWell(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Icon(
                    Icons.photo,
                    color: AppStyles.primaryColor,
                    size: 40,
                  ),
                  SizedBox(width: 10),
                  Text(StringRes.gallery),
                ],
              ),
              onTap: () async {
                bool permission = await Services().askPhotosPermission();
                if (permission) {
                  controller.getImage(ImageSource.gallery);
                }
              },
            ),
          ],
        ),
        controller.inProcess.value
            ? Container(
                color: Colors.white,
                height: MediaQuery.of(context).size.height,
                child: Center(child: CircularProgressIndicator()),
              )
            : Center(),
      ],
    );
  }

  Widget _getImageWidget(TicketController controller) {
    return controller.selectedFile.value != null
        ? ClipOval(
            child: Image.file(
              controller.selectedFile.value!,
              width: 120,
              height: 120,
              fit: BoxFit.contain,
            ),
          )
        : ClipOval(
            child: Image.asset(
              'assets/complaint.png',
              width: 120,
              height: 120,
              fit: BoxFit.fill,
            ),
          );
  }

  Widget _titleDetailsSection(TicketController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 20),
        Padding(
          padding: EdgeInsets.only(left: 10, bottom: 0),
          child: textSemiBold(text: StringRes.ticketUserName, fontSize: 16),
        ),
        TextFormFieldConst(
          controller: controller.userNameController,
          hintText: StringRes.enterTicketUserName,
          keyboardType: TextInputType.text,
          maxLine: 1,
          prefixIcon:
              Icon(Icons.ad_units, color: AppStyles.primaryColor, size: 20),
        ),
      ],
    );
  }

  Widget _facingSection(TicketController controller) {
    return Padding(
      padding: const EdgeInsets.only(left: 12.0, right: 12.0, top: 8),
      child: DropDownUIConst(
        label: StringRes.facingIssueSince,
        dropDownSelectionValue: controller.facingDate.value ?? "",
        suffixIcons: ClearControllerButtonWidget(
          onPressed: () {
            HapticFeedback.mediumImpact();
            controller.facingDate.value = null;
          },
        ),
        valueFontSize: 15,
        onTap: () {
          showDatePicker(
            context: Get.context!,
            initialDate: DateTime.now(),
            firstDate: DateTime(2020),
            lastDate: DateTime(2100),
            builder: (context, child) {
              return Theme(
                data: ThemeData.light().copyWith(
                  colorScheme: const ColorScheme.light(
                    primary: AppStyles.primaryColor,
                    onPrimary: AppStyles.white,
                    onSurface: AppStyles.black,
                  ),
                  dialogBackgroundColor: AppStyles.white,
                ),
                child: child!,
              );
            },
          ).then((pickedDate) {
            if (pickedDate != null) {
              controller.facingDate.value =
                  DateFormat("dd MMM, yyyy").format(pickedDate);
            }
          });
        },
      ),
    );
  }

  Widget _descriptionDetailsSection(TicketController controller, Size size) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 20),
        Padding(
          padding: EdgeInsets.only(left: 10, bottom: 0),
          child: textSemiBold(text: StringRes.description, fontSize: 16),
        ),
        TextFormFieldConst(
          height: size.height * 0.20,
          controller: controller.descriptionController,
          hintText: StringRes.enterDescription,
          keyboardType: TextInputType.text,
          maxLine: 5,
          prefixIcon:
              Icon(Icons.description, color: AppStyles.primaryColor, size: 20),
        ),
      ],
    );
  }

  // Widget _ticketAreaProblemWidget(TicketController controller, BuildContext context) {
  //   return Padding(
  //     padding: const EdgeInsets.only(top: 12.0),
  //     child: SearchDropUiWidget(
  //       label: StringRes.problemArea,
  //       title: controller.selectedTicketAreaProblem.value ?? StringRes.problemArea,
  //       suffixIcons: ClearControllerButtonWidget(
  //         onPressed: () {
  //           HapticFeedback.mediumImpact();
  //           controller.selectedTicketAreaProblem.value = null;
  //           controller.selectedTicketSubAreaProblem.value = null;
  //           controller.selectedTicketAreaProblemID.value = null;
  //           controller.selectedTicketSubAreaProblemID.value = null;
  //         },
  //       ),
  //       isValueSelected: controller.selectedTicketAreaProblem.value != null,
  //       onTap: () async {
  //         await showDialog(
  //           context: context,
  //           useRootNavigator: false,
  //           builder: (context) => SearchableDropDownWidget(
  //             headingTitle: StringRes.problemArea,
  //             listData: controller.searchTicketAreaProblemList,
  //             onDataChanged: (value) {
  //               if (controller.selectedTicketAreaProblem.value != value.title) {
  //                 controller.selectedTicketSubAreaProblem.value = null;
  //                 controller.selectedTicketSubAreaProblemID.value = null;
  //               }
  //               controller.selectedTicketAreaProblem.value = value.title;
  //               controller.selectedTicketAreaProblemID.value = value.id;
  //               // controller.getTicketSubAreaProblem();
  //             },
  //           ),
  //         );
  //       },
  //     ),
  //   );
  // }

  Widget _ticketSubAreaProblemWidget(
      TicketController controller, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0),
      child: SearchDropUiWidget(
        label: StringRes.problemSubArea,
        title: controller.selectedTicketSubAreaProblem.value ??
            StringRes.problemSubArea,
        suffixIcons: ClearControllerButtonWidget(
          onPressed: () {
            HapticFeedback.mediumImpact();
            controller.selectedTicketSubAreaProblem.value = null;
            controller.selectedTicketSubAreaProblemID.value = null;
          },
        ),
        isValueSelected: controller.selectedTicketSubAreaProblem.value != null,
        onTap: controller.getTicketSubAreaProblemList.isEmpty
            ? () {
                showSnackBar(
                    context: context,
                    msg: StringRes.pleaseSelectProblemArea,
                    isError: true);
              }
            : () async {
                await showDialog(
                  context: context,
                  useRootNavigator: false,
                  builder: (context) => SearchableDropDownWidget(
                    headingTitle: StringRes.problemSubArea,
                    listData: controller.searchTicketSubAreaProblemList,
                    onDataChanged: (value) {
                      controller.selectedTicketSubAreaProblem.value =
                          value.title;
                      controller.selectedTicketSubAreaProblemID.value =
                          value.id;
                    },
                  ),
                );
              },
      ),
    );
  }

  Widget _ticketPriorityWidget(
      TicketController controller, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0),
      child: SearchDropUiWidget(
        label: StringRes.ticketPriority,
        title:
            controller.selectedTicketPriority.value ?? StringRes.ticketPriority,
        suffixIcons: ClearControllerButtonWidget(
          onPressed: () {
            HapticFeedback.mediumImpact();
            controller.selectedTicketPriority.value = null;
            controller.selectedTicketPriorityID.value = null;
          },
        ),
        isValueSelected: controller.selectedTicketPriority.value != null,
        onTap: () async {
          await showDialog(
            context: context,
            useRootNavigator: false,
            builder: (context) => SearchableDropDownWidget(
              headingTitle: StringRes.ticketPriority,
              listData: controller.searchTicketPriorityList,
              onDataChanged: (value) {
                controller.selectedTicketPriority.value = value.title;
                controller.selectedTicketPriorityID.value = value.id;
              },
            ),
          );
        },
      ),
    );
  }

  Widget _submitButton(
      TicketController controller, Size size, BuildContext context) {
    return controller.isAddTicketLoading.value
        ? Padding(
            padding: EdgeInsets.only(bottom: size.height * 0.02),
            child: AppUtils.circularLoaderData(),
          )
        : ContainerConst(
            onTap: () {
              controller.validateDetails(context);
            },
            height: 50,
            width: size.width,
            color: appPrimaryMaterialColorcard,
            topPadding: size.height * 0.01,
            bottomPadding: size.height * 0.02,
            child: Center(
              child: Text(
                StringRes.createTicket,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w700),
              ),
            ),
          );
  }
}
