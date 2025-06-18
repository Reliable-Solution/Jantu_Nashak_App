// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// // import 'package:intl/intl.dart';
// import 'package:sentry_flutter/sentry_flutter.dart';
// // import 'package:suratjugaad/a_structure/constant/app_common_text.dart';
// // import 'package:suratjugaad/a_structure/constant/app_styles.dart';
// // import 'package:suratjugaad/a_structure/constant/app_utils.dart';
// // import 'package:suratjugaad/a_structure/models/ticket_model/get_tickrt_list_model.dart';
// // import 'package:suratjugaad/a_structure/preferences/shared_pref_const.dart';
// // import 'package:suratjugaad/a_structure/preferences/shared_prefs_data.dart';
// // import 'package:suratjugaad/a_structure/bloc/ticket/ticket_controller.dart';
//
// import '../../controller/ticketController.dart';
// import 'app_common_text.dart';
// import 'app_style.dart';
// import 'app_utils.dart'; // Import the GetX controller
//
// class TicketViewScreen extends StatelessWidget {
//   const TicketViewScreen({super.key});
//
//   static Widget create() {
//     Get.put(TicketController()); // Initialize the controller
//     return const TicketViewScreen();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final controller = Get.find<TicketController>();
//     controller.size.value = MediaQuery.of(context).size;
//
//     // Trigger initial API call
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       // controller.getTicketListAPI();
//     });
//
//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: AppStyles.backgroundColor,
//         body: Obx(() {
//           // Show loading indicator if first loading or API is in progress
//           if (controller.isFirstLoading.value || controller.isTicketListLoading.value) {
//             return AppUtils.circularLoaderData();
//           }
//
//           // Handle success and error cases
//           if (controller.isFailed.value && controller.error.value != null) {
//             WidgetsBinding.instance.addPostFrameCallback((_) {
//               Fluttertoast.showToast(msg: controller.error.value ?? "");
//             });
//           }
//
//           return _detailsViewSection(controller);
//         }),
//       ),
//     );
//   }
//
//   Widget _detailsViewSection(TicketController controller) {
//     return controller.getTicketListModel.value?.data?.isEmpty ?? true
//         ? AppUtils.noRecordMsg()
//         : ListView.builder(
//       shrinkWrap: true,
//       physics: const BouncingScrollPhysics(),
//       itemCount: controller.getTicketListModel.value?.data?.length ?? 0,
//       padding: const EdgeInsets.only(top: 12),
//       itemBuilder: (context, index) {
//         return Padding(
//           padding: const EdgeInsets.only(left: 12.0, top: 8.0, right: 12.0),
//           child: Container(
//             width: controller.size.value.width,
//             decoration: BoxDecoration(
//               color: AppStyles.white,
//               borderRadius: BorderRadius.circular(8),
//             ),
//             child: Padding(
//               padding: const EdgeInsets.only(
//                 left: 10.0,
//                 top: 8,
//                 bottom: 8,
//                 right: 10,
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   _nameNoteSection(controller, index),
//                   _descriptionDetailSection(controller, index),
//                   _callDetailsSection(controller, index),
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
//
//   Widget _nameNoteSection(TicketController controller, int index) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             textSemiBold(
//               text: controller.getTicketListModel.value?.data?[index].ticketsUserName ?? "",
//               fontSize: 14,
//             ),
//             textRegular(
//               text:
//                   "${""}",
//               // "${DateFormat("dd MMM, yyyy").format(controller.getTicketListModel.value?.data?[index].ticketsCdt ?? DateTime.now())}",
//               fontSize: 12,
//             ),
//           ],
//         ),
//         const SizedBox(height: 3),
//         textRegular(
//           text: "Desc : ${controller.getTicketListModel.value?.data?[index].ticketsDescription ?? ""}",
//           fontSize: 12,
//           fontColor: AppStyles.grey71,
//         ),
//       ],
//     );
//   }
//
//   Widget _callDetailsSection(TicketController controller, int index) {
//     return Padding(
//       padding: const EdgeInsets.only(top: 3.0),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Column(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               textRegular(
//                 text: "Ticket ID : ${controller.getTicketListModel.value?.data?[index].ticketsId ?? ""}",
//                 fontSize: 12,
//                 fontColor: AppStyles.primaryColor,
//               ),
//               textRegular(
//                 text: "Status: ${controller.getTicketListModel.value?.data?[index].ticketstageName ?? ""}",
//                 fontSize: 12,
//                 fontColor: AppStyles.primaryColor,
//               ),
//             ],
//           ),
//           // Row(
//           //   children: [
//           //     CallLauncherWidget(
//           //       phoneNumber: controller.getTicketListModel.value?.data?[index].inquiryPhoneNo ?? "",
//           //     ),
//           //     const SizedBox(width: 20),
//           //     WhatsappLauncherWidget(
//           //       phoneNumber: controller.getTicketListModel.value?.data?[index].inquiryWhatsappNo ?? "",
//           //     ),
//           //   ],
//           // ),
//         ],
//       ),
//     );
//   }
//
//   Widget _descriptionDetailSection(TicketController controller, int index) {
//     return Column(
//       children: [
//         const SizedBox(height: 3),
//       ],
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import '../../controller/ticketController.dart';
import '../../utils/string_res.dart';
import 'app_common_text.dart';
import 'app_style.dart';
import 'app_utils.dart';
import 'getTickeListModel.dart';
// import 'package:suratjugaad/a_structure/constant/app_common_text.dart';
// import 'package:suratjugaad/a_structure/constant/app_styles.dart';
// import 'package:suratjugaad/a_structure/constant/app_utils.dart';
// import 'package:suratjugaad/a_structure/preferences/shared_pref_const.dart';
// import 'package:suratjugaad/a_structure/preferences/shared_prefs_data.dart';
// import 'ticket_controller.dart';

