//flutter
import 'package:flutter/material.dart';
//package
import 'package:get/get.dart';
//constants
import 'package:keep_app/constant/colorConst.dart';
import 'package:keep_app/constant/imagesConst.dart';
import 'package:keep_app/controller/homeController.dart';
import 'package:keep_app/theme/nativeTheme.dart';
import 'package:keep_app/widget/alignWidget.dart';
import 'package:keep_app/widget/dividerWidgets.dart';
import 'package:keep_app/widget/iconButtonWidget.dart';
import 'package:keep_app/widget/inputWidget.dart';
import 'package:keep_app/widget/textWidget.dart';

import '../../../utils/string_res.dart';

class HomeProductHeader extends StatelessWidget {
  final HomeController _controller = Get.find<HomeController>();

  HomeProductHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      color: COLOR.background,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          DividerWidget(thickness: 2),
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.04,
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  // onTap: () => openBottomSheetSort(context),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        child: ImageIcon(
                          AssetImage(Images.sort),
                          size: 21,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 5),
                        child: TextWiget(
                          title: StringRes.sort,
                          style: Themes.dark.textTheme.displaySmall,
                        ),
                      ),
                    ],
                  ),
                ),
                VerticalDivider(thickness: 1.5),
                InkWell(
                  // onTap: () => openBottomSheetCategory(context),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        padding: EdgeInsets.only(right: 5),
                        child: TextWiget(
                          title: StringRes.category,
                          style: Themes.dark.textTheme.displaySmall,
                        ),
                      ),
                      Container(
                        child: Icon(
                          Icons.keyboard_arrow_down,
                          size: 21,
                        ),
                      ),
                    ],
                  ),
                ),
                VerticalDivider(thickness: 1.5),
                InkWell(
                  // onTap: () => openBottomSheetGender(context),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        padding: EdgeInsets.only(right: 5),
                        child: TextWiget(
                          title: StringRes.gender,
                          style: Themes.dark.textTheme.displaySmall,
                        ),
                      ),
                      Container(
                        child: Icon(
                          Icons.keyboard_arrow_down,
                          size: 21,
                        ),
                      ),
                    ],
                  ),
                ),
                VerticalDivider(thickness: 1.5),
                InkWell(
                  // onTap: () => openBottomSheetFilter(context),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        child: Icon(
                          Icons.filter_list,
                          size: 21,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 5),
                        child: TextWiget(
                          title: StringRes.filters,
                          style: Themes.dark.textTheme.displaySmall,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          DividerWidget(thickness: 2),
        ],
      ),
    );
  }

  void openBottomSheetSort(BuildContext context) {
    Get.bottomSheet(
      Obx(
        () => Container(
          height: MediaQuery.of(context).size.height * 0.55,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Padding(
                      padding: Get.width > 360
                          ? EdgeInsets.symmetric(horizontal: 20, vertical: 10)
                          : EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          TextWiget(
                            title: StringRes.sortNew,
                            style: Themes.light.textTheme.displayLarge,
                          ),
                          Expanded(
                            child: AlignWidget(
                              alignment: Alignment.topRight,
                              child: IconButtonWidget(
                                voidCallback: () {
                                  // Get.back();
                                },
                                icons: Icons.close,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    DividerWidget(thickness: 1),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: RadioListTile(
                  value: 1,
                  groupValue: _controller.sortValue.value,
                  onChanged: (value) {
                    // _controller.sortValue.value = int.parse(value.toString());
                    // _controller.update();
                  },
                  contentPadding: EdgeInsets.zero,
                  activeColor: COLOR.appBaseColor,
                  visualDensity: const VisualDensity(
                    horizontal: VisualDensity.minimumDensity,
                    vertical: VisualDensity.minimumDensity,
                  ),
                  title: TextWiget(
                    title: StringRes.relevance,
                    style: _controller.sortValue.value == 1
                        ? Themes.light.textTheme.displayLarge
                        : Themes.light.textTheme.displaySmall,
                  ),
                  toggleable: true,
                  controlAffinity: ListTileControlAffinity.trailing,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: RadioListTile(
                  value: 2,
                  groupValue: _controller.sortValue.value,
                  onChanged: (value) {
                    // _controller.sortValue.value = int.parse(value.toString());
                    // _controller.update();
                  },
                  contentPadding: EdgeInsets.zero,
                  activeColor: COLOR.appBaseColor,
                  visualDensity: const VisualDensity(
                    horizontal: VisualDensity.minimumDensity,
                    vertical: VisualDensity.minimumDensity,
                  ),
                  title: TextWiget(
                    title: StringRes.newArrivals,
                    style: _controller.sortValue.value == 2
                        ? Themes.light.textTheme.displayLarge
                        : Themes.light.textTheme.displaySmall,
                  ),
                  toggleable: true,
                  controlAffinity: ListTileControlAffinity.trailing,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: RadioListTile(
                  value: 3,
                  groupValue: _controller.sortValue.value,
                  contentPadding: EdgeInsets.zero,
                  onChanged: (value) {
                    // _controller.sortValue.value = int.parse(value.toString());
                    // _controller.update();
                  },
                  activeColor: COLOR.appBaseColor,
                  visualDensity: const VisualDensity(
                    horizontal: VisualDensity.minimumDensity,
                    vertical: VisualDensity.minimumDensity,
                  ),
                  title: TextWiget(
                    title: StringRes.price,
                    style: _controller.sortValue.value == 3
                        ? Themes.light.textTheme.displayLarge
                        : Themes.light.textTheme.displaySmall,
                  ),
                  toggleable: true,
                  controlAffinity: ListTileControlAffinity.trailing,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: RadioListTile(
                  value: 4,
                  groupValue: _controller.sortValue.value,
                  contentPadding: EdgeInsets.zero,
                  onChanged: (value) {
                    // _controller.sortValue.value = int.parse(value.toString());
                    // _controller.update();
                  },
                  activeColor: COLOR.appBaseColor,
                  visualDensity: const VisualDensity(
                    horizontal: VisualDensity.minimumDensity,
                    vertical: VisualDensity.minimumDensity,
                  ),
                  title: TextWiget(
                    title: StringRes.price,
                    style: _controller.sortValue.value == 4
                        ? Themes.light.textTheme.displayLarge
                        : Themes.light.textTheme.displaySmall,
                  ),
                  toggleable: true,
                  controlAffinity: ListTileControlAffinity.trailing,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: RadioListTile(
                  value: 5,
                  groupValue: _controller.sortValue.value,
                  contentPadding: EdgeInsets.zero,
                  onChanged: (value) {
                    // _controller.sortValue.value = int.parse(value.toString());
                    // _controller.update();
                  },
                  activeColor: COLOR.appBaseColor,
                  visualDensity: const VisualDensity(
                    horizontal: VisualDensity.minimumDensity,
                    vertical: VisualDensity.minimumDensity,
                  ),
                  title: TextWiget(
                    title: StringRes.rating,
                    style: _controller.sortValue.value == 5
                        ? Themes.light.textTheme.displayLarge
                        : Themes.light.textTheme.displaySmall,
                  ),
                  toggleable: true,
                  controlAffinity: ListTileControlAffinity.trailing,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: RadioListTile(
                  value: 6,
                  groupValue: _controller.sortValue.value,
                  contentPadding: EdgeInsets.zero,
                  visualDensity: const VisualDensity(
                    horizontal: VisualDensity.minimumDensity,
                    vertical: VisualDensity.minimumDensity,
                  ),
                  onChanged: (value) {
                    // _controller.sortValue.value = int.parse(value.toString());
                    // _controller.update();
                  },
                  activeColor: COLOR.appBaseColor,
                  title: TextWiget(
                    title: StringRes.discount,
                    style: _controller.sortValue.value == 6
                        ? Themes.light.textTheme.displayLarge
                        : Themes.light.textTheme.displaySmall,
                  ),
                  toggleable: true,
                  controlAffinity: ListTileControlAffinity.trailing,
                ),
              ),
            ],
          ),
        ),
      ),
      barrierColor: COLOR.black.withOpacity(0.8),
      isScrollControlled: true,
      backgroundColor: COLOR.background,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
    );
  }

  void openBottomSheetCategory(BuildContext context) {
    Get.bottomSheet(
      Container(
        height: MediaQuery.of(context).size.height * 0.95,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.09,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        TextWiget(
                          title: StringRes.categoryNew,
                          style: Themes.light.textTheme.displayLarge,
                        ),
                        Expanded(
                          child: AlignWidget(
                            alignment: Alignment.topRight,
                            child: IconButtonWidget(
                              voidCallback: () {
                                // Get.back();
                              },
                              icons: Icons.close,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  DividerWidget(thickness: 2),
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                DividerWidget(thickness: 2),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: TextWiget(
                          title: StringRes.products,
                        ),
                      ),
                      AlignWidget(
                        alignment: Alignment.center,
                        // child: ButtonWidgets(
                        //   color: COLOR.pink,
                        //   title: "Done",
                        //   style: Themes.light.textTheme.displayLarge!.copyWith(color: Colors.white),
                        //   padding: EdgeInsets.symmetric(horizontal: 40),
                        //   voidCallback: () => Get.back(),
                        // ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      barrierColor: COLOR.black.withOpacity(0.8),
      isScrollControlled: true,
      backgroundColor: COLOR.background,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
    );
  }

  void openBottomSheetGender(BuildContext context) {
    Get.bottomSheet(
      Container(
        height: MediaQuery.of(context).size.height * 0.35,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.09,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        TextWiget(
                          title: StringRes.genderNew,
                          style: Themes.light.textTheme.displayLarge,
                        ),
                        Expanded(
                          child: AlignWidget(
                            alignment: Alignment.topRight,
                            child: IconButtonWidget(
                              voidCallback: () {
                                Get.back();
                              },
                              icons: Icons.close,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  DividerWidget(thickness: 1),
                ],
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        CircleAvatar(
                          maxRadius: 30,
                          backgroundColor: COLOR.background,
                          backgroundImage: NetworkImage(
                              'https://s.wsj.net/public/resources/images/WW-AA663A_SANDB_M_20150928140602.jpg'),
                        ),
                        TextWiget(
                          title: StringRes.women,
                          style: Themes.light.textTheme.displayLarge,
                        )
                      ],
                    ),
                    Column(
                      children: [
                        CircleAvatar(
                          maxRadius: 30,
                          backgroundColor: COLOR.background,
                          backgroundImage: NetworkImage(
                              'https://www.bollywoodhungama.com/wp-content/uploads/2022/01/Hrithik-Roshan-adopts-a-puppy-names-him-Mowgli-on-his-birthday-eve-Varun-Dhawan-says-%E2%80%98best-decision%E2%80%99.jpeg'),
                        ),
                        TextWiget(
                          title: StringRes.men,
                          style: Themes.light.textTheme.displayLarge,
                        )
                      ],
                    ),
                    Column(
                      children: [
                        CircleAvatar(
                            maxRadius: 30,
                            backgroundColor: COLOR.background,
                            backgroundImage: NetworkImage(
                                'https://image.shutterstock.com/image-photo/pretty-curly-little-girl-standing-260nw-572774149.jpg')),
                        TextWiget(
                          title: StringRes.girls,
                          style: Themes.light.textTheme.displayLarge,
                        )
                      ],
                    ),
                    Column(
                      children: [
                        CircleAvatar(
                            maxRadius: 30,
                            backgroundColor: COLOR.background,
                            backgroundImage: NetworkImage(
                                'https://media.istockphoto.com/photos/boy-having-fun-on-studio-white-background-picture-id1069693268?k=20&m=1069693268&s=612x612&w=0&h=Mp8Jy6jOjqdeIRoCFRc6cvwbZDL89LZuHRZWfyMcRwA=')),
                        TextWiget(
                          title: StringRes.boys,
                          style: Themes.light.textTheme.displayLarge,
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DividerWidget(thickness: 1),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: TextWiget(
                          title: StringRes.products,
                        ),
                      ),
                      AlignWidget(
                        alignment: Alignment.center,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      barrierColor: COLOR.black.withOpacity(0.8),
      isScrollControlled: true,
      backgroundColor: COLOR.background,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
    );
  }

  void openBottomSheetFilter(BuildContext context) {
    Get.bottomSheet(
      Container(
        height: MediaQuery.of(context).size.height * 0.9,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.09,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        TextWiget(
                          title: StringRes.filters,
                          style: Themes.light.textTheme.displayLarge,
                        ),
                        Expanded(
                          child: AlignWidget(
                            alignment: Alignment.topRight,
                            child: IconButtonWidget(
                              voidCallback: () {
                                Get.back();
                              },
                              icons: Icons.close,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  DividerWidget(thickness: 2),
                ],
              ),
            ),
            Expanded(
              child: AlignWidget(
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Obx(
                      () => Container(
                        width: MediaQuery.of(context).size.width * 0.3,
                        child: RotatedBox(
                          quarterTurns: 1,
                          child: TabBar(
                            isScrollable: true,
                            indicatorSize: TabBarIndicatorSize.label,
                            controller: _controller.myTabController,
                            indicatorColor: COLOR.appBaseColor,
                            indicatorPadding: EdgeInsets.zero,
                            labelPadding: EdgeInsets.zero,
                            indicator: BoxDecoration(),
                            indicatorWeight: 0,
                            unselectedLabelColor: COLOR.grey,
                            onTap: (index) {
                              _controller.selectedFilterIndex.value = index;
                              _controller.update();
                            },
                            tabs: List.generate(
                              _controller.filters.length,
                              (ind) {
                                return RotatedBox(
                                  quarterTurns: -1,
                                  child: Container(
                                    color:
                                        _controller.selectedFilterIndex.value ==
                                                ind
                                            ? COLOR.background
                                            : COLOR.greyLight,
                                    height: 50,
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 5,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(5),
                                              bottomRight: Radius.circular(5),
                                            ),
                                            color: _controller
                                                        .selectedFilterIndex
                                                        .value ==
                                                    ind
                                                ? COLOR.appBaseColor
                                                : COLOR.transparent,
                                          ),
                                        ),
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.25,
                                          alignment: Alignment.centerLeft,
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 8),
                                          child: TextWiget(
                                            title: _controller.filters[ind],
                                            style: Themes
                                                .dark.textTheme.displayLarge!
                                                .copyWith(
                                              color: _controller
                                                          .selectedFilterIndex
                                                          .value ==
                                                      ind
                                                  ? COLOR.appBaseColor
                                                  : COLOR.grey,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DividerWidget(thickness: 2),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: TextWiget(
                          title: StringRes.products,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      barrierColor: COLOR.black.withOpacity(0.8),
      isScrollControlled: true,
      backgroundColor: COLOR.background,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
    );
  }

  RotatedBox filterCategory(BuildContext context, HomeController _controller) {
    return RotatedBox(
      quarterTurns: -1,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: AlignWidget(
                alignment: Alignment.centerLeft,
                child: TextWiget(
                  title: StringRes.category,
                  style: Themes.light.textTheme.displayLarge!.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  RotatedBox filterGender(HomeController _controller) {
    return RotatedBox(
      quarterTurns: -1,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: AlignWidget(
                alignment: Alignment.centerLeft,
                child: TextWiget(
                  title: StringRes.gender,
                  style: Themes.light.textTheme.displayLarge!.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  RotatedBox filterFabric(BuildContext context, HomeController _controller) {
    return RotatedBox(
      quarterTurns: -1,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: AlignWidget(
                alignment: Alignment.centerLeft,
                child: TextWiget(
                  title: StringRes.fabric,
                  style: Themes.light.textTheme.displayLarge!.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  RotatedBox filterColor(HomeController _controller) {
    return RotatedBox(
      quarterTurns: -1,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: AlignWidget(
                alignment: Alignment.centerLeft,
                child: TextWiget(
                  title: StringRes.color,
                  style: Themes.light.textTheme.displayLarge!.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  RotatedBox filterPrice(HomeController _controller) {
    return RotatedBox(
      quarterTurns: -1,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: AlignWidget(
                alignment: Alignment.centerLeft,
                child: TextWiget(
                  title: StringRes.price,
                  style: Themes.light.textTheme.displayLarge!.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  RotatedBox filterRating(HomeController _controller) {
    return RotatedBox(
      quarterTurns: -1,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: AlignWidget(
              alignment: Alignment.centerLeft,
              child: TextWiget(
                title: StringRes.rating,
                style: Themes.light.textTheme.displayLarge!.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  RotatedBox filterSize(BuildContext context, HomeController _controller) {
    return RotatedBox(
      quarterTurns: -1,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: AlignWidget(
                alignment: Alignment.centerLeft,
                child: TextWiget(
                  title: StringRes.size,
                  style: Themes.light.textTheme.displayLarge!.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            Container(
                padding: EdgeInsets.only(top: 5),
                height: MediaQuery.of(context).size.height * 0.05,
                child: InputFiledArea(
                  controller: _controller.search,
                  border: 1,
                  contentPadding: EdgeInsets.only(top: 10),
                  keyboardType: TextInputType.text,
                  hintText: StringRes.searchProduct,
                  prefixIcon: Icon(Icons.search),
                )),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(top: 5),
                alignment: Alignment.center,
              ),
            ),
          ],
        ),
      ),
    );
  }

  RotatedBox filterCombo(HomeController _controller) {
    return RotatedBox(
      quarterTurns: -1,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: AlignWidget(
              alignment: Alignment.centerLeft,
              child: TextWiget(
                title: StringRes.combo,
                style: Themes.light.textTheme.displayLarge!.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                padding: EdgeInsets.only(top: 5),
                alignment: Alignment.center,
              ),
            ),
          ),
        ],
      ),
    );
  }

  RotatedBox _bottomwerFabric(HomeController _controller) {
    return RotatedBox(
      quarterTurns: -1,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: AlignWidget(
              alignment: Alignment.centerLeft,
              child: TextWiget(
                title: StringRes.bottomwearFabric,
                style: Themes.light.textTheme.displayLarge!.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                padding: EdgeInsets.only(top: 5),
                alignment: Alignment.center,
              ),
            ),
          ),
        ],
      ),
    );
  }

  RotatedBox _ornamentation(HomeController _controller) {
    return RotatedBox(
      quarterTurns: -1,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: AlignWidget(
              alignment: Alignment.centerLeft,
              child: TextWiget(
                title: StringRes.ornamentation,
                style: Themes.light.textTheme.displayLarge!.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ProfileContainer extends StatelessWidget {
  final String? title;
  final VoidCallback? voidCallback;
  final Color? color;
  final Color? bordercolor;
  final TextStyle? style;
  const ProfileContainer({
    @required this.title,
    @required this.voidCallback,
    this.style,
    this.bordercolor,
    this.color,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      child: ElevatedButton(
        child: Padding(
          padding: const EdgeInsets.all(0),
          child: FittedBox(
            child: TextWiget(
              title: title,
              style: style,
            ),
          ),
        ),
        onPressed: voidCallback,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            side: BorderSide(color: bordercolor ?? COLOR.appBaseColor),
            borderRadius: BorderRadius.circular(60),
          ),
          backgroundColor: color ?? COLOR.pinkLight,
        ),
      ),
    );
  }
}
