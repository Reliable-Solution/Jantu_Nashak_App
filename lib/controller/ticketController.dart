// //
// // import 'dart:developer';
// // import 'dart:io';
// //
// // import 'package:flutter/cupertino.dart';
// // import 'package:flutter/material.dart';
// // import 'package:fluttertoast/fluttertoast.dart';
// // import 'package:get/get.dart';
// // import 'package:get/get_core/src/get_main.dart';
// // import 'package:get/get_rx/src/rx_types/rx_types.dart';
// // import 'package:get/get_state_manager/src/simple/get_controllers.dart';
// // import 'package:image_cropper/image_cropper.dart';
// // import 'package:image_picker/image_picker.dart';
// // import 'package:sentry_flutter/sentry_flutter.dart';
// //
// // import '../models/customerModel.dart';
// // import '../utils/api_status.dart';
// // import '../utils/sharedPrefs.dart';
// // import '../view/raise ticket/GetTicketAreaModel.dart';
// // import '../view/raise ticket/app_style.dart';
// // import '../view/raise ticket/getTickeListModel.dart';
// // import '../view/raise ticket/getTicketPriorityData.dart';
// // import '../view/raise ticket/getTicketSubAreaProblemData.dart';
// // import '../view/raise ticket/text_field/search_model.dart';
// // import '../widget/show_snackbar.dart';
// //
// // class TicketController extends GetxController {
// //   final userNameController = TextEditingController();
// //   final descriptionController = TextEditingController();
// //   final facingController = TextEditingController();
// //   SharedHelper helper = SharedHelper();
// //   CustomerModel? m1 = CustomerModel();
// //
// //   var isGetTicketAreaProblemLoading = false.obs;
// //   var isGetTicketSubAreaProblemLoading = false.obs;
// //   var isTicketPriorityLoading = false.obs;
// //   var isAddTicketLoading = false.obs;
// //   var isTicketListLoading = false.obs;
// //   var isCompleted = false.obs;
// //   var isFailed = false.obs;
// //   var error = RxnString();
// //   var tabIndex = 0.obs;
// //   var isFirstLoading = true.obs;
// //
// //   Rx<CustomerModel>? customerModel = CustomerModel().obs;
// //
// //
// //   var getTicketListModel = Rxn<GetTicketListModel>();
// //
// //   var size = Get.size.obs;
// //
// //
// //
// //   /// Ticket Area
// //   var selectedTicketAreaProblem = RxnString();
// //   var userName = RxnString();
// //   var selectedTicketAreaProblemID = RxnString();
// //   var searchTicketAreaProblemList = <SearchDropModel>[].obs;
// //   var getTicketAreaProblemList = <GetTicketAreaProblemData>[].obs;
// //
// //   /// Ticket Sub Area
// //   var selectedTicketSubAreaProblem = RxnString();
// //   var selectedTicketSubAreaProblemID = RxnString();
// //   var searchTicketSubAreaProblemList = <SearchDropModel>[].obs;
// //   var getTicketSubAreaProblemList = <GetTicketSubAreaProblemData>[].obs;
// //
// //   /// Ticket Priority
// //   var selectedTicketPriority = RxnString();
// //   var selectedTicketPriorityID = RxnString();
// //   var searchTicketPriorityList = <SearchDropModel>[].obs;
// //   var getTicketPriority = <GetTicketPriorityData>[].obs;
// //
// //   var selectedFile = Rxn<File>();
// //   var image = Rxn<File>();
// //   final picker = ImagePicker();
// //   var inProcess = false.obs;
// //   var facingDate = RxnString();
// //
// //   // var isGetTicketAreaProblemLoading = false.obs;
// //   // var isAddTicketLoading = false.obs;
// //   // var error = RxnString();
// //
// //   @override
// //   void onInit() {
// //     super.onInit();
// //     getPrefs();
// //     initAPICall();
// //     getLocalData();
// //   }
// //   Future<void> getPrefs() async {
// //     CustomerModel? customer = await helper.getCustomer();
// //     if (customer != null) {
// //       customerModel!.value = customer;
// //       print("✅ Name: ${customer.customerName}");
// //       print("Controller hash in HomeController: ${this.hashCode}");
// //       print("Updated Name: ${customer.customerName}");
// //       update(); // agar tu GetBuilder bhi use kar raha hai
// //
// //     }
// //   }
// //
// //
// //   Future<void> getLocalData() async {
// //     userName.value = customerModel!.value.customerName ?? "";
// //     if (userName.value != null) {
// //       userNameController.text = userName.value!;
// //     }
// //   }
// //
// //   void initAPICall() {
// //     getTicketAreaProblemAPI();
// //     getTicketPriorityAPI();
// //   }
// //
// //   Future<void> getImage(ImageSource source) async {
// //     inProcess.value = true;
// //
// //     final pickedFile = await picker.pickImage(source: source);
// //     if (pickedFile != null) {
// //       image.value = File(pickedFile.path);
// //     }
// //
// //     if (image.value != null) {
// //       CroppedFile? cropped = await ImageCropper().cropImage(
// //         sourcePath: image.value!.path,
// //         aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
// //         compressQuality: 100,
// //         maxWidth: 700,
// //         maxHeight: 700,
// //         compressFormat: ImageCompressFormat.jpg,
// //         uiSettings: [
// //           AndroidUiSettings(
// //             initAspectRatio: CropAspectRatioPreset.original,
// //             toolbarColor: Colors.white,
// //             toolbarTitle: 'Edit Images',
// //             statusBarColor: AppStyles.primaryColor,
// //             activeControlsWidgetColor: AppStyles.primaryColor,
// //             cropFrameColor: Colors.white,
// //             cropGridColor: Colors.white,
// //             toolbarWidgetColor: AppStyles.primaryColor,
// //             backgroundColor: Colors.white,
// //           )
// //         ],
// //       );
// //
// //       if (cropped != null) {
// //         selectedFile.value = File(cropped.path);
// //         log("Selected File: ${selectedFile.value}");
// //         if (source == ImageSource.camera && image.value!.existsSync()) {
// //           image.value!.deleteSync();
// //         }
// //         image.value = null;
// //       }
// //       inProcess.value = false;
// //     } else {
// //       inProcess.value = false;
// //     }
// //   }
// //
// //   Future<void> getTicketAreaProblemAPI() async {
// //     try {
// //       isGetTicketAreaProblemLoading.value = true;
// //       Map<String, dynamic> bodyData = {"": ""};
// //       log("getTicketAreaProblemAPI bodyData: $bodyData");
// //       // Simulate API call (replace with actual API call)
// //       // For demonstration, assuming API returns data
// //       // final response = await YourApiService.getTicketAreaProblem(bodyData);
// //       // getTicketAreaProblemList.assignAll(response.data);
// //
// //       // Example data population
// //       getTicketAreaProblemList.forEach((data) {
// //         if (data.problemName!.isNotEmpty) {
// //           searchTicketAreaProblemList.add(
// //             SearchDropModel(
// //               title: data.problemName,
// //               id: data.problemId,
// //               value: data.problemId,
// //             ),
// //           );
// //         }
// //       });
// //     } catch (exception, stackTrace) {
// //       error.value = exception.toString();
// //       Fluttertoast.showToast(msg: error.value ?? "");
// //       await Sentry.captureException(exception, stackTrace: stackTrace);
// //     } finally {
// //       isGetTicketAreaProblemLoading.value = false;
// //     }
// //   }
// //
// //   Future<void> getTicketSubAreaProblemAPI() async {
// //     try {
// //       Map<String, dynamic> bodyData = {'ProblemId': selectedTicketAreaProblemID.value};
// //       log("getTicketSubAreaProblemAPI bodyData: $bodyData");
// //       // Simulate API call (replace with actual API call)
// //       // final response = await YourApiService.getTicketSubAreaProblem(bodyData);
// //       // getTicketSubAreaProblemList.assignAll(response.data);
// //
// //       searchTicketSubAreaProblemList.clear();
// //       getTicketSubAreaProblemList.forEach((data) {
// //         searchTicketSubAreaProblemList.add(
// //           SearchDropModel(
// //             title: data.subproblemName,
// //             id: data.subproblemId,
// //             value: data.subproblemId,
// //           ),
// //         );
// //       });
// //     } catch (exception, stackTrace) {
// //       error.value = exception.toString();
// //       Fluttertoast.showToast(msg: error.value ?? "");
// //       await Sentry.captureException(exception, stackTrace: stackTrace);
// //     }
// //   }
// //
// //   Future<void> getTicketPriorityAPI() async {
// //     try {
// //       Map<String, dynamic> bodyData = {"": ""};
// //       log("getTicketPriorityAPI bodyData: $bodyData");
// //       // Simulate API call (replace with actual API call)
// //       // final response = await YourApiService.getTicketPriority(bodyData);
// //       // getTicketPriority.assignAll(response.data);
// //
// //       getTicketPriority.forEach((data) {
// //         searchTicketPriorityList.add(
// //           SearchDropModel(
// //             title: data.priorityName,
// //             id: data.priorityId,
// //             value: data.priorityId,
// //           ),
// //         );
// //       });
// //     } catch (exception, stackTrace) {
// //       error.value = exception.toString();
// //       Fluttertoast.showToast(msg: error.value ?? "");
// //       await Sentry.captureException(exception, stackTrace: stackTrace);
// //     }
// //   }
// //
// //   Future<void> addTicketAPI(BuildContext context) async {
// //     try {
// //       isAddTicketLoading.value = true;
// //       Map<String, dynamic> bodyData = {
// //         "UsersId": customerModel!.value.customerName,
// //         "TicketAreaOfProblem": selectedTicketAreaProblemID.value,
// //         "TicketsSubAreaProblem": selectedTicketSubAreaProblemID.value,
// //         "TicketsUserName": userNameController.text.trim(),
// //         "TicketsDescription": descriptionController.text.trim(),
// //         "TicketsFacingSince": facingDate.value,
// //         "TicketPriority": selectedTicketPriorityID.value,
// //         "TicketsImage": selectedFile.value?.path ?? "",
// //       };
// //       log("addTicketAPI bodyData: $bodyData");
// //       // Simulate API call (replace with actual API call)
// //       // await YourApiService.addTicket(bodyData);
// //
// //       showSnackBar(msg: "Your ticket created successfully", context: context);
// //       facingDate.value = null;
// //       selectedTicketAreaProblem.value = null;
// //       selectedTicketSubAreaProblem.value = null;
// //       selectedTicketPriority.value = null;
// //       descriptionController.clear();
// //     } catch (exception, stackTrace) {
// //       error.value = exception.toString();
// //       Fluttertoast.showToast(msg: error.value ?? "");
// //       await Sentry.captureException(exception, stackTrace: stackTrace);
// //     } finally {
// //       isAddTicketLoading.value = false;
// //     }
// //   }
// //
// //   void validateDetails(BuildContext context) {
// //     if (userNameController.text.trim().isEmpty) {
// //       showSnackBar(msg: "Please enter the user name", isError: true, context: context);
// //     } else if (facingDate.value == null) {
// //       showSnackBar(msg: "Please select the facing issue", isError: true, context: context);
// //     } else if (selectedTicketAreaProblem.value == null) {
// //       showSnackBar(msg: "Select the ticket problem area", isError: true, context: context);
// //     } else if (selectedTicketSubAreaProblem.value == null) {
// //       showSnackBar(msg: "Select the ticket problem sub area", isError: true, context: context);
// //     } else if (selectedTicketPriority.value == null) {
// //       showSnackBar(msg: "Select the ticket priority", isError: true, context: context);
// //     } else if (descriptionController.text.trim().isEmpty) {
// //       showSnackBar(msg: "Please enter the description", isError: true, context: context);
// //     } else {
// //     addTicketAPI(context);
// //     }
// //   }
// //   // Future<void> getTicketListAPI() async {
// //   //   try {
// //   //     isTicketListLoading.value = true;
// //   //     isCompleted.value = false;
// //   //     isFailed.value = false;
// //   //     error.value = null;
// //   //
// //   //     Map<String, dynamic> bodyData = {
// //   //       "UsersId": customerModel!.value.customerName,
// //   //     };
// //   //     log("getTicketListAPI bodyData is called: $bodyData");
// //   //     final response = await _ticketRepository.getTicketList(bodyData);
// //   //     if (response.status == ApiStatus.success) {
// //   //       getTicketListModel.value = response.data;
// //   //       isCompleted.value = true;
// //   //       isFirstLoading.value = false;
// //   //     } else {
// //   //       isFailed.value = true;
// //   //       error.value = response.errorMsg;
// //   //       Fluttertoast.showToast(msg: error.value ?? "");
// //   //     }
// //   //   } catch (exception, stackTrace) {
// //   //     await Sentry.captureException(exception, stackTrace: stackTrace);
// //   //     isFailed.value = true;
// //   //     error.value = exception.toString();
// //   //     Fluttertoast.showToast(msg: error.value ?? "");
// //   //   } finally {
// //   //     isTicketListLoading.value = false;
// //   //   }
// //   // }
// //
// // }
// import 'dart:developer';
// import 'dart:io';
//
// import 'package:dio/dio.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:get/get.dart';
// import 'package:image_cropper/image_cropper.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:intl/intl.dart';
// import 'package:keep_app/constant/app_constant.dart';
// import 'package:keep_app/utils/sharedPrefs.dart';
// import 'package:sentry_flutter/sentry_flutter.dart';
// // import 'package:suratjugaad/a_structure/api_client/api_utils.dart';
// // import 'package:suratjugaad/a_structure/constant/app_constants.dart';
// // import 'package:suratjugaad/a_structure/models/api_models/api_response.dart';
// // import 'package:suratjugaad/a_structure/models/ticket_model/add_ticket_model.dart';
// // import 'package:suratjugaad/a_structure/models/ticket_model/get_ticket_area_problem_model.dart';
// // import 'package:suratjugaad/a_structure/models/ticket_model/get_ticket_priority_model.dart';
// // import 'package:suratjugaad/a_structure/models/ticket_model/get_ticket_sub_area_problem_model.dart';
// // import 'package:suratjugaad/a_structure/models/ticket_model/get_tickrt_list_model.dart';
// // import 'package:suratjugaad/a_structure/preferences/shared_pref_const.dart';
// // import 'package:suratjugaad/a_structure/preferences/shared_prefs_data.dart';
// // import 'package:suratjugaad/a_structure/repository/ticket_repo/ticket_repo.dart';
// // import 'package:suratjugaad/a_structure/constant/app_styles.dart';
// // import 'package:suratjugaad/a_structure/models/drop_down_model/search_drop_model.dart';
// // import 'package:suratjugaad/screen_const/show_snack_bar.dart';
//
// import '../constant/api_endpoints.dart';
// import '../models/addTicket.dart';
// import '../models/customerModel.dart';
// import '../utils/api_response.dart';
// import '../utils/api_status.dart';
// import '../utils/api_utils.dart';
// import '../view/raise ticket/GetTicketAreaModel.dart';
// import '../view/raise ticket/app_style.dart';
// import '../view/raise ticket/getTickeListModel.dart';
// import '../view/raise ticket/getTicketPriorityData.dart';
// import '../view/raise ticket/getTicketSubAreaProblemData.dart';
// import '../view/raise ticket/text_field/search_model.dart';
// import '../widget/show_snackbar.dart';
// import 'package:dio/dio.dart' as dio; // Use alias for dio
//
//
// class TicketController extends GetxController {
//   final TicketRepositoryImpl _ticketRepository = Get.put(TicketRepositoryImpl());
//   final userNameController = TextEditingController();
//   final descriptionController = TextEditingController();
//   final facingController = TextEditingController();
//   final SharedHelper sharedPrefs = SharedHelper();
//   final picker = ImagePicker();
//
//   // Observable states
//   var isGetTicketAreaProblemLoading = false.obs;
//   var isGetTicketSubAreaProblemLoading = false.obs;
//   var isTicketPriorityLoading = false.obs;
//   var isAddTicketLoading = false.obs;
//   var isTicketListLoading = false.obs;
//   var isCompleted = false.obs;
//   var isFailed = false.obs;
//   var error = RxnString();
//   var tabIndex = 0.obs;
//   var isFirstLoading = true.obs;
//
//   // Ticket Area
//   var selectedTicketAreaProblem = RxnString();
//   var selectedTicketAreaProblemID = RxnString();
//   var searchTicketAreaProblemList = <SearchDropModel>[].obs;
//   var getTicketAreaProblemList = <GetTicketAreaProblemData>[].obs;
//
//   // Ticket Sub Area
//   var selectedTicketSubAreaProblem = RxnString();
//   var selectedTicketSubAreaProblemID = RxnString();
//   var searchTicketSubAreaProblemList = <SearchDropModel>[].obs;
//   var getTicketSubAreaProblemList = <GetTicketSubAreaProblemData>[].obs;
//
//   // Ticket Priority
//   var selectedTicketPriority = RxnString();
//   var selectedTicketPriorityID = RxnString();
//   var searchTicketPriorityList = <SearchDropModel>[].obs;
//   var getTicketPriorityModel = <GetTicketPriorityData>[].obs;
//
//   // Ticket List
//   var getTicketListModel = Rxn<GetTicketListModel>();
//
//   // Image handling
//   var selectedFile = Rxn<File>();
//   var image = Rxn<File>();
//   var inProcess = false.obs;
//   var facingDate = RxnString();
//
//   Rx<CustomerModel>? customerModel = CustomerModel().obs;
//
//
//   @override
//   void onInit() {
//     super.onInit();
//     getLocalData();
//     initAPICall();
//   }
//
//   Future<void> getLocalData() async {
//     String? userName = await sharedPrefs.getCustomer().then((value) => value?.customerName);
//     if (userName != null && userName.isNotEmpty) {
//       userNameController.text = userName;
//     }
//   }
//
//   void initAPICall() {
//     getPrefs();
//     getTicketAreaProblem();
//     getTicketPriority();
//     getTicketList();
//   }
//
//   Future<void> getPrefs() async {
//     CustomerModel? customer = await sharedPrefs.getCustomer();
//     if (customer != null) {
//       customerModel!.value = customer;
//       print("✅ Name: ${customer.customerName}");
//       print("Controller hash in HomeController: ${this.hashCode}");
//       print("Updated Name: ${customer.customerName}");
//       update(); // agar tu GetBuilder bhi use kar raha hai
//
//     }
//   }
//
//   Future<void> getImage(ImageSource source) async {
//     inProcess.value = true;
//     try {
//       final pickedFile = await picker.pickImage(source: source);
//       if (pickedFile != null) {
//         image.value = File(pickedFile.path);
//       }
//
//       if (image.value != null) {
//         CroppedFile? cropped = await ImageCropper().cropImage(
//           sourcePath: image.value!.path,
//           aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
//           compressQuality: 100,
//           maxWidth: 700,
//           maxHeight: 700,
//           compressFormat: ImageCompressFormat.jpg,
//           uiSettings: [
//             AndroidUiSettings(
//               initAspectRatio: CropAspectRatioPreset.original,
//               toolbarColor: Colors.white,
//               toolbarTitle: 'Edit Images',
//               // statusBarColor: AppStyles.primaryColor,
//               activeControlsWidgetColor: AppStyles.primaryColor,
//               cropFrameColor: Colors.white,
//               cropGridColor: Colors.white,
//               toolbarWidgetColor: AppStyles.primaryColor,
//               backgroundColor: Colors.white,
//             ),
//           ],
//         );
//
//         if (cropped != null) {
//           selectedFile.value = File(cropped.path);
//           log("Selected File: ${selectedFile.value}");
//           if (source == ImageSource.camera && image.value!.existsSync()) {
//             image.value!.deleteSync();
//           }
//           image.value = null;
//         }
//       }
//     } catch (exception, stackTrace) {
//       error.value = exception.toString();
//       Fluttertoast.showToast(msg: error.value ?? "");
//       await Sentry.captureException(exception, stackTrace: stackTrace);
//     } finally {
//       inProcess.value = false;
//     }
//   }
//
//   Future<void> getTicketAreaProblem() async {
//     try {
//       isGetTicketAreaProblemLoading.value = true;
//       Map<String, dynamic> bodyData = {"": ""};
//       log("getTicketAreaProblem bodyData: $bodyData");
//       final response = await _ticketRepository.getTicketAreaProblem(bodyData);
//       if (response.status == ApiStatus.success) {
//         getTicketAreaProblemList.assignAll(response.data?.data ?? []);
//         searchTicketAreaProblemList.clear();
//         getTicketAreaProblemList.forEach((data) {
//           if (data.problemName?.isNotEmpty ?? false) {
//             searchTicketAreaProblemList.add(
//               SearchDropModel(
//                 title: data.problemName,
//                 id: data.problemId,
//                 value: data.problemId,
//               ),
//             );
//           }
//         });
//       } else {
//         error.value = response.errorMsg;
//         Fluttertoast.showToast(msg: error.value ?? "");
//       }
//     } catch (exception, stackTrace) {
//       error.value = exception.toString();
//       Fluttertoast.showToast(msg: error.value ?? "");
//       await Sentry.captureException(exception, stackTrace: stackTrace);
//     } finally {
//       isGetTicketAreaProblemLoading.value = false;
//     }
//   }
//
//   Future<void> getTicketSubAreaProblem() async {
//     try {
//       isGetTicketSubAreaProblemLoading.value = true;
//       Map<String, dynamic> bodyData = {'ProblemId': selectedTicketAreaProblemID.value};
//       log("getTicketSubAreaProblem bodyData: $bodyData");
//       final response = await _ticketRepository.getTicketSubAreaProblem(bodyData);
//       if (response.status == ApiStatus.success) {
//         getTicketSubAreaProblemList.assignAll(response.data?.data ?? []);
//         searchTicketSubAreaProblemList.clear();
//         getTicketSubAreaProblemList.forEach((data) {
//           searchTicketSubAreaProblemList.add(
//             SearchDropModel(
//               title: data.subproblemName,
//               id: data.subproblemId,
//               value: data.subproblemId,
//             ),
//           );
//         });
//       } else {
//         error.value = response.errorMsg;
//         Fluttertoast.showToast(msg: error.value ?? "");
//       }
//     } catch (exception, stackTrace) {
//       error.value = exception.toString();
//       Fluttertoast.showToast(msg: error.value ?? "");
//       await Sentry.captureException(exception, stackTrace: stackTrace);
//     } finally {
//       isGetTicketSubAreaProblemLoading.value = false;
//     }
//   }
//
//   Future<void> getTicketPriority() async {
//     try {
//       isTicketPriorityLoading.value = true;
//       Map<String, dynamic> bodyData = {"": ""};
//       log("getTicketPriority bodyData: $bodyData");
//       final response = await _ticketRepository.getTicketPriorityApi(bodyData);
//       if (response.status == ApiStatus.success) {
//         getTicketPriorityModel.assignAll(response.data?.data ?? []);
//         searchTicketPriorityList.clear();
//         getTicketPriorityModel.forEach((data) {
//           searchTicketPriorityList.add(
//             SearchDropModel(
//               title: data?.priorityName,
//               id: data.priorityId,
//               value: data.priorityId,
//             ),
//           );
//         });
//       } else {
//         error.value = response.errorMsg;
//         Fluttertoast.showToast(msg: error.value ?? "");
//       }
//     } catch (exception, stackTrace) {
//       error.value = exception.toString();
//       Fluttertoast.showToast(msg: error.value ?? "");
//       await Sentry.captureException(exception, stackTrace: stackTrace);
//     } finally {
//       isTicketPriorityLoading.value = false;
//     }
//   }
//
//   // Future<void> addTicket(BuildContext context) async {
//   //   try {
//   //     isAddTicketLoading.value = true;
//   //     Map<String, dynamic> bodyData = {
//   //       "CustomerId": customerModel!.value.customerId,
//   //       // await sharedPrefs.getStringData(SharedPrefConst.userID),
//   //       // "TicketAreaOfProblem": selectedTicketAreaProblemID.value,
//   //       "TicketsPhoneNo":  customerModel!.value.customerPhoneNo,
//   //       // "TicketsSubAreaProblem": selectedTicketSubAreaProblemID.value,
//   //       "TicketsUserName": userNameController.text.trim(),
//   //       "TicketsDescription": descriptionController.text.trim(),
//   //       // "TicketsFacingSince": facingDate.value,
//   //       // "TicketPriority": selectedTicketPriorityID.value,
//   //       "FirmId": firmId,
//   //     };
//   //     if (selectedFile.value != null) {
//   //       bodyData["TicketsImage"] = await dio.MultipartFile.fromFile(selectedFile.value!.path);
//   //     }
//   //     log("addTicket bodyData: $bodyData");
//   //     final response = await _ticketRepository.addTicket(bodyData);
//   //     if (response.status == ApiStatus.success) {
//   //       showSnackBar(msg: "Your ticket created successfully", context: context);
//   //       facingDate.value = null;
//   //       selectedTicketAreaProblem.value = null;
//   //       selectedTicketSubAreaProblem.value = null;
//   //       selectedTicketPriority.value = null;
//   //       selectedTicketAreaProblemID.value = null;
//   //       selectedTicketSubAreaProblemID.value = null;
//   //       selectedTicketPriorityID.value = null;
//   //       descriptionController.clear();
//   //       selectedFile.value = null;
//   //       facingController.clear();
//   //       tabIndex.value = 1; // Switch to TicketViewScreen
//   //       getTicketList();
//   //     } else {
//   //       error.value = response.errorMsg;
//   //       Fluttertoast.showToast(msg: error.value ?? "");
//   //     }
//   //   } catch (exception, stackTrace) {
//   //     error.value = exception.toString();
//   //     Fluttertoast.showToast(msg: error.value ?? "");
//   //     await Sentry.captureException(exception, stackTrace: stackTrace);
//   //   } finally {
//   //     isAddTicketLoading.value = false;
//   //   }
//   // }
//
//   Future<void> addTicket(BuildContext context) async {
//     try {
//       isAddTicketLoading.value = true;
//       Map<String, dynamic> bodyData = {
//         "CustomerId": customerModel?.value.customerId ?? "", // Ensure not null
//         "TicketsPhoneNo": customerModel?.value.customerPhoneNo ?? "",
//         "TicketsUserName": userNameController.text.trim(),
//         "TicketsDescription": descriptionController.text.trim(),
//         "FirmId": firmId ?? "", // Ensure not null
//         // Uncomment and include if server requires these
//         // "TicketAreaOfProblem": selectedTicketAreaProblemID.value ?? "",
//         // "TicketsSubAreaProblem": selectedTicketSubAreaProblemID.value ?? "",
//         // "TicketsFacingSince": facingDate.value ?? "",
//         // "TicketPriority": selectedTicketPriorityID.value ?? "",
//       };
//
//       if (selectedFile.value != null && selectedFile.value!.existsSync()) {
//         bodyData["TicketsImage"] = await dio.MultipartFile.fromFile(
//           selectedFile.value!.path,
//           filename: "ticket_image_${DateTime.now().millisecondsSinceEpoch}.jpg",
//         );
//       } else {
//         log("No image selected or file does not exist");
//       }
//
//       log("addTicket bodyData: $bodyData");
//       final response = await _ticketRepository.addTicket(bodyData);
//       if (response.status == ApiStatus.success) {
//         showSnackBar(msg: "Your ticket created successfully", context: context);
//         // Reset fields
//         facingDate.value = null;
//         selectedTicketAreaProblem.value = null;
//         selectedTicketSubAreaProblem.value = null;
//         selectedTicketPriority.value = null;
//         selectedTicketAreaProblemID.value = null;
//         selectedTicketSubAreaProblemID.value = null;
//         selectedTicketPriorityID.value = null;
//         descriptionController.clear();
//         selectedFile.value = null;
//         facingController.clear();
//         tabIndex.value = 1; // Switch to TicketViewScreen
//         getTicketList();
//       } else {
//         error.value = response.errorMsg;
//         Fluttertoast.showToast(msg: error.value ?? "Failed to create ticket");
//       }
//     } catch (exception, stackTrace) {
//       error.value = exception.toString();
//       Fluttertoast.showToast(msg: "Error: ${error.value}");
//       await Sentry.captureException(exception, stackTrace: stackTrace);
//       log("addTicket exception: $exception, StackTrace: $stackTrace");
//     } finally {
//       isAddTicketLoading.value = false;
//     }
//   }
//   Future<void> getTicketList() async {
//     try {
//       isTicketListLoading.value = true;
//       isCompleted.value = false;
//       isFailed.value = false;
//       error.value = null;
//       Map<String, dynamic> bodyData = {
//         "UsersId": await sharedPrefs.getCustomer().then((value) => value?.customerId),
//       };
//       log("getTicketList bodyData: $bodyData");
//       final response = await _ticketRepository.getTicketList(bodyData);
//       if (response.status == ApiStatus.success) {
//         getTicketListModel.value = response.data;
//         isCompleted.value = true;
//         isFirstLoading.value = false;
//       } else {
//         isFailed.value = true;
//         error.value = response.errorMsg;
//         Fluttertoast.showToast(msg: error.value ?? "");
//       }
//     } catch (exception, stackTrace) {
//       isFailed.value = true;
//       error.value = exception.toString();
//       Fluttertoast.showToast(msg: error.value ?? "");
//       await Sentry.captureException(exception, stackTrace: stackTrace);
//     } finally {
//       isTicketListLoading.value = false;
//     }
//   }
//
//   void validateDetails(BuildContext context) {
//     if (userNameController.text.trim().isEmpty) {
//       showSnackBar(msg: "Please enter the user name", isError: true, context: context);
//     }
//     // else if (facingDate.value == null) {
//     //   showSnackBar(msg: "Please select the facing issue", isError: true, context: context);
//     // } else if (selectedTicketAreaProblem.value == null) {
//     //   showSnackBar(msg: "Select the ticket problem area", isError: true, context: context);
//     // } else if (selectedTicketSubAreaProblem.value == null) {
//     //   showSnackBar(msg: "Select the ticket problem sub area", isError: true, context: context);
//     // } else if (selectedTicketPriority.value == null) {
//     //   showSnackBar(msg: "Select the ticket priority", isError: true, context: context);
//     // }
//     else if (descriptionController.text.trim().isEmpty) {
//       showSnackBar(msg: "Please enter the description", isError: true, context: context);
//     } else {
//       addTicket(context);
//     }
//   }
// }
//
// // import 'dart:developer';
// //
// // import 'package:dio/dio.dart';
// // import 'package:get/get.dart';
// // import 'package:suratjugaad/a_structure/api_client/api_utils.dart';
// // import 'package:suratjugaad/a_structure/constant/app_constants.dart';
// // import 'package:suratjugaad/a_structure/models/api_models/api_response.dart';
// // import 'package:suratjugaad/a_structure/models/ticket_model/add_ticket_model.dart';
// // import 'package:suratjugaad/a_structure/models/ticket_model/get_ticket_area_problem_model.dart';
// // import 'package:suratjugaad/a_structure/models/ticket_model/get_ticket_priority_model.dart';
// // import 'package:suratjugaad/a_structure/models/ticket_model/get_ticket_sub_area_problem_model.dart';
// // import 'package:suratjugaad/a_structure/models/ticket_model/get_tickrt_list_model.dart';
// // import 'package:suratjugaad/a_structure/repository/ticket_repo/ticket_repo.dart';
//
// abstract class TicketRepository {
//   Future<ApiResponse<GetTicketAreaProblemModel>> getTicketAreaProblem(Map<String, dynamic> bodyData);
//   Future<ApiResponse<GetTicketSubAreaProblemModel>> getTicketSubAreaProblem(Map<String, dynamic> bodyData);
//   Future<ApiResponse<GetTicketPriorityModel>> getTicketPriorityApi(Map<String, dynamic> bodyData);
//   Future<ApiResponse<AddTicketModel>> addTicket(Map<String, dynamic> bodyData);
//   Future<ApiResponse<GetTicketListModel>> getTicketList(Map<String, dynamic> bodyData);
// }
//
//
//
//
// class TicketRepositoryImpl extends TicketRepository {
//   final Dio _dio = Get.find<Dio>();
//
//   @override
//   Future<ApiResponse<GetTicketAreaProblemModel>> getTicketAreaProblem(Map<String, dynamic> bodyData) async {
//     try {
//       final response = await _dio.post(ticketAreaProblem, data: dio.FormData.fromMap(bodyData));
//       log("getTicketAreaProblem response: ${response.data}");
//       if (response.data == null) {
//         return ApiResponse.error(
//           // error: ApiError(code: 'NULL_RESPONSE', message: 'Empty response from server'),
//           errorMsg: 'Server returned empty response',
//         );
//       }
//       final getTicketAreaProblemResponse = GetTicketAreaProblemModel.fromJson(response.data);
//       return ApiResponse.success(data: getTicketAreaProblemResponse);
//     } on DioException catch (error) {
//       log("getTicketAreaProblem error: ${error.response?.data}, ${error.message}, ${error.response?.statusCode}");
//       try {
//         final getTicketAreaProblemResponse = GetTicketAreaProblemModel.fromJson(error.response?.data ?? {});
//         return ApiResponse.error(
//           error: ApiUtils.getApiError(error),
//           errorMsg: getTicketAreaProblemResponse.message ?? 'Unknown error',
//         );
//       } catch (e) {
//         return ApiResponse.error(
//           // error: ApiError(code: 'PARSING_ERROR', message: e.toString()),
//           errorMsg: 'Failed to parse error response',
//         );
//       }
//     } catch (e, stackTrace) {
//       log("getTicketAreaProblem unexpected error: $e, StackTrace: $stackTrace");
//       return ApiResponse.error(
//         // error: ApiError(code: 'UNEXPECTED', message: e.toString()),
//         errorMsg: 'Unexpected error occurred',
//       );
//     }
//   }
//
//   @override
//   Future<ApiResponse<GetTicketSubAreaProblemModel>> getTicketSubAreaProblem(Map<String, dynamic> bodyData) async {
//     try {
//       final response = await _dio.post(ticketSubAreaProblem, data: dio.FormData.fromMap(bodyData));
//       log("getTicketSubAreaProblem response: ${response.data}");
//       if (response.data == null) {
//         return ApiResponse.error(
//           // error: ApiError(code: 'NULL_RESPONSE', message: 'Empty response from server'),
//           errorMsg: 'Server returned empty response',
//         );
//       }
//       final getTicketSubAreaProblemResponse = GetTicketSubAreaProblemModel.fromJson(response.data);
//       return ApiResponse.success(data: getTicketSubAreaProblemResponse);
//     } on DioException catch (error) {
//       log("getTicketSubAreaProblem error: ${error.response?.data}, ${error.message}, ${error.response?.statusCode}");
//       try {
//         final getTicketSubAreaProblemResponse = GetTicketSubAreaProblemModel.fromJson(error.response?.data ?? {});
//         return ApiResponse.error(
//           error: ApiUtils.getApiError(error),
//           errorMsg: getTicketSubAreaProblemResponse.message ?? 'Unknown error',
//         );
//       } catch (e) {
//         return ApiResponse.error(
//           // error: ApiError(code: 'PARSING_ERROR', message: e.toString()),
//           errorMsg: 'Failed to parse error response',
//         );
//       }
//     } catch (e, stackTrace) {
//       log("getTicketSubAreaProblem unexpected error: $e, StackTrace: $stackTrace");
//       return ApiResponse.error(
//         // error: ApiError(code: 'UNEXPECTED', message: e.toString()),
//         errorMsg: 'Unexpected error occurred',
//       );
//     }
//   }
//
//   @override
//   Future<ApiResponse<GetTicketPriorityModel>> getTicketPriorityApi(Map<String, dynamic> bodyData) async {
//     try {
//       final response = await _dio.post(ticketPriority, data: dio.FormData.fromMap(bodyData));
//       log("getTicketPriority response: ${response.data}");
//       if (response.data == null) {
//         return ApiResponse.error(
//           // error: ApiError(code: 'NULL_RESPONSE', message: 'Empty response from server'),
//           errorMsg: 'Server returned empty response',
//         );
//       }
//       final getTicketPriorityResponse = GetTicketPriorityModel.fromJson(response.data);
//       return ApiResponse.success(data: getTicketPriorityResponse);
//     } on DioException catch (error) {
//       log("getTicketPriority error: ${error.response?.data}, ${error.message}, ${error.response?.statusCode}");
//       try {
//         final getTicketPriorityResponse = GetTicketPriorityModel.fromJson(error.response?.data ?? {});
//         return ApiResponse.error(
//           error: ApiUtils.getApiError(error),
//           errorMsg: getTicketPriorityResponse.message ?? 'Unknown error',
//         );
//       } catch (e) {
//         return ApiResponse.error(
//           // error: ApiError(code: 'PARSING_ERROR', message: e.toString()),
//           errorMsg: 'Failed to parse error response',
//         );
//       }
//     } catch (e, stackTrace) {
//       log("getTicketPriority unexpected error: $e, StackTrace: $stackTrace");
//       return ApiResponse.error(
//         // error: ApiError(code: 'UNEXPECTED', message: e.toString()),
//         errorMsg: 'Unexpected error occurred',
//       );
//     }
//   }
//
//   @override
//   Future<ApiResponse<AddTicketModel>> addTicket(Map<String, dynamic> bodyData) async {
//     try {
//       log("addTicket request body: $bodyData");
//       final response = await _dio.post(
//         addTicketApi,
//         data: dio.FormData.fromMap(bodyData),
//         options: Options(
//           headers: {
//             'Content-Type': 'multipart/form-data',
//           },
//         ),
//       );
//       log("addTicket response: ${response.data}");
//       if (response.data == null || response.data.isEmpty) {
//         return ApiResponse.error(
//           // error: ApiError(code: 'NULL_RESPONSE', message: 'Empty response from server'),
//           errorMsg: 'Server returned empty response',
//         );
//       }
//       final addTicketResponse = AddTicketModel.fromJson(response.data);
//       return ApiResponse.success(data: addTicketResponse);
//     } on DioException catch (error) {
//       log("addTicket error: ${error.response?.data}, ${error.message}, ${error.response?.statusCode}");
//       try {
//         final addTicketResponse = AddTicketModel.fromJson(error.response?.data ?? {});
//         return ApiResponse.error(
//           error: ApiUtils.getApiError(error),
//           errorMsg: addTicketResponse.message ?? 'Unknown error',
//         );
//       } catch (e) {
//         return ApiResponse.error(
//           // error: ApiError(code: 'PARSING_ERROR', message: e.toString()),
//           errorMsg: 'Failed to parse error response: ${error.response?.data}',
//         );
//       }
//     } catch (e, stackTrace) {
//       log("addTicket unexpected error: $e, StackTrace: $stackTrace");
//       return ApiResponse.error(
//         // error: ApiError(code: 'UNEXPECTED', message: e.toString()),
//         errorMsg: 'Unexpected error occurred',
//       );
//     }
//   }
//
//   @override
//   Future<ApiResponse<GetTicketListModel>> getTicketList(Map<String, dynamic> bodyData) async {
//     try {
//       final response = await _dio.post(getTicket, data: dio.FormData.fromMap(bodyData));
//       log("getTicketList response: ${response.data}");
//       if (response.data == null) {
//         return ApiResponse.error(
//           // error: ApiError(code: 'NULL_RESPONSE', message: 'Empty response from server'),
//           errorMsg: 'Server returned empty response',
//         );
//       }
//       final getTicketListResponse = GetTicketListModel.fromJson(response.data);
//       return ApiResponse.success(data: getTicketListResponse);
//     } on DioException catch (error) {
//       log("getTicketList error: ${error.response?.data}, ${error.message}, ${error.response?.statusCode}");
//       try {
//         final getTicketListResponse = GetTicketListModel.fromJson(error.response?.data ?? {});
//         return ApiResponse.error(
//           error: ApiUtils.getApiError(error),
//           errorMsg: getTicketListResponse.message ?? 'Unknown error',
//         );
//       } catch (e) {
//         return ApiResponse.error(
//           // error: 'PARSING_ERROR', message: e.toString()),
//           errorMsg: 'Failed to parse error response',
//         );
//       }
//     } catch (e, stackTrace) {
//       log("getTicketList unexpected error: $e, StackTrace: $stackTrace");
//       return ApiResponse.error(
//         // error: ApiError(code: 'UNEXPECTED', message: e.toString()),
//         errorMsg: 'Unexpected error occurred',
//       );
//     }
//   }
// }
// // class TicketRepositoryImpl extends TicketRepository {
// //   final Dio _dio = Get.find<Dio>();
// //
// //   @override
// //   Future<ApiResponse<GetTicketAreaProblemModel>> getTicketAreaProblem(Map<String, dynamic> bodyData) async {
// //     try {
// //       final response = await _dio.post(ticketAreaProblem, data: dio.FormData.fromMap(bodyData));
// //       log("getTicketAreaProblem data: $response");
// //       final getTicketAreaProblemResponse = GetTicketAreaProblemModel.fromJson(response.data);
// //       return ApiResponse.success(data: getTicketAreaProblemResponse);
// //     } on DioException catch (error) {
// //       final getTicketAreaProblemResponse = GetTicketAreaProblemModel.fromJson(error.response?.data ?? {});
// //       return ApiResponse.error(
// //           error: ApiUtils.getApiError(error), errorMsg: getTicketAreaProblemResponse.message ?? 'Unknown error');
// //     }
// //   }
// //
// //   @override
// //   Future<ApiResponse<GetTicketSubAreaProblemModel>> getTicketSubAreaProblem(Map<String, dynamic> bodyData) async {
// //     try {
// //       final response = await _dio.post(ticketSubAreaProblem, data: dio.FormData.fromMap(bodyData));
// //       log("getTicketSubAreaProblem data: $response");
// //       final getTicketSubAreaProblemResponse = GetTicketSubAreaProblemModel.fromJson(response.data);
// //       return ApiResponse.success(data: getTicketSubAreaProblemResponse);
// //     } on DioException catch (error) {
// //       final getTicketSubAreaProblemResponse = GetTicketSubAreaProblemModel.fromJson(error.response?.data ?? {});
// //       return ApiResponse.error(
// //           error: ApiUtils.getApiError(error), errorMsg: getTicketSubAreaProblemResponse.message ?? 'Unknown error');
// //     }
// //   }
// //
// //   @override
// //   Future<ApiResponse<GetTicketPriorityModel>> getTicketPriorityApi(Map<String, dynamic> bodyData) async {
// //     try {
// //       final response = await _dio.post(ticketPriority, data: dio.FormData.fromMap(bodyData));
// //       log("getTicketPriority data: $response");
// //       final getTicketPriorityResponse = GetTicketPriorityModel.fromJson(response.data);
// //       return ApiResponse.success(data: getTicketPriorityResponse);
// //     } on DioException catch (error) {
// //       final getTicketPriorityResponse = GetTicketPriorityModel.fromJson(error.response?.data ?? {});
// //       return ApiResponse.error(
// //           error: ApiUtils.getApiError(error), errorMsg: getTicketPriorityResponse.message ?? 'Unknown error');
// //     }
// //   }
// //
// //   @override
// //   Future<ApiResponse<AddTicketModel>> addTicket(Map<String, dynamic> bodyData) async {
// //     try {
// //       log("Add Ticket Body Data ${bodyData}");
// //       final response = await _dio.post(addTicketApi, data: dio.FormData.fromMap(bodyData));
// //       log("addTicket data: $response");
// //       final addTicketResponse = AddTicketModel.fromJson(response.data);
// //       return ApiResponse.success(data: addTicketResponse);
// //     } on DioException catch (error) {
// //       final addTicketResponse = AddTicketModel.fromJson(error.response?.data ?? {});
// //       log("addTicket error: $error");
// //       return ApiResponse.error(
// //           error: ApiUtils.getApiError(error), errorMsg: addTicketResponse.message ?? 'Unknown error');
// //     }
// //   }
// //
// //   @override
// //   Future<ApiResponse<GetTicketListModel>> getTicketList(Map<String, dynamic> bodyData) async {
// //     try {
// //       final response = await _dio.post(getTicket, data: dio.FormData.fromMap(bodyData));
// //       log("getTicketList data: $response");
// //       final getTicketListResponse = GetTicketListModel.fromJson(response.data);
// //       return ApiResponse.success(data: getTicketListResponse);
// //     } on DioException catch (error) {
// //       final getTicketListResponse = GetTicketListModel.fromJson(error.response?.data ?? {});
// //       return ApiResponse.error(
// //           error: ApiUtils.getApiError(error), errorMsg: getTicketListResponse.message ?? 'Unknown error');
// //     }
// //   }
// // }