class TicketViewScreen extends StatelessWidget {
  const TicketViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TicketController controller = Get.find<TicketController>();
    final Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        backgroundColor: AppStyles.backgroundColor,
        body: Obx(() => controller.isFirstLoading.value || controller.isTicketListLoading.value
            ? AppUtils.circularLoaderData()
            : _detailsViewSection(controller, size)),
      ),
    );
  }

  Widget _detailsViewSection(TicketController controller, Size size) {
    return controller.getTicketListModel.value?.data?.isEmpty ?? true
        ? AppUtils.noRecordMsg()
        : ListView.builder(
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      itemCount: controller.getTicketListModel.value!.data!.length,
      padding: const EdgeInsets.only(top: 12),
      itemBuilder: (context, index) {
        final ticket = controller.getTicketListModel.value!.data![index];
        return Padding(
          padding: const EdgeInsets.only(left: 12.0, top: 8.0, right: 12.0),
          child: Container(
            width: size.width,
            decoration: BoxDecoration(
                color: AppStyles.white, borderRadius: BorderRadius.circular(8)),
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0, top: 8, bottom: 8, right: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _nameNoteSection(ticket, index),
                  _descriptionDetailSection(ticket),
                  _callDetailsSection(ticket),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _nameNoteSection(GetTicketListData ticket, int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            textSemiBold(text: ticket.ticketsUserName ?? "", fontSize: 14),
            textRegular(
                text: "${DateFormat("dd MMM, yyyy").format(ticket.ticketsCdt ?? DateTime.now())}",
                fontSize: 12),
          ],
        ),
        const SizedBox(height: 3),
        textRegular(
            text: "${StringRes.desc} : ${ticket.ticketsDescription ?? ""}",
            fontSize: 12,
            fontColor: AppStyles.grey71),
      ],
    );
  }

  Widget _callDetailsSection(GetTicketListData ticket) {
    return Padding(
      padding: const EdgeInsets.only(top: 3.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              textRegular(
                  text: "${StringRes.ticketId} : ${ticket.ticketsId ?? ""}",
                  fontSize: 12,
                  fontColor: AppStyles.primaryColor),
              textRegular(
                  text: "${StringRes.status}: ${ticket.ticketstageName ?? ""}",
                  fontSize: 12,
                  fontColor: AppStyles.primaryColor),
            ],
          ),
        ],
      ),
    );
  }

  Widget _descriptionDetailSection(GetTicketListData ticket) {
    return Column(
      children: [
        const SizedBox(height: 3),
      ],
    );
  }
}