// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:keep_app/models/educationModel.dart';
// import 'package:keep_app/widget/appBarWidget.dart';
//
// import '../../Theme/nativeTheme.dart';
// import '../../constant/app_constant.dart';
// import '../../utils/string_res.dart';
// import '../../widget/textWidget.dart';
//
// class VideoListScreen extends StatefulWidget {
//   EducationData? blogData;
//
//   VideoListScreen({super.key, required this.blogData});
//
//   @override
//   State<VideoListScreen> createState() => _VideoState();
// }
//
// class _VideoState extends State<VideoListScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: MyCustomAppBar(
//         actionPadding: 10,
//         height: 90,
//         appbarPadding: 0,
//         elevation: 1,
//         title: TextWiget(
//           title: StringRes.orders,
//           style: Themes.light.textTheme.headlineLarge,
//         ),
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: ListView.builder(
//               padding: EdgeInsets.all(10),
//               itemCount: widget.blogData!.blogs!.length,
//               itemBuilder: (context, index) {
//                 return Column(
//                   children: [
//                     ListTile(
//                       leading: Image(
//                           image: NetworkImage(
//                               "$IMAGE_URL${widget.blogData!.blogs![index].blogImage}")),
//                       title: Text(
//                           "${widget.blogData!.blogs![index].blogTitle}"),
//                       onTap: () {
//                         // providerW!.selectIndex(index);
//                         // Navigator.pushNamed(context, 'videoLoad');
//                       },
//                     ),
//                     Divider(),
//                   ],
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:keep_app/controller/dashboardController.dart';
import 'package:keep_app/view/dashboard/dashboardScreen.dart';
import 'package:keep_app/view/home/home_screen.dart';
import 'package:keep_app/widget/dividerWidgets.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:keep_app/models/educationModel.dart';
import '../../Theme/nativeTheme.dart';
import '../../constant/app_constant.dart';
import '../../constant/colorConst.dart';
import '../../controller/homeController.dart';
import '../../models/productModel.dart';
import '../../widget/categoryWidget.dart';
import '../../widget/productWidget.dart';
import '../../widget/textWidget.dart';
import '../../widget/appBarWidget.dart';
import '../../utils/string_res.dart';

class VideoListScreen extends StatefulWidget {
  final Blogs? blogData;

  const VideoListScreen({super.key, required this.blogData});

  @override
  State<VideoListScreen> createState() => _VideoListScreenState();
}

class _VideoListScreenState extends State<VideoListScreen> {
  late YoutubePlayerController _youtubeController;
  String? selectedVideoUrl;
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    if (widget.blogData!.blogLink!.isNotEmpty) {
      selectedVideoUrl = widget.blogData!.blogLink!.trim();
      _initializeYoutubePlayer(selectedVideoUrl!);
    }
  }

  void _initializeYoutubePlayer(String url) {
    final videoId = YoutubePlayer.convertUrlToId(url) ?? "";
    _youtubeController = YoutubePlayerController(
      initialVideoId: videoId,
      flags: YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
        // autoPlay: false,
        // mute: false,
        enableCaption: true,
        controlsVisibleAtStart: true,
        isLive: false,
        forceHD: false,
        hideControls: false,
        disableDragSeek: false,
        loop: false,
        showLiveFullscreenButton: true,
      ),
    );
  }

  @override
  void dispose() {
    _youtubeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(
        player: YoutubePlayer(
          controller: _youtubeController,
          showVideoProgressIndicator: true,
          progressIndicatorColor: Colors.red,
          onEnded: (metaData) {
            _youtubeController.pause();
          },
        ),
        builder: (context, player) {
          return WillPopScope(
            onWillPop: () async {
              DashboardController controller = Get.find();
              controller.tabIndex = 1;
              Get.offAll(DashboardScreen(pageIndex: 1));
              return false;
            },
            child: Scaffold(
              backgroundColor: COLOR.background,
              appBar: MyCustomAppBar(
                actionPadding: 10,
                height: 90,
                appbarPadding: 0,
                elevation: 1,
                title: TextWiget(
                  title: widget.blogData!.blogTitle,
                  style: Themes.light.textTheme.headlineLarge,
                ),
              ),
              body: ListView(
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: MediaQuery.sizeOf(context).height * 0.32,
                    child:
                        selectedVideoUrl != null && _youtubeController != null
                            ? YoutubePlayer(
                                controller: _youtubeController,
                                showVideoProgressIndicator: true,
                                progressIndicatorColor: Colors.red,
                                onEnded: (metaData) {
                                  _youtubeController
                                      .pause(); // Pause when video ends
                                },
                              )
                            : Image.network(
                                "$IMAGE_URL${widget.blogData!.blogImage}",
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height: double.infinity,
                                errorBuilder: (context, error, stackTrace) =>
                                    const Icon(
                                  Icons.error,
                                  size: 50,
                                  color: Colors.grey,
                                ),
                              ),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.all(10.0),
                  //   child: Column(
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     children: [
                  //       Text(
                  //         "Symptones",
                  //         style: TextStyle(
                  //             fontWeight: FontWeight.w600, fontSize: 20),
                  //       ),
                  //       Padding(
                  //         padding: const EdgeInsets.all(8.0),
                  //         child: Text(
                  //           " • ${widget.blogData!.blogDescription}",
                  //           style: TextStyle(
                  //               fontSize: 15,
                  //               decorationStyle: TextDecorationStyle.dotted,color: Colors.black87),
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  // Padding(
                  //   padding: const EdgeInsets.all(1.0),
                  //   child: Text(
                  //     "Suggested Product",
                  //     style: TextStyle(fontWeight: FontWeight.w500, fontSize: 22),
                  //   ),
                  // ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0,vertical: 2),
                    child: DividerWidget(thickness: 0.6,),
                  ),
                  // Divider(height: 1),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          StringRes.description,
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 20),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            " • ${widget.blogData!.blogDescription}",
                            style: TextStyle(
                                fontSize: 15,
                                decorationStyle: TextDecorationStyle.dotted,color: Colors.black87),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.all(1.0),
                  //   child: Text(
                  //     "Suggested Product",
                  //     style: TextStyle(fontWeight: FontWeight.w500, fontSize: 22),
                  //   ),
                  // ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0,vertical: 2),
                    child: DividerWidget(thickness: 0.6,),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.all(4.0),
                  //   child: Divider(color: Colors.black12,thickness: 1.5,),
                  // ),
                  // SizedBox(height: 10,),
                  GetBuilder<HomeController>(builder: (controller) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            StringRes.suggestedProduct,
                            // "Suggested Product",
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 20),
                          ),
                        ),
                        // SizedBox(height: 10,),
                        if ((widget.blogData?.products?.isNotEmpty ?? false))
                          Container(
                            // margin: EdgeInsets.symmetric(horizontal: 10),
                            height: MediaQuery.sizeOf(context).height * 0.5,
                            // 👈 Set height based on your design
                            child: ListView.builder(
                              // padding: EdgeInsets.symmetric(horizontal: 10),
                              scrollDirection: Axis.horizontal,
                              itemCount: widget.blogData?.products?.length ?? 0,
                              itemBuilder: (context, index) {
                                final products = widget.blogData!
                                    .products![index]; // Type: Products
                                final productModel = ProductModel.fromJson(
                                    products.toJson()); // 🔄 Converted

                                return  Column(
                                  children: [
                                widget.blogData!.products!.isNotEmpty ? Container(
                                        margin:
                                            EdgeInsets.symmetric(horizontal: 10),
                                        child: ProductComponent(
                                            products: productModel))
                               : Text("No Product Found"),
                                  ],
                                ) ;
                                    // : Text("No Product Found");
                                // return Padding(
                                //   padding: const EdgeInsets.only(right: 10.0),
                                //   child: CategoryComponent(
                                //     categoryModel: controller.categoryList[index],
                                //   ),
                                // );
                              },
                            ),
                          ),
                      ],
                    );
                  })

                  // GetBuilder<HomeController>(builder: (controller) {
                  //   return  Column(
                  //     children: [
                  //       ListView.builder(
                  //         scrollDirection: Axis.horizontal,
                  //         // shrinkWrap: true,
                  //         // physics: NeverScrollableScrollPhysics(),
                  //         // gridDelegate:
                  //         // SliverGridDelegateWithFixedCrossAxisCount(
                  //         //   crossAxisCount: 3,
                  //         //   childAspectRatio: 1.6 / 2,
                  //         // ),
                  //         itemCount:
                  //         controller.categoryList.length,
                  //         itemBuilder: (context, index) {
                  //           return Padding(
                  //             padding: const EdgeInsets.only(
                  //                 right: 10.0),
                  //             child: CategoryComponent(
                  //                 categoryModel: controller
                  //                     .categoryList[index]),
                  //           );
                  //         },
                  //       ),
                  //     ],
                  //   );
                  //   //   SliverToBoxAdapter(
                  //   //   child: Column(
                  //   //     children: [
                  //   //       Container(
                  //   //         color: Color(0xFFF5E6F5),
                  //   //         // Light purple/pink background similar to screenshot
                  //   //         // padding: EdgeInsets.all(8.0),
                  //   //         padding: EdgeInsets.only(
                  //   //             top: 0, left: 8.0, right: 8.0, bottom: 8.0),
                  //   //         // Adjusted padding, reduced top padding
                  //   //
                  //   //         // color: Colors.amber,
                  //   //         child: GridView.builder(
                  //   //           itemCount: controller.productList.length,
                  //   //           shrinkWrap: true,
                  //   //           physics: NeverScrollableScrollPhysics(),
                  //   //           gridDelegate:
                  //   //           SliverGridDelegateWithFixedCrossAxisCount(
                  //   //             crossAxisCount: 2,
                  //   //             childAspectRatio: 0.78,
                  //   //             // Adjust based on your height/width ratio
                  //   //             crossAxisSpacing: 8.0,
                  //   //             // mainAxisSpacing: 8.0,
                  //   //             // crossAxisCount: 2,
                  //   //             // childAspectRatio: 1 / 1.8,
                  //   //           ),
                  //   //           itemBuilder: (context, index) {
                  //   //             final products = controller.productList[index];
                  //   //             return ProductComponent(products: products);
                  //   //           },
                  //   //
                  //   //           // delegate: SliverChildBuilderDelegate(
                  //   //           //   (context, index) {
                  //   //           //     final products = controller.productList[index];
                  //   //           //     return ProductComponent(products: products);
                  //   //           //   },
                  //   //           //   childCount: controller.productList.length,
                  //   //           // ),
                  //   //           // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  //   //           //   crossAxisCount: 2,
                  //   //           //   childAspectRatio: 1 / 1.4,
                  //   //           //   crossAxisSpacing: 2,
                  //   //           //   mainAxisSpacing: 2,
                  //   //           // ),
                  //   //         ),
                  //   //       ),
                  //   //     ],
                  //   //   ),
                  //   // );
                  // })

                  // Expanded(
                  //   child: ListView.builder(
                  //     padding: const EdgeInsets.all(10),
                  //     itemCount: widget.blogData!.length,
                  //     itemBuilder: (context, index) {
                  //       final blog = widget.educationData!.blogs![index];
                  //       return Column(
                  //         children: [
                  //           ListTile(
                  //             selected: selectedIndex == index,
                  //             selectedTileColor: Colors.grey.shade200,
                  //             leading: Image.network(
                  //               "$IMAGE_URL${blog.blogImage}",
                  //               width: 60,
                  //               height: 60,
                  //               fit: BoxFit.cover,
                  //               errorBuilder: (_, __, ___) => const Icon(Icons.error),
                  //             ),
                  //             title: Text(blog.blogTitle ?? ''),
                  //             onTap: () {
                  //               final newUrl = blog.blogDescription!.trim();
                  //               final newVideoId =
                  //                   YoutubePlayer.convertUrlToId(newUrl) ?? "";
                  //
                  //               if (newVideoId.isNotEmpty) {
                  //                 _youtubeController.load(newVideoId);
                  //                 setState(() {
                  //                   selectedVideoUrl = newUrl;
                  //                   selectedIndex = index;
                  //                 });
                  //               }
                  //             },
                  //           ),
                  //           const Divider(),
                  //         ],
                  //       );
                  //     },
                  //   ),
                  // ),
                ],
              ),
            ),
          );
        });
  }
}
