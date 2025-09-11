import 'dart:math' as math;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constant/app_constant.dart';
import '../../constant/colorConst.dart';
import '../../controller/leadeController.dart';
import '../../models/MonthlyUser.dart';
import '../../models/prizeModel.dart';
import '../../utils/string_res.dart';

class LeadershipScreen extends StatefulWidget {
  const LeadershipScreen({super.key});

  @override
  State<LeadershipScreen> createState() => _LeadershipScreenState();
}

class _LeadershipScreenState extends State<LeadershipScreen>
    with SingleTickerProviderStateMixin {
  final leadershipBoardList = <Map<String, dynamic>>[].obs;
  final isLoading = false.obs;

  late AnimationController _ctrl;

  final LeaderboardController controller = Get.put(LeaderboardController());

  @override
  void initState() {
    super.initState();
    controller.fetchData();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
  }


  List<Map<String, dynamic>> _dummyList() {
    return List.generate(10, (i) {
      final rank = i + 1;
      return {
        "UsersFirstname": "User $rank",
        "LeadershippointValue": "${1000 - (rank - 1) * 50}",
        "UsersProfileImage": "",
      };
    });
  }

// late AnimationController _ctrl;

  @override
// void initState() {
//   super.initState();
//   _ctrl = AnimationController(
//     vsync: this,
//     duration: const Duration(seconds: 2),
//   )..repeat();
// }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  Widget _imageWidget(String url) {
    return SizedBox(
      width: 50,
      height: 50,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration:
            const BoxDecoration(shape: BoxShape.circle, color: Colors.black87),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: Image.network(
            "https://via.placeholder.com/150",
            fit: BoxFit.fill,
            errorBuilder: (_, __, ___) =>
                Image.asset("assets/images/profile.png"),
          ),
        ),
      ),
    );
  }

  Widget pollUIWidget(double height, int title, String name, String point,
      double opacity, String image,
      {String? prizeImage}) {
    return SizedBox(
      width: 100,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            point,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
                color: COLOR.appBaseColor),
          ),
          const SizedBox(height: 2),
          Text(
            name,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 15,
                color: COLOR.appBaseColor),
          ),
          const SizedBox(height: 2),
          _imageWidget(image),
          SizedBox(height: 5),
          Container(
            height: height,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
              color: COLOR.appBaseColor.withOpacity(opacity),
            ),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Stack(
                    children: [
                      Icon(Icons.bookmark, size: 35, color: COLOR.appBaseColor),
                      Positioned.fill(
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            title.toString(),
                            style: const TextStyle(
                                color: Colors.white, fontSize: 15),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Flexible(
                    child: Container(
                        height: 60,
                        width: 55,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
// shape:BoxShape.circle,
                          image: DecorationImage(
                              image: NetworkImage(prizeImage!
// 'https://imgd.aeplcdn.com/642x336/n/cw/ec/103183/raider-125-right-side-view-20.png?isig=0&q=80'
                                  )),
                        )),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
//   Widget build(BuildContext context) {
//     return Scaffold(
// // appBar: AppBar(
// //   backgroundColor: COLOR.appBaseColor,
// //   title: const Text('Leadership Point Detail',
// //       style: TextStyle(color: Colors.white)),
// //   leading: IconButton(
// //     icon: const Icon(Icons.arrow_back, color: Colors.white),
// //     onPressed: () => Get.back(),
// //   ),
// // ),
//         body: Obx(() => isLoading.value
//             ? const Center(child: CircularProgressIndicator())
//             : leadershipBoardList.isEmpty
//                 ? const Center(child: Text('LeaderShip Data Not Found'))
//                 : Padding(
//                     padding: const EdgeInsets.only(
//                         top: 10, left: 10, right: 10, bottom: 05
// // ,vertical: 15, horizontal: 10
//                         ),
//                     child: Column(children: [
//                       Row(
//                         crossAxisAlignment: CrossAxisAlignment.end,
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           pollUIWidget(
//                               95,
//                               2,
//                               leadershipBoardList[1]['UsersFirstname'],
//                               leadershipBoardList[1]['LeadershippointValue'],
//                               0.4,
//                               leadershipBoardList[1]['UsersProfileImage'],
//                               prizeImage:
//                                   "https://media.assettype.com/tnm/import/sites/default/files/Ola_Electric_1200.jpg?w=1200&h=675&auto=format%2Ccompress&fit=max&enlarge=true"
// // "https://www.shutterstock.com/image-photo/white-suv-car-isolated-on-260nw-2323736773.jpg"
//                               ),
//                           pollUIWidget(
//                               130,
//                               1,
//                               leadershipBoardList[0]['UsersFirstname'],
//                               leadershipBoardList[0]['LeadershippointValue'],
//                               0.5,
//                               leadershipBoardList[0]['UsersProfileImage'],
//                               prizeImage:
//                                   "https://www.shutterstock.com/image-photo/white-suv-car-isolated-on-260nw-2323736773.jpg"),
//                           pollUIWidget(
//                               75,
//                               3,
//                               leadershipBoardList[2]['UsersFirstname'],
//                               leadershipBoardList[2]['LeadershippointValue'],
//                               0.3,
//                               leadershipBoardList[2]['UsersProfileImage'],
//                               prizeImage:
//                                   "https://cdn.mos.cms.futurecdn.net/h8cTAUPU8Bs67h2RZ9qbvD.jpg"
// // "https://www.shutterstock.com/image-photo/white-suv-car-isolated-on-260nw-2323736773.jpg"
//
//                               ),
//                         ],
//                       ),
//                       const SizedBox(height: 5),
//                       Expanded(
//                         child: ListView.builder(
//                           itemCount: leadershipBoardList.length,
//                           itemBuilder: (_, index) {
//                             if (index < 3) return const SizedBox();
//                             final item = leadershipBoardList[index];
//                             return Container(
//                               padding: const EdgeInsets.symmetric(
//                                   vertical: 15, horizontal: 05),
//                               margin: const EdgeInsets.symmetric(
//                                   vertical: 08, horizontal: 5),
//                               decoration: BoxDecoration(
//                                 color: COLOR.appBaseColor.withOpacity(0.2),
//                                 borderRadius: BorderRadius.circular(10),
//                               ),
//                               child: Row(
// // mainAxisAlignment:
// //     MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   Container(
//                                     child: Text(
//                                       "${(index + 1).toString()}.",
//                                       style: const TextStyle(
//                                           color: Colors.black87),
//                                     ),
//                                     margin: EdgeInsets.all(06),
//                                   ),
// // Stack(
// //   children: [
// //     // Image(
// //     //     image: NetworkImage(
// //     //         'https://imgd.aeplcdn.com/642x336/n/cw/ec/103183/raider-125-right-side-view-20.png?isig=0&q=80')),
// //      Icon(Icons.bookmark,
// //         size: 35, color: COLOR.appBaseColor),
// //     Positioned.fill(
// //       child: Align(
// //         alignment: Alignment.center,
// //         child: Text(
// //           (index + 1).toString(),
// //           style: const TextStyle(
// //               color: Colors.white),
// //         ),
// //       ),
// //     ),
// //   ],
// // ),
//                                   Row(
//                                     children: [
//                                       _imageWidget(item['UsersProfileImage']),
//                                       const SizedBox(width: 10),
//                                       Column(
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.start,
//                                         children: [
//                                           Text(item['UsersFirstname'],
//                                               style: const TextStyle(
//                                                   fontWeight: FontWeight.w500)),
//                                           const SizedBox(height: 5),
//                                           Text(item['LeadershippointValue'],
//                                               style: const TextStyle(
//                                                   fontWeight: FontWeight.bold)),
//                                         ],
//                                       ),
//                                     ],
//                                   ),
//                                   Spacer(),
// // Container(decoration: BoxDecoration(image: DecorationImage(image: image)),)
//                                   Container(
//                                       height: 50,
//                                       width: 55,
//                                       decoration: BoxDecoration(
//                                         shape: BoxShape.circle,
//                                         image: DecorationImage(
//                                             image: NetworkImage(
//                                           'https://5.imimg.com/data5/SELLER/Default/2022/9/RJ/VD/FR/113915368/head-phone.jpg',
// // 'https://imgd.aeplcdn.com/642x336/n/cw/ec/103183/raider-125-right-side-view-20.png?isig=0&q=80')),
//                                         )),
// // Stack(
// //   children: [
// //     Image(
// //         image: NetworkImage(
// //             'https://imgd.aeplcdn.com/642x336/n/cw/ec/103183/raider-125-right-side-view-20.png?isig=0&q=80')),
// //     //  Icon(Icons.bookmark,
// //     //     size: 35, color: COLOR.appBaseColor),
// //     // Positioned.fill(
// //     //   child: Align(
// //     //     alignment: Alignment.center,
// //     //     child: Text(
// //     //       (index + 1).toString(),
// //     //       style: const TextStyle(
// //     //           color: Colors.white),
// //     //     ),
// //     //   ),
// //     // ),
// //   ],
// // ),
//                                       ))
//                                 ],
//                               ),
//                             );
//                           },
//                         ),
//                       ),
// // _highlightedRow(),
//                       SizedBox(
//                         height: 80,
//                         child: AnimatedBuilder(
//                           animation: _ctrl,
//                           builder: (_, __) {
//                             return CustomPaint(
//                                 painter: _BorderSweepPainter(
//                                     sweepAngle: _ctrl.value * 2 * math.pi,
//                                     strokeWidth: 4,
//                                     color: Colors.green
// // COLOR
// //     .appBaseColor, // jo color ghumwana hai
//                                     ),
//                                 child: Container(
//                                   padding: const EdgeInsets.symmetric(
//                                       vertical: 10, horizontal: 05),
// // margin: const EdgeInsets.only(
// //   top: 10, bottom: 0,
// //   // vertical: 10, horizontal: 5
// // ),
//                                   decoration: BoxDecoration(
//                                     gradient: LinearGradient(
//                                         colors: [Colors.yellow, Colors.black],
//                                         stops: [0, 0]),
//                                     color: COLOR.appBaseColor.withOpacity(0.2),
//                                     borderRadius: BorderRadius.circular(20),
//                                   ),
//                                   child: Row(
// // mainAxisAlignment:
// //     MainAxisAlignment.spaceBetween,
//                                     children: [
//                                       Container(
//                                         child: Text(
//                                           "${(53).toString()}.",
//                                           style: const TextStyle(
//                                               color: Colors.black87),
//                                         ),
//                                         margin: EdgeInsets.all(06),
//                                       ),
// // Stack(
// //   children: [
// //     // Image(
// //     //     image: NetworkImage(
// //     //         'https://imgd.aeplcdn.com/642x336/n/cw/ec/103183/raider-125-right-side-view-20.png?isig=0&q=80')),
// //      Icon(Icons.bookmark,
// //         size: 35, color: COLOR.appBaseColor),
// //     Positioned.fill(
// //       child: Align(
// //         alignment: Alignment.center,
// //         child: Text(
// //           (index + 1).toString(),
// //           style: const TextStyle(
// //               color: Colors.white),
// //         ),
// //       ),
// //     ),
// //   ],
// // ),
//                                       Row(
//                                         children: [
//                                           _imageWidget('UsersProfileImage'),
//                                           const SizedBox(width: 10),
//                                           Column(
//                                             crossAxisAlignment:
//                                                 CrossAxisAlignment.start,
//                                             children: [
//                                               Text('My Name',
//                                                   style: const TextStyle(
//                                                       fontWeight:
//                                                           FontWeight.w500)),
//                                               const SizedBox(height: 5),
//                                               Text('Point Value',
//                                                   style: const TextStyle(
//                                                       fontWeight:
//                                                           FontWeight.bold)),
//                                             ],
//                                           ),
//                                         ],
//                                       ),
//                                       Spacer(),
// // Container(decoration: BoxDecoration(image: DecorationImage(image: image)),)
//                                       Container(
//                                           height: 60,
//                                           width: 55,
//                                           decoration: BoxDecoration(
//                                             shape: BoxShape.circle,
//                                             image: DecorationImage(
//                                                 image: NetworkImage(
//                                                     'https://imgd.aeplcdn.com/642x336/n/cw/ec/103183/raider-125-right-side-view-20.png?isig=0&q=80')),
//                                           )),
// // Stack(
// //   children: [
// //     Image(
// //         image: NetworkImage(
// //             'https://imgd.aeplcdn.com/642x336/n/cw/ec/103183/raider-125-right-side-view-20.png?isig=0&q=80')),
// //     //  Icon(Icons.bookmark,
// //     //     size: 35, color: COLOR.appBaseColor),
// //     // Positioned.fill(
// //     //   child: Align(
// //     //     alignment: Alignment.center,
// //     //     child: Text(
// //     //       (index + 1).toString(),
// //     //       style: const TextStyle(
// //     //           color: Colors.white),
// //     //     ),
// //     //   ),
// //     // ),
// //   ],
// // ),
//                                     ],
//                                   ),
// //   ),
// // ),
//                                 )
// // const Center(
// //   child: Icon(Icons.favorite, color: Colors.white, size: 64),
// // ),
//                                 );
//                           },
//                         ),
//
// //   // child: AnimatedContainer(
// //   //
// //   //   duration: const Duration(seconds: 1),
// //   //   curve: Curves.easeInOut,
// //   //   // width: 200,
// //   //   // height: 200,
// //   //   decoration: BoxDecoration(
// //   //     border: Border.all(color: Colors.red, width: 2),
// //   //     borderRadius: BorderRadius.circular(2),
// //   //   ),
// //   //   alignment: Alignment.center,
// //   //     child: Container(
// //   //       padding: const EdgeInsets.symmetric(
// //   //           vertical: 10, horizontal: 05),
// //   //       margin: const EdgeInsets.only(
// //   //         top: 10,bottom: 0,
// //   //         // vertical: 10, horizontal: 5
// //   //       ),
// //   //       decoration: BoxDecoration(
// //   //         color: COLOR.appBaseColor.withOpacity(0.2),
// //   //         borderRadius: BorderRadius.circular(10),
// //   //       ),
// //   //       child: Row(
// //   //         // mainAxisAlignment:
// //   //         //     MainAxisAlignment.spaceBetween,
// //   //         children: [
// //   //           Container(
// //   //
// //   //             child: Text(
// //   //               "${(53 ).toString()}.",
// //   //               style: const TextStyle(
// //   //                   color: Colors.black87),
// //   //             ),
// //   //             margin: EdgeInsets.all(06),
// //   //           ),
// //   //           // Stack(
// //   //           //   children: [
// //   //           //     // Image(
// //   //           //     //     image: NetworkImage(
// //   //           //     //         'https://imgd.aeplcdn.com/642x336/n/cw/ec/103183/raider-125-right-side-view-20.png?isig=0&q=80')),
// //   //           //      Icon(Icons.bookmark,
// //   //           //         size: 35, color: COLOR.appBaseColor),
// //   //           //     Positioned.fill(
// //   //           //       child: Align(
// //   //           //         alignment: Alignment.center,
// //   //           //         child: Text(
// //   //           //           (index + 1).toString(),
// //   //           //           style: const TextStyle(
// //   //           //               color: Colors.white),
// //   //           //         ),
// //   //           //       ),
// //   //           //     ),
// //   //           //   ],
// //   //           // ),
// //   //           Row(
// //   //             children: [
// //   //               _imageWidget('UsersProfileImage'),
// //   //               const SizedBox(width: 10),
// //   //               Column(
// //   //                 crossAxisAlignment:
// //   //                 CrossAxisAlignment.start,
// //   //                 children: [
// //   //                   Text('My Name',
// //   //                       style: const TextStyle(
// //   //                           fontWeight: FontWeight.w500)),
// //   //                   const SizedBox(height: 5),
// //   //                   Text('Point Value',
// //   //                       style: const TextStyle(
// //   //                           fontWeight: FontWeight.bold)),
// //   //                 ],
// //   //               ),
// //   //             ],
// //   //           ),
// //   //           Spacer(),
// //   //           // Container(decoration: BoxDecoration(image: DecorationImage(image: image)),)
// //   //           Container(
// //   //               height : 60, width : 55,
// //   //               decoration: BoxDecoration(
// //   //                 shape:BoxShape.circle,
// //   //                 image: DecorationImage(image:
// //   //                 NetworkImage(
// //   //                     'https://imgd.aeplcdn.com/642x336/n/cw/ec/103183/raider-125-right-side-view-20.png?isig=0&q=80')),
// //   //               )),
// //   //           // Stack(
// //   //           //   children: [
// //   //           //     Image(
// //   //           //         image: NetworkImage(
// //   //           //             'https://imgd.aeplcdn.com/642x336/n/cw/ec/103183/raider-125-right-side-view-20.png?isig=0&q=80')),
// //   //           //     //  Icon(Icons.bookmark,
// //   //           //     //     size: 35, color: COLOR.appBaseColor),
// //   //           //     // Positioned.fill(
// //   //           //     //   child: Align(
// //   //           //     //     alignment: Alignment.center,
// //   //           //     //     child: Text(
// //   //           //     //       (index + 1).toString(),
// //   //           //     //       style: const TextStyle(
// //   //           //     //           color: Colors.white),
// //   //           //     //     ),
// //   //           //     //   ),
// //   //           //     // ),
// //   //           //   ],
// //   //           // ),
// //   //         ],
// //   //       ),
// //   //   //   ),
// //   //   // ),
// //   // )
// //   // ],
//                       ),
//                     ]))));
//   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
      return  controller.isLoading.value
            ? const Center(child: CircularProgressIndicator())
            : controller.monthlyUsers.isEmpty
            ?  Center(child: Text(StringRes.noDataFound))
            : _buildUI(controller.monthlyUsers, controller.prizes);
      }),
    );
  }


  Widget _buildUI(List<MonthlyUser> users, List<Prize> prizes) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          // Top 3
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (users.length > 1) _topUser(2, users[1], prizes),
              if (users.isNotEmpty) _topUser(1, users[0], prizes),
              if (users.length > 2) _topUser(3, users[2], prizes),
            ],
          ),
          SizedBox(height: 20),
          // Rest
          Expanded(
            child: ListView.builder(
              itemCount: users.length > 3 ? users.length - 3 : 0,
              itemBuilder: (_, index) {
                print("=======> User length ${users.length}");
                final user = users[index + 3];
                final prize = prizes.firstWhereOrNull((p) => p.prizePosition == user.rank);
                return prize == null ?SizedBox() :_listTile(user, prize);
              },
            ),
          ),
          if(users.length > 10)
          SizedBox(
            height: 80,
            child: AnimatedBuilder(
              animation: _ctrl,
              builder: (_, __) {
                return CustomPaint(
                    painter: _BorderSweepPainter(
                        sweepAngle: _ctrl.value * 2 * math.pi,
                        strokeWidth: 4,
                        color: Colors.green
                    ),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 05),
                      decoration: BoxDecoration(
                        // gradient: LinearGradient(
                        //     colors: [Colors.yellow, Colors.black],
                        //     stops: [0, 0]),
                        color: Colors.yellow.shade600.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(

                        children: [
                          Container(
                            child: Text(
                              "${(users[10].rank).toString()}.",
                              style: const TextStyle(
                                  color: Colors.black87),
                            ),
                            margin: EdgeInsets.all(06),
                          ),

                          Row(
                            children: [
                              _imageWidget('UsersProfileImage'),
                              const SizedBox(width: 10),
                              Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  Text(users[10].customerName,
                                      style: const TextStyle(
                                          fontWeight:
                                          FontWeight.w500)),
                                  const SizedBox(height: 5),
                                  Text(users[10].totalAmount,
                                      style: const TextStyle(
                                          fontWeight:
                                          FontWeight.bold)),
                                ],
                              ),
                            ],
                          ),
                          // Spacer(),
// Container(decoration: BoxDecoration(image: DecorationImage(image: image)),)
//                          users[11].customerName? Container(
//                               height: 60,
//                               width: 55,
//                               decoration: BoxDecoration(
//                                 shape: BoxShape.circle,
//                                 image: DecorationImage(
//                                     image: NetworkImage(
//                                         'https://imgd.aeplcdn.com/642x336/n/cw/ec/103183/raider-125-right-side-view-20.png?isig=0&q=80')),
//                               )),
// Stack(
//   children: [
//     Image(
//         image: NetworkImage(
//             'https://imgd.aeplcdn.com/642x336/n/cw/ec/103183/raider-125-right-side-view-20.png?isig=0&q=80')),
//     //  Icon(Icons.bookmark,
//     //     size: 35, color: COLOR.appBaseColor),
//     // Positioned.fill(
//     //   child: Align(
//     //     alignment: Alignment.center,
//     //     child: Text(
//     //       (index + 1).toString(),
//     //       style: const TextStyle(
//     //           color: Colors.white),
//     //     ),
//     //   ),
//     // ),
//   ],
// ),
                        ],
                      ),
//   ),
// ),
                    )
// const Center(
//   child: Icon(Icons.favorite, color: Colors.white, size: 64),
// ),
                );
              },
            ),