import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart' as dio;
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:keep_app/constant/api_endpoints.dart';
import 'package:keep_app/models/addTicket.dart';
import 'package:keep_app/models/customerModel.dart';
import 'package:keep_app/utils/api_response.dart';
import 'package:keep_app/utils/api_status.dart';
import 'package:keep_app/utils/api_utils.dart';
import 'package:keep_app/utils/sharedPrefs.dart';
import 'package:keep_app/view/raise ticket/GetTicketAreaModel.dart';
import 'package:keep_app/view/raise ticket/app_style.dart';
import 'package:keep_app/view/raise ticket/getTickeListModel.dart';
import 'package:keep_app/view/raise ticket/getTicketPriorityData.dart';
import 'package:keep_app/view/raise ticket/getTicketSubAreaProblemData.dart';
import 'package:keep_app/view/raise ticket/text_field/search_model.dart';
import 'package:keep_app/widget/show_snackbar.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import '../constant/app_constant.dart';

class TicketController extends GetxController {
  final TicketRepositoryImpl _ticketRepository =
      Get.put(TicketRepositoryImpl());
  final userNameController = TextEditingController();
  final descriptionController = TextEditingController();
  final facingController = TextEditingController();
  final SharedHelper sharedPrefs = SharedHelper();
  final picker = ImagePicker();

