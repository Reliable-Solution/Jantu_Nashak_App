// flutter
import 'package:carousel_slider/carousel_slider.dart';
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
                Container(
                  color: COLOR.background,
                  margin: EdgeInsets.all(2),
                  padding: EdgeInsets.all(6),
                  // padding: EdgeInsets.symmetric(vertical: 10),
                  width: MediaQuery.of(context).size.width,
                  child: GetBuilder<HomeController>(builder: (controller) {
                    return controller.isDashBoardLoading.value
                        ? SizedBox(
                            height: MediaQuery.of(context).size.height,
                            child: Center(child: CircularProgressIndicator()))
                        : Column(
                            children: [
                              ///  DashBoard offers
                              Padding(
                                padding: const EdgeInsets.all(0),
                                child: Container(
                                  padding: EdgeInsets.symmetric(vertical: 5),
                                  width: MediaQuery.of(context).size.width,
                                  color: COLOR.background,
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10),
                                        child: Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.23,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: CarouselSlider.builder(
                                            itemCount:
                                                controller.offerList.length,
                                            itemBuilder:
                                                (context, index, realIndex) {
                                              return Container(
                                                decoration: BoxDecoration(
                                                  color: COLOR.pinkLight,
                                                  image: DecorationImage(
                                                    image: NetworkImage(
                                                        '$IMAGE_URL${controller.offerList[index].offerImage}'),
                                                    fit: BoxFit.cover,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                              );
                                            },
                                            options: CarouselOptions(
                                              enlargeCenterPage: true,
                                              autoPlay: true,
                                              onPageChanged: (index, reason) {
                                                controller.activeIndex.value =
                                                    index;
                                                controller.update();
                                              },
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 5),
                                        child: buildIndicator(),
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                              ///  DashBoard category
                              GridView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  childAspectRatio: 1.5 / 2,
                                ),
                                itemCount: controller.categoryList.length,
                                itemBuilder: (context, index) {
                                  return Container(
                                    color: COLOR.background,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          height: Get.width > 360
                                              ? MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.14
                                              : MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.15,
                                          decoration: BoxDecoration(
                                            color: COLOR.amber,
                                            image: DecorationImage(
                                              image: NetworkImage(
                                                '$IMAGE_URL${controller.categoryList[index].categoryImage}',
                                              ),
                                              fit: BoxFit.cover,
                                            ),
                                            // border: Border.all(width: 5)
                                          ),
                                        ),
                                        Text(
                                          controller
                                              .categoryList[index].categoryName,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),

                              /// Dashboard products
                              GridView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  childAspectRatio: 1.5 / 2,
                                ),
                                itemCount: controller.productList.length,
                                itemBuilder: (context, index) {
                                  return Container(
                                    color: COLOR.background,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          height: Get.width > 360
                                              ? MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.14
                                              : MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.15,
                                          decoration: BoxDecoration(
                                            color: COLOR.amber,
                                            image: DecorationImage(
                                              image: NetworkImage(
                                                '$IMAGE_URL${controller.productList[index].subcategoryImage}',
                                              ),
                                              fit: BoxFit.cover,
                                            ),
                                            // border: Border.all(width: 5)
                                          ),
                                        ),
                                        Text(
                                          controller
                                              .productList[index].productName ?? "",
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ],
                          );
                  }),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildIndicator() {
    return GetBuilder<HomeController>(builder: (controller) {
      return AnimatedSmoothIndicator(
        activeIndex: controller.activeIndex.value,
        count: controller.offerList.length,
        effect: ExpandingDotsEffect(
          dotWidth: 6,
          dotHeight: 4,
          activeDotColor: COLOR.pink,
          dotColor: COLOR.grey.withOpacity(0.5),
        ),
      );
    });
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