//   // child: AnimatedContainer(
//   //
//   //   duration: const Duration(seconds: 1),
//   //   curve: Curves.easeInOut,
//   //   // width: 200,
//   //   // height: 200,
//   //   decoration: BoxDecoration(
//   //     border: Border.all(color: Colors.red, width: 2),
//   //     borderRadius: BorderRadius.circular(2),
//   //   ),
//   //   alignment: Alignment.center,
//   //     child: Container(
//   //       padding: const EdgeInsets.symmetric(
//   //           vertical: 10, horizontal: 05),
//   //       margin: const EdgeInsets.only(
//   //         top: 10,bottom: 0,
//   //         // vertical: 10, horizontal: 5
//   //       ),
//   //       decoration: BoxDecoration(
//   //         color: COLOR.appBaseColor.withOpacity(0.2),
//   //         borderRadius: BorderRadius.circular(10),
//   //       ),
//   //       child: Row(
//   //         // mainAxisAlignment:
//   //         //     MainAxisAlignment.spaceBetween,
//   //         children: [
//   //           Container(
//   //
//   //             child: Text(
//   //               "${(53 ).toString()}.",
//   //               style: const TextStyle(
//   //                   color: Colors.black87),
//   //             ),
//   //             margin: EdgeInsets.all(06),
//   //           ),
//   //           // Stack(
//   //           //   children: [
//   //           //     // Image(
//   //           //     //     image: NetworkImage(
//   //           //     //         'https://imgd.aeplcdn.com/642x336/n/cw/ec/103183/raider-125-right-side-view-20.png?isig=0&q=80')),
//   //           //      Icon(Icons.bookmark,
//   //           //         size: 35, color: COLOR.appBaseColor),
//   //           //     Positioned.fill(
//   //           //       child: Align(
//   //           //         alignment: Alignment.center,
//   //           //         child: Text(
//   //           //           (index + 1).toString(),
//   //           //           style: const TextStyle(
//   //           //               color: Colors.white),
//   //           //         ),
//   //           //       ),
//   //           //     ),
//   //           //   ],
//   //           // ),
//   //           Row(
//   //             children: [
//   //               _imageWidget('UsersProfileImage'),
//   //               const SizedBox(width: 10),
//   //               Column(
//   //                 crossAxisAlignment:
//   //                 CrossAxisAlignment.start,
//   //                 children: [
//   //                   Text('My Name',
//   //                       style: const TextStyle(
//   //                           fontWeight: FontWeight.w500)),
//   //                   const SizedBox(height: 5),
//   //                   Text('Point Value',
//   //                       style: const TextStyle(
//   //                           fontWeight: FontWeight.bold)),
//   //                 ],
//   //               ),
//   //             ],
//   //           ),
//   //           Spacer(),
//   //           // Container(decoration: BoxDecoration(image: DecorationImage(image: image)),)
//   //           Container(
//   //               height : 60, width : 55,
//   //               decoration: BoxDecoration(
//   //                 shape:BoxShape.circle,
//   //                 image: DecorationImage(image:
//   //                 NetworkImage(
//   //                     'https://imgd.aeplcdn.com/642x336/n/cw/ec/103183/raider-125-right-side-view-20.png?isig=0&q=80')),
//   //               )),
//   //           // Stack(
//   //           //   children: [
//   //           //     Image(
//   //           //         image: NetworkImage(
//   //           //             'https://imgd.aeplcdn.com/642x336/n/cw/ec/103183/raider-125-right-side-view-20.png?isig=0&q=80')),
//   //           //     //  Icon(Icons.bookmark,
//   //           //     //     size: 35, color: COLOR.appBaseColor),
//   //           //     // Positioned.fill(
//   //           //     //   child: Align(
//   //           //     //     alignment: Alignment.center,
//   //           //     //     child: Text(
//   //           //     //       (index + 1).toString(),
//   //           //     //       style: const TextStyle(
//   //           //     //           color: Colors.white),
//   //           //     //     ),
//   //           //     //   ),
//   //           //     // ),
//   //           //   ],
//   //           // ),
//   //         ],
//   //       ),
//   //   //   ),
//   //   // ),
//   // )
//   // ],
          ),
        ],
      ),
    );
  }

  Widget _topUser(int rank, MonthlyUser user, List<Prize> prizes) {
    final prize = prizes.firstWhereOrNull((p) => p.prizePosition == rank);

    final double height = rank == 1 ? 130 : (rank == 2 ? 95 : 75);
    final double opacity = rank == 1 ? 0.5 : (rank == 2 ? 0.4 : 0.3);

    return SizedBox(
      width: 100,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "₹${user.totalAmount}",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
              color: COLOR.appBaseColor,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            " $rank ${user.customerName}",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 13,
              color: COLOR.appBaseColor,
            ),
          ),
          const SizedBox(height: 4),
          CircleAvatar(
            radius: 25,
            backgroundColor: Colors.grey.shade200,
            child: Icon(Icons.person, size: 30, color: Colors.black87),
          ),
          const SizedBox(height: 5),
          Container(
            height: height,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
              color: COLOR.appBaseColor.withOpacity(opacity),
            ),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Stack(
                    children: [
                      Icon(Icons.bookmark, size: 35, color: COLOR.appBaseColor),
                      Positioned.fill(
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            rank.toString(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  if (prize != null)
                    Flexible(
                      child: Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          image: DecorationImage(
                            image: NetworkImage("$IMAGE_URL${prize.prizeImage}"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _listTile(MonthlyUser user, Prize? prize) {
    return Container(
      padding: const EdgeInsets.symmetric(
          vertical: 15, horizontal: 05),
      margin: const EdgeInsets.symmetric(
          vertical: 08, horizontal: 5),
      decoration: BoxDecoration(
        color: COLOR.appBaseColor.withOpacity(0.2),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Container(
            child: Text(
              "${(prize!.prizePosition).toString()}.",
              style: const TextStyle(
                  color: Colors.black87),
            ),
            margin: EdgeInsets.all(06),
          ),
          Row(
            children: [
              _imageWidget(prize!.prizeImage),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [
                  Text(user.customerName,
                      style: const TextStyle(
                          fontWeight: FontWeight.w500)),
                  const SizedBox(height: 5),
                  Text(user.totalAmount,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold)),
                ],
              ),
            ],
          ),
          Spacer(),
          Container(
              height: 50,
              width: 55,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                    image: NetworkImage(
                    IMAGE_URL +  prize.prizeImage
                    )),
              ))
        ],
      ),
    );
  }

// Last row (53) ka special widget
  Widget _highlightedRow() {
    return SizedBox(
      height: 85,
      child: AnimatedBuilder(
        animation: _ctrl,
        builder: (_, __) {
          return CustomPaint(
            painter: _BorderSweepPainter(
              sweepAngle: _ctrl.value * 2 * math.pi,
              strokeWidth: 4, // Border width
              color: COLOR.appBaseColor, // Highlight color
            ),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 05),
// margin: const EdgeInsets.only(top: 10, bottom: 0),
              decoration: BoxDecoration(
                color: COLOR.appBaseColor.withOpacity(0.2),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  Container(
                    child: Text(
                      "53.",
                      style: const TextStyle(color: Colors.black87),
                    ),
                    margin: EdgeInsets.all(06),
                  ),
                  Row(
                    children: [
                      _imageWidget('UsersProfileImage'),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(StringRes.name,
                              style:
                                  const TextStyle(fontWeight: FontWeight.w500)),
                          const SizedBox(height: 5),
                          Text(StringRes.pointValue,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ],
                  ),
                  Spacer(),
                  Container(
                    height: 60,
                    width: 55,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: NetworkImage(
                            'https://imgd.aeplcdn.com/642x336/n/cw/ec/103183/raider-125-right-side-view-20.png?isig=0&q=80'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

// Last mein isko call kar instead of purane wale 53 wale section ke
// Replace this part in your build method:

// OLD CODE (remove this):
/*
SizedBox(
  height: 85,
  child: AnimatedBuilder(
    animation: _ctrl,
    builder: (_, __) {
      return CustomPaint(
        painter: _BorderSweepPainter(
          sweepAngle: _ctrl.value * 2 * math.pi,
          strokeWidth: 0,
          color: COLOR.appBaseColor,
        ),
        child: Container(...)
      );
    },
  ),
)
*/
}


class _BorderSweepPainter extends CustomPainter {
  final double sweepAngle;
  final double strokeWidth;
  final Color color;

  _BorderSweepPainter({
    required this.sweepAngle,
    required this.strokeWidth,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final rrect = RRect.fromRectAndRadius(
      rect.deflate(strokeWidth / 2),
      const Radius.circular(20),
    );

    // full border gray (static)
    final grayPaint = Paint()
      ..color = Colors.grey[800]!
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    canvas.drawRRect(rrect, grayPaint);

    // sweeping color arc (only border)
    final sweepPaint = Paint()
      ..shader = SweepGradient(
        colors: [color.withOpacity(0), color, color.withOpacity(0)],
        stops: const [0.0, 0.1, 0.2],
        transform: GradientRotation(sweepAngle),
      ).createShader(rect)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    canvas.drawRRect(rrect, sweepPaint);
  }

  @override
  bool shouldRepaint(covariant _BorderSweepPainter old) =>
      old.sweepAngle != sweepAngle;
}












/////////////////////////////////
// import 'dart:math' as math;
//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import '../../constant/app_constant.dart';
// import '../../constant/colorConst.dart';
// import '../../controller/leadeController.dart';
// import '../../models/MonthlyUser.dart';
// import '../../models/prizeModel.dart';
//
// class LeadershipScreen extends StatefulWidget {
//   const LeadershipScreen({super.key});
//
//   @override
//   State<LeadershipScreen> createState() => _LeadershipScreenState();
// }
//
// class _LeadershipScreenState extends State<LeadershipScreen>
//     with SingleTickerProviderStateMixin {
//   final leadershipBoardList = <Map<String, dynamic>>[].obs;
//   final isLoading = false.obs;
//
//   late AnimationController _ctrl;
//
//   final LeaderboardController controller = Get.put(LeaderboardController());
//
//   @override
//   void initState() {
//     super.initState();
//     // fetchData();
//     controller.fetchData();
//     _ctrl = AnimationController(
//       vsync: this,
//       duration: const Duration(seconds: 2),
//     )..repeat();
//   }
//
//   // Future<void> fetchData() async {
//   //   isLoading(true);
//   //   await Future.delayed(const Duration(seconds: 1)); // simulate
//   //   leadershipBoardList.assignAll(_dummyList());
//   //   isLoading(false);
//   // }
//
//   List<Map<String, dynamic>> _dummyList() {
//     return List.generate(10, (i) {
//       final rank = i + 1;
//       return {
//         "UsersFirstname": "User $rank",
//         "LeadershippointValue": "${1000 - (rank - 1) * 50}",
//         "UsersProfileImage": "",
//       };
//     });
//   }
//
// // late AnimationController _ctrl;
//
//   @override
// // void initState() {
// //   super.initState();
// //   _ctrl = AnimationController(
// //     vsync: this,
// //     duration: const Duration(seconds: 2),
// //   )..repeat();
// // }
//
//   @override
//   void dispose() {
//     _ctrl.dispose();
//     super.dispose();
//   }
//
//   Widget _imageWidget(String url) {
//     return SizedBox(
//       width: 50,
//       height: 50,
//       child: Container(
//         padding: const EdgeInsets.all(8),
//         decoration:
//         const BoxDecoration(shape: BoxShape.circle, color: Colors.black87),
//         child: ClipRRect(
//           borderRadius: BorderRadius.circular(50),
//           child: Image.network(
//             "https://via.placeholder.com/150",
//             fit: BoxFit.fill,
//             errorBuilder: (_, __, ___) =>
//                 Image.asset("assets/images/profile.png"),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget pollUIWidget(double height, int title, String name, String point,
//       double opacity, String image,
//       {String? prizeImage}) {
//     return SizedBox(
//       width: 100,
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Text(
//             point,
//             style: TextStyle(
//                 fontWeight: FontWeight.bold,
//                 fontSize: 15,
//                 color: COLOR.appBaseColor),
//           ),
//           const SizedBox(height: 2),
//           Text(
//             name,
//             textAlign: TextAlign.center,
//             style: TextStyle(
//                 fontWeight: FontWeight.w500,
//                 fontSize: 15,
//                 color: COLOR.appBaseColor),
//           ),
//           const SizedBox(height: 2),
//           _imageWidget(image),
//           SizedBox(height: 5),
//           Container(
//             height: height,
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
//               color: COLOR.appBaseColor.withOpacity(opacity),
//             ),
//             child: Center(
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Stack(
//                     children: [
//                       Icon(Icons.bookmark, size: 35, color: COLOR.appBaseColor),
//                       Positioned.fill(
//                         child: Align(
//                           alignment: Alignment.center,
//                           child: Text(
//                             title.toString(),
//                             style: const TextStyle(
//                                 color: Colors.white, fontSize: 15),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                   Flexible(
//                     child: Container(
//                         height: 60,
//                         width: 55,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(30),
// // shape:BoxShape.circle,
//                           image: DecorationImage(
//                               image: NetworkImage(prizeImage!
// // 'https://imgd.aeplcdn.com/642x336/n/cw/ec/103183/raider-125-right-side-view-20.png?isig=0&q=80'
//                               )),
//                         )),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// // // appBar: AppBar(
// // //   backgroundColor: COLOR.appBaseColor,
// // //   title: const Text('Leadership Point Detail',
// // //       style: TextStyle(color: Colors.white)),
// // //   leading: IconButton(
// // //     icon: const Icon(Icons.arrow_back, color: Colors.white),
// // //     onPressed: () => Get.back(),
// // //   ),
// // // ),
// //         body: Obx(() => isLoading.value
// //             ? const Center(child: CircularProgressIndicator())
// //             : leadershipBoardList.isEmpty
// //                 ? const Center(child: Text('LeaderShip Data Not Found'))
// //                 : Padding(
// //                     padding: const EdgeInsets.only(
// //                         top: 10, left: 10, right: 10, bottom: 05
// // // ,vertical: 15, horizontal: 10
// //                         ),
// //                     child: Column(children: [
// //                       Row(
// //                         crossAxisAlignment: CrossAxisAlignment.end,
// //                         mainAxisAlignment: MainAxisAlignment.center,
// //                         children: [
// //                           pollUIWidget(
// //                               95,
// //                               2,
// //                               leadershipBoardList[1]['UsersFirstname'],
// //                               leadershipBoardList[1]['LeadershippointValue'],
// //                               0.4,
// //                               leadershipBoardList[1]['UsersProfileImage'],
// //                               prizeImage:
// //                                   "https://media.assettype.com/tnm/import/sites/default/files/Ola_Electric_1200.jpg?w=1200&h=675&auto=format%2Ccompress&fit=max&enlarge=true"
// // // "https://www.shutterstock.com/image-photo/white-suv-car-isolated-on-260nw-2323736773.jpg"
// //                               ),
// //                           pollUIWidget(
// //                               130,
// //                               1,
// //                               leadershipBoardList[0]['UsersFirstname'],
// //                               leadershipBoardList[0]['LeadershippointValue'],
// //                               0.5,
// //                               leadershipBoardList[0]['UsersProfileImage'],
// //                               prizeImage:
// //                                   "https://www.shutterstock.com/image-photo/white-suv-car-isolated-on-260nw-2323736773.jpg"),
// //                           pollUIWidget(
// //                               75,
// //                               3,
// //                               leadershipBoardList[2]['UsersFirstname'],
// //                               leadershipBoardList[2]['LeadershippointValue'],
// //                               0.3,
// //                               leadershipBoardList[2]['UsersProfileImage'],
// //                               prizeImage:
// //                                   "https://cdn.mos.cms.futurecdn.net/h8cTAUPU8Bs67h2RZ9qbvD.jpg"
// // // "https://www.shutterstock.com/image-photo/white-suv-car-isolated-on-260nw-2323736773.jpg"
// //
// //                               ),
// //                         ],
// //                       ),
// //                       const SizedBox(height: 5),
// //                       Expanded(
// //                         child: ListView.builder(
// //                           itemCount: leadershipBoardList.length,
// //                           itemBuilder: (_, index) {
// //                             if (index < 3) return const SizedBox();
// //                             final item = leadershipBoardList[index];
// //                             return Container(
// //                               padding: const EdgeInsets.symmetric(
// //                                   vertical: 15, horizontal: 05),
// //                               margin: const EdgeInsets.symmetric(
// //                                   vertical: 08, horizontal: 5),
// //                               decoration: BoxDecoration(
// //                                 color: COLOR.appBaseColor.withOpacity(0.2),
// //                                 borderRadius: BorderRadius.circular(10),
// //                               ),
// //                               child: Row(
// // // mainAxisAlignment:
// // //     MainAxisAlignment.spaceBetween,
// //                                 children: [
// //                                   Container(
// //                                     child: Text(
// //                                       "${(index + 1).toString()}.",
// //                                       style: const TextStyle(
// //                                           color: Colors.black87),
// //                                     ),
// //                                     margin: EdgeInsets.all(06),
// //                                   ),
// // // Stack(
// // //   children: [
// // //     // Image(
// // //     //     image: NetworkImage(
// // //     //         'https://imgd.aeplcdn.com/642x336/n/cw/ec/103183/raider-125-right-side-view-20.png?isig=0&q=80')),
// // //      Icon(Icons.bookmark,
// // //         size: 35, color: COLOR.appBaseColor),
// // //     Positioned.fill(
// // //       child: Align(
// // //         alignment: Alignment.center,
// // //         child: Text(
// // //           (index + 1).toString(),
// // //           style: const TextStyle(
// // //               color: Colors.white),
// // //         ),
// // //       ),
// // //     ),
// // //   ],
// // // ),
// //                                   Row(
// //                                     children: [
// //                                       _imageWidget(item['UsersProfileImage']),
// //                                       const SizedBox(width: 10),
// //                                       Column(
// //                                         crossAxisAlignment:
// //                                             CrossAxisAlignment.start,
// //                                         children: [
// //                                           Text(item['UsersFirstname'],
// //                                               style: const TextStyle(
// //                                                   fontWeight: FontWeight.w500)),
// //                                           const SizedBox(height: 5),
// //                                           Text(item['LeadershippointValue'],
// //                                               style: const TextStyle(
// //                                                   fontWeight: FontWeight.bold)),
// //                                         ],
// //                                       ),
// //                                     ],
// //                                   ),
// //                                   Spacer(),
// // // Container(decoration: BoxDecoration(image: DecorationImage(image: image)),)
// //                                   Container(
// //                                       height: 50,
// //                                       width: 55,
// //                                       decoration: BoxDecoration(
// //                                         shape: BoxShape.circle,
// //                                         image: DecorationImage(
// //                                             image: NetworkImage(
// //                                           'https://5.imimg.com/data5/SELLER/Default/2022/9/RJ/VD/FR/113915368/head-phone.jpg',
// // // 'https://imgd.aeplcdn.com/642x336/n/cw/ec/103183/raider-125-right-side-view-20.png?isig=0&q=80')),
// //                                         )),
// // // Stack(
// // //   children: [
// // //     Image(
// // //         image: NetworkImage(
// // //             'https://imgd.aeplcdn.com/642x336/n/cw/ec/103183/raider-125-right-side-view-20.png?isig=0&q=80')),
// // //     //  Icon(Icons.bookmark,
// // //     //     size: 35, color: COLOR.appBaseColor),
// // //     // Positioned.fill(
// // //     //   child: Align(
// // //     //     alignment: Alignment.center,
// // //     //     child: Text(
// // //     //       (index + 1).toString(),
// // //     //       style: const TextStyle(
// // //     //           color: Colors.white),
// // //     //     ),
// // //     //   ),
// // //     // ),
// // //   ],
// // // ),
// //                                       ))
// //                                 ],
// //                               ),
// //                             );
// //                           },
// //                         ),
// //                       ),
// // // _highlightedRow(),
// //                       SizedBox(
// //                         height: 80,
// //                         child: AnimatedBuilder(
// //                           animation: _ctrl,
// //                           builder: (_, __) {
// //                             return CustomPaint(
// //                                 painter: _BorderSweepPainter(
// //                                     sweepAngle: _ctrl.value * 2 * math.pi,
// //                                     strokeWidth: 4,
// //                                     color: Colors.green
// // // COLOR
// // //     .appBaseColor, // jo color ghumwana hai
// //                                     ),
// //                                 child: Container(
// //                                   padding: const EdgeInsets.symmetric(
// //                                       vertical: 10, horizontal: 05),
// // // margin: const EdgeInsets.only(
// // //   top: 10, bottom: 0,
// // //   // vertical: 10, horizontal: 5
// // // ),
// //                                   decoration: BoxDecoration(
// //                                     gradient: LinearGradient(
// //                                         colors: [Colors.yellow, Colors.black],
// //                                         stops: [0, 0]),
// //                                     color: COLOR.appBaseColor.withOpacity(0.2),
// //                                     borderRadius: BorderRadius.circular(20),
// //                                   ),
// //                                   child: Row(
// // // mainAxisAlignment:
// // //     MainAxisAlignment.spaceBetween,
// //                                     children: [
// //                                       Container(
// //                                         child: Text(
// //                                           "${(53).toString()}.",
// //                                           style: const TextStyle(
// //                                               color: Colors.black87),
// //                                         ),
// //                                         margin: EdgeInsets.all(06),
// //                                       ),
// // // Stack(
// // //   children: [
// // //     // Image(
// // //     //     image: NetworkImage(
// // //     //         'https://imgd.aeplcdn.com/642x336/n/cw/ec/103183/raider-125-right-side-view-20.png?isig=0&q=80')),
// // //      Icon(Icons.bookmark,
// // //         size: 35, color: COLOR.appBaseColor),
// // //     Positioned.fill(
// // //       child: Align(
// // //         alignment: Alignment.center,
// // //         child: Text(
// // //           (index + 1).toString(),
// // //           style: const TextStyle(
// // //               color: Colors.white),
// // //         ),
// // //       ),
// // //     ),
// // //   ],
// // // ),
// //                                       Row(
// //                                         children: [
// //                                           _imageWidget('UsersProfileImage'),
// //                                           const SizedBox(width: 10),
// //                                           Column(
// //                                             crossAxisAlignment:
// //                                                 CrossAxisAlignment.start,
// //                                             children: [
// //                                               Text('My Name',
// //                                                   style: const TextStyle(
// //                                                       fontWeight:
// //                                                           FontWeight.w500)),
// //                                               const SizedBox(height: 5),
// //                                               Text('Point Value',
// //                                                   style: const TextStyle(
// //                                                       fontWeight:
// //                                                           FontWeight.bold)),
// //                                             ],
// //                                           ),
// //                                         ],
// //                                       ),
// //                                       Spacer(),
// // // Container(decoration: BoxDecoration(image: DecorationImage(image: image)),)
// //                                       Container(
// //                                           height: 60,
// //                                           width: 55,
// //                                           decoration: BoxDecoration(
// //                                             shape: BoxShape.circle,
// //                                             image: DecorationImage(
// //                                                 image: NetworkImage(
// //                                                     'https://imgd.aeplcdn.com/642x336/n/cw/ec/103183/raider-125-right-side-view-20.png?isig=0&q=80')),
// //                                           )),
// // // Stack(
// // //   children: [
// // //     Image(
// // //         image: NetworkImage(
// // //             'https://imgd.aeplcdn.com/642x336/n/cw/ec/103183/raider-125-right-side-view-20.png?isig=0&q=80')),
// // //     //  Icon(Icons.bookmark,
// // //     //     size: 35, color: COLOR.appBaseColor),
// // //     // Positioned.fill(
// // //     //   child: Align(
// // //     //     alignment: Alignment.center,
// // //     //     child: Text(
// // //     //       (index + 1).toString(),
// // //     //       style: const TextStyle(
// // //     //           color: Colors.white),
// // //     //     ),
// // //     //   ),
// // //     // ),
// // //   ],
// // // ),
// //                                     ],
// //                                   ),
// // //   ),
// // // ),
// //                                 )
// // // const Center(
// // //   child: Icon(Icons.favorite, color: Colors.white, size: 64),
// // // ),
// //                                 );
// //                           },
// //                         ),
// //
// // //   // child: AnimatedContainer(
// // //   //
// // //   //   duration: const Duration(seconds: 1),
// // //   //   curve: Curves.easeInOut,
// // //   //   // width: 200,
// // //   //   // height: 200,
// // //   //   decoration: BoxDecoration(
// // //   //     border: Border.all(color: Colors.red, width: 2),
// // //   //     borderRadius: BorderRadius.circular(2),
// // //   //   ),
// // //   //   alignment: Alignment.center,
// // //   //     child: Container(
// // //   //       padding: const EdgeInsets.symmetric(
// // //   //           vertical: 10, horizontal: 05),
// // //   //       margin: const EdgeInsets.only(
// // //   //         top: 10,bottom: 0,
// // //   //         // vertical: 10, horizontal: 5
// // //   //       ),
// // //   //       decoration: BoxDecoration(
// // //   //         color: COLOR.appBaseColor.withOpacity(0.2),
// // //   //         borderRadius: BorderRadius.circular(10),
// // //   //       ),
// // //   //       child: Row(
// // //   //         // mainAxisAlignment:
// // //   //         //     MainAxisAlignment.spaceBetween,
// // //   //         children: [
// // //   //           Container(
// // //   //
// // //   //             child: Text(
// // //   //               "${(53 ).toString()}.",
// // //   //               style: const TextStyle(
// // //   //                   color: Colors.black87),
// // //   //             ),
// // //   //             margin: EdgeInsets.all(06),
// // //   //           ),
// // //   //           // Stack(
// // //   //           //   children: [
// // //   //           //     // Image(
// // //   //           //     //     image: NetworkImage(
// // //   //           //     //         'https://imgd.aeplcdn.com/642x336/n/cw/ec/103183/raider-125-right-side-view-20.png?isig=0&q=80')),
// // //   //           //      Icon(Icons.bookmark,
// // //   //           //         size: 35, color: COLOR.appBaseColor),
// // //   //           //     Positioned.fill(
// // //   //           //       child: Align(
// // //   //           //         alignment: Alignment.center,
// // //   //           //         child: Text(
// // //   //           //           (index + 1).toString(),
// // //   //           //           style: const TextStyle(
// // //   //           //               color: Colors.white),
// // //   //           //         ),
// // //   //           //       ),
// // //   //           //     ),
// // //   //           //   ],
// // //   //           // ),
// // //   //           Row(
// // //   //             children: [
// // //   //               _imageWidget('UsersProfileImage'),
// // //   //               const SizedBox(width: 10),
// // //   //               Column(
// // //   //                 crossAxisAlignment:
// // //   //                 CrossAxisAlignment.start,
// // //   //                 children: [
// // //   //                   Text('My Name',
// // //   //                       style: const TextStyle(
// // //   //                           fontWeight: FontWeight.w500)),
// // //   //                   const SizedBox(height: 5),
// // //   //                   Text('Point Value',
// // //   //                       style: const TextStyle(
// // //   //                           fontWeight: FontWeight.bold)),
// // //   //                 ],
// // //   //               ),
// // //   //             ],
// // //   //           ),
// // //   //           Spacer(),
// // //   //           // Container(decoration: BoxDecoration(image: DecorationImage(image: image)),)
// // //   //           Container(
// // //   //               height : 60, width : 55,
// // //   //               decoration: BoxDecoration(
// // //   //                 shape:BoxShape.circle,
// // //   //                 image: DecorationImage(image:
// // //   //                 NetworkImage(
// // //   //                     'https://imgd.aeplcdn.com/642x336/n/cw/ec/103183/raider-125-right-side-view-20.png?isig=0&q=80')),
// // //   //               )),
// // //   //           // Stack(
// // //   //           //   children: [
// // //   //           //     Image(
// // //   //           //         image: NetworkImage(
// // //   //           //             'https://imgd.aeplcdn.com/642x336/n/cw/ec/103183/raider-125-right-side-view-20.png?isig=0&q=80')),
// // //   //           //     //  Icon(Icons.bookmark,
// // //   //           //     //     size: 35, color: COLOR.appBaseColor),
// // //   //           //     // Positioned.fill(
// // //   //           //     //   child: Align(
// // //   //           //     //     alignment: Alignment.center,
// // //   //           //     //     child: Text(
// // //   //           //     //       (index + 1).toString(),
// // //   //           //     //       style: const TextStyle(
// // //   //           //     //           color: Colors.white),
// // //   //           //     //     ),
// // //   //           //     //   ),
// // //   //           //     // ),
// // //   //           //   ],
// // //   //           // ),
// // //   //         ],
// // //   //       ),
// // //   //   //   ),
// // //   //   // ),
// // //   // )
// // //   // ],
// //                       ),
// //                     ]))));
// //   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Obx(() {
//         return  controller.isLoading.value
//             ? const Center(child: CircularProgressIndicator())
//             : controller.monthlyUsers.isEmpty
//             ? const Center(child: Text('No data found'))
//             : _buildUI(controller.monthlyUsers, controller.prizes);
//
//
//
//         // if (controller.isLoading.value) {
//         //   return Center(child: CircularProgressIndicator());
//         // }
//         //
//         // final users = controller.monthlyUsers;
//         // if (users.isEmpty) return Center(child: Text("No data"));
//         //
//         // return Padding(
//         //   padding: const EdgeInsets.all(12),
//         //   child: Column(
//         //     children: [
//         //       // Top 3
//         //       Row(
//         //         crossAxisAlignment: CrossAxisAlignment.end,
//         //         mainAxisAlignment: MainAxisAlignment.center,
//         //         children: [
//         //           if (users.length > 1) _topUser(2, users[1], prizes),
//         //           if (users.isNotEmpty) _topUser(1, users[0], prizes),
//         //           if (users.length > 2) _topUser(3, users[2], prizes),
//         //           // if (users.length > 1) _topUser(2, users[1], 95, 0.4),
//         //           // if (users.isNotEmpty) _topUser(1, users[0], 130, 0.5),
//         //           // if (users.length > 2) _topUser(3, users[2], 75, 0.3),
//         //         ],
//         //       ),
//         //       SizedBox(height: 20),
//         //       // Rest of list
//         //       Expanded(
//         //         child: ListView.builder(
//         //           itemCount: users.length > 3 ? users.length - 3 : 0,
//         //           itemBuilder: (_, index) {
//         //             final user = users[index + 3];
//         //             final prize = controller.getPrizeForRank(user.rank);
//         //             return _listTile(user, prize);
//         //           },
//         //         ),
//         //       ),
//         //     ],
//         //   ),
//         // );
//       }),
//     );
//   }
//
//
//   Widget _buildUI(List<MonthlyUser> users, List<Prize> prizes) {
//     return Padding(
//       padding: const EdgeInsets.all(12),
//       child: Column(
//         children: [
//           // Top 3
//           Row(
//             crossAxisAlignment: CrossAxisAlignment.end,
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               if (users.length > 1) _topUser(2, users[1], prizes),
//               if (users.isNotEmpty) _topUser(1, users[0], prizes),
//               if (users.length > 2) _topUser(3, users[2], prizes),
//             ],
//           ),
//           SizedBox(height: 20),
//           // Rest
//           Expanded(
//             child: ListView.builder(
//               itemCount: users.length > 3 ? users.length - 3 : 0,
//               itemBuilder: (_, index) {
//                 final user = users[index + 3];
//                 final prize = prizes.firstWhereOrNull((p) => p.prizePosition == user.rank);
//                 return _listTile(user, prize);
//               },
//             ),
//           ),
//           SizedBox(
//             height: 80,
//             child: AnimatedBuilder(
//               animation: _ctrl,
//               builder: (_, __) {
//                 return CustomPaint(
//                     painter: _BorderSweepPainter(
//                         sweepAngle: _ctrl.value * 2 * math.pi,
//                         strokeWidth: 4,
//                         color: Colors.green
//                     ),
//                     child: Container(
//                       padding: const EdgeInsets.symmetric(
//                           vertical: 10, horizontal: 05),
//                       decoration: BoxDecoration(
//                         // gradient: LinearGradient(
//                         //     colors: [Colors.yellow, Colors.black],
//                         //     stops: [0, 0]),
//                         color: Colors.yellow.shade600.withOpacity(0.2),
//                         borderRadius: BorderRadius.circular(20),
//                       ),
//                       child: Row(
//
//                         children: [
//                           Container(
//                             child: Text(
//                               "${(53).toString()}.",
//                               style: const TextStyle(
//                                   color: Colors.black87),
//                             ),
//                             margin: EdgeInsets.all(06),
//                           ),
// // Stack(
// //   children: [
// //     // Image(
// //     //     image: NetworkImage(
// //     //         'https://imgd.aeplcdn.com/642x336/n/cw/ec/103183/raider-125-right-side-view-20.png?isig=0&q=80')),
// //      Icon(Icons.bookmark,
// //         size: 35, color: COLOR.appBaseColor),
// //     Positioned.fill(
// //       child: Align(
// //         alignment: Alignment.center,
// //         child: Text(
// //           (index + 1).toString(),
// //           style: const TextStyle(
// //               color: Colors.white),
// //         ),
// //       ),
// //     ),
// //   ],
// // ),
//                           Row(
//                             children: [
//                               _imageWidget('UsersProfileImage'),
//                               const SizedBox(width: 10),
//                               Column(
//                                 crossAxisAlignment:
//                                 CrossAxisAlignment.start,
//                                 children: [
//                                   Text('My Name',
//                                       style: const TextStyle(
//                                           fontWeight:
//                                           FontWeight.w500)),
//                                   const SizedBox(height: 5),
//                                   Text('Point Value',
//                                       style: const TextStyle(
//                                           fontWeight:
//                                           FontWeight.bold)),
//                                 ],
//                               ),
//                             ],
//                           ),
//                           Spacer(),
// // Container(decoration: BoxDecoration(image: DecorationImage(image: image)),)
//                           Container(
//                               height: 60,
//                               width: 55,
//                               decoration: BoxDecoration(
//                                 shape: BoxShape.circle,
//                                 image: DecorationImage(
//                                     image: NetworkImage(
//                                         'https://imgd.aeplcdn.com/642x336/n/cw/ec/103183/raider-125-right-side-view-20.png?isig=0&q=80')),
//                               )),
// // Stack(
// //   children: [
// //     Image(
// //         image: NetworkImage(
// //             'https://imgd.aeplcdn.com/642x336/n/cw/ec/103183/raider-125-right-side-view-20.png?isig=0&q=80')),
// //     //  Icon(Icons.bookmark,
// //     //     size: 35, color: COLOR.appBaseColor),
// //     // Positioned.fill(
// //     //   child: Align(
// //     //     alignment: Alignment.center,
// //     //     child: Text(
// //     //       (index + 1).toString(),
// //     //       style: const TextStyle(
// //     //           color: Colors.white),
// //     //     ),
// //     //   ),
// //     // ),
// //   ],
// // ),
//                         ],
//                       ),
// //   ),
// // ),
//                     )
// // const Center(
// //   child: Icon(Icons.favorite, color: Colors.white, size: 64),
// // ),
//                 );
//               },
//             ),
//
// //   // child: AnimatedContainer(
// //   //
// //   //   duration: const Duration(seconds: 1),
// //   //   curve: Curves.easeInOut,
// //   //   // width: 200,
// //   //   // height: 200,
// //   //   decoration: BoxDecoration(
// //   //     border: Border.all(color: Colors.red, width: 2),
// //   //     borderRadius: BorderRadius.circular(2),
// //   //   ),
// //   //   alignment: Alignment.center,
// //   //     child: Container(
// //   //       padding: const EdgeInsets.symmetric(
// //   //           vertical: 10, horizontal: 05),
// //   //       margin: const EdgeInsets.only(
// //   //         top: 10,bottom: 0,
// //   //         // vertical: 10, horizontal: 5
// //   //       ),
// //   //       decoration: BoxDecoration(
// //   //         color: COLOR.appBaseColor.withOpacity(0.2),
// //   //         borderRadius: BorderRadius.circular(10),
// //   //       ),
// //   //       child: Row(
// //   //         // mainAxisAlignment:
// //   //         //     MainAxisAlignment.spaceBetween,
// //   //         children: [
// //   //           Container(
// //   //
// //   //             child: Text(
// //   //               "${(53 ).toString()}.",
// //   //               style: const TextStyle(
// //   //                   color: Colors.black87),
// //   //             ),
// //   //             margin: EdgeInsets.all(06),
// //   //           ),
// //   //           // Stack(
// //   //           //   children: [
// //   //           //     // Image(
// //   //           //     //     image: NetworkImage(
// //   //           //     //         'https://imgd.aeplcdn.com/642x336/n/cw/ec/103183/raider-125-right-side-view-20.png?isig=0&q=80')),
// //   //           //      Icon(Icons.bookmark,
// //   //           //         size: 35, color: COLOR.appBaseColor),
// //   //           //     Positioned.fill(
// //   //           //       child: Align(
// //   //           //         alignment: Alignment.center,
// //   //           //         child: Text(
// //   //           //           (index + 1).toString(),
// //   //           //           style: const TextStyle(
// //   //           //               color: Colors.white),
// //   //           //         ),
// //   //           //       ),
// //   //           //     ),
// //   //           //   ],
// //   //           // ),
// //   //           Row(
// //   //             children: [
// //   //               _imageWidget('UsersProfileImage'),
// //   //               const SizedBox(width: 10),
// //   //               Column(
// //   //                 crossAxisAlignment:
// //   //                 CrossAxisAlignment.start,
// //   //                 children: [
// //   //                   Text('My Name',
// //   //                       style: const TextStyle(
// //   //                           fontWeight: FontWeight.w500)),
// //   //                   const SizedBox(height: 5),
// //   //                   Text('Point Value',
// //   //                       style: const TextStyle(
// //   //                           fontWeight: FontWeight.bold)),
// //   //                 ],
// //   //               ),
// //   //             ],
// //   //           ),
// //   //           Spacer(),
// //   //           // Container(decoration: BoxDecoration(image: DecorationImage(image: image)),)
// //   //           Container(
// //   //               height : 60, width : 55,
// //   //               decoration: BoxDecoration(
// //   //                 shape:BoxShape.circle,
// //   //                 image: DecorationImage(image:
// //   //                 NetworkImage(
// //   //                     'https://imgd.aeplcdn.com/642x336/n/cw/ec/103183/raider-125-right-side-view-20.png?isig=0&q=80')),
// //   //               )),
// //   //           // Stack(
// //   //           //   children: [
// //   //           //     Image(
// //   //           //         image: NetworkImage(
// //   //           //             'https://imgd.aeplcdn.com/642x336/n/cw/ec/103183/raider-125-right-side-view-20.png?isig=0&q=80')),
// //   //           //     //  Icon(Icons.bookmark,
// //   //           //     //     size: 35, color: COLOR.appBaseColor),
// //   //           //     // Positioned.fill(
// //   //           //     //   child: Align(
// //   //           //     //     alignment: Alignment.center,
// //   //           //     //     child: Text(
// //   //           //     //       (index + 1).toString(),
// //   //           //     //       style: const TextStyle(
// //   //           //     //           color: Colors.white),
// //   //           //     //     ),
// //   //           //     //   ),
// //   //           //     // ),
// //   //           //   ],
// //   //           // ),
// //   //         ],
// //   //       ),
// //   //   //   ),
// //   //   // ),
// //   // )
// //   // ],
//           ),
//         ],
//       ),
//     );
//   }
//
//   // Widget _topUser(int rank, MonthlyUser user, double height, double opacity) {
//   //   final prize = controller.getPrizeForRank(rank);
//   //   return SizedBox(
//   //     width: 100,
//   //     child: Column(
//   //       children: [
//   //         Text("₹${user.totalAmount}", style: TextStyle(fontWeight: FontWeight.bold)),
//   //         Text("Rank $rank", style: TextStyle(fontSize: 12)),
//   //         CircleAvatar(radius: 25, child: Icon(Icons.person)),
//   //         Container(
//   //           height: height,
//   //           decoration: BoxDecoration(
//   //             color: COLOR.appBaseColor.withOpacity(opacity),
//   //             borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
//   //           ),
//   //           child: Column(
//   //             mainAxisAlignment: MainAxisAlignment.center,
//   //             children: [
//   //               Icon(Icons.bookmark, color: Colors.white),
//   //               if (prize != null)
//   //                 Container(
//   //                   height: 50,
//   //                   width: 50,
//   //                   decoration: BoxDecoration(
//   //                     image: DecorationImage(
//   //                       image: NetworkImage("$IMAGE_URL${prize.prizeImage}"),
//   //                       fit: BoxFit.cover,
//   //                     ),
//   //                   ),
//   //                 ),
//   //             ],
//   //           ),
//   //         ),
//   //       ],
//   //     ),
//   //   );
//   // }
//   Widget _topUser(int rank, MonthlyUser user, List<Prize> prizes) {
//     final prize = prizes.firstWhereOrNull((p) => p.prizePosition == rank);
//
//     final double height = rank == 1 ? 130 : (rank == 2 ? 95 : 75);
//     final double opacity = rank == 1 ? 0.5 : (rank == 2 ? 0.4 : 0.3);
//
//     return SizedBox(
//       width: 100,
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Text(
//             "₹${user.totalAmount}",
//             style: TextStyle(
//               fontWeight: FontWeight.bold,
//               fontSize: 15,
//               color: COLOR.appBaseColor,
//             ),
//           ),
//           const SizedBox(height: 2),
//           Text(
//             "Rank $rank",
//             textAlign: TextAlign.center,
//             style: TextStyle(
//               fontWeight: FontWeight.w500,
//               fontSize: 13,
//               color: COLOR.appBaseColor,
//             ),
//           ),
//           const SizedBox(height: 4),
//           CircleAvatar(
//             radius: 25,
//             backgroundColor: Colors.grey.shade200,
//             child: Icon(Icons.person, size: 30, color: Colors.black87),
//           ),
//           const SizedBox(height: 5),
//           Container(
//             height: height,
//             decoration: BoxDecoration(
//               borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
//               color: COLOR.appBaseColor.withOpacity(opacity),
//             ),
//             child: Center(
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Stack(
//                     children: [
//                       Icon(Icons.bookmark, size: 35, color: COLOR.appBaseColor),
//                       Positioned.fill(
//                         child: Align(
//                           alignment: Alignment.center,
//                           child: Text(
//                             rank.toString(),
//                             style: const TextStyle(
//                               color: Colors.white,
//                               fontSize: 15,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 4),
//                   if (prize != null)
//                     Flexible(
//                       child: Container(
//                         height: 50,
//                         width: 50,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(25),
//                           image: DecorationImage(
//                             image: NetworkImage("$IMAGE_URL${prize.prizeImage}"),
//                             fit: BoxFit.cover,
//                           ),
//                         ),
//                       ),
//                     ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _listTile(MonthlyUser user, Prize? prize) {
//     return Container(
//       padding: const EdgeInsets.symmetric(
//           vertical: 15, horizontal: 05),
//       margin: const EdgeInsets.symmetric(
//           vertical: 08, horizontal: 5),
//       decoration: BoxDecoration(
//         color: COLOR.appBaseColor.withOpacity(0.2),
//         borderRadius: BorderRadius.circular(10),
//       ),
//       child: Row(
//         children: [
//           Container(
//             child: Text(
//               "${(prize!.prizePosition).toString()}.",
//               style: const TextStyle(
//                   color: Colors.black87),
//             ),
//             margin: EdgeInsets.all(06),
//           ),
//           Row(
//             children: [
//               _imageWidget(prize!.prizeImage),
//               const SizedBox(width: 10),
//               Column(
//                 crossAxisAlignment:
//                 CrossAxisAlignment.start,
//                 children: [
//                   Text(user.customerId,
//                       style: const TextStyle(
//                           fontWeight: FontWeight.w500)),
//                   const SizedBox(height: 5),
//                   Text(user.totalAmount,
//                       style: const TextStyle(
//                           fontWeight: FontWeight.bold)),
//                 ],
//               ),
//             ],
//           ),
//           Spacer(),
//           Container(
//               height: 50,
//               width: 55,
//               decoration: BoxDecoration(
//                 shape: BoxShape.circle,
//                 image: DecorationImage(
//                     image: NetworkImage(
//                         IMAGE_URL +  prize.prizeImage
//                     )),
//               ))
//         ],
//       ),
//     );
//     //   ListTile(
//     //   leading: CircleAvatar(child: Text("${user.rank}")),
//     //   title: Text("Customer ${user.customerId}"),
//     //   subtitle: Text("₹${user.totalAmount}"),
//     //   trailing: prize != null
//     //       ? Image.network("$IMAGE_URL${prize.prizeImage}", width: 40, height: 40)
//     //       : null,
//     // );
//   }
//
// // Last row (53) ka special widget
//   Widget _highlightedRow() {
//     return SizedBox(
//       height: 85,
//       child: AnimatedBuilder(
//         animation: _ctrl,
//         builder: (_, __) {
//           return CustomPaint(
//             painter: _BorderSweepPainter(
//               sweepAngle: _ctrl.value * 2 * math.pi,
//               strokeWidth: 4, // Border width
//               color: COLOR.appBaseColor, // Highlight color
//             ),
//             child: Container(
//               padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 05),
// // margin: const EdgeInsets.only(top: 10, bottom: 0),
//               decoration: BoxDecoration(
//                 color: COLOR.appBaseColor.withOpacity(0.2),
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               child: Row(
//                 children: [
//                   Container(
//                     child: Text(
//                       "53.",
//                       style: const TextStyle(color: Colors.black87),
//                     ),
//                     margin: EdgeInsets.all(06),
//                   ),
//                   Row(
//                     children: [
//                       _imageWidget('UsersProfileImage'),
//                       const SizedBox(width: 10),
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text('My Name',
//                               style:
//                               const TextStyle(fontWeight: FontWeight.w500)),
//                           const SizedBox(height: 5),
//                           Text('Point Value',
//                               style:
//                               const TextStyle(fontWeight: FontWeight.bold)),
//                         ],
//                       ),
//                     ],
//                   ),
//                   Spacer(),
//                   Container(
//                     height: 60,
//                     width: 55,
//                     decoration: BoxDecoration(
//                       shape: BoxShape.circle,
//                       image: DecorationImage(
//                         image: NetworkImage(
//                             'https://imgd.aeplcdn.com/642x336/n/cw/ec/103183/raider-125-right-side-view-20.png?isig=0&q=80'),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
//
// // Last mein isko call kar instead of purane wale 53 wale section ke
// // Replace this part in your build method:
//
// // OLD CODE (remove this):
// /*
// SizedBox(
//   height: 85,
//   child: AnimatedBuilder(
//     animation: _ctrl,
//     builder: (_, __) {
//       return CustomPaint(
//         painter: _BorderSweepPainter(
//           sweepAngle: _ctrl.value * 2 * math.pi,
//           strokeWidth: 0,
//           color: COLOR.appBaseColor,
//         ),
//         child: Container(...)
//       );
//     },
//   ),
// )
// */
// }
//
//
// class _BorderSweepPainter extends CustomPainter {
//   final double sweepAngle;
//   final double strokeWidth;
//   final Color color;
//
//   _BorderSweepPainter({
//     required this.sweepAngle,
//     required this.strokeWidth,
//     required this.color,
//   });
//
//   @override
//   void paint(Canvas canvas, Size size) {
//     final rect = Offset.zero & size;
//     final rrect = RRect.fromRectAndRadius(
//       rect.deflate(strokeWidth / 2),
//       const Radius.circular(20),
//     );
//
//     // full border gray (static)
//     final grayPaint = Paint()
//       ..color = Colors.grey[800]!
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = strokeWidth;
//
//     canvas.drawRRect(rrect, grayPaint);
//
//     // sweeping color arc (only border)
//     final sweepPaint = Paint()
//       ..shader = SweepGradient(
//         colors: [color.withOpacity(0), color, color.withOpacity(0)],
//         stops: const [0.0, 0.1, 0.2],
//         transform: GradientRotation(sweepAngle),
//       ).createShader(rect)
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = strokeWidth;
//
//     canvas.drawRRect(rrect, sweepPaint);
//   }
//
//   @override
//   bool shouldRepaint(covariant _BorderSweepPainter old) =>
//       old.sweepAngle != sweepAngle;
// }