  // Observable states
  var isGetTicketAreaProblemLoading = false.obs;
  var isGetTicketSubAreaProblemLoading = false.obs;
  var isTicketPriorityLoading = false.obs;
  var isAddTicketLoading = false.obs;
  var isTicketListLoading = false.obs;
  var isCompleted = false.obs;
  var isFailed = false.obs;
  var error = RxnString();
  var tabIndex = 0.obs;
  var isFirstLoading = true.obs;

  // Ticket Area
  var selectedTicketAreaProblem = RxnString();
  var selectedTicketAreaProblemID = RxnString();
  var searchTicketAreaProblemList = <SearchDropModel>[].obs;
  var getTicketAreaProblemList = <GetTicketAreaProblemData>[].obs;

  // Ticket Sub Area
  var selectedTicketSubAreaProblem = RxnString();
  var selectedTicketSubAreaProblemID = RxnString();
  var searchTicketSubAreaProblemList = <SearchDropModel>[].obs;
  var getTicketSubAreaProblemList = <GetTicketSubAreaProblemData>[].obs;

  // Ticket Priority
  var selectedTicketPriority = RxnString();
  var selectedTicketPriorityID = RxnString();
  var searchTicketPriorityList = <SearchDropModel>[].obs;
  var getTicketPriorityModel = <GetTicketPriorityData>[].obs;

