import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:suratjugaad/Common/Colors.dart';
import 'package:suratjugaad/Common/constants.dart';
import 'package:suratjugaad/Common/services.dart';
import 'package:suratjugaad/a_structure/bloc/ticket/ticket_bloc.dart';
import 'package:suratjugaad/a_structure/constant/app_styles.dart';
import 'package:suratjugaad/a_structure/constant/app_utils.dart';
import 'package:suratjugaad/a_structure/models/drop_down_model/search_drop_model.dart';
import 'package:suratjugaad/a_structure/models/ticket_model/get_ticket_area_problem_model.dart';
import 'package:suratjugaad/a_structure/models/ticket_model/get_ticket_priority_model.dart';
import 'package:suratjugaad/a_structure/models/ticket_model/get_ticket_sub_area_problem_model.dart';
import 'package:suratjugaad/a_structure/preferences/shared_pref_const.dart';
import 'package:suratjugaad/a_structure/preferences/shared_prefs_data.dart';
import 'package:suratjugaad/screen_const/container_const.dart';
import 'package:suratjugaad/screen_const/show_snack_bar.dart';
import 'package:suratjugaad/screen_const/text_form_field_const.dart';
import 'package:suratjugaad/widgets/clear_controller_button_widget.dart';
import 'package:suratjugaad/widgets/drop_down_widget/drop_down_ui_const.dart';
import 'package:suratjugaad/widgets/drop_down_widget/search_drop_UI_widget.dart';
import 'package:suratjugaad/widgets/drop_down_widget/searchable_drop_down_widget.dart';

import '../../../Common/StringRes.dart';

class CreateComplainScreen extends StatefulWidget {
  const CreateComplainScreen({super.key});

  static Widget create() {
    return BlocProvider<TicketBloc>(
      create: (_) => TicketBloc(),
      child: CreateComplainScreen(),
    );
  }

  @override
  State<CreateComplainScreen> createState() => _CreateComplainScreenState();
}

class _CreateComplainScreenState extends State<CreateComplainScreen> {
  late Size size;

  final TextEditingController userNameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController facingController = TextEditingController();

  /// Ticket Area
  String? selectedTicketAreaProblem;
  String? userName;
  String? selectedTicketAreaProblemID;
  List<SearchDropModel> searchTicketAreaProblemList = [];
  List<GetTicketAreaProblemData> getTicketAreaProblemList = [];

  /// Ticket Sub Area
  String? selectedTicketSubAreaProblem;
  String? selectedTicketSubAreaProblemID;
  List<SearchDropModel> searchTicketSubAreaProblemList = [];
  List<GetTicketSubAreaProblemData> getTicketSubAreaProblemList = [];

  /// Ticket Priority
  String? selectedTicketPriority;
  String? selectedTicketPriorityID;
  List<SearchDropModel> searchTicketPriorityList = [];
  List<GetTicketPriorityData> getTicketPriority = [];

  File? _selectedFile;
  File? _image;
  final _picker = ImagePicker();
  bool _inProcess = false;
  String? facingDate;

