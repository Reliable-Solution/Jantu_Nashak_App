// flutter
import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';
import 'package:keep_app/utils/string_res.dart';
import 'package:keep_app/view/video_player/video_list_screen.dart';

import 'package:keep_app/widget/productWidget.dart';

import '../../Theme/nativeTheme.dart';
import '../../constant/app_constant.dart';
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
  Timer? _debounce; // Debounce timer for search

  @override
  Widget build(BuildContext context) {
    // print("Search Screen isSearchLoading ${homeController.isSearchLoading.value}");
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

    return SafeArea(
      top: false,
      bottom: true,
      child: Scaffold(
          appBar: MyCustomAppBar(
            actionPadding: 10,
            height: 90,
            appbarPadding: 0,
            elevation: 0,
            title: Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Container(
                // padding: EdgeInsets.only(right: 20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white),
                alignment: Alignment.centerLeft,
                child: Form(
                  child: GetBuilder<HomeController>(
                    builder: (_controller) => SizedBox(
                        height: MediaQuery.of(context).size.height * 0.05,
                        width: MediaQuery.of(context).size.width,
                        child: InputFiledArea(
                          onChanged: (p0) {
                            if (_debounce?.isActive ?? false)
                              _debounce!.cancel();
                            _debounce =
                                Timer(const Duration(milliseconds: 500), () {
                              homeController.onSearchChanged(p0);
                            });
                          },
                          keyboardType: TextInputType.text,
                          controller: _controller.searchController,
                          hintText: StringRes.searchHint,
                          contentPadding: EdgeInsets.only(top: 10, left: 10),
                          border: 1,
                          suffixIcon: Container(
                            width: 50,
                            child: Row(
                              children: [
                                VerticalDivider(
                                    thickness: 1, color: COLOR.background),
                                InkWell(
                                  onTap: () {
                                    homeController.startVoiceSearch(context);
                                  },
                                  child: Icon(
                                    Icons.mic,
                                    color: Colors.black,
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
            ),
            titleSpacing: 0,
          ),
          backgroundColor: COLOR.greyLight,
          body: SingleChildScrollView(
            child: Column(
              children: [
                GetBuilder<HomeController>(builder: (controller) {
                  print(
                      "Search Screen isSearchLoading new ${controller.isSearchLoading.value}");
                  return Column(
                    children: [
                      // Loader
                      if (controller.isSearchLoading.value)
                        const LinearProgressIndicator()
                      else
                        const SizedBox.shrink(),
                      if (controller.searchList.isEmpty &&
                          !controller.isSearchLoading.value)
                        Padding(
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
                                      style: Themes
                                          .dark.textTheme.displayMedium!
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
                                          title: "Khatma",
                                          voidCallback: () {
                                            homeController.searchController
                                                .text = "Khatma";
                                            // StringRes.saree;

                                            homeController
                                                .getSearchData(StringRes.saree);
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
                      if (!controller.isSearchLoading.value)
                        controller.searchList.isEmpty
                            ? SizedBox(
                                height: MediaQuery.sizeOf(context).height * 0.5,
                                child: Center(
                                    child: Text(StringRes.noProductsFound)),
                              )
                            : Column(
                                children: [
                                  // 🔹 Products Grid
                                  GridView.builder(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    // parent scroll karega
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      childAspectRatio: 1 / 1.4,
                                      crossAxisSpacing: 2,
                                      mainAxisSpacing: 2,
                                    ),
                                    itemCount: controller.searchList.length,
                                    itemBuilder: (context, index) {
                                      return ProductComponent(
                                        products: controller.searchList[index],
                                      );
                                    },
                                  ),

                                  // 🔹 Blog/Video Slider - ye hamesha last me aayega
                                  if (controller.blogList != null &&
                                      controller.blogList.isNotEmpty)
                                    Container(
                                      padding: EdgeInsets.symmetric(horizontal: 20),
                                      alignment:Alignment.centerLeft,
                                      child: Text(StringRes.videos,style: TextStyle(fontSize: 24,fontWeight: FontWeight.w600),),
                                    ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 15, bottom: 20),
                                    child: CarouselSlider.builder(
itemCount: controller.blogList.length,
                                     itemBuilder:  (context, index, realIndex) {
                                       final blog = controller.blogList[index];
                                       return GestureDetector(
                                         onTap: () {
                                           Get.to(VideoListScreen(blogData: blog));
                                           // TODO: video/blog link open
                                         },
                                         child: Container(
                                           width: MediaQuery.of(context)
                                               .size
                                               .width,
                                           margin:
                                           const EdgeInsets.symmetric(
                                               horizontal: 5.0),
                                           decoration: BoxDecoration(
                                             borderRadius:
                                             BorderRadius.circular(10),
                                             color: Colors.white,
                                             boxShadow: [
                                               BoxShadow(
                                                 color: Colors.grey
                                                     .withOpacity(0.5),
                                                 spreadRadius: 2,
                                                 blurRadius: 5,
                                                 offset:
                                                 const Offset(0, 3),
                                               ),
                                             ],
                                           ),
                                           child: Column(
                                             crossAxisAlignment:
                                             CrossAxisAlignment.start,
                                             children: [
                                               ClipRRect(
                                                 borderRadius:
                                                 const BorderRadius
                                                     .only(
                                                   topLeft:
                                                   Radius.circular(10),
                                                   topRight:
                                                   Radius.circular(10),
                                                 ),
                                                 child: Image.network(
                                                   IMAGE_URL + blog.blogImage! ?? "",
                                                   height: 140,
                                                   width: double.infinity,
                                                   fit: BoxFit.cover,
                                                   errorBuilder: (context,
                                                       error, stackTrace) {
                                                     return const Icon(
                                                         Icons.error);
                                                   },
                                                 ),
                                               ),
                                               Padding(
                                                 padding:
                                                 const EdgeInsets.all(
                                                     8.0),
                                                 child: TextWiget(
                                                   title: blog.blogTitle ??
                                                       '',
                                                   style: Themes
                                                       .dark
                                                       .textTheme
                                                       .bodyLarge,
                                                 ),
                                               ),
                                               Padding(
                                                 padding: const EdgeInsets
                                                     .symmetric(
                                                     horizontal: 8.0),
                                                 child: TextWiget(
                                                   title: (blog.blogDescription
                                                       ?.length ??
                                                       0) >
                                                       50
                                                       ? '${blog.blogDescription!.substring(0, 50)}...'
                                                       : (blog.blogDescription ??
                                                       ''),
                                                   style: Themes
                                                       .dark
                                                       .textTheme
                                                       .bodySmall,
                                                 ),
                                               ),
                                             ],
                                           ),
                                         ),
                                       );
                                     },
                                      options: CarouselOptions(
                                        height: 220.0,
                                        autoPlay: true,
                                        enlargeCenterPage: true,
                                        viewportFraction: 0.9,
                                      ),
                                      // itemBuilder: controller.blogList.map((blog) {
                                      //   return Builder(
                                      //     builder: (BuildContext context) {
                                      //       return GestureDetector(
                                      //         onTap: () {
                                      //           Get.to(VideoListScreen(blogData: blog));
                                      //           // TODO: video/blog link open
                                      //         },
                                      //         child: Container(
                                      //           width: MediaQuery.of(context)
                                      //               .size
                                      //               .width,
                                      //           margin:
                                      //               const EdgeInsets.symmetric(
                                      //                   horizontal: 5.0),
                                      //           decoration: BoxDecoration(
                                      //             borderRadius:
                                      //                 BorderRadius.circular(10),
                                      //             color: Colors.white,
                                      //             boxShadow: [
                                      //               BoxShadow(
                                      //                 color: Colors.grey
                                      //                     .withOpacity(0.5),
                                      //                 spreadRadius: 2,
                                      //                 blurRadius: 5,
                                      //                 offset:
                                      //                     const Offset(0, 3),
                                      //               ),
                                      //             ],
                                      //           ),
                                      //           child: Column(
                                      //             crossAxisAlignment:
                                      //                 CrossAxisAlignment.start,
                                      //             children: [
                                      //               ClipRRect(
                                      //                 borderRadius:
                                      //                     const BorderRadius
                                      //                         .only(
                                      //                   topLeft:
                                      //                       Radius.circular(10),
                                      //                   topRight:
                                      //                       Radius.circular(10),
                                      //                 ),
                                      //                 child: Image.network(
                                      //                  IMAGE_URL + blog.blogImage! ?? "",
                                      //                   height: 140,
                                      //                   width: double.infinity,
                                      //                   fit: BoxFit.cover,
                                      //                   errorBuilder: (context,
                                      //                       error, stackTrace) {
                                      //                     return const Icon(
                                      //                         Icons.error);
                                      //                   },
                                      //                 ),
                                      //               ),
                                      //               Padding(
                                      //                 padding:
                                      //                     const EdgeInsets.all(
                                      //                         8.0),
                                      //                 child: TextWiget(
                                      //                   title: blog.blogTitle ??
                                      //                       '',
                                      //                   style: Themes
                                      //                       .dark
                                      //                       .textTheme
                                      //                       .bodyLarge,
                                      //                 ),
                                      //               ),
                                      //               Padding(
                                      //                 padding: const EdgeInsets
                                      //                     .symmetric(
                                      //                     horizontal: 8.0),
                                      //                 child: TextWiget(
                                      //                   title: (blog.blogDescription
                                      //                                   ?.length ??
                                      //                               0) >
                                      //                           50
                                      //                       ? '${blog.blogDescription!.substring(0, 50)}...'
                                      //                       : (blog.blogDescription ??
                                      //                           ''),
                                      //                   style: Themes
                                      //                       .dark
                                      //                       .textTheme
                                      //                       .bodySmall,
                                      //                 ),
                                      //               ),
                                      //             ],
                                      //           ),
                                      //         ),
                                      //       );
                                      //     },
                                      //   );
                                      // }).toList(),
                                    ),
                                  ),
                                ],
                              ),

                    ],
                  );

                }),
              ],
            ),
            // ),
          )),
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
