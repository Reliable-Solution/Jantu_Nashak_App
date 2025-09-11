// flutter
import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:keep_app/constant/app_constant.dart';
import 'package:keep_app/controller/cartController.dart';
import 'package:keep_app/controller/dashboardController.dart';
import 'package:keep_app/controller/editController.dart';
import 'package:keep_app/view/Crop/crop_screen.dart';
import 'package:keep_app/view/account/account_screen.dart';
import 'package:keep_app/view/dashboard/dashboardScreen.dart';
import 'package:keep_app/view/home/SliverAppBarDelegate.dart';
import 'package:keep_app/view/leadership%20&%20reward/leadership%20main.dart';
import 'package:keep_app/view/video_player/video_list_screen.dart';
import 'package:keep_app/view/wishlist/wishlist_screen.dart';
import 'package:keep_app/widget/alignWidget.dart';
import 'package:keep_app/widget/categoryWidget.dart';
import 'package:keep_app/widget/dividerWidgets.dart';
import 'package:keep_app/widget/inputWidget.dart';
import 'package:keep_app/widget/productWidget.dart';
import 'package:keep_app/widget/textButtonWidget.dart';
import 'package:share_plus/share_plus.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../constant/colorConst.dart';
import '../../constant/imagesConst.dart';
import '../../controller/homeController.dart';
import '../../controller/languageController.dart';
import '../../controller/productDetailController.dart';
import '../../main.dart';
import '../../models/productModel.dart';
import '../../theme/nativeTheme.dart';
import '../../utils/sharedPrefs.dart';
import '../../utils/string_res.dart';
import '../../widget/category_detail_shimmer.dart';
import '../../widget/iconButtonWidget.dart';
import '../../widget/languageWidget.dart';
import '../../widget/service_shimmer.dart';
import '../../widget/textWidget.dart';
import '../AddtoCard/cartScreen.dart';
import '../account/editProfile.dart';
import '../address/allAddress_screen.dart';
import 'package:keep_app/view/otp/phone_auth.dart';

