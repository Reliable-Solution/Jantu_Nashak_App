// flutter
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';
import 'package:keep_app/utils/string_res.dart';

import 'package:keep_app/widget/productWidget.dart';

import '../../Theme/nativeTheme.dart';
import '../../constant/colorConst.dart';
import '../../controller/homeController.dart';
import '../../widget/alignWidget.dart';
import '../../widget/appBarWidget.dart';
import '../../widget/inputWidget.dart';
import '../../widget/textWidget.dart';
import '../home/widget/homeProductHeader.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key}) : super(key: key);
  final HomeController homeController = Get.find<HomeController>();

  // final HomeController homeController = Get.put(HomeController());

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
              onTap: () {
                _openGallary(context);
              },
            ),
            const Padding(padding: EdgeInsets.all(10)),
            GestureDetector(
              child: TextWiget(
                title: StringRes.camera,
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

    return Scaffold(
      appBar: MyCustomAppBar(
        actionPadding: 10,
        height: 90,
        appbarPadding: 0,
        elevation: 0,
        title: Container(
          padding: EdgeInsets.only(right: 20),
          alignment: Alignment.centerLeft,
          child: Form(
            child: GetBuilder<HomeController>(
              builder: (_controller) => SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                  width: MediaQuery.of(context).size.width,
                  child: InputFiledArea(
                    onChanged: _controller.onSearchChanged,
                    keyboardType: TextInputType.text,
                    controller: _controller.searchController,
                    hintText: StringRes.searchHint,
                    contentPadding: EdgeInsets.only(top: 10, left: 10),
                    border: 1,
                    suffixIcon: Container(
                      width: 50,
                      child: Row(
                        children: [
                          VerticalDivider(thickness: 1, color: COLOR.grey),
                          InkWell(
                            onTap: () {
                              homeController.startVoiceSearch(context);
                            },
                            child: Icon(
                              Icons.mic,
                              color: COLOR.grey,
                              size: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )),
            ),
          ),
        ),
        titleSpacing: 0,
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: Container(
            child: Icon(
              Icons.arrow_back_ios,
              color: COLOR.greyback,
              size: 20,
            ),
          ),
        ),
      ),
      backgroundColor: COLOR.greyLight,
      body: SingleChildScrollView(
        child: Column(
          children: [
            GetBuilder<HomeController>(
              builder: (controller) {
                return Column(
                  children: [
                    Visibility(
                      visible: controller.searchList.isEmpty,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          color: COLOR.background,
                          child: Container(
                            padding: EdgeInsets.all(15),
                            child: Column(
                              children: [
                                AlignWidget(
                                  alignment: Alignment.centerLeft,
                                  child: TextWiget(
                                    title: StringRes.popularSearches,
                                    style: Themes.dark.textTheme.displayMedium!
                                        .copyWith(
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  padding: EdgeInsets.only(top: 20),
                                  child: Wrap(
                                    spacing: 10.0,
                                    runSpacing: 12.0,
                                    children: [
                                      ProfileContainer(
                                        title: StringRes.saree,
                                        voidCallback: () {
                                          homeController.searchController.text =
                                              StringRes.saree;

                                          homeController
                                              .getSearchData(StringRes.saree);
                                        },
                                        color: COLOR.greyLight,
                                        bordercolor: COLOR.searchgrey,
                                      ),
                                      ProfileContainer(
                                        title: StringRes.kurti,
                                        color: COLOR.greyLight,
                                        bordercolor: COLOR.searchgrey,
                                        voidCallback: () {
                                          homeController.searchController.text =
                                              StringRes.kurti;

                                          homeController
                                              .getSearchData(StringRes.kurti);
                                        },
                                      ),
                                      ProfileContainer(
                                        title: StringRes.topsForWomen,
                                        color: COLOR.greyLight,
                                                                                                                                      bordercolor: COLOR.searchgrey,
                                        voidCallback: () {
                                          homeController.searchController.text =
                                              StringRes.topsForWomen;

                                          homeController.getSearchData(
                                              StringRes.topsForWomen);
                                        },
                                      ),
                                      ProfileContainer(
                                        title: StringRes.watch,
                                        color: COLOR.greyLight,
                                        bordercolor: COLOR.searchgrey,
                                        voidCallback: () {
                                          homeController
                                              .getSearchData(StringRes.watch);
                                        },
                                      ),
                                      ProfileContainer(
                                        title: StringRes.jewellery,
                                        voidCallback: () {
                                          homeController.searchController.text =
                                              StringRes.jewellery;

                                          homeController.getSearchData(
                                              StringRes.jewellery);
                                        },
                                        color: COLOR.greyLight,
                                        bordercolor: COLOR.searchgrey,
                                      ),
                                      ProfileContainer(
                                        title: StringRes.shoes,
                                        voidCallback: () {
                                          homeController.searchController.text =
                                              StringRes.shoes;

                                          homeController.getSearchData(
                                              StringRes.shoes);
                                        },
                                        color: COLOR.greyLight,
                                        bordercolor: COLOR.searchgrey,
                                      ),
                                      ProfileContainer(
                                        title: StringRes.sareesNewCollection,
                                        voidCallback: () {
                                          homeController.searchController.text =
                                              StringRes.sareesNewCollection;

                                          homeController.getSearchData(
                                              StringRes.sareesNewCollection);
                                        },
                                        color: COLOR.greyLight,
                                        bordercolor: COLOR.searchgrey,
                                      ),
                                      ProfileContainer(
                                        title: StringRes.smartWatch,
                                        voidCallback: () {
                                          homeController.searchController.text =
                                              StringRes.smartWatch;

                                          homeController.getSearchData(
                                              StringRes.smartWatch);
                                        },
                                        color: COLOR.greyLight,
                                        bordercolor: COLOR.searchgrey,
                                      ),
                                      ProfileContainer(
                                        title: StringRes.tShirt,
                                        voidCallback: () {
                                          homeController.searchController.text =
                                              StringRes.tShirt;

                                          homeController.getSearchData(
                                              StringRes.tShirt);
                                        },
                                        color: COLOR.greyLight,
                                        bordercolor: COLOR.searchgrey,
                                      ),
                                      ProfileContainer(
                                        title: StringRes.top,
                                        voidCallback: () {
                                          homeController.searchController.text =
                                              StringRes.top;

                                          homeController.getSearchData(
                                              StringRes.top);
                                        },
                                        color: COLOR.greyLight,
                                        bordercolor: COLOR.searchgrey,
                                      ),
                                      ProfileContainer(
                                        title: StringRes.saree,
                                        voidCallback: () {
                                          homeController.searchController.text =
                                              StringRes.saree;

                                          homeController.getSearchData(
                                              StringRes.saree);
                                        },
                                        color: COLOR.greyLight,
                                        bordercolor: COLOR.searchgrey,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    controller.isLoading.value
                        ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(child: CircularProgressIndicator()),
                    )
                        : controller.searchList.isEmpty
                        ? SizedBox(
                        height: MediaQuery.sizeOf(context).height * 0.5,
                        child: Center(
                            child: Text(StringRes.noProductsFound)))
                        : SizedBox(
                      height: MediaQuery.of(context).size.height *
                          0.9, // Ensuring proper scroll
                      child: GridView.builder(
                        gridDelegate:
                        SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          // childAspectRatio:
                          // Get.width >= 480 ? 1.15 / 2 : 1 / 2.1,
                          childAspectRatio: 1/1.4,

                          crossAxisSpacing: 2,
                          mainAxisSpacing: 2,
                        ),
                        itemCount: homeController.searchList.length,
                        itemBuilder: (context, index) {
                          return ProductComponent(
                              products:
                              homeController.searchList[index]);
                        },
                      ),
                    )
                  ],
                );
              },
            ),
            SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.01,
            ),

            // Obx(() {
            //   if(homeController.isLoading.value)
            //   {
            //     return Padding(
            //       padding: const EdgeInsets.all(8.0),
            //       child: Center(child: CircularProgressIndicator()),
            //     );
            //
            //   }
            //   else if(homeController.searchList.isEmpty)
            //   {
            //     return Center(child: Text('No products found'));
            //
            //   }
            //   return
            //     SizedBox(
            //       height: MediaQuery.of(context).size.height * 0.9, // Ensuring proper scroll
            //       child: GridView.builder(
            //         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            //           crossAxisCount: 2,
            //           childAspectRatio: Get.width >= 480 ? 1.15 / 2 : 1 / 2.1,
            //           crossAxisSpacing: 2,
            //           mainAxisSpacing: 2,
            //         ),
            //         itemCount: homeController.searchList.length,
            //         itemBuilder: (context, index) {
            //           return ProductComponent(products: homeController.searchList[index]);
            //         },
            //       ),
            //     );
            // },)
          ],
        ),
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
