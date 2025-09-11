
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
import '../utils/services/api_services.dart';

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

  Future<void> getTicketList() async {
    try {
      isTicketListLoading.value = true;
      isCompleted.value = false;
      isFailed.value = false;
      error.value = null;
      Map<String, dynamic> bodyData = {
        "CustomerId": customerModel!.value.customerId,
        "FirmId": firmId,
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

    else {

      addTicket(context);
      // }
    }
  }
}


abstract class TicketRepository {

  Future<ApiResponse<AddTicketModel>> addTicket(Map<String, dynamic> bodyData);

  Future<ApiResponse<GetTicketListModel>> getTicketList(
      Map<String, dynamic> bodyData);
}

class TicketRepositoryImpl extends TicketRepository {
  final dio.Dio _dio = Get.find<dio.Dio>();


  Future<ApiResponse<AddTicketModel>> addTicket(
      Map<String, dynamic> bodyData) async {
    try {
      log("addTicket request body: $bodyData");
      final response = await _dio.post(
        ApiService.baseUrl+addTicketApi,
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


  @override
  Future<ApiResponse<GetTicketListModel>> getTicketList(
      Map<String, dynamic> bodyData) async {
    try {
      final response = await _dio.post(
        ApiService.baseUrl+getTicket,
        data: dio.FormData.fromMap(bodyData),
      );
      log("getTicketList response: ${response.data}");
      if (response.data == null) {
        return ApiResponse.error(
          errorMsg: 'Server returned empty response',
        );
      }
      log("getTicketList raw response: ${response.data}");

      // Check if response.data is a String and decode it to Map
      final Map<String, dynamic> jsonData =
          response.data is String ? json.decode(response.data) : response.data;

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
        final getTicketListResponse = GetTicketListModel.fromJson(jsonError);
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
