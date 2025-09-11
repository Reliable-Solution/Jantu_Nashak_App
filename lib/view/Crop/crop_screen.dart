// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:keep_app/widget/appBarWidget.dart';
//
// import '../../Theme/nativeTheme.dart';
// import '../../constant/app_constant.dart';
// import '../../constant/colorConst.dart';
// import '../../controller/homeController.dart';
// import '../../utils/string_res.dart';
// import '../../widget/textWidget.dart';
// import '../video_player/video_list_screen.dart';
//
// class CropScreen extends StatefulWidget {
//   const CropScreen({super.key});
//
//   @override
//   State<CropScreen> createState() => _CropScreenState();
// }
//
// class _CropScreenState extends State<CropScreen> {
//   final HomeController _controller = Get.put(HomeController());
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     // _controller.getEducationData();
//     // print("educationList length   1 ${_controller.educationList.length}");
//     super.initState();
//     _controller.getEducationData();
//     debugPrint(
//         "educationList length init: ${_controller.educationList.length}");
//
//     // print("educationList length   1 ${_controller.educationList.length}");
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     print("educationList length ${_controller.educationList.length}");
//     return Scaffold(
//       backgroundColor: COLOR.background,
//       appBar: MyCustomAppBar(
//         leading: SizedBox(),
//         actionPadding: 10,
//         height: 90,
//         appbarPadding: 0,
//         elevation: 1,
//         title: TextWiget(
//           title: "Krushi Book",
//           style: Themes.light.textTheme.headlineLarge,
//         ),
//       ),
//       // appBar: MyCustomAppBar(
//       //   height: height,
//       // ),
//       body: GetBuilder<HomeController>(
//         builder: (_controller) {
//           debugPrint(
//               "educationList length build: ${_controller.educationList.length}");
//           print("educationList length ${_controller.educationList.length}");
//
//           if (_controller.educationList.isEmpty) {
//             return Center(child: CircularProgressIndicator());
//           }
//           if (_controller.educationList.isEmpty) {
//             return const Center(child: Text('No data available'));
//           }
//           return
//               //   Column(
//               //   children: [
//               //     Padding(
//               //       padding: const EdgeInsets.all(10),
//               //       child: Row(
//               //         children: [
//               //           Expanded(
//               //             child: TextFormField(
//               //               controller: _controller.searchController,
//               //               textInputAction: TextInputAction.search,
//               //               cursorColor: COLOR.appBaseColor,
//               //               decoration: InputDecoration(
//               //                 hintText: StringRes.searchHere,
//               //                 hintStyle: const TextStyle(fontSize: 13),
//               //                 border: OutlineInputBorder(
//               //                   borderRadius: BorderRadius.circular(6),
//               //                   borderSide: BorderSide.none,
//               //                 ),
//               //                 filled: true,
//               //                 fillColor: Colors.white,
//               //               ),
//               //               onFieldSubmitted: (value) {
//               //                 _controller.searchBlogsApi(value.trim());
//               //               },
//               //             ),
//               //           ),
//               //           const SizedBox(width: 8),
//               //           GestureDetector(
//               //             onTap: () {
//               //               _controller.searchBlogsApi(_controller.searchController.text.trim());
//               //             },
//               //             child: Container(
//               //               padding: const EdgeInsets.all(12),
//               //               decoration: BoxDecoration(
//               //                 color: COLOR.appBaseColor,
//               //                 borderRadius: BorderRadius.circular(8),
//               //               ),
//               //               child: const Icon(Icons.search, color: Colors.white),
//               //             ),
//               //           ),
//               //         ],
//               //       ),
//               //     ),
//               //     Expanded(
//               //       child: Obx(() {
//               //         if (_controller.isBlogSearching.value) {
//               //           return Center(child: CircularProgressIndicator());
//               //         }
//               //
//               //         final query = _controller.searchController.text;
//               //
//               //         if (query.isNotEmpty) {
//               //           if (_controller.searchBlogs.isEmpty) {
//               //             return Center(child: Text("No blogs found"));
//               //           }
//               //           return ListView.builder(
//               //             itemCount: _controller.searchBlogs.length,
//               //             itemBuilder: (context, index) {
//               //               final blog = _controller.searchBlogs[index];
//               //               return Card(
//               //                 margin: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
//               //                 child: ListTile(
//               //                   leading: Image.network(
//               //                     "https://staging-jantunashak.reliablesolution.in/upload/${blog.blogImage}",
//               //                     width: 60,
//               //                     height: 60,
//               //                     fit: BoxFit.cover,
//               //                     errorBuilder: (_, __, ___) => Icon(Icons.image),
//               //                   ),
//               //                   title: Text(blog.blogTitle ?? ""),
//               //                   subtitle: Text(blog.blogDescription ?? ""),
//               //                   onTap: () {
//               //                     Get.to(
//               //                       VideoListScreen(blogData: blog),
//               //                       transition: Transition.rightToLeftWithFade,
//               //                     );
//               //                   },
//               //                 ),
//               //               );
//               //             },
//               //           );
//               //         }
//               //
//               //         // Default education list
//               //         return ListView.builder(
//               //           itemCount: _controller.educationList.length,
//               //           itemBuilder: (context, index) {
//               //             final category = _controller.educationList[index];
//               //             return Column(
//               //               crossAxisAlignment: CrossAxisAlignment.start,
//               //               children: [
//               //                 Padding(
//               //                   padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
//               //                   child: Text(
//               //                     category.educationalCategoryName ?? "",
//               //                     style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//               //                   ),
//               //                 ),
//               //                 SizedBox(
//               //                   height: 180,
//               //                   child: ListView.builder(
//               //                     scrollDirection: Axis.horizontal,
//               //                     itemCount: category.blogs?.length ?? 0,
//               //                     itemBuilder: (context, i) {
//               //                       final blog = category.blogs![i];
//               //                       return InkWell(
//               //                         onTap: () {
//               //                           Get.to(
//               //                             VideoListScreen(blogData: blog),
//               //                             transition: Transition.rightToLeftWithFade,
//               //                           );
//               //                         },
//               //                         child: SizedBox(
//               //                           width: MediaQuery.of(context).size.width * 0.38,
//               //                           child: Card(
//               //                             color: Colors.amber,
//               //                             child: ClipRRect(
//               //                               borderRadius: BorderRadius.circular(5),
//               //                               child: Image.network(
//               //                                 "https://staging-jantunashak.reliablesolution.in/upload/${blog.blogImage}",
//               //                                 fit: BoxFit.cover,
//               //                                 errorBuilder: (_, __, ___) => Icon(Icons.error),
//               //                               ),
//               //                             ),
//               //                           ),
//               //                         ),
//               //                       );
//               //                     },
//               //                   ),
//               //                 ),
//               //               ],
//               //             );
//               //           },
//               //         );
//               //       }),
//               //     ),
//               //   ],
//               // );
//
//               Column(
//             children: [
//               Padding(
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: 8.0, vertical: 15),
//                 child: Container(
//                   height: 60,
//                   padding: const EdgeInsets.symmetric(horizontal: 20),
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(15),
//                     boxShadow: const [
//                       BoxShadow(
//                           color: Colors.black12,
//                           blurRadius: 6,
//                           offset: Offset(0, 2))
//                     ],
//                   ),
//                   child: Row(
//                     children: [
//                       Expanded(
//                         child: TextFormField(
//                           controller: _controller.searchBlogController,
//                           textInputAction: TextInputAction.search,
//                           // style: GoogleFonts.lato(color: COLOR.appBaseColor),
//                           cursorColor: COLOR.appBaseColor,
//                           decoration: InputDecoration(
//                             hintText: StringRes.searchHere,
//                             hintStyle: const TextStyle(fontSize: 13),
//                             border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(6.0),
//                               borderSide: BorderSide.none,
//                             ),
//                             filled: true,
//                             fillColor: Colors.white,
//                           ),
//                           onFieldSubmitted: (value) {
//                             _controller.searchBlogsApi(value.trim());
//                           },
//                           // onChanged: controller.searchCategory,
//                         ),
//                       ),
//                       GestureDetector(
//                         onTap: () => _controller.searchBlogsApi(
//                             _controller.searchBlogController.text),
//                         child: const Icon(Icons.search, color: Colors.black87),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               Expanded(child: Obx(() {
//                 if (_controller.isBlogSearching.value) {
//                   return Center(child: CircularProgressIndicator());
//                 }
//
//                 final query = _controller.searchBlogController.text;
//
//                 if (query.isNotEmpty) {
//                   if (_controller.searchBlogs.isEmpty) {
//                     return Center(child: Text("No blogs found"));
//                   }
//                   return ListView.builder(
//                     itemCount: _controller.searchBlogs.length,
//                     itemBuilder: (context, index) {
//                       final blogData = _controller.searchBlogs[index];
//                       return InkWell(
//                         onTap: () {
//                           Get.to(
//                             VideoListScreen(blogData: blogData),
//                             transition: Transition.rightToLeftWithFade,
//                           );
//                         },
//                         child: SizedBox(
//                           width: MediaQuery.of(context).size.width * 0.38,
//                           child: Card(
//                             color: Colors.amber,
//                             child: ClipRRect(
//                               borderRadius: BorderRadius.circular(5),
//                               child: Image.network(
//                                 "https://staging-jantunashak.reliablesolution.in/upload/${blogData.blogImage}",
//                                 fit: BoxFit.cover,
//                                 errorBuilder: (_, __, ___) => Icon(Icons.error),
//                               ),
//                             ),
//                           ),
//                         ),
//                       );
//                     },
//                   );
//
//                   //   Card(
//                   //   margin:
//                   //       EdgeInsets.symmetric(horizontal: 10, vertical: 6),
//                   //   child: ListTile(
//                   //     leading: Image.network(
//                   //       "https://staging-jantunashak.reliablesolution.in/upload/${blog.blogImage}",
//                   //       width: 60,
//                   //       height: 60,
//                   //       fit: BoxFit.cover,
//                   //       errorBuilder: (_, __, ___) => Icon(Icons.image),
//                   //     ),
//                   //     title: Text(blog.blogTitle ?? ""),
//                   //     subtitle: Text(blog.blogDescription ?? ""),
//                   //     onTap: () {
//                   //       Get.to(
//                   //         VideoListScreen(blogData: blog),
//                   //         transition: Transition.rightToLeftWithFade,
//                   //       );
//                   //     },
//                   //   ),
//                   // );
//                   // },
//                   // );
//                 }
//
//                 return ListView.builder(
//                   itemCount: _controller.educationList.length,
//                   scrollDirection: Axis.vertical,
//                   itemBuilder: (context, index) {
//                     print(
//                         "educationList length name length ${_controller.educationList.length}");
//                     print(
//                         "educationList length name ${_controller.educationList[index].educationalCategoryName}");
//                     final category = _controller.educationList[index];
//                     return Container(
//                       padding: const EdgeInsets.symmetric(
//                           horizontal: 10, vertical: 12),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             "${category.educationalCategoryName ?? 'No Name'}",
//                             style: const TextStyle(
//                               fontSize: 18,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                           // Divider(endIndent: 120,thickness: 2,),
//                           // Text("Education Data ${_controller.educationList[index].educationalCategoryName}"),
//                           SizedBox(
//                             height: 180, // Fixed height for each row
//                             child: category.blogs == null ||
//                                     category.blogs!.isEmpty
//                                 ? const Center(
//                                     child: Text('No blogs available'))
//                                 : ListView.builder(
//                                     scrollDirection: Axis.horizontal,
//                                     itemCount: category.blogs!.length,
//                                     itemBuilder: (context, index) {
//                                       print(
//                                           "educationList length ${_controller.educationList.length}");
//                                       final products = category.blogs![index];
//                                       return InkWell(
//                                         onTap: () {
//                                           Get.to(
//                                             VideoListScreen(blogData: products),
//                                             transition:
//                                                 Transition.rightToLeftWithFade,
//                                           );
//                                         },
//                                         child: SizedBox(
//                                           height: MediaQuery.sizeOf(context)
//                                                   .height *
//                                               0.15,
//                                           width: MediaQuery.sizeOf(context)
//                                                   .width *
//                                               0.38, // Fixed width for each card
//                                           child: Card(
//                                             color: Colors.amber,
//                                             // shape: RoundedRectangleBorder(
//                                             //     borderRadius: BorderRadius.circular(10)),
//                                             elevation: 2,
//                                             child: ClipRRect(
//                                               borderRadius: BorderRadius.all(
//                                                   Radius.circular(05)),
//                                               child: Image.network(
//                                                 '$IMAGE_URL${products.blogImage}',
//                                                 // [index]['image']!,
//                                                 fit: BoxFit.cover,
//                                                 errorBuilder: (_, __, ___) =>
//                                                     Icon(Icons.error),
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                       );
//                                     },
//                                   ),
//                           ),
//                         ],
//                       ),
//                     );
//
//                     // Text("Education Data ${_controller.educationList[index].educationalCategoryName}");
//                   },
//                   // child: ListView.builder(
//                   //   scrollDirection: Axis.horizontal,
//                   //   itemCount: _controller.educationList.length,
//                   //   itemBuilder: (context, index) {
//                   //     print(
//                   //         "educationList length ${_controller.educationList.length}");
//                   //     final products = _controller.educationList[index];
//                   //     return SizedBox(
//                   //       width: 150, // Fixed width for each card
//                   //
//                   //       child: Card(
//                   //         color: Colors.amber,
//                   //         shape: RoundedRectangleBorder(
//                   //             borderRadius: BorderRadius.circular(10)),
//                   //         elevation: 4,
//                   //         child: Column(
//                   //           crossAxisAlignment: CrossAxisAlignment.stretch,
//                   //           children: [
//                   //             Expanded(
//                   //               flex: 7,
//                   //               child: ClipRRect(
//                   //                 borderRadius:
//                   //                     BorderRadius.vertical(top: Radius.circular(10)),
//                   //                 child: Image.network(
//                   //                   '$IMAGE_URL${products.educationalCategoryImage}',
//                   //                   // [index]['image']!,
//                   //                   fit: BoxFit.cover,
//                   //                   errorBuilder: (_, __, ___) => Icon(Icons.error),
//                   //                 ),
//                   //               ),
//                   //             ),
//                   //             Expanded(
//                   //               flex: 3,
//                   //               child: Center(
//                   //                 child: Text(
//                   //                   products.educationalCategoryName!,
//                   //                   // diseaseList[index]['name']!,
//                   //                   style: TextStyle(
//                   //                       fontSize: 16, fontWeight: FontWeight.w500),
//                   //                 ),
//                   //               ),
//                   //             ),
//                   //           ],
//                   //         ),
//                   //       ),
//                   //     );
//                   //   },
//                   // ),
//                   // ),
//                 );
//               }))
//             ],
//           );
//         },
//       ),
//     );
//   }
// }

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:keep_app/widget/appBarWidget.dart';

