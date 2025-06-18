// flutter
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:keep_app/constant/app_constant.dart';
import 'package:keep_app/controller/cartController.dart';
import 'package:keep_app/view/home/SliverAppBarDelegate.dart';
import 'package:keep_app/view/wishlist/wishlist_screen.dart';
import 'package:keep_app/widget/alignWidget.dart';
import 'package:keep_app/widget/categoryWidget.dart';
import 'package:keep_app/widget/dividerWidgets.dart';
import 'package:keep_app/widget/inputWidget.dart';
import 'package:keep_app/widget/productWidget.dart';
import 'package:keep_app/widget/textButtonWidget.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../constant/colorConst.dart';
import '../../constant/imagesConst.dart';
import '../../controller/homeController.dart';
import '../../controller/productDetailController.dart';
import '../../theme/nativeTheme.dart';
import '../../utils/string_res.dart';
import '../../widget/category_detail_shimmer.dart';
import '../../widget/iconButtonWidget.dart';
import '../../widget/textWidget.dart';
import '../AddtoCard/cartScreen.dart';
import '../address/allAddress_screen.dart';
import 'package:keep_app/view/otp/phone_auth.dart';

import '../faq/faq_screen.dart';
import '../search/search_screen.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  final HomeController _controller =
      Get.put(HomeController()); // ensure registration
  final CartController cartController = Get.put(CartController());
  ProductDetailsController productDetailsController = Get.find();

  productRemove() {
    productDetailsController.isCart = false;
    productDetailsController.update();
  }

  @override
  Widget build(BuildContext context) {
    print("HomeScreen name: ${_controller.customerModel!.value?.customerName}");

    print("language changes ${StringRes.searchProduct}");
    return Scaffold(
      backgroundColor: COLOR.greyLight,
      body: GetBuilder<HomeController>(
        builder: (controller) => controller.categoryList.isEmpty
            ? Container(
                margin: EdgeInsets.only(top: 25),
                padding: EdgeInsets.all(0),
                child: SizedBox())
            : CustomScrollView(
                slivers: [
                  SliverAppBar(
                    actionsPadding: EdgeInsets.symmetric(horizontal: 10),
                    snap: false,
                    pinned: true,
                    floating: true,
                         title: Obx(() => TextWiget(
                          title: _controller.customerModel != null
                              ? "${StringRes.hello} ${_controller.customerModel!.value.customerName}"
                              : StringRes.hello,
                          style: Themes.light.textTheme.displayMedium,
                        )),
                    actions: [
                      IconButton(
                          onPressed: () {
                            Get.to(
                              () => WishlistScreen(),
                              transition: Transition.rightToLeftWithFade,
                            );
                          },
                          icon: Icon(Icons.favorite_border)),
                      Stack(
                        children: [
                          IconButtonWidget(
                            voidCallback: () {
                              cartController.getCartDetails(cartController
                                  .customerModel!.value.customerId!);
                              cartController.getCartTotal(cartController
                                  .customerModel!.value.customerId!);

                              Get.to(
                                () => CartScreen(
                                  removeCart: productRemove,
                                ),
                                // transition: Transition.rightToLeftWithFade,
                              );
                            },
                            icons: Icons.shopping_cart_outlined,
                            color: COLOR.black,
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
                            _controller.searchList.clear();
                            _controller.searchController.clear();
                            Get.to(() => SearchScreen());
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            color: COLOR.background,
                            padding: EdgeInsets.symmetric(
                                horizontal: 13, vertical: 2),
                            child: Card(
                              elevation: 0,
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                height:
                                    MediaQuery.of(context).size.height * 0.07,
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
                                        title: StringRes.searchProduct,
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
                        Divider(),
                        Container(
                          color: COLOR.background,
                          margin: EdgeInsets.all(2),
                          padding: EdgeInsets.all(6),
                          width: MediaQuery.of(context).size.width,
                          child:
                              GetBuilder<HomeController>(builder: (controller) {
                            return controller.isDashBoardLoading.value
                                ? SizedBox(
                                    height: MediaQuery.of(context).size.height,
                                    child: Center(
                                        child: CircularProgressIndicator()))
                                : Column(
                                    children: [
                                      ///  DashBoard offers
                                      controller.offerList.isEmpty
                                          ? Container()
                                          : Padding(
                                              padding: const EdgeInsets.all(0),
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
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          vertical: 10),
                                                      child: Container(
                                                        height: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height *
                                                            0.23,
                                                        width: MediaQuery.of(
                                                                context)
                                                            .size
                                                            .width,
                                                        child: CarouselSlider
                                                            .builder(
                                                          itemCount: controller
                                                              .offerList.length,
                                                          itemBuilder: (context,
                                                              index,
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
                                                          const EdgeInsets.only(
                                                              top: 5),
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
                                          childAspectRatio: 1.6 / 2,
                                        ),
                                        itemCount:
                                            controller.categoryList.length,
                                        itemBuilder: (context, index) {
                                          return CategoryComponent(
                                              categoryModel: controller
                                                  .categoryList[index]);
                                        },
                                      ),
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
                            horizontal: 10, vertical: 10),
                        child: Text(
                          StringRes.trendingProducts,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            // color: Color(0xff900C3F),
                          ),
                        ),
                      ),
                    ),
                  ),
                  GetBuilder<HomeController>(builder: (controller) {
                    return SliverGrid(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          final products = controller.productList[index];
                          return ProductComponent(products: products);
                        },
                        childCount: controller.productList.length,
                      ),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 1 / 1.4,
                        crossAxisSpacing: 2,
                        mainAxisSpacing: 2,
                      ),
                    );
                  })
                ],
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