import '../faq/faq_screen.dart';
import '../order/orderScreen.dart';
import '../refer & earn/refer&earn_screen.dart';
import '../search/search_screen.dart';
import '../webView/webView_screen.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeController _controller = Get.put(HomeController());

  // ensure registration
  final CartController cartController = Get.put(CartController());
  final RxString selectedLang = "English".obs;

  ProductDetailsController productDetailsController = Get.find();

  EditProfileController editProfileController = Get.find();

  final LanguageController languageController = Get.find<LanguageController>();

  final List<String> searchLabels = [
    StringRes.searchProduct,
    StringRes.searchBrand,
    StringRes.searchInsecticide,
    StringRes.searchSuperKiller,
    StringRes.searchCoragen
    // 'Search Product',
    // 'Search Brand',
    // 'Search Insecticide',
    // 'Search SuperKiller',
    // 'Search Coragen',
  ];

  productRemove() {
    productDetailsController.isCart = false;
    productDetailsController.update();
  }

  ScrollController _scrollController = ScrollController();
  RxBool _showSliverAppBar = false.obs;

  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    languageController.loadLanguage();
  }

  void _onScroll() {
    print('Scroll position: ${_scrollController.position.pixels}');

    // Example: hide something after 100px
    if (_scrollController.position.pixels > 100) {
      print("Hiding app bar");
      setState(() {
        _showSliverAppBar.value = true;
        print("Hello World Scroller ${_scrollController.position.pixels}");
        print("Hello World Scroller ${_showSliverAppBar}");
      });
    } else {
      setState(() {
        _showSliverAppBar.value = false;
      });
      // _showSliverAppBar.value = false;

      print("Showing app bar");
      // Do something like hiding app bar or loading more
    }
  }

  @override
  Widget build(BuildContext context) {
    print("HomeScreen name: ${_controller.customerModel!.value?.customerName}");

    print("language changes ${StringRes.searchProduct}");
    return SafeArea(
      child: Scaffold(
        backgroundColor: COLOR.greyLight,
        // drawer: Drawer(),
        body: GetBuilder<HomeController>(builder: (controller) {
          if (controller.isDashBoardLoading.value ||
              controller.categoryList.isEmpty) {
            return ServicesShimmer(); // Show shimmer while loading or if categoryList is empty
          }
          return controller.categoryList.isEmpty
              ? Container(
                  margin: EdgeInsets.only(top: 25),
                  padding: EdgeInsets.all(0),
                  child: SizedBox())
              : CustomScrollView(
                  controller: _scrollController, // <- attach here

                  physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics()),
                  slivers: [
                    SliverAppBar(
                      leading: SizedBox(),
                      backgroundColor: COLOR.appBaseColor,
                      actionsPadding: EdgeInsets.symmetric(horizontal: 10),
                      snap: false,
                      // pinned: true,
                      floating: false,
                      flexibleSpace: FlexibleSpaceBar(
                        background: Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: Row(
                            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Builder(
                                builder: (context) =>
                                    // ,
                                    // child:
                                    InkWell(
                                  onTap: () {
                                    Scaffold.of(context).openDrawer();
                                  },
                                  child: Padding(
                                      padding: const EdgeInsets.only(right: 08),
                                      child: Container(
                                        height: 50,
                                        width: 70,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image:

                                                // backgroundImage:
                                                editProfileController.m1.value!
                                                            .customerImage! ==
                                                        null
                                                    ? AssetImage(
                                                        Images.profileicon)
                                                    : NetworkImage(IMAGE_URL +
                                                        editProfileController
                                                            .m1
                                                            .value!
                                                            .customerImage!),

                                            // AssetImage(Images.profileicon),
                                            fit: BoxFit.cover,
                                          ),
                                          shape: BoxShape.circle,
                                          color: COLOR.greyLight,
                                        ),
                                      )),
                                ),
                              ),
                              // CircleAvatar(
                              //   radius: 32,
                              //   child: ,
                              //   backgroundImage: AssetImage(Images.profileicon),
                              // ),
                              Obx(() => TextWiget(
                                    title: _controller.customerModel != null
                                        ? "${StringRes.hello} ${editProfileController.m1.value!.customerName!}"
                                        : StringRes.hello,
                                    style: Themes.light.textTheme.displayMedium,
                                  )),
                              Spacer(),
                              GetBuilder<HomeController>(
                                builder: (_controller) =>
                                    // ,
                                    // () =>
                                    // child:F
                                    Container(
                                  height: 30,
                                  // width: 80,
                                  padding: EdgeInsets.symmetric(horizontal: 10),

                                  alignment: Alignment.center,

                                  // color: Colors.yellow,
                                  decoration: BoxDecoration(
                                      color: Colors.yellow.shade500,
                                      borderRadius: BorderRadius.horizontal(
                                          right: Radius.circular(10),
                                          left: Radius.circular(10))),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Icon(
                                        Icons.money,
                                        size: 18,
                                      ),
                                      Text(
                                        editProfileController.m1.value!.points!,
                                        // "${_controller.customerModel!.value.points}",
                                        // "${controller.m1 != null ? controller.m1!.points != null || controller.m1!.points!.isNotEmpty ? controller.m1!.points : 0 : 0}",
                                        style: TextStyle(fontSize: 16),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Stack(
                                children: [
                                  IconButtonWidget(
                                    voidCallback: () {
                                      cartController.getCartDetails(
                                          cartController.customerModel!.value
                                              .customerId!);
                                      cartController.redeemPointsController
                                          .clear();
                                      cartController.getCartTotal(cartController
                                          .customerModel!.value.customerId!);
                                      // cartController.redeemPointsController.clear();

                                      Get.to(
                                        () => CartScreen(
                                          removeCart: productRemove,
                                        ),
                                        // transition: Transition.rightToLeftWithFade,
                                      );
                                    },
                                    icons: Icons.shopping_cart_outlined,
                                    color: COLOR.background,
                                  ),
                                  Positioned(
                                    right: 0,
                                    top: 0,
                                    child: GetBuilder<CartController>(
                                        builder: (cartController) {
                                      cartController.cartCount.value =
                                          cartController.cartList.length;
                                      return cartController.cartCount.value > 0
                                          ? Container(
                                              padding: EdgeInsets.all(5),
                                              alignment: Alignment.centerLeft,
                                              decoration: BoxDecoration(
                                                color: Colors.red,
                                                shape: BoxShape.circle,
                                              ),
                                              child: Text(
                                                cartController.cartCount.value
                                                    .toString(),
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            )
                                          : SizedBox();
                                    }),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      // title: Obx(() => TextWiget(
                      //       title: _controller.customerModel != null
                      //           ? "${StringRes.hello} ${_controller.customerModel!.value.customerName}"
                      //           : StringRes.hello,
                      //       style: Themes.light.textTheme.displayMedium,
                      //     )),
                      // actions: [
                      //   // IconButton(
                      //   //     onPressed: () {
                      //   //       Get.to(
                      //   //         () => WishlistScreen(),
                      //   //         transition: Transition.rightToLeftWithFade,
                      //   //       );
                      //   //     },
                      //   //     icon: Icon(Icons.favorite_border,
                      //   //       color: COLOR.background,
                      //   //
                      //   //     )),
                      //   Stack(
                      //     children: [
                      //       IconButtonWidget(
                      //         voidCallback: () {
                      //           cartController.getCartDetails(cartController
                      //               .customerModel!.value.customerId!);
                      //           cartController.getCartTotal(cartController
                      //               .customerModel!.value.customerId!);
                      //
                      //           Get.to(
                      //             () => CartScreen(
                      //               removeCart: productRemove,
                      //             ),
                      //             // transition: Transition.rightToLeftWithFade,
                      //           );
                      //         },
                      //         icons: Icons.shopping_cart_outlined,
                      //         color: COLOR.background,
                      //       ),
                      //       Positioned(
                      //         right: 0,
                      //         top: 0,
                      //         child: GetBuilder<CartController>(
                      //             builder: (cartController) {
                      //           cartController.cartCount.value =
                      //               cartController.cartList.length;
                      //           return cartController.cartCount.value > 0
                      //               ? Container(
                      //                   padding: EdgeInsets.all(5),
                      //                   alignment: Alignment.centerLeft,
                      //                   decoration: BoxDecoration(
                      //                     color: Colors.red,
                      //                     shape: BoxShape.circle,
                      //                   ),
                      //                   child: Text(
                      //                     cartController.cartCount.value
                      //                         .toString(),
                      //                     style: TextStyle(
                      //                       color: Colors.white,
                      //                       fontSize: 12,
                      //                       fontWeight: FontWeight.bold,
                      //                     ),
                      //                   ),
                      //                 )
                      //               : SizedBox();
                      //         }),
                      //       ),
                      //     ],
                      //   ),
                      // ],
                      // leading: Padding(
                      //     padding: const EdgeInsets.only(left: 15),
                      //     child: Container(
                      //       height: 70,
                      //       width: 70,
                      //       decoration: BoxDecoration(
                      //         image: DecorationImage(
                      //           image: AssetImage(Images.profileicon),
                      //           fit: BoxFit.cover,
                      //         ),
                      //         shape: BoxShape.circle,
                      //         color: COLOR.greyLight,
                      //       ),
                      //     )),
                      // elevation: 0,
                    ),
                    SliverPersistentHeader(
                      floating: false,
                      pinned: true,
                      delegate: SliverAppBarDelegate(
                        child: PreferredSize(
                          preferredSize: Size.fromHeight(65),
                          child: GetBuilder<HomeController>(
                            builder: (_controller) => Container(
                              color: COLOR.appBaseColor,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: InkWell(
                                      onTap: () {
                                        _controller.searchList.clear();
                                        _controller.blogList.clear();
                                        _controller.searchController.clear();
                                        Get.to(() => SearchScreen());
                                      },
                                      child: Container(
                                        width: MediaQuery.of(Get.context!)
                                            .size
                                            .width,
                                        color: COLOR.appBaseColor,
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 13, vertical: 2),
                                        child: Card(
                                          elevation: 0,
                                          child: Container(
                                            width: MediaQuery.of(Get.context!)
                                                .size
                                                .width,
                                            height: MediaQuery.of(Get.context!)
                                                    .size
                                                    .height *
                                                0.07,
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10),
                                            decoration: BoxDecoration(
                                              color: COLOR.background,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              border: Border.all(
                                                color: COLOR.grey,
                                                width: 1,
                                              ),
                                            ),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Icon(
                                                      Icons.search,
                                                      size: 25,
                                                      color: COLOR.grey,
                                                    ),
                                                    SizedBox(width: 4),
                                                    GetBuilder<HomeController>(
                                                      builder: (_controller) =>
                                                          AnimatedSwitcher(
                                                        duration: Duration(
                                                            milliseconds: 600),
                                                        transitionBuilder:
                                                            (Widget child,
                                                                Animation<
                                                                        double>
                                                                    animation) {
                                                          final isNew = child
                                                                  .key ==
                                                              ValueKey<String>(
                                                                _controller
                                                                        .searchLabels[
                                                                    _controller
                                                                        .currentLabelIndex
                                                                        .value],
                                                              );
                                                          print(
                                                              "==========>Language ${_controller.searchLabels[_controller.currentLabelIndex.value]}");
                                                          final offsetTween = isNew
                                                              ? Tween<Offset>(
                                                                  begin: Offset(
                                                                      0, 0.6),
                                                                  end: Offset(
                                                                      0, 0))
                                                              : Tween<Offset>(
                                                                  begin: Offset(
                                                                      0, 0),
                                                                  end: Offset(
                                                                      0, -0.0));

                                                          return SlideTransition(
                                                            position:
                                                                offsetTween
                                                                    .animate(
                                                              CurvedAnimation(
                                                                parent:
                                                                    animation,
                                                                curve: Curves
                                                                    .easeInOutCubic,
                                                                reverseCurve: Curves
                                                                    .easeInOutCubic,
                                                              ),
                                                            ),
                                                            child:
                                                                FadeTransition(
                                                              opacity:
                                                                  CurvedAnimation(
                                                                parent:
                                                                    animation,
                                                                curve: isNew
                                                                    ? Interval(
                                                                        0.2,
                                                                        1.0,
                                                                        curve: Curves
                                                                            .easeIn)
                                                                    : Interval(
                                                                        0.0,
                                                                        0.8,
                                                                        curve: Curves
                                                                            .easeOut),
                                                              ),
                                                              child: child,
                                                            ),
                                                          );
                                                        },
                                                        layoutBuilder: (Widget?
                                                                currentChild,
                                                            List<Widget>
                                                                previousChildren) {
                                                          return Stack(
                                                            clipBehavior:
                                                                Clip.hardEdge,
                                                            alignment: Alignment
                                                                .centerLeft,
                                                            children: [
                                                              if (currentChild !=
                                                                  null)
                                                                currentChild,
                                                            ],
                                                          );
                                                        },
                                                        child: TextWiget(
                                                          key: ValueKey<String>(
                                                            _controller
                                                                    .searchLabels[
                                                                _controller
                                                                    .currentLabelIndex
                                                                    .value],
                                                          ),
                                                          title: _controller
                                                                  .searchLabels[
                                                              _controller
                                                                  .currentLabelIndex
                                                                  .value],
                                                          style: TextStyle(
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color: Colors.black,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),

                                  // SizedBox(width: 25),

                                  // Container(child: Text("value $_showSliverAppBar"),),
                                  Obx(
                                    () =>
                                        // child:
                                        _showSliverAppBar.value == true
                                            ? Stack(
                                                children: [
                                                  IconButtonWidget(
                                                    voidCallback: () {
                                                      cartController
                                                          .getCartDetails(
                                                              cartController
                                                                  .customerModel!
                                                                  .value
                                                                  .customerId!);
                                                      cartController
                                                          .redeemPointsController
                                                          .clear();
                                                      cartController
                                                          .getCartTotal(
                                                              cartController
                                                                  .customerModel!
                                                                  .value
                                                                  .customerId!);

                                                      Get.to(
                                                        () => CartScreen(
                                                          removeCart:
                                                              productRemove,
                                                        ),
                                                        // transition: Transition.rightToLeftWithFade,
                                                      );
                                                    },
                                                    icons: Icons
                                                        .shopping_cart_outlined,
                                                    color: Colors.white,
                                                    // color: COLOR.background,
                                                  ),
                                                  Positioned(
                                                    right: 0,
                                                    top: 0,
                                                    child: GetBuilder<
                                                            CartController>(
                                                        builder:
                                                            (cartController) {
                                                      cartController
                                                              .cartCount.value =
                                                          cartController
                                                              .cartList.length;
                                                      return cartController
                                                                  .cartCount
                                                                  .value >
                                                              0
                                                          ? Container(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(5),
                                                              alignment: Alignment
                                                                  .centerLeft,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color:
                                                                    Colors.red,
                                                                shape: BoxShape
                                                                    .circle,
                                                              ),
                                                              child: Text(
                                                                cartController
                                                                    .cartCount
                                                                    .value
                                                                    .toString(),
                                                                style:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                              ),
                                                            )
                                                          : SizedBox();
                                                    }),
                                                  ),
                                                ],
                                              )
                                            : Container(),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SliverList(
                      delegate: SliverChildListDelegate(
                        [
                          Divider(),
                          Container(
                            color: COLOR.background,
                            margin: EdgeInsets.all(2),
                            padding: EdgeInsets.all(6),
                            width: MediaQuery.of(context).size.width,
                            child: GetBuilder<HomeController>(
                                builder: (controller) {
                              return controller.isDashBoardLoading.value
                                  ? SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height,
                                      child: Center(
                                          child: CircularProgressIndicator()))
                                  : Column(
                                      children: [
                                        ///  DashBoard category
                                        Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.15,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10.0, vertical: 10),
                                          // Add padding for better look
                                          child: ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                            // shrinkWrap: true,
                                            // physics: NeverScrollableScrollPhysics(),
                                            // gridDelegate:
                                            // SliverGridDelegateWithFixedCrossAxisCount(
                                            //   crossAxisCount: 3,
                                            //   childAspectRatio: 1.6 / 2,
                                            // ),
                                            itemCount:
                                                controller.categoryList.length,
                                            itemBuilder: (context, index) {
                                              return Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 10.0),
                                                child: CategoryComponent(
                                                    categoryModel: controller
                                                        .categoryList[index]),
                                              );
                                            },
                                          ),
                                        ),

                                        ///  DashBoard offers
                                        controller.offerList.isEmpty
                                            ? Container()
                                            : Padding(
                                                padding:
                                                    const EdgeInsets.all(0),
                                                child: Container(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 5),
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  color: COLOR.background,
                                                  child: Column(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                vertical: 10),
                                                        child: Container(
                                                          height: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .height *
                                                              0.15,
                                                          width: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .width,
                                                          child: CarouselSlider
                                                              .builder(
                                                            itemCount:
                                                                controller
                                                                    .offerList
                                                                    .length,
                                                            itemBuilder:
                                                                (context, index,
                                                                    realIndex) {
                                                              return Container(
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: COLOR
                                                                      .pinkLight,
                                                                  image:
                                                                      DecorationImage(
                                                                    image: NetworkImage(
                                                                        '$IMAGE_URL${controller.offerList[index].offerImage}'),
                                                                    fit: BoxFit
                                                                        .fill,
                                                                  ),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10),
                                                                ),
                                                              );
                                                            },
                                                            options:
                                                                CarouselOptions(
                                                              enlargeCenterPage:
                                                                  true,
                                                              autoPlay: true,
                                                              onPageChanged:
                                                                  (index,
                                                                      reason) {
                                                                controller
                                                                    .activeIndex
                                                                    .value = index;
                                                                controller
                                                                    .update();
                                                              },
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(top: 5),
                                                        child: buildIndicator(),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),

                                        ///  DashBoard education blog
                                        controller.educationList.isEmpty
                                            ? Container()
                                            : Padding(
                                                padding:
                                                    const EdgeInsets.all(0),
                                                child: Container(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 5),
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  color: COLOR.background,
                                                  child: Column(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                vertical: 10),
                                                        child: Container(
                                                          height: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .height *
                                                              0.15,
                                                          width: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .width,
                                                          child: CarouselSlider
                                                              .builder(
                                                            itemCount: controller
                                                                .educationList
                                                                .length,
                                                            itemBuilder:
                                                                (context, index,
                                                                    realIndex) {
                                                              final educationData =
                                                                  controller
                                                                          .educationList[
                                                                      index];
                                                              return InkWell(
                                                                onTap: () {
                                                                  print(
                                                                      "============ Education Data Home Screen ${educationData.blogs!.length}");

                                                                  Get.to(VideoListScreen(
                                                                      blogData:
                                                                          educationData
                                                                              .blogs![1]));
                                                                  // print("Eductaion Data Home Screen ${controller.educationList[index].data!}");
                                                                  // Get.to(WebViewScreen(url: "${controller.educationList[index].blogs![index].blogDescription}"));
                                                                  // Get.to(VideoListScreen(educationData: "${controller.educationList[index].data!}"));

                                                                  // _launchURL();
                                                                  // _launchUrl();
                                                                },
                                                                child:
                                                                    Container(
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: COLOR
                                                                        .pinkLight,
                                                                    image:
                                                                        DecorationImage(
                                                                      image: educationData.educationalCategoryImage !=
                                                                              null
                                                                          ? NetworkImage(
                                                                              '$IMAGE_URL${educationData.educationalCategoryImage}',
                                                                              // ??
                                                                              // 'no_img.jpg'}', // Null check
                                                                              // '$IMAGE_URL${controller.educationList[index].data![index].blogs![index].educationalCategoryImage}'
                                                                            )
                                                                          : AssetImage(
                                                                              Images.profileicon),
                                                                      fit: BoxFit
                                                                          .fill,
                                                                      onError: (exception,
                                                                              stackTrace) =>
                                                                          Image.asset(
                                                                              'assets/no_image.jpg'), // Fallback image
                                                                    ),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10),
                                                                  ),
                                                                ),
                                                              );
                                                            },
                                                            options:
                                                                CarouselOptions(
                                                              enlargeCenterPage:
                                                                  true,
                                                              autoPlay: true,
                                                              onPageChanged:
                                                                  (index,
                                                                      reason) {
                                                                controller
                                                                    .educationIndex
                                                                    .value = index;
                                                                controller
                                                                    .update();
                                                              },
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(top: 5),
                                                        child:
                                                            buildIndicatorEducation(),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),

                                        ///  DashBoard category
                                        // ListView.builder(
                                        //   shrinkWrap: true,
                                        //   physics: NeverScrollableScrollPhysics(),
                                        //   // gridDelegate:
                                        //   //     SliverGridDelegateWithFixedCrossAxisCount(
                                        //   //   crossAxisCount: 3,
                                        //   //   childAspectRatio: 1.6 / 2,
                                        //   // ),
                                        //   itemCount:
                                        //       controller.categoryList.length,
                                        //   itemBuilder: (context, index) {
                                        //     return CategoryComponent(
                                        //         categoryModel: controller
                                        //             .categoryList[index]);
                                        //   },
                                        // ),
                                      ],
                                    );
                            }),
                          ),
                        ],
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Container(
                        width: MediaQuery.sizeOf(context).width,
                        color: COLOR.background,
                        margin: EdgeInsets.symmetric(vertical: 5),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 0, vertical: 10),
                          child: Image.asset(
                            'assets/images/nomoreweed.jpg',
                            // 'assets/images/nomoreweed.jpg', // Replace with your image path
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Container(
                        padding: EdgeInsets.only(left: 20, right: 20, top: 10),
                        // Reduced vertical padding
                        // padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                        // color: Color(0xFFF5E6F5),
                        color: Colors.green.withOpacity(0.2),

                        // Match with grid background
                        child: Text(
                          'Top Picks for You',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                            // color: Color(0xff900C3F),
                          ),
                        ),
                      ),
                    ),
                    GetBuilder<HomeController>(builder: (controller) {
                      return SliverToBoxAdapter(
                        child: Column(
                          children: [
                            Container(
                              // color: COLOR.appBaseColor.withOpacity(0.2),
                              color: Colors.green.withOpacity(0.2),
                              padding: EdgeInsets.only(
                                  top: 0, left: 8.0, right: 8.0, bottom: 8.0),
                              child: GridView.builder(
                                itemCount: controller.productList.length,
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: 0.78,
                                  // Adjust based on your height/width ratio
                                  crossAxisSpacing: 8.0,
                                ),
                                itemBuilder: (context, index) {
                                  final products =
                                      controller.productList[index];
                                  return ProductComponent(
                                    products: products,
                                    color: Colors.green,
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                    GetBuilder<HomeController>(builder: (controller) {
                      return SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            final tag = controller.tagProductList[index];
                            print(
                                "Tag Product data ${controller.tagProductList[0] != null}");
                            print(
                                "Tag Product data ${controller.tagProductList[0] != null}");
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Tag Header
                                Container(
                                    alignment: Alignment.center,
                                    color: Colors.white,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5, vertical: 10),
                                      child: tag.tagImage != null
                                          ? Image.network(
                                              IMAGE_URL + tag.tagImage!,
                                              fit: BoxFit.cover,
                                            )
                                          : Image.asset(
                                              'assets/images/nomoreweed.jpg',
                                              // 'assets/images/nomoreweed.jpg', // Replace with your image path
                                              fit: BoxFit.cover,
                                            ),
                                    )),
                                Container(
                                  width: 900,
                                  padding: EdgeInsets.only(
                                      left: 10, right: 20, top: 10, bottom: 10),
                                  color:index == 0
                            ? Colors.orange.shade100.withOpacity(0.9)
                                : index == 1
                            ? Colors.blue.shade100
                                .withOpacity(0.9)
                                : index == 2
                            ? Colors.purpleAccent.shade100
                                .withOpacity(0.09)
                                : Colors.white,
                                  // Color(0xffcfdbfa),
                                  child: Text(
                                    tag.tagName ?? 'Tag ${index + 1}',
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),

                                // Tag Products Grid
                                Container(
                                  color: index == 0
                                      ? Colors.orange.shade100.withOpacity(0.9)
                                      : index == 1
                                          ? Colors.blue.shade100
                                              .withOpacity(0.9)
                                          : index == 2
                                              ? Colors.purpleAccent.shade100
                                                  .withOpacity(0.09)
                                              : Colors.white,
                                  padding: EdgeInsets.only(
                                      top: 0,
                                      left: 8.0,
                                      right: 8.0,
                                      bottom: 8.0),
                                  child: Builder(
                                    builder: (context) {
                                      final seenIds = <String>{};
                                      final uniqueProducts = (tag.products ?? [])
                                          .where((p) => p.productId != null && seenIds.add(p.productId!))
                                          .toList();

                                      return GridView.builder(
                                        itemCount:  uniqueProducts.length ?? 0,
                                        // tag.products?.length ?? 0,
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        gridDelegate:
                                            SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          childAspectRatio: 0.78,
                                          crossAxisSpacing: 8.0,
                                        ),
                                        itemBuilder: (context, productIndex) {
                                          print(
                                              "======> Product Index ${productIndex} ==== ${index}");
                                          // final product =
                                          //     tag.products![productIndex];
                                          // final productModel =
                                          //     ProductModel.fromJson(
                                          //         product.toJson()); // 🔄 Converted

                                          final product = uniqueProducts[productIndex];
                                          final productModel = ProductModel.fromJson(product.toJson());

                                          return ProductComponent(
                                              color: index == 0
                                                  ? Colors.orange.shade200
                                                  : index == 1
                                                      ? Colors.blue.shade200
                                                      : index == 2
                                                          ? Colors
                                                              .purpleAccent.shade100
                                                          : Colors.white,
                                              products: productModel);
                                        },
                                      );
                                    }
                                  ),
                                ),
                              ],
                            );
                          },
                          childCount: controller.tagProductList.length,
                        ),
                      );
                    }),
                  ],
                );
        }),
        drawer: Obx(
          () => CustomDrawer(
            name: editProfileController.m1.value!.customerName! ?? "Name",
            phone: "+91-${editProfileController.m1.value!.customerPhoneNo!}",
            language: languageController.languageName.value == "en"
                ? "English"
                : languageController.languageName == "hi"
                    ? "हिंदी"
                    : "ગુજરાતી",
          ),
        ),
        floatingActionButton: FloatingActionButton(
          elevation: 10,
          onPressed: () {
            Get.to(
              FaqScreen(),
              transition: Transition.rightToLeftWithFade,
            );
          },
          child: Icon(
            Icons.help,
            color: COLOR.background,
          ),
          backgroundColor: COLOR.appBaseColor,
        ),
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
          activeDotColor: COLOR.appBaseColor,
          dotColor: COLOR.grey.withOpacity(0.5),
        ),
      );
    });
  }

  Widget buildIndicatorEducation() {
    return GetBuilder<HomeController>(builder: (controller) {
      return AnimatedSmoothIndicator(
        activeIndex: controller.educationIndex.value,
        count: controller.educationList.length,
        effect: ExpandingDotsEffect(
          dotWidth: 6,
          dotHeight: 4,
          activeDotColor: COLOR.appBaseColor,
          dotColor: COLOR.grey.withOpacity(0.5),
        ),
      );
    });
  }

  _launchURL() async {
    if (Platform.isIOS) {
      if (await canLaunch(
          'youtube://www.youtube.com/channel/UCwXdFgeE9KYzlDdR7TG9cMw')) {
        await launch(
            'youtube://www.youtube.com/channel/UCwXdFgeE9KYzlDdR7TG9cMw',
            forceSafariVC: false);
      } else {
        if (await canLaunch(
            'https://www.youtube.com/channel/UCwXdFgeE9KYzlDdR7TG9cMw')) {
          await launch(
              'https://www.youtube.com/channel/UCwXdFgeE9KYzlDdR7TG9cMw');
        } else {
          throw 'Could not launch https://www.youtube.com/channel/UCwXdFgeE9KYzlDdR7TG9cMw';
        }
      }
    } else {
      const url = 'https://www.youtube.com/channel/UCwXdFgeE9KYzlDdR7TG9cMw';
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
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
                            title: StringRes.addDeliveryLocation,
                            style: Themes.light.textTheme.displaySmall!
                                .copyWith(color: COLOR.background),
                          ),
                          AlignWidget(
                            alignment: Alignment.topRight,
                            child: IconButtonWidget(
                              voidCallback: () {
                                // Get.back();
                              },
                              icons: Icons.close,
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
                          labelText: StringRes.typeDeliveryPincode,
                          suffixIcon: TextButtonWidget(
                            text: StringRes.submit,
                            border: 1,
                            style: Themes.light.textTheme.displaySmall!
                                .copyWith(color: COLOR.appBaseColor),
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
}

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

class CustomDrawer extends StatelessWidget {
  final String name;
  final String phone;
  final String language;

  CustomDrawer({
    super.key,
    required this.name,
    required this.phone,
    required this.language,
  });

  // backgroundImage: editProfileController.m1.value!.customerImage == "" ?AssetImage(Images.profileicon):NetworkImage(IMAGE_URL+editProfileController.m1.value!.customerImage!),

  EditProfileController editProfileController = Get.find();
  DashboardController dashboardController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      width: MediaQuery.sizeOf(context).width * 0.8,
      child: Column(
        children: [
          // 🔹 Profile Section
          Obx(
            () => Container(
              height: 120,
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              color: Colors.green.shade700,
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 32,
                    backgroundImage:
                        editProfileController.m1.value!.customerImage! == null
                            ? AssetImage(Images.profileicon)
                            : NetworkImage(IMAGE_URL +
                                editProfileController.m1.value!.customerImage!),

                    // backgroundImage: AssetImage(Images.profileicon),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(name.isNotEmpty ? name : StringRes.enterYourName,
                            style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white)),
                        const SizedBox(height: 4),
                        Text(phone,
                            style: const TextStyle(
                                fontSize: 14, color: Colors.white70)),
                        Text(language,
                            style: const TextStyle(
                                fontSize: 14, color: Colors.white70)),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Get.to(
                        () => EditProfileScreen(),
                        transition: Transition.rightToLeftWithFade,
                      );
                      // TODO: Edit profile
                    },
                    icon: const Icon(Icons.edit, color: Colors.white),
                  )
                ],
              ),
            ),
          ),
          Transform.translate(
              offset: Offset(0, -14),
              // scaleX: 10,
              // scale: 10,
              // bottom: 70,
              //             top: 10,
              child: InkWell(
                onTap: () {
                  Get.to(
                    () => EditProfileScreen(),
                    transition: Transition.rightToLeftWithFade,
                  );
                },
                child: Container(
                  height: 45,
                  width: 250,
                  alignment: Alignment.center,
                  child: Text(
                    StringRes.editProfile,
                    style: TextStyle(
                        color: COLOR.appBaseColor,
                        fontSize: 17,
                        fontWeight: FontWeight.w500),
                  ),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(spreadRadius: -10, blurRadius: 18)
                      ]),
                ),
              )),
          // 🔹 Menu Items List
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                _drawerTile(
                  Icons.account_circle,
                  StringRes.account,
                  voidCallback: () {
                    Get.to(AccountScreen());
                  },
                ),
                _drawerTile(
                  Icons.card_giftcard,
                  StringRes.referAndEarn,
                  voidCallback: () {
                    // onPressed: () {
                    Get.to(
                      () => ReferAndEarnScreen(),
                      transition: Transition.rightToLeftWithFade,
                    );
                    // TODO: Edit profile
                    // },
                  },
                ),
                _drawerTile(
                  Icons.shopping_bag_outlined,
                  StringRes.orders,
                  voidCallback: () {
                    dashboardController.tabIndex = 2;
                    dashboardController.changeTabIndex(2);
                    Get.to(
                      DashboardScreen(pageIndex: 2),
                      transition: Transition.rightToLeftWithFade,
                    );
                  },
                ),
                _drawerTile(
                  Icons.menu_book,
                  StringRes.krushiBook,
                  voidCallback: () {
                    dashboardController.tabIndex = 1;
                    dashboardController.changeTabIndex(1);
                    Get.to(
                      DashboardScreen(pageIndex: 1),
                      transition: Transition.rightToLeftWithFade,
                    );
                    // Get.to(
                    //       () => CropScreen(),
                    //   transition: Transition.rightToLeftWithFade,
                    // );
                  },
                ),
                _drawerTile(
                  Icons.leaderboard,
                  StringRes.leaderShipRewards,
                  voidCallback: () {
                    // dashboardController.tabIndex = 1;
                    // dashboardController.changeTabIndex(1);
                    Get.to(
                      TabMainScreen(),
                      transition: Transition.rightToLeftWithFade,
                    );
                    // Get.to(
                    //       () => CropScreen(),
                    //   transition: Transition.rightToLeftWithFade,
                    // );
                  },
                ),
                // _drawerTile(Icons.store_mall_directory, "Krushi Dukan"),
                // _drawerTile(Icons.person, "Kahani Tarakki Ki"),
                const Divider(),
                _drawerTile(
                  Icons.share,
                  StringRes.share,
                  voidCallback: () {
                    final RenderBox? box =
                        context.findRenderObject() as RenderBox?;
                    if (box != null) {
                      final position = box.localToGlobal(Offset.zero);
                      final size = box.size;
                      final sharePositionOrigin = Rect.fromLTWH(
                          position.dx, position.dy, size.width, size.height);

                      print("Share Position Origin: $sharePositionOrigin");
                      try {
                        Share.share(
                          'Download the JantuNashak App for get better Product at Farmers.\n\nhttps://play.google.com/store/apps/details?id=com.reliable.jantunashak',
                          // 'com.acman.user',
                          subject: 'Check out JantuNashak App!',
                          sharePositionOrigin: sharePositionOrigin,
                        );
                      } catch (e) {
                        print("Error sharing: $e");
                        // snackBarMessengers(context, message: "Error sharing app: $e", color: appColor(context).red);
                      }
                    } else {
                      print("Error: Could not find RenderBox for context.");
                      // snackBarMessengers(context, message: "Unable to share. Try again.", color: appColor(context).red);
                    }
                  },
                ),
                // _drawerTile(Icons.feedback_outlined, "Share your feedback"),
                _drawerTile(
                  Icons.language,
                  StringRes.language,
                  voidCallback: () {
                    showLanguageBottomSheet(context);
                    // changeLanguageButton(() {
                    //   showLanguageBottomSheet(context);
                    // },)
                    // showBottomSheet(context: context, builder: builder)
                  },
                ),
                // _drawerTile(Icons.chat, "Chat"),
                // _drawerTile(Icons.call, "Call for Bulk Orders"),
                const Divider(),
                _drawerTile(Icons.article, StringRes.terms),
                _drawerTile(Icons.lock, StringRes.privacyPolicy),
              ],
            ),
          ),

          // 🔹 Logout Button
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: ElevatedButton.icon(
              onPressed: () {
                _showLogoutBottomSheet(context);
                // TODO: Logout
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  minimumSize: const Size.fromHeight(40)),
              icon: const Icon(
                Icons.logout,
                color: Colors.white,
              ),
              label: Text(
                StringRes.logout,
                style: TextStyle(color: Colors.white),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _drawerTile(IconData icon, String title,
      {final VoidCallback? voidCallback}) {
    return ListTile(
        leading: Icon(icon, color: Colors.green.shade700),
        title: Text(title),
        onTap: voidCallback
        //     () {
        //   // TODO: Navigation
        // },
        );
  }

  Widget changeLanguageButton(VoidCallback onTap) {
    return Material(
        color: Colors.transparent, // Transparent background for ripple effect
        child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(12),
            // Ripple effect ke liye
            splashColor: COLOR.appBaseColor.withOpacity(0.2),
            // Ripple ka color
            highlightColor: COLOR.appBaseColor.withOpacity(0.1),
            // Button press effect
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                border: Border.all(color: Colors.grey, width: 0.5),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Icon(Icons.language, size: 30, color: COLOR.appBaseColor),
                      Positioned(
                        top: -5,
                        right: -5,
                        child: Container(
                          padding: const EdgeInsets.all(3),
                          decoration: BoxDecoration(
                            color: COLOR.appBaseColor,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "अ",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(width: 2),
                              Text(
                                "A",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Text(
                    StringRes.changeLanguage,
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            )));
  }

  void _showLogoutBottomSheet(BuildContext context) {
    Get.bottomSheet(
      SafeArea(
        bottom: true,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                StringRes.logoutConfirmation,

                // "Are you sure you want to logout?",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.black,
                      backgroundColor: Colors.white,
                      side: BorderSide(color: Colors.black),
                    ),
                    onPressed: () => Get.back(),
                    child:
                        Text(StringRes.cancel, style: TextStyle(fontSize: 16)),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: COLOR.appBaseColor,
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () async {
                      SharedHelper helper = SharedHelper();
                      await helper
                          .deleteCustomer(); // agar yeh async method hai\
                      // await helper.storeBool(value: true,key: SharedHelper.deleteAccountKey);
                      // await authenticate.signOut();
                      Get.offAll(() => LoginScreen());
                      // Logout logic here
                      Get.back();
                    },
                    child:
                        Text(StringRes.logout, style: TextStyle(fontSize: 16)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      isDismissible: true,
      enableDrag: true,
      enterBottomSheetDuration: Duration(milliseconds: 300),
      exitBottomSheetDuration: Duration(milliseconds: 300),
    );
  }
}