  // Ticket List
  var getTicketListModel = Rxn<GetTicketListModel>();

  // Image handling
  var selectedFile = Rxn<File>();
  var image = Rxn<File>();
  var inProcess = false.obs;
  var facingDate = RxnString();

  Rx<CustomerModel>? customerModel = CustomerModel().obs;
  // String? firmId; // Define firmId (replace with actual source)

  @override
  void onInit() {
    super.onInit();
    getLocalData();
    // initAPICall();
  }

  Future<void> getLocalData() async {
    CustomerModel? customer = await sharedPrefs.getCustomer();
    if (customer != null) {
      customerModel!.value = customer;
      userNameController.text = customer.customerName ?? "";
      // Assume firmId is stored in SharedPrefs or passed from another controller
      // firmId = firmId; // Replace with actual logic
      log("Customer: ${customer.customerName}, FirmId: $firmId");
      log("Customer: ${customer.customerId}, FirmId: $firmId");
      initAPICall();

    }
  }

  void initAPICall() {
    // getTicketAreaProblem();
    // getTicketPriority();
    getTicketList();
  }

  Future<void> getImage(ImageSource source) async {
    inProcess.value = true;
    try {
      final pickedFile = await picker.pickImage(source: source);
      if (pickedFile != null) {
        image.value = File(pickedFile.path);
      }

      if (image.value != null) {
        CroppedFile? cropped = await ImageCropper().cropImage(
          sourcePath: image.value!.path,
          aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
          compressQuality: 100,
          maxWidth: 700,
          maxHeight: 700,
          compressFormat: ImageCompressFormat.jpg,
          uiSettings: [
            AndroidUiSettings(
              initAspectRatio: CropAspectRatioPreset.original,
              toolbarColor: Colors.white,
              toolbarTitle: 'Edit Images',
              activeControlsWidgetColor: AppStyles.primaryColor,
              cropFrameColor: Colors.white,
              cropGridColor: Colors.white,
              toolbarWidgetColor: AppStyles.primaryColor,
              backgroundColor: Colors.white,
            ),
          ],
        );

        if (cropped != null) {
          selectedFile.value = File(cropped.path);
          log("Selected File: ${selectedFile.value}");
          if (source == ImageSource.camera && image.value!.existsSync()) {
            image.value!.deleteSync();
          }
          image.value = null;
        }
      }
    } catch (exception, stackTrace) {
      error.value = exception.toString();
      Fluttertoast.showToast(msg: error.value ?? "");
      await Sentry.captureException(exception, stackTrace: stackTrace);
    } finally {
      inProcess.value = false;
    }
  }