  @override
  void initState() {
    super.initState();
    initAPICall();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getLocalData();
    });
  }

  getLocalData() async {
    setState(() {
      userName = SharedPrefsData().getStringData(SharedPrefConst.userName) ?? "";
      if(userName != null ){
        userNameController.text = userName!;
      }
    });
  }

  initAPICall() {
    _getTicketAreaProblemAPI();
    _getTicketPriorityAPI();
  }

  void _getImage(ImageSource source) async {
    this.setState(() => _inProcess = true);

    final pickedFile = await _picker.pickImage(source: source);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });

    if (_image != null) {
      CroppedFile? cropped = await ImageCropper().cropImage(
          sourcePath: _image!.path,
          aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
          compressQuality: 100,
          maxWidth: 700,
          maxHeight: 700,
          compressFormat: ImageCompressFormat.jpg,
          uiSettings: [
            AndroidUiSettings(
              initAspectRatio: CropAspectRatioPreset.original,
              toolbarColor: Colors.white,
              toolbarTitle: 'Edit Images',
              statusBarColor: AppStyles.primaryColor,
              activeControlsWidgetColor: AppStyles.primaryColor,
              cropFrameColor: Colors.white,
              cropGridColor: Colors.white,
              toolbarWidgetColor: AppStyles.primaryColor,
              backgroundColor: Colors.white,
            )
          ]);

      this.setState(() {
        // if (_selectedFile!.existsSync()) {
        //   _selectedFile!.deleteSync();
        // }
        _selectedFile = File(cropped!.path);
        print("Selected File :--- $_selectedFile");
        // delete image camera
        if (source.toString() == 'ImageSource.camera' && _image!.existsSync()) {
          _image!.deleteSync();
        }

        _image = null;
        _inProcess = false;
      });
    } else {
      this.setState(() => _inProcess = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        // appBar: AppBar(
        //   automaticallyImplyLeading: true,
        //   backgroundColor: AppStyles.primaryColor,
        //   centerTitle: true,
        //   // title: Text(
        //   //   "Raise a ticket",
        //   //   style: TextStyle(fontSize: 16, color: Colors.white),
        //   // ),
        //   leading: InkWell(
        //     onTap: () {
        //       Navigator.pop(context);
        //     },
        //     child: Icon(
        //       Icons.arrow_back,
        //     ),
        //   ),
        // ),
        body: BlocListener<TicketBloc, TicketState>(
          listener: (context, state) {
            if (state.isCompleted) {
              if (state.getTicketAreaProblemModel != null) {
                getTicketAreaProblemList =
                    state.getTicketAreaProblemModel?.data ?? [];
                for (var data in getTicketAreaProblemList) {
                  if (data.problemName!.isNotEmpty) {
                    searchTicketAreaProblemList.add(
                      SearchDropModel(
                          title: data.problemName,
                          id: data.problemId,
                          value: data.problemId),
                    );
                  }
                }
              }
              if (state.getTicketSubAreaProblemModel != null) {
                searchTicketSubAreaProblemList.clear();
                getTicketSubAreaProblemList =
                    state.getTicketSubAreaProblemModel?.data ?? [];
                for (var data in getTicketSubAreaProblemList) {
                  searchTicketSubAreaProblemList.add(
                    SearchDropModel(
                        title: data.subproblemName,
                        id: data.subproblemId,
                        value: data.subproblemId),
                  );
                }
              }
              if (state.getTicketPriorityModel != null) {
                getTicketPriority = state.getTicketPriorityModel?.data ?? [];
                for (var data in getTicketPriority) {
                  searchTicketPriorityList.add(
                    SearchDropModel(
                        title: data.priorityName,
                        id: data.priorityId,
                        value: data.priorityId),
                  );
                }
              }
              if (state.addTicketModel != null) {
                showSnackBar(
                    context: context, msg: "Your ticket created successfully");
                facingDate = null;
                selectedTicketAreaProblem = null;
                selectedTicketSubAreaProblem = null;
                selectedTicketPriority = null;
                descriptionController.text = "";
              }
            } else if (state.error != null) {
              Fluttertoast.showToast(
                msg: state.error ?? "",
              );
            }
          },
          child: BlocBuilder<TicketBloc, TicketState>(
            builder: (context, ticketState) {
              return ticketState.isGetTicketAreaProblemLoading
                  ? AppUtils.circularLoaderData()
                  : SingleChildScrollView(
                      child: Column(
                        children: [
                          _imagePicketSection(),
                          if(userName == "")...[_titleDetailsSection()],
                          _facingSection(),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Column(
                              children: [
                                _ticketAreaProblemWidget(),
                                _ticketSubAreaProblemWidget(),
                                _ticketPriorityWidget(),
                              ],
                            ),
                          ),
                          _descriptionDetailsSection(),
                          _submitButton(ticketState)
                        ],
                      ),
                    );
            },
          ),
        ),
      ),
    );
  }

  Widget _imagePicketSection() {
    return Column(
      children: [
        SizedBox(height: 20),
        _getImageWidget(),
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
                  Text('Camera'),
                ],
              ),
              onTap: () async {
                bool permission = await Services().askCameraPermission();
                if (permission) {
                  _getImage(ImageSource.camera);
                }
              },
            ),
            Container(
              width: 20,
            ),
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
                  Text('Gallery'),
                ],
              ),
              onTap: () async {
                bool permission = await Services().askPhotosPermission();
                if (permission) {
                  _getImage(ImageSource.gallery);
                }
              },
            ),
          ],
        ),
        (_inProcess)
            ? Container(
                color: Colors.white,
                height: MediaQuery.of(context).size.height,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              )
            : Center()
      ],
    );
  }

  Widget _getImageWidget() {
    return _selectedFile != null
        ? ClipOval(
            child: Image.file(
              _selectedFile!,
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

  Widget _titleDetailsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 20),
        Padding(
          padding: EdgeInsets.only(left: 10, bottom: 0),
          child: Text(StringRes.ticketUserName),
        ),
        TextFormFieldConst(
          controller: userNameController,
          hintText: StringRes.enterTicketUserName,
          keyboardType: TextInputType.text,
          maxLine: 1,
          prefixIcon:
              Icon(Icons.ad_units, color: AppStyles.primaryColor, size: 20),
        ),
      ],
    );
  }

  Widget _facingSection() {
    return Padding(
      padding: const EdgeInsets.only(left: 12.0, right: 12.0, top: 8),
      child: DropDownUIConst(
        label: StringRes.facingIssueSince,
        dropDownSelectionValue: facingDate == null ? "" : facingDate ?? "",
        suffixIcons: ClearControllerButtonWidget(
          onPressed: () {
            HapticFeedback.mediumImpact();
            setState(() {
              facingDate = null;
              // item.fromDateDateTimeFormat = null;
            });
          },
        ),
        valueFontSize: 15,
        onTap: () {
          showDatePicker(
            context: context,
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
            setState(() {});
            facingDate =
                DateFormat("dd MMM, yyyy").format(pickedDate ?? DateTime.now());
          });
        },
      ),
    );
  }

  Widget _descriptionDetailsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 20),
        Padding(
          padding: EdgeInsets.only(left: 10, bottom: 0),
          child: Text(StringRes.description),
        ),
        TextFormFieldConst(
          height: size.height * 0.20,
          controller: descriptionController,
          hintText: StringRes.enterDescription,
          keyboardType: TextInputType.text,
          maxLine: 5,
          prefixIcon:
              Icon(Icons.description, color: AppStyles.primaryColor, size: 20),
        ),
      ],
    );
  }

  Widget _ticketAreaProblemWidget() {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0),
      child: SearchDropUiWidget(
        label: StringRes.problemArea,
        title: selectedTicketAreaProblem == null
            ? StringRes.problemArea
            : selectedTicketAreaProblem!,
        suffixIcons: ClearControllerButtonWidget(
          onPressed: () {
            HapticFeedback.mediumImpact();
            setState(() {
              selectedTicketAreaProblem = null;
              selectedTicketSubAreaProblem = null;
            });
          },
        ),
        isValueSelected: selectedTicketAreaProblem == null ? false : true,
        onTap: () async {
          await showDialog(
            context: context,
            useRootNavigator: false,
            builder: (context) => SearchableDropDownWidget(
              headingTitle: StringRes.problemArea,
              listData: searchTicketAreaProblemList,
              onDataChanged: (value) {
                if(selectedTicketAreaProblem !=  value.title){
                  selectedTicketSubAreaProblem = null;
                }
                setState(() {
                  selectedTicketAreaProblem = value.title;
                  selectedTicketAreaProblemID = value.id;
                });
                _getTicketSubAreaProblemAPI();
              },
            ),
          );
        },
      ),
    );
  }

  Widget _ticketSubAreaProblemWidget() {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0),
      child: SearchDropUiWidget(
        label: StringRes.problemSubArea,
        title: selectedTicketSubAreaProblem == null
            ? StringRes.problemSubArea
            : selectedTicketSubAreaProblem!,
        suffixIcons: ClearControllerButtonWidget(
          onPressed: () {
            HapticFeedback.mediumImpact();
            setState(() {
              selectedTicketSubAreaProblem = null;
            });
          },
        ),
        isValueSelected: selectedTicketSubAreaProblem == null ? false : true,
        onTap: getTicketSubAreaProblemList.isEmpty
            ? () {
                showSnackBar(
                    context: context,
                    msg: "Please first select the problem area ",
                    isError: true);
              }
            : () async {
                await showDialog(
                  context: context,
                  useRootNavigator: false,
                  builder: (context) => SearchableDropDownWidget(
                    headingTitle: StringRes.problemSubArea,
                    listData: searchTicketSubAreaProblemList,
                    onDataChanged: (value) {
                      setState(() {
                        selectedTicketSubAreaProblem = value.title;
                        selectedTicketSubAreaProblemID = value.id;
                      });
                    },
                  ),
                );
              },
      ),
    );
  }

  Widget _ticketPriorityWidget() {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0),
      child: SearchDropUiWidget(
        label: StringRes.ticketPriority,
        title: selectedTicketPriority == null
            ? StringRes.ticketPriority
            : selectedTicketPriority!,
        suffixIcons: ClearControllerButtonWidget(
          onPressed: () {
            HapticFeedback.mediumImpact();
            setState(() {
              selectedTicketPriority = null;
            });
          },
        ),
        isValueSelected: selectedTicketPriority == null ? false : true,
        onTap: () async {
          await showDialog(
            context: context,
            useRootNavigator: false,
            builder: (context) => SearchableDropDownWidget(
              headingTitle: StringRes.ticketPriority,
              listData: searchTicketPriorityList,
              onDataChanged: (value) {
                setState(() {
                  selectedTicketPriority = value.title;
                  selectedTicketPriorityID = value.id;
                });
              },
            ),
          );
        },
      ),
    );
  }

  Widget _submitButton(TicketState ticketState) {
    return ticketState.isAddTicketLoading
        ? Padding(
            padding: EdgeInsets.only(bottom: size.height * 0.02),
            child: AppUtils.circularLoaderData(),
          )
        : ContainerConst(
            onTap: () {
              validationDetails();
            },
            height: 50,
            width: size.width,
            color: appPrimaryMaterialColorcard,
            topPadding: size.height * 0.01,
            bottomPadding: size.height * 0.02,
            child: Center(
              child: Text(
                "Create Ticket",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w700),
              ),
            ),
          );
  }

  validationDetails() {
    if (userNameController.text.trim().isEmpty) {
      showSnackBar(
          context: context, msg: "Please enter the user name", isError: true);
    } else if (facingDate == null) {
      showSnackBar(
          context: context,
          msg: "Please select the facing issue",
          isError: true);
    } else if (selectedTicketAreaProblem == null) {
      showSnackBar(
          context: context,
          msg: "Select the ticket problem area",
          isError: true);
    } else if (selectedTicketSubAreaProblem == null) {
      showSnackBar(
          context: context,
          msg: "Select the ticket problem sub area",
          isError: true);
    } else if (selectedTicketPriority == null) {
      showSnackBar(
          context: context, msg: "Select the ticket priority", isError: true);
    } else if (descriptionController.text.trim().isEmpty) {
      showSnackBar(
          context: context, msg: "Please enter the description", isError: true);
    } else {
      _addTicketAPI();
    }
  }

  Future<void> _getTicketAreaProblemAPI() async {
    try {
      Map<String, dynamic> bodyData = {"": ""};
      log("_getTicketAreaProblemAPI bodyData is call : ${bodyData}");
      BlocProvider.of<TicketBloc>(context).add(
        PerformGetTicketAreaProblemEvent(bodyData: bodyData),
      );
    } catch (exception, stackTrace) {
      await Sentry.captureException(
        exception,
        stackTrace: stackTrace,
      );
    }
  }

  Future<void> _getTicketSubAreaProblemAPI() async {
    try {
      Map<String, dynamic> bodyData = {
        'ProblemId': selectedTicketAreaProblemID,
      };
      log("_getTicketSubAreaProblemAPI bodyData is call : ${bodyData}");
      BlocProvider.of<TicketBloc>(context).add(
        PerformGetTicketSubAreaProblemEvent(bodyData: bodyData),
      );
    } catch (exception, stackTrace) {
      await Sentry.captureException(
        exception,
        stackTrace: stackTrace,
      );
    }
  }

  Future<void> _getTicketPriorityAPI() async {
    try {
      Map<String, dynamic> bodyData = {"": ""};
      log("_getTicketSubAreaProblemAPI bodyData is call : ${bodyData}");
      BlocProvider.of<TicketBloc>(context).add(
        PerformGetTicketPriorityEvent(bodyData: bodyData),
      );
    } catch (exception, stackTrace) {
      await Sentry.captureException(
        exception,
        stackTrace: stackTrace,
      );
    }
  }

  Future<void> _addTicketAPI() async {
    try {
      Map<String, dynamic> bodyData = {
        "UsersId": SharedPrefsData().getStringData(SharedPrefConst.userID),
        "TicketAreaOfProblem": selectedTicketAreaProblemID,
        "TicketsSubAreaProblem": selectedTicketSubAreaProblemID,
        "TicketsUserName": userNameController.text.trim(),
        "TicketsDescription": descriptionController.text.trim(),
        "TicketsFacingSince": facingDate,
        "TicketPriority": selectedTicketPriorityID,
        "TicketsImage": _selectedFile?.path ?? "",
      };
      log("_addTicketAPI bodyData is call : ${bodyData}");
      BlocProvider.of<TicketBloc>(context).add(
        PerformAddTicketEvent(bodyData: bodyData),
      );
    } catch (exception, stackTrace) {
      await Sentry.captureException(
        exception,
        stackTrace: stackTrace,
      );
    }
  }
}