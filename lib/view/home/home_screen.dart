// flutter
import 'package:flutter/material.dart';
// package
import 'package:get/get.dart';
import 'package:keep_app/constant/app_constant.dart';
import 'package:keep_app/view/SharedProducts/sharedProductScreen.dart';
import 'package:keep_app/view/home/SliverAppBarDelegate.dart';
import 'package:keep_app/view/home/priceStroescreen.dart';
import 'package:keep_app/view/home/widget/homeProductHeader.dart';
import 'package:keep_app/view/home/widget/homeProductList.dart';
import 'package:keep_app/widget/alignWidget.dart';
import 'package:keep_app/widget/dividerWidgets.dart';
import 'package:keep_app/widget/inputWidget.dart';
import 'package:keep_app/widget/textButtonWidget.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../constant/colorConst.dart';
import '../../constant/imagesConst.dart';
import '../../controller/homeController.dart';
import '../../theme/nativeTheme.dart';
import '../../widget/iconButtonWidget.dart';
import '../../widget/textWidget.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  final HomeController _controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: COLOR.greyLight,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            snap: false,
            pinned: true,
            floating: true,
            backgroundColor: COLOR.background,
            title: Obx(() => TextWiget(
              title: _controller.customerModel != null
                  ? _controller.customerModel!.value.customerName
                  : "",
              style: Themes.light.textTheme.displayLarge,
            )),
            leading: Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(Images.profileicon),
                      fit: BoxFit.cover,
                    ),
                    shape: BoxShape.circle,
                    color: COLOR.greyLight,
                  ),
                )),
            // actions: [
            //   IconButtonWidget(
            //     voidCallback: () {
            //       Get.to(() => ShareProductScreen());
            //     },
            //     icons: Icons.favorite_border,
            //     color: COLOR.black,
            //   ),
            //   IconButtonWidget(
            //     voidCallback: () {
            //       Get.to(() => NotificationHomeScreen());
            //     },
            //     icons: Icons.notifications_none,
            //     color: COLOR.black,
            //   ),
            //   IconButtonWidget(
            //     voidCallback: () {
            //       Get.to(() => AddToCardScreen());
            //     },
            //     icons: Icons.shopping_cart_outlined,
            //     color: COLOR.black,
            //   ),
            // ],
            elevation: 0,
          ),
          SliverPersistentHeader(
            floating: false,
            pinned: true,
            delegate: SliverAppBarDelegate(
              child: PreferredSize(
                preferredSize: Size.fromHeight(50),
                child: InkWell(
                  onTap: () {
                    // Get.to(() => SearchScreen());
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    color: COLOR.background,
                    padding: EdgeInsets.symmetric(horizontal: 13, vertical: 2),
                    child: Card(
                      elevation: 0,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.07,
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          color: COLOR.background,
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                            color: COLOR.grey,
                            width: 1,
                          ),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.search,
                              size: 25,
                              color: COLOR.grey,
                            ),
                            SizedBox(width: 4),
                            Expanded(
                              child: TextWiget(
                                // title: 'Search Keyword or Product ID',
                                title: 'Search Product',
                              ),
                            ),
                            // VerticalDivider(thickness: 1, color: COLOR.grey),
                            // InkWell(
                            //   onTap: () {},
                            //   child: Icon(
                            //     Icons.camera_alt_outlined,
                            //     color: COLOR.grey,
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Container(
                  color: COLOR.purpleLight,
                  child: InkWell(
                    onTap: () => openBottomSheetDelivery(context),
                    child: Padding(
                      padding:
                      EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                      child: Row(
                        children: <Widget>[
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Icon(
                              Icons.location_on_outlined,
                              color: COLOR.purple,
                              size: 20,
                            ),
                          ),
                          TextWiget(
                              title:
                              'Add delivery location to get extra discount',
                              style: Themes.dark.textTheme.displayLarge),
                          Icon(Icons.navigate_next),
                        ],
                      ),
                    ),
                  ),
                ),
                // Container(
                //   color: COLOR.background,
                //   alignment: Alignment.center,
                //   child: Padding(
                //     padding: EdgeInsets.symmetric(vertical: 8),
                //     child: HomecategoriesList(),
                //   ),
                // ),
                //

                Container(
                  color: Colors.white,
                  margin: EdgeInsets.all(2),
                  padding: EdgeInsets.all(6),
                  // padding: EdgeInsets.symmetric(vertical: 10),
                  width: MediaQuery.of(context).size.width,
                  child: GetBuilder<HomeController>(builder: (controller) {
                    return GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        childAspectRatio: 1.6 / 2,
                        // crossAxisSpacing: 7,
                        // mainAxisSpacing: 7,
                      ),
                      // padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      itemCount: controller.categoryList.length,
                      itemBuilder: (context, index) {
                        return Container(
                          color: COLOR.background,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: () {
                                  // controller.fetchSubCategoryData(controller.categoryList[index].categoryId);
                                   Get.to(() => SubCategoryScreen(category: "${controller.categoryList[index].categoryId}",));
                                },
                                child: Container(
                                  height: Get.width > 360
                                      ? MediaQuery.of(context).size.height *
                                      0.14
                                      : MediaQuery.of(context).size.height *
                                      0.15,
                                  decoration: BoxDecoration(
                                    color: COLOR.amber,
                                    image: DecorationImage(
                                      // colorFilter: new ColorFilter.mode(
                                      //     COLOR.black.withOpacity(0.8),
                                      //     BlendMode.dstATop),
                                      image: NetworkImage(
                                        '$IMAGE_URL${controller.categoryList[index].categoryImage}',
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                    // border: Border.all(width: 5)
                                  ),
                                ),
                              ),
                              // Expanded(
                              //   child: AlignWidget(
                              //     alignment: Alignment.center,
                              //     child: TextWiget(
                              //       title: controller
                              //           .categoryList[index].categoryName,
                              //       style: Themes.light.textTheme.displaySmall!
                              //           .copyWith(fontWeight: FontWeight.w600),
                              //     ),
                              //   ),
                              // ),
                            ],
                          ),
                        );
                      },
                    );
                  }),
                ),

                // Padding(
                //   padding: const EdgeInsets.all(0),
                //   child: Obx(
                //     () => Container(
                //       padding: EdgeInsets.symmetric(vertical: 5),
                //       width: MediaQuery.of(context).size.width,
                //       color: COLOR.background,
                //       child: Column(
                //         children: [
                //           Padding(
                //             padding: const EdgeInsets.symmetric(vertical: 10),
                //             child: Container(
                //               height: MediaQuery.of(context).size.height * 0.23,
                //               width: MediaQuery.of(context).size.width,
                //               child: CarouselSlider.builder(
                //                 itemCount: _controller.sliderImage.length,
                //                 itemBuilder: (context, index, realIndex) {
                //                   return Container(
                //                     decoration: BoxDecoration(
                //                       color: COLOR.pinkLight,
                //                       image: DecorationImage(
                //                         image: NetworkImage(_controller.sliderImage[index]),
                //                         fit: BoxFit.cover,
                //                       ),
                //                       borderRadius: BorderRadius.circular(10),
                //                     ),
                //                   );
                //                 },
                //                 options: CarouselOptions(
                //                   enlargeCenterPage: true,
                //                   autoPlay: true,
                //                   onPageChanged: (index, reason) {
                //                     _controller.activeIndex.value = index;
                //                   },
                //                 ),
                //               ),
                //             ),
                //           ),
                //           Padding(
                //             padding: const EdgeInsets.only(top: 5),
                //             child: buildIndicator(),
                //           ),
                //           Padding(
                //             padding: const EdgeInsets.only(top: 10),
                //             child: Container(
                //               height: Get.height >= 800 ? MediaQuery.of(context).size.height * 0.07 : MediaQuery.of(context).size.height * 0.09,
                //               width: MediaQuery.of(context).size.width,
                //               decoration: BoxDecoration(
                //                 color: Colors.blue[100],
                //                 borderRadius: BorderRadius.circular(7),
                //               ),
                //               child: Padding(
                //                 padding: const EdgeInsets.symmetric(horizontal: 15),
                //                 child: Row(
                //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //                   children: <Widget>[
                //                     Row(
                //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //                       children: [
                //                         FittedBox(
                //                           child: Row(
                //                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //                             children: <Widget>[
                //                               CircleAvatar(
                //                                 backgroundColor: COLOR.background,
                //                                 maxRadius: 18,
                //                                 backgroundImage: AssetImage(Images.cash),
                //                               ),
                //                               Padding(
                //                                 padding: EdgeInsets.only(left: 6),
                //                                 child: Column(
                //                                   children: [
                //                                     TextWiget(
                //                                       title: 'Cash on',
                //                                       style: Themes.light.textTheme.displayMedium!.copyWith(fontWeight: FontWeight.w700),
                //                                     ),
                //                                     TextWiget(
                //                                       title: 'Delivery',
                //                                       style: Themes.light.textTheme.displayMedium!.copyWith(fontWeight: FontWeight.w700),
                //                                     ),
                //                                   ],
                //                                 ),
                //                               )
                //                             ],
                //                           ),
                //                         ),
                //                       ],
                //                     ),
                //                     Padding(
                //                       padding: EdgeInsets.symmetric(vertical: 10),
                //                       child: VerticalDivider(
                //                         thickness: 2,
                //                         color: COLOR.background,
                //                       ),
                //                     ),
                //                     FittedBox(
                //                       child: Row(
                //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //                         children: <Widget>[
                //                           CircleAvatar(
                //                             backgroundColor: COLOR.background,
                //                             maxRadius: 18,
                //                             backgroundImage: AssetImage(Images.delivery),
                //                           ),
                //                           Container(
                //                             child: Padding(
                //                               padding: EdgeInsets.only(left: 6),
                //                               child: Column(
                //                                 children: [
                //                                   TextWiget(
                //                                     title: 'Free Delivery',
                //                                     style: Themes.light.textTheme.displayMedium!.copyWith(fontWeight: FontWeight.w700),
                //                                   ),
                //                                   TextWiget(
                //                                     title: 'Free Returns',
                //                                     style: Themes.light.textTheme.displayMedium!.copyWith(fontWeight: FontWeight.w700),
                //                                   ),
                //                                 ],
                //                               ),
                //                             ),
                //                           )
                //                         ],
                //                       ),
                //                     ),
                //                     Padding(
                //                       padding: EdgeInsets.symmetric(vertical: 10),
                //                       child: VerticalDivider(
                //                         thickness: 2,
                //                         color: COLOR.background,
                //                       ),
                //                     ),
                //                     FittedBox(
                //                       child: Row(
                //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //                         children: <Widget>[
                //                           CircleAvatar(
                //                             backgroundColor: COLOR.background,
                //                             maxRadius: 18,
                //                             backgroundImage: AssetImage(Images.delivery),
                //                           ),
                //                           Padding(
                //                             padding: EdgeInsets.only(left: 6),
                //                             child: Column(
                //                               children: [
                //                                 TextWiget(
                //                                   title: 'Lowest',
                //                                   style: Themes.light.textTheme.displayMedium!.copyWith(
                //                                     fontWeight: FontWeight.w700,
                //                                   ),
                //                                 ),
                //                                 TextWiget(
                //                                   title: 'Price',
                //                                   style: Themes.light.textTheme.displayMedium!.copyWith(
                //                                     fontWeight: FontWeight.w700,
                //                                   ),
                //                                 ),
                //                               ],
                //                             ),
                //                           )
                //                         ],
                //                       ),
                //                     )
                //                   ],
                //                 ),
                //               ),
                //             ),
                //           ),
                //           // Container(
                //           //   height: MediaQuery.of(context).size.height * 0.06,
                //           //   width: MediaQuery.of(context).size.width,
                //           //   child: Padding(
                //           //     padding: const EdgeInsets.symmetric(horizontal: 15),
                //           //     child: Row(
                //           //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //           //       children: <Widget>[
                //           //         TextWiget(
                //           //           title: 'Best Sellers',
                //           //           style: Themes.light.textTheme.headlineSmall,
                //           //         ),
                //           //         InkWell(
                //           //           onTap: () {
                //           //             // Get.to(() => BestSellersScreen());
                //           //           },
                //           //           child: TextWiget(
                //           //             title: 'VIEW ALL',
                //           //             style: Themes.light.textTheme.displaySmall!.copyWith(
                //           //               color: COLOR.pink,
                //           //               fontWeight: FontWeight.w600,
                //           //             ),
                //           //           ),
                //           //         )
                //           //       ],
                //           //     ),
                //           //   ),
                //           // ),
                //           // Container(
                //           //   width: MediaQuery.of(context).size.width,
                //           //   height: MediaQuery.of(context).size.height * 0.22,
                //           //   color: COLOR.background,
                //           //   child: ListView.builder(
                //           //     padding: EdgeInsets.symmetric(horizontal: 15),
                //           //     scrollDirection: Axis.horizontal,
                //           //     itemCount: _controller.bestSellerlist.length,
                //           //     itemBuilder: (context, index) {
                //           //       return Column(
                //           //         children: [
                //           //           Padding(
                //           //             padding: const EdgeInsets.only(right: 10),
                //           //             child: InkWell(
                //           //               onTap: () {
                //           //                 // Get.to(() => PriceStroeScreen());
                //           //               },
                //           //               child: Container(
                //           //                 height: Get.width > 360 ? MediaQuery.of(context).size.height * 0.14 : MediaQuery.of(context).size.height * 0.15,
                //           //                 width: 100,
                //           //                 decoration: BoxDecoration(
                //           //                   color: COLOR.amber,
                //           //                   image: DecorationImage(
                //           //                     colorFilter: new ColorFilter.mode(COLOR.black.withOpacity(0.8), BlendMode.dstATop),
                //           //                     image: NetworkImage(
                //           //                       _controller.bestSellerlist[index].image!,
                //           //                     ),
                //           //                     fit: BoxFit.cover,
                //           //                   ),
                //           //                   borderRadius: BorderRadius.circular(10),
                //           //                 ),
                //           //               ),
                //           //             ),
                //           //           ),
                //           //           Padding(
                //           //             padding: const EdgeInsets.only(top: 10),
                //           //             child: TextWiget(
                //           //                 title: _controller.bestSellerlist[index].name,
                //           //                 style: Themes.light.textTheme.bodyLarge!.copyWith(
                //           //                   color: COLOR.grey,
                //           //                   fontWeight: FontWeight.w600,
                //           //                 )),
                //           //           ),
                //           //           Padding(
                //           //             padding: const EdgeInsets.only(bottom: 0),
                //           //             child: TextWiget(
                //           //               title: 'From ₹${_controller.bestSellerlist[index].price!.toStringAsFixed(0)}',
                //           //               style: Themes.light.textTheme.displaySmall!.copyWith(
                //           //                 fontWeight: FontWeight.w600,
                //           //                 color: COLOR.black,
                //           //               ),
                //           //             ),
                //           //           )
                //           //         ],
                //           //       );
                //           //     },
                //           //   ),
                //           // ),
                //         ],
                //       ),
                //     ),
                //   ),
                // ),
                // Padding(
                //   padding: const EdgeInsets.only(top: 10),
                //   child: Container(
                //     width: MediaQuery.of(context).size.width,
                //     color: COLOR.background,
                //     child: HomePriceList(),
                //   ),
                // ),
                // Padding(
                //   padding: const EdgeInsets.only(top: 10),
                //   child: Container(
                //     width: MediaQuery.of(context).size.width,
                //     color: COLOR.background,
                //     child: TopDemandList(),
                //   ),
                // ),
                // Padding(
                //   padding: const EdgeInsets.only(top: 10, bottom: 8),
                //   child: Container(
                //     width: MediaQuery.of(context).size.width,
                //     color: COLOR.background,
                //     child: HomeTrendingList(),
                //   ),
                // ),
                Container(
                  color: COLOR.background,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: <Widget>[
                      DividerWidget(thickness: 1),
                      Padding(
                        padding:
                        EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                        child: AlignWidget(
                          alignment: Alignment.centerLeft,
                          child: TextWiget(
                            // title: 'Products For You',
                            title: 'Trending Products',
                            style: Themes.light.textTheme.headlineSmall,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SliverPersistentHeader(
            floating: false,
            pinned: true,
            delegate: SliverAppBarDelegate(
              child: PreferredSize(
                preferredSize: Size.fromHeight(45),
                child: InkWell(
                  onTap: () {},
                  child: HomeProductHeader(),
                ),
              ),
            ),
          ),
          // SliverGrid(
          //   delegate: SliverChildBuilderDelegate(
          //         (context, index) {
          //       final products = _controller.productsList[index];
          //       return HomeProductList(products: products);
          //     },
          //     childCount: _controller.productsList.length,
          //   ),
          //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          //     crossAxisCount: 2,
          //     childAspectRatio: Get.width >= 480 ? 1.15 / 2 : 1 / 2.1,
          //     crossAxisSpacing: 2,
          //     mainAxisSpacing: 2,
          //   ),
          // ),
        ],
      ),
    );
  }

  Widget buildIndicator() {
    return AnimatedSmoothIndicator(
      activeIndex: _controller.activeIndex.value,
      count: _controller.sliderImage.length,
      effect: ExpandingDotsEffect(
        dotWidth: 6,
        dotHeight: 4,
        activeDotColor: COLOR.pink,
        dotColor: COLOR.grey.withOpacity(0.5),
      ),
    );
  }

  void openBottomSheetDelivery(BuildContext context) {
    Get.bottomSheet(
      Container(
        height: MediaQuery.of(context).size.height * 0.24,
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.08,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        TextWiget(
                          title: 'ADD DELIVERY LOCATION',
                          style: Themes.light.textTheme.displaySmall!
                              .copyWith(color: COLOR.background),
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
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                alignment: Alignment.centerLeft,
                child: Form(
                  child: GetBuilder<HomeController>(
                    builder: (_controller) => SizedBox(
                      width: MediaQuery.of(context).size.width * 0.6,
                      child: InputFiledArea(
                        controller: _controller.deliveryPincode,
                        maxlength: 6,
                        counterText: '',
                        focusNode: _controller.fdeliveryPincode,
                        style: Themes.light.textTheme.displayLarge,
                        keyboardType: TextInputType.number,
                        labelText: 'Type Delivery Pincode',
                        suffixIcon: TextButtonWidget(
                          text: 'SUBMIT',
                          border: 1,
                          style: Themes.light.textTheme.displaySmall!
                              .copyWith(color: COLOR.pink),
                          onPressed: (_controller.deliveryPincode.text
                              .trim()
                              .isNotEmpty)
                              ? () {
                            Get.back();
                          }
                              : null,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            )
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
}