  // Future<void> getTicketAreaProblem() async {
  //   try {
  //     isGetTicketAreaProblemLoading.value = true;
  //     Map<String, dynamic> bodyData = {"": ""};
  //     log("getTicketAreaProblem bodyData: $bodyData");
  //     final response = await _ticketRepository.getTicketAreaProblem(bodyData);
  //     if (response.status == ApiStatus.success) {
  //       getTicketAreaProblemList.assignAll(response.data?.data ?? []);
  //       searchTicketAreaProblemList.clear();
  //       getTicketAreaProblemList.forEach((data) {
  //         if (data.problemName?.isNotEmpty ?? false) {
  //           searchTicketAreaProblemList.add(
  //             SearchDropModel(
  //               title: data.problemName,
  //               id: data.problemId,
  //               value: data.problemId,
  //             ),
  //           );
  //         }
  //       });
  //     } else {
  //       error.value = response.errorMsg;
  //       Fluttertoast.showToast(msg: error.value ?? "");
  //     }
  //   } catch (exception, stackTrace) {
  //     error.value = exception.toString();
  //     Fluttertoast.showToast(msg: error.value ?? "");
  //     await Sentry.captureException(exception, stackTrace: stackTrace);
  //   } finally {
  //     isGetTicketAreaProblemLoading.value = false;
  //   }
  // }
  //
  // Future<void> getTicketSubAreaProblem() async {
  //   try {
  //     isGetTicketSubAreaProblemLoading.value = true;
  //     Map<String, dynamic> bodyData = {'ProblemId': selectedTicketAreaProblemID.value};
  //     log("getTicketSubAreaProblem bodyData: $bodyData");
  //     final response = await _ticketRepository.getTicketSubAreaProblem(bodyData);
  //     if (response.status == ApiStatus.success) {
  //       getTicketSubAreaProblemList.assignAll(response.data?.data ?? []);
  //       searchTicketSubAreaProblemList.clear();
  //       getTicketSubAreaProblemList.forEach((data) {
  //         searchTicketSubAreaProblemList.add(
  //           SearchDropModel(
  //             title: data.subproblemName,
  //             id: data.subproblemId,
  //             value: data.subproblemId,
  //           ),
  //         );
  //       });
  //     } else {
  //       error.value = response.errorMsg;
  //       Fluttertoast.showToast(msg: error.value ?? "");
  //     }
  //   } catch (exception, stackTrace) {
  //     error.value = exception.toString();
  //     Fluttertoast.showToast(msg: error.value ?? "");
  //     await Sentry.captureException(exception, stackTrace: stackTrace);
  //   } finally {
  //     isGetTicketSubAreaProblemLoading.value = false;
  //   }
  // }
  //
  // Future<void> getTicketPriority() async {
  //   try {
  //     isTicketPriorityLoading.value = true;
  //     Map<String, dynamic> bodyData = {"": ""};
  //     log("getTicketPriority bodyData: $bodyData");
  //     final response = await _ticketRepository.getTicketPriorityApi(bodyData);
  //     if (response.status == ApiStatus.success) {
  //       getTicketPriorityModel.assignAll(response.data?.data ?? []);
  //       searchTicketPriorityList.clear();
  //       getTicketPriorityModel.forEach((data) {
  //         searchTicketPriorityList.add(
  //           SearchDropModel(
  //             title: data.priorityName,
  //             id: data.priorityId,
  //             value: data.priorityId,
  //           ),
  //         );
  //       });
  //     } else {
  //       error.value = response.errorMsg;
  //       Fluttertoast.showToast(msg: error.value ?? "");
  //     }
  //   } catch (exception, stackTrace) {
  //     error.value = exception.toString();
  //     Fluttertoast.showToast(msg: error.value ?? "");
  //     await Sentry.captureException(exception, stackTrace: stackTrace);
  //   } finally {
  //     isTicketPriorityLoading.value = false;
  //   }
  // }