import '../../Theme/nativeTheme.dart';
import '../../constant/app_constant.dart';
import '../../constant/colorConst.dart';
import '../../controller/homeController.dart';
import '../../utils/string_res.dart';
import '../../widget/textWidget.dart';
import '../video_player/video_list_screen.dart';

class CropScreen extends StatefulWidget {
  const CropScreen({super.key});

  @override
  State<CropScreen> createState() => _CropScreenState();
}

class _CropScreenState extends State<CropScreen> {
  final HomeController _controller = Get.find();

  @override
  void initState() {
    super.initState();
    _controller.getEducationData();
    debugPrint(
        "educationList length init: ${_controller.educationList.length}");
  }

  @override
  Widget build(BuildContext context) {
    print("educationList length ${_controller.educationList.length}");
    return Scaffold(
      backgroundColor: COLOR.background,
      appBar: MyCustomAppBar(
        leading: SizedBox(),
        actionPadding: 10,
        height: 90,
        appbarPadding: 0,
        elevation: 1,
        title: TextWiget(
          title: StringRes.krushiBook,
          style: Themes.light.textTheme.headlineLarge,
        ),
      ),
      body: GetBuilder<HomeController>(
        builder: (_controller) {
          debugPrint(
              "educationList length build: ${_controller.educationList.length}");
          print("educationList length ${_controller.educationList.length}");

          if (_controller.educationList.isEmpty) {
            return Center(child: CircularProgressIndicator());
          }
          final query = _controller.searchBlogController.text.trim();
          return Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 15),
                child: Container(
                  height: 60,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.black12,
                          blurRadius: 6,
                          offset: Offset(0, 2))
                    ],
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child:
                            // Obx(() {
                            //   final query = _controller.searchBlogController.text.trim();
                            //   return
                            GetBuilder<HomeController>(
                              builder: (controller) => TextFormField(
                                                        controller: controller.searchBlogController,
                                                        textInputAction: TextInputAction.search,
                                                        cursorColor: COLOR.appBaseColor,
                                                        onChanged: (value) {
                              controller.searchBlogsApi(value.trim());
                                                        },
                                                        decoration: InputDecoration(
                              hintText: StringRes.searchHere,
                              hintStyle: const TextStyle(fontSize: 13),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(6),
                                borderSide: BorderSide.none,
                              ),
                              filled: true,
                              fillColor: Colors.white,
                              suffixIcon: query.isNotEmpty && _controller.searchBlogs.isNotEmpty
                                  ?
                              GetBuilder<HomeController>(
                                builder: (context) {
                                  return IconButton(
                                          icon: const Icon(Icons.clear),
                                          onPressed: () {
                                            // controller.searchBlogController.clear();
                                            controller.searchBlogsApi('');
                                            controller.searchBlogController.clear();
                                            setState(() {

                                            });
                                          },
                                        );
                                }
                              )
                                  : null,
                                                        ),
                                                      ),
                            ),
                        // }),
                      ),
                      GestureDetector(
                        onTap: () => _controller.searchBlogsApi(
                            _controller.searchBlogController.text.trim()),
                        child: const Icon(Icons.search, color: Colors.black87),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Obx(() {
                  if (_controller.isBlogSearching.value) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  final query = _controller.searchBlogController.text.trim();

                  if (query.isNotEmpty) {
                    if (_controller.searchBlogs.isEmpty) {
                      return  Center(child: Text(StringRes.noDataFound));
                    }
                    return GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2),
                      itemCount: _controller.searchBlogs.length,
                      itemBuilder: (context, index) {
                        final blogData = _controller.searchBlogs[index];
                        return Container(
                          // height: ,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 12),
                          child: Column(
                            // crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Text(
                              //   "${blogData.educationalCategoryName ?? 'No Name'}",
                              //   style: const TextStyle(
                              //     fontSize: 18,
                              //     fontWeight: FontWeight.bold,
                              //   ),
                              // ),
                              SizedBox(
                                height: 120,
                                // Fixed height for each row
                                child:
                                // _controller.searchBlogs == null ||
                                //         _controller.searchBlogs.isEmpty
                                //     ? const Center(
                                //         child: Text('No blogs available'))
                                //     :
                                InkWell(
                                        onTap: () {
                                          Get.to(
                                            VideoListScreen(
                                                blogData: _controller
                                                    .searchBlogs[index]),
                                            transition:
                                                Transition.rightToLeftWithFade,
                                          );
                                        },
                                        child: SizedBox(
                                          height: MediaQuery.sizeOf(context)
                                                  .height *
                                              .01,
                                          width: MediaQuery.sizeOf(context)
                                                  .width *
                                              0.2, // Fixed width for each card
                                          child: Card(
                                            color: Colors.amber,
                                            elevation: 2,
                                            child: ClipRRect(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(5)),
                                              child: Image.network(
                                                '$IMAGE_URL${blogData.blogImage}',
                                                fit: BoxFit.cover,
                                                errorBuilder: (_, __, ___) =>
                                                    const Icon(Icons.error),
                                              ),
                                            ),
                                          ),
                                        ),
                                        // ListView.builder(
                                        //   scrollDirection: Axis.vertical,
                                        //   itemCount: _controller.searchBlogs!.length,
                                        //   itemBuilder: (context, i) {
                                        //     print(
                                        //         "educationList length ${_controller.educationList.length}");
                                        //     final blog =  _controller.searchBlogs![index];
                                        //     return
                                        //
                                        //       InkWell(
                                        //       onTap: () {
                                        //         Get.to(
                                        //           VideoListScreen(blogData: _controller.searchBlogs[index]),
                                        //           transition: Transition
                                        //               .rightToLeftWithFade,
                                        //         );
                                        //       },
                                        //       child: SizedBox(
                                        //         height: MediaQuery.sizeOf(context)
                                        //             .height *
                                        //             .09,
                                        //         width: MediaQuery.sizeOf(context)
                                        //             .width *
                                        //             0.2, // Fixed width for each card
                                        //         child: Card(
                                        //           color: Colors.amber,
                                        //           elevation: 2,
                                        //           child: ClipRRect(
                                        //             borderRadius:
                                        //             const BorderRadius.all(
                                        //                 Radius.circular(5)),
                                        //             child: Image.network(
                                        //               '$IMAGE_URL${blog.blogImage}',
                                        //               fit: BoxFit.cover,
                                        //               errorBuilder:
                                        //                   (_, __, ___) =>
                                        //               const Icon(
                                        //                   Icons.error),
                                        //             ),
                                        //           ),
                                        //         ),
                                        //       ),
                                        //     );
                                      ),
                              ),
                            ],
                          ),
                        );
                        //   Card(
                        //   margin: const EdgeInsets.symmetric(
                        //       horizontal: 10, vertical: 6),
                        //   child: ListTile(
                        //     leading: Image.network(
                        //       "https://staging-jantunashak.reliablesolution.in/resources/images/"
                        //       // "https://staging-jantunashak.reliablesolution.in/upload/"
                        //           "${blogData.blogImage}",
                        //       width: 60,
                        //       height: 60,
                        //       fit: BoxFit.cover,
                        //       errorBuilder: (_, __, ___) =>
                        //       const Icon(Icons.image),
                        //     ),
                        //     title: Text(blogData.blogTitle ?? ""),
                        //     subtitle: Text(blogData.blogDescription ?? ""),
                        //     onTap: () {
                        //       Get.to(
                        //         VideoListScreen(blogData: blogData),
                        //         transition: Transition.rightToLeftWithFade,
                        //       );
                        //     },
                        //   ),
                        // );
                      },
                    );
                  }

                  return ListView.builder(
                    itemCount: _controller.educationList.length,
                    itemBuilder: (context, index) {
                      print(
                          "educationList length name length ${_controller.educationList.length}");
                      print(
                          "educationList length name ${_controller.educationList[index].educationalCategoryName}");
                      final category = _controller.educationList[index];
                      return Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${category.educationalCategoryName ?? 'No Name'}",
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              height: 180, // Fixed height for each row
                              child: category.blogs == null ||
                                      category.blogs!.isEmpty
                                  ? const Center(
                                      child: Text('No blogs available'))
                                  : ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: category.blogs!.length,
                                      itemBuilder: (context, i) {
                                        print(
                                            "educationList length ${_controller.educationList.length}");
                                        final blog = category.blogs![i];
                                        return InkWell(
                                          onTap: () {
                                            Get.to(
                                              VideoListScreen(blogData: blog),
                                              transition: Transition
                                                  .rightToLeftWithFade,
                                            );
                                          },
                                          child: SizedBox(
                                            height: MediaQuery.sizeOf(context)
                                                    .height *
                                                0.15,
                                            width: MediaQuery.sizeOf(context)
                                                    .width *
                                                0.38, // Fixed width for each card
                                            child: Card(
                                              color: Colors.amber,
                                              elevation: 2,
                                              child: ClipRRect(
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(5)),
                                                child: Image.network(
                                                  '$IMAGE_URL${blog.blogImage}',
                                                  fit: BoxFit.cover,
                                                  errorBuilder: (_, __, ___) =>
                                                      const Icon(Icons.error),
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                }),
              ),
            ],
          );
        },
      ),
    );
  }
}