  Future<void> addTicket(BuildContext context) async {
    try {
      isAddTicketLoading.value = true;
      if (customerModel?.value.customerId == null) {
        throw Exception("Customer ID is missing");
      }
      // if (firmId == null) {
      //   throw Exception("Firm ID is missing");
      // }

      Map<String, dynamic> bodyData = {
        "CustomerId": customerModel!.value.customerId,
        "TicketsPhoneNo": customerModel!.value.customerPhoneNo ?? "",
        "TicketsUserName": userNameController.text.trim(),
        "TicketsDescription": descriptionController.text.trim(),
        "FirmId": 2,
      };

      if (selectedFile.value != null && selectedFile.value!.existsSync()) {
        final filePath = selectedFile.value!.path;
        final fileName =
            "ticket_image_${DateTime.now().millisecondsSinceEpoch}.jpg";
        bodyData["TicketsImage"] =
            await compute(_processFile, [filePath, fileName]);
      } else {
        log("No valid image selected");
      }

      log("addTicket bodyData: $bodyData");
      final response = await _ticketRepository.addTicket(bodyData);
      log("addTicket response status: ${response.status}, data: ${response.data?.message}");
      if (response.status == ApiStatus.success) {
        showSnackBar(
            msg: response.data?.message ?? "Your ticket created successfully",
            context: context);
        facingDate.value = null;
        selectedTicketAreaProblem.value = null;
        selectedTicketSubAreaProblem.value = null;
        selectedTicketPriority.value = null;
        selectedTicketAreaProblemID.value = null;
        selectedTicketSubAreaProblemID.value = null;
        selectedTicketPriorityID.value = null;
        descriptionController.clear();
        selectedFile.value = null;
        facingController.clear();
        tabIndex.value = 1;
        getTicketList();
      } else {
        error.value = response.errorMsg ?? "Failed to create ticket";
        Fluttertoast.showToast(msg: error.value!);
      }
    } catch (exception, stackTrace) {
      error.value = exception.toString();
      Fluttertoast.showToast(msg: "Error: ${error.value}");
      await Sentry.captureException(exception, stackTrace: stackTrace);
      log("addTicket exception: $exception, StackTrace: $stackTrace");
    } finally {
      isAddTicketLoading.value = false;
    }
  }

  static Future<dio.MultipartFile> _processFile(List<String> args) async {
    final filePath = args[0];
    final fileName = args[1];
    return dio.MultipartFile.fromFileSync(filePath, filename: fileName);
  }

  // Future<void> addTicket(BuildContext context) async {
  //   try {
  //     isAddTicketLoading.value = true;
  //     if (customerModel?.value.customerId == null) {
  //       throw Exception("Customer ID is missing");
  //     }
  //     // if (firmId == ) {
  //     //   throw Exception("Firm ID is missing");
  //     // }
  //
  //     Map<String, dynamic> bodyData = {
  //       "CustomerId": customerModel!.value.customerId,
  //       "TicketsPhoneNo": customerModel!.value.customerPhoneNo ?? "",
  //       "TicketsUserName": userNameController.text.trim(),
  //       "TicketsDescription": descriptionController.text.trim(),
  //       "FirmId": 2,
  //       // // Include if server requires
  //       // "TicketAreaOfProblem": selectedTicketAreaProblemID.value ?? "",
  //       // "TicketsSubAreaProblem": selectedTicketSubAreaProblemID.value ?? "",
  //       // "TicketsFacingSince": facingDate.value ?? "",
  //       // "TicketPriority": selectedTicketPriorityID.value ?? "",
  //     };
  //
  //     if (selectedFile.value != null && selectedFile.value!.existsSync()) {
  //       bodyData["TicketsImage"] = await dio.MultipartFile.fromFile(
  //         selectedFile.value!.path,
  //         filename: "ticket_image_${DateTime.now().millisecondsSinceEpoch}.jpg",
  //       );
  //     } else {
  //       log("No valid image selected");
  //     }
  //
  //     log("addTicket bodyData: $bodyData");
  //     final response = await _ticketRepository.addTicket(bodyData);
  //     print("Add Ticket Data Responce ${response.data}");
  //     print("Add Ticket Data Status ${response.status}");
  //     print("Add Ticket Data Error ${response.error}");
  //     print("Add Ticket Data Error Msg ${response.errorMsg}");
  //     if (response.status == ApiStatus.success) {
  //       showSnackBar(msg: "Your ticket created successfully", context: context);
  //       // Reset fields
  //       facingDate.value = null;
  //       selectedTicketAreaProblem.value = null;
  //       selectedTicketSubAreaProblem.value = null;
  //       selectedTicketPriority.value = null;
  //       selectedTicketAreaProblemID.value = null;
  //       selectedTicketSubAreaProblemID.value = null;
  //       selectedTicketPriorityID.value = null;
  //       descriptionController.clear();
  //       selectedFile.value = null;
  //       facingController.clear();
  //       tabIndex.value = 1; // Switch to TicketViewScreen
  //       getTicketList();
  //     } else {
  //       error.value = response.errorMsg ?? "Failed to create ticket";
  //       Fluttertoast.showToast(msg: error.value!);
  //     }
  //   } catch (exception, stackTrace) {
  //     error.value = exception.toString();
  //     Fluttertoast.showToast(msg: "Error: ${error.value}");
  //     await Sentry.captureException(exception, stackTrace: stackTrace);
  //     log("addTicket exception: $exception, StackTrace: $stackTrace");
  //   } finally {
  //     isAddTicketLoading.value = false;
  //   }
  // }
  //
  Future<void> getTicketList() async {
    try {
      isTicketListLoading.value = true;
      isCompleted.value = false;
      isFailed.value = false;
      error.value = null;
      Map<String, dynamic> bodyData = {
        "CustomerId": customerModel!.value.customerId,
        "FirmId":firmId,
      };
      log("getTicketList bodyData: $bodyData");
      final response = await _ticketRepository.getTicketList(bodyData);
      if (response.status == ApiStatus.success) {
        getTicketListModel.value = response.data;
        isCompleted.value = true;
        isFirstLoading.value = false;
      } else {
        isFailed.value = true;
        error.value = response.errorMsg;
        Fluttertoast.showToast(msg: error.value ?? "");
      }
    } catch (exception, stackTrace) {
      isFailed.value = true;
      error.value = exception.toString();
      Fluttertoast.showToast(msg: error.value ?? "");
      await Sentry.captureException(exception, stackTrace: stackTrace);
    } finally {
      isTicketListLoading.value = false;
    }
  }

  void validateDetails(BuildContext context) {
    if (userNameController.text.trim().isEmpty) {
      showSnackBar(
          msg: "Please enter the user name", isError: true, context: context);
    } else if (descriptionController.text.trim().isEmpty) {
      showSnackBar(
          msg: "Please enter the description", isError: true, context: context);
    } else if (customerModel?.value.customerId == null) {
      showSnackBar(
          msg: "Customer ID is missing", isError: true, context: context);
    }
    // else if (firmId == null) {
    //   showSnackBar(msg: "Firm ID is missing", isError: true, context: context);
    // }
    else {
      // Uncomment these if server requires them
      // if (facingDate.value == null) {
      //   showSnackBar(msg: "Please select the facing issue", isError: true, context: context);
      // } else if (selectedTicketAreaProblem.value == null) {
      //   showSnackBar(msg: "Select the ticket problem area", isError: true, context: context);
      // } else if (selectedTicketSubAreaProblem.value == null) {
      //   showSnackBar(msg: "Select the ticket problem sub area", isError: true, context: context);
      // } else if (selectedTicketPriority.value == null) {
      //   showSnackBar(msg: "Select the ticket priority", isError: true, context: context);
      // } else {
      addTicket(context);
      // }
    }
  }
}
//
// import 'dart:developer';
//
// import 'package:dio/dio.dart' as dio;
// import 'package:get/get.dart';
// import 'package:keep_app/constant/api_endpoints.dart';
// import 'package:keep_app/models/addTicket.dart';
// import 'package:keep_app/utils/api_response.dart';
// import 'package:keep_app/utils/api_utils.dart';
// import 'package:keep_app/view/raise ticket/GetTicketAreaModel.dart';
// import 'package:keep_app/view/raise ticket/getTickeListModel.dart';
// import 'package:keep_app/view/raise ticket/getTicketPriorityData.dart';
// import 'package:keep_app/view/raise ticket/getTicketSubAreaProblemData.dart';

abstract class TicketRepository {
  // Future<ApiResponse<GetTicketAreaProblemModel>> getTicketAreaProblem(Map<String, dynamic> bodyData);
  // Future<ApiResponse<GetTicketSubAreaProblemModel>> getTicketSubAreaProblem(Map<String, dynamic> bodyData);
  // Future<ApiResponse<GetTicketPriorityModel>> getTicketPriorityApi(Map<String, dynamic> bodyData);
  Future<ApiResponse<AddTicketModel>> addTicket(Map<String, dynamic> bodyData);

  Future<ApiResponse<GetTicketListModel>> getTicketList(
      Map<String, dynamic> bodyData);
}

class TicketRepositoryImpl extends TicketRepository {
  final dio.Dio _dio = Get.find<dio.Dio>();

  // @override
  // Future<ApiResponse<GetTicketAreaProblemModel>> getTicketAreaProblem(Map<String, dynamic> bodyData) async              {
  //   try {
  //     final response = await _dio.post(ticketAreaProblem, data: dio.FormData.fromMap(bodyData));
  //     log("getTicketAreaProblem response: ${response.data}");
  //     if (response.data == null) {
  //       return ApiResponse.error(
  //         // error: ApiError(code: 'NULL_RESPONSE', message: 'Empty response from server'),
  //         errorMsg: 'Server returned empty response',
  //       );
  //     }
  //     final getTicketAreaProblemResponse = GetTicketAreaProblemModel.fromJson(response.data);
  //     return ApiResponse.success(data: getTicketAreaProblemResponse);
  //   } on dio.DioException catch (error) {
  //     log("getTicketAreaProblem error: ${error.response?.data}, ${error.message}, ${error.response?.statusCode}");
  //     try {
  //       final getTicketAreaProblemResponse = GetTicketAreaProblemModel.fromJson(error.response?.data ?? {});
  //       return ApiResponse.error(
  //         error: ApiUtils.getApiError(error),
  //         errorMsg: getTicketAreaProblemResponse.message ?? 'Unknown error',
  //       );
  //     } catch (e) {
  //       return ApiResponse.error(
  //         // error: ApiError(code: 'PARSING_ERROR', message: e.toString()),
  //         errorMsg: 'Failed to parse error response',
  //       );
  //     }
  //   } catch (e, stackTrace) {
  //     log("getTicketAreaProblem unexpected error: $e, StackTrace: $stackTrace");
  //     return ApiResponse.error(
  //       // error: ApiError(code: 'UNEXPECTED', message: e.toString()),
  //       errorMsg: 'Unexpected error occurred',
  //     );
  //   }
  // }
  //
  // @override
  // Future<ApiResponse<GetTicketSubAreaProblemModel>> getTicketSubAreaProblem(Map<String, dynamic> bodyData) async {
  //   try {
  //     final response = await _dio.post(ticketSubAreaProblem, data: dio.FormData.fromMap(bodyData));
  //     log("getTicketSubAreaProblem response: ${response.data}");
  //     if (response.data == null) {
  //       return ApiResponse.error(
  //         // error: ApiError(code: 'NULL_RESPONSE', message: 'Empty response from server'),
  //         errorMsg: 'Server returned empty response',
  //       );
  //     }
  //     final getTicketSubAreaProblemResponse = GetTicketSubAreaProblemModel.fromJson(response.data);
  //     return ApiResponse.success(data: getTicketSubAreaProblemResponse);
  //   } on dio.DioException catch (error) {
  //     log("getTicketSubAreaProblem error: ${error.response?.data}, ${error.message}, ${error.response?.statusCode}");
  //     try {
  //       final getTicketSubAreaProblemResponse = GetTicketSubAreaProblemModel.fromJson(error.response?.data ?? {});
  //       return ApiResponse.error(
  //         error: ApiUtils.getApiError(error),
  //         errorMsg: getTicketSubAreaProblemResponse.message ?? 'Unknown error',
  //       );
  //     } catch (e) {
  //       return ApiResponse.error(
  //         // error: ApiError(code: 'PARSING_ERROR', message: e.toString()),
  //         errorMsg: 'Failed to parse error response',
  //       );
  //     }
  //   } catch (e, stackTrace) {
  //     log("getTicketSubAreaProblem unexpected error: $e, StackTrace: $stackTrace");
  //     return ApiResponse.error(
  //       // error: ApiError(code: 'UNEXPECTED', message: e.toString()),
  //       errorMsg: 'Unexpected error occurred',
  //     );
  //   }
  // }
  //
  // @override
  // Future<ApiResponse<GetTicketPriorityModel>> getTicketPriorityApi(Map<String, dynamic> bodyData) async {
  //   try {
  //     final response = await _dio.post(ticketPriority, data: dio.FormData.fromMap(bodyData));
  //     log("getTicketPriority response: ${response.data}");
  //     if (response.data == null) {
  //       return ApiResponse.error(
  //         // error: ApiError(code: 'NULL_RESPONSE', message: 'Empty response from server'),
  //         errorMsg: 'Server returned empty response',
  //       );
  //     }
  //     final getTicketPriorityResponse = GetTicketPriorityModel.fromJson(response.data);
  //     return ApiResponse.success(data: getTicketPriorityResponse);
  //   } on dio.DioException catch (error) {
  //     log("getTicketPriority error: ${error.response?.data}, ${error.message}, ${error.response?.statusCode}");
  //     try {
  //       final getTicketPriorityResponse = GetTicketPriorityModel.fromJson(error.response?.data ?? {});
  //       return ApiResponse.error(
  //         error: ApiUtils.getApiError(error),
  //         errorMsg: getTicketPriorityResponse.message ?? 'Unknown error',
  //       );
  //     } catch (e) {
  //       return ApiResponse.error(
  //         // error: ApiError(code: 'PARSING_ERROR', message: e.toString()),
  //         errorMsg: 'Failed to parse error response',
  //       );
  //     }
  //   } catch (e, stackTrace) {
  //     log("getTicketPriority unexpected error: $e, StackTrace: $stackTrace");
  //     return ApiResponse.error(
  //       // error: ApiError(code: 'UNEXPECTED', message: e.toString()),
  //       errorMsg: 'Unexpected error occurred',
  //     );
  //   }
  // }
  Future<ApiResponse<AddTicketModel>> addTicket(
      Map<String, dynamic> bodyData) async {
    try {
      log("addTicket request body: $bodyData");
      final response = await _dio.post(
        "https://kffashionnew.reliablesolution.in/Admin/Ajax/addTicket",
        // addTicketApi,
        data: dio.FormData.fromMap(bodyData),
        options: dio.Options(
          headers: {
            'Content-Type': 'multipart/form-data',
          },
        ),
      );
      log("addTicket response: ${response.data}, statusCode: ${response.statusCode}");
      if (response.data == null || response.data.isEmpty) {
        return ApiResponse.error(
          // error: ApiError(code: 'NULL_RESPONSE', message: 'Empty response from server'),
          errorMsg: 'Server returned empty response',
        );
      }
      final addTicketResponse = AddTicketModel.fromJson(response.data);
      log("Parsed AddTicketModel: isSuccess=${addTicketResponse.isSuccess}, message=${addTicketResponse.message}, data=${addTicketResponse.data}");
      return ApiResponse.success(data: addTicketResponse);
    } on dio.DioException catch (error) {
      log("addTicket error: ${error.response?.data}, ${error.message}, ${error.response?.statusCode}, type: ${error.type}");
      String errorMsg = 'Unknown error';
      if (error.type == dio.DioExceptionType.connectionTimeout) {
        errorMsg = 'Connection timed out';
      } else if (error.type == dio.DioExceptionType.sendTimeout) {
        errorMsg = 'Send timeout';
      } else if (error.type == dio.DioExceptionType.receiveTimeout) {
        errorMsg = 'Receive timeout';
      } else if (error.type == dio.DioExceptionType.badResponse) {
        errorMsg = 'Bad response: ${error.response?.statusCode}';
      } else if (error.type == dio.DioExceptionType.connectionError) {
        errorMsg = 'Connection error';
      }
      return ApiResponse.error(
        error: ApiUtils.getApiError(error),
        errorMsg: errorMsg,
      );
    } catch (e, stackTrace) {
      log("addTicket unexpected error: $e, StackTrace: $stackTrace");
      return ApiResponse.error(
        // error: ApiError(code: 'UNEXPECTED', message: e.toString()),
        errorMsg: 'Unexpected error occurred',
      );
    }
  }

  // @override
  // Future<ApiResponse<AddTicketModel>> addTicket(Map<String, dynamic> bodyData) async {
  //   try {
  //     log("addTicket request body: $bodyData");
  //     final response = await _dio.post(
  //      'https://kffashionnew.reliablesolution.in/Admin/Ajax/addTicket',
  //       data: dio.FormData.fromMap(bodyData),
  //       options: dio.Options(
  //         headers: {
  //           'Content-Type': 'multipart/form-data',
  //         },
  //       ),
  //     );
  //     log("addTicket response: ${response.data}");
  //     if (response.data == null || response.data.isEmpty) {
  //       return ApiResponse.error(
  //         // error: ApiError(code: 'NULL_RESPONSE', message: 'Empty response from server'),
  //         errorMsg: 'Server returned empty response',
  //       );
  //     }
  //     final addTicketResponse = AddTicketModel.fromJson(response.data);
  //     return ApiResponse.success(data: addTicketResponse);
  //   } on dio.DioException catch (error) {
  //     log("addTicket error: ${error.response?.data}, ${error.message}, ${error.response?.statusCode}");
  //     try {
  //       final addTicketResponse = AddTicketModel.fromJson(error.response?.data ?? {});
  //       return ApiResponse.error(
  //         error: ApiUtils.getApiError(error),
  //         errorMsg: addTicketResponse.message ?? 'Unknown error',
  //       );
  //     } catch (e) {
  //       return ApiResponse.error(
  //         // error: ApiError(code: 'PARSING_ERROR', message: e.toString()),
  //         errorMsg: 'Failed to parse error response: ${error.response?.data}',
  //       );
  //     }
  //   } catch (e, stackTrace) {
  //     log("addTicket unexpected error: $e, StackTrace: $stackTrace");
  //     return ApiResponse.error(
  //       // error: ApiError(code: 'UNEXPECTED', message: e.toString()),
  //       errorMsg: 'Unexpected error occurred',
  //     );
  //   }
  // }

  @override
  Future<ApiResponse<GetTicketListModel>> getTicketList(
      Map<String, dynamic> bodyData) async
  {
    try {
      final response = await _dio.post(
        "https://kffashionnew.reliablesolution.in/Admin/Ajax/Get_ticket",
        // getTicket,
        data: dio.FormData.fromMap(bodyData),
      );
      log("getTicketList response: ${response.data}");
      if (response.data == null) {
        return ApiResponse.error(
          // error: ApiError(code: 'NULL_RESPONSE', message: 'Empty response from server'),
          errorMsg: 'Server returned empty response',
        );
      }
      log("getTicketList raw response: ${response.data}");

      // Check if response.data is a String and decode it to Map
      final Map<String, dynamic> jsonData = response.data is String
          ? json.decode(response.data)
          : response.data;

      if (jsonData.isEmpty) {
        return ApiResponse.error(
          errorMsg: 'Server returned empty response',
        );
      }

      final getTicketListResponse = GetTicketListModel.fromJson(jsonData);
      return ApiResponse.success(data: getTicketListResponse);
    } on dio.DioException catch (error) {
      log("getTicketList error: ${error.response?.data}, ${error.message}, ${error.response?.statusCode}");
      try {
        final jsonError = error.response?.data is String
            ? json.decode(error.response?.data)
            : error.response?.data ?? {};
        final getTicketListResponse =
            GetTicketListModel.fromJson(jsonError);
        return ApiResponse.error(
          error: ApiUtils.getApiError(error),
          errorMsg: getTicketListResponse.message ?? 'Unknown error',
        );
      } catch (e) {
        return ApiResponse.error(
          // error: ApiError(code: 'PARSING_ERROR', message: e.toString()),
          errorMsg: 'Failed to parse error response',
        );
      }
    } catch (e, stackTrace) {
      log("getTicketList unexpected error: $e, StackTrace: $stackTrace");
      return ApiResponse.error(
        // error: ApiError(code: 'UNEXPECTED', message: e.toString()),
        errorMsg: 'Unexpected error occurred',
      );
    }
  }
}
