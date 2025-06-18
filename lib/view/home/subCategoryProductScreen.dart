// flutter
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

// package
import 'package:get/get.dart';
import 'package:keep_app/controller/productDetailController.dart';
import 'package:keep_app/controller/subCategoreyController.dart';

// constants
// import 'package:getxnative/constants/colorConst.dart';
// // controllers
// import 'package:getxnative/controllers/homeController.dart';
// // theme
// import 'package:getxnative/theme/nativeTheme.dart';
// // views
// import 'package:getxnative/views/SharedProducts/sharedProductScreen.dart';
// import 'package:getxnative/views/home/widget/SliverAppBarDelegate.dart';
// import 'package:getxnative/views/home/widget/homeProductHeader.dart';
// import 'package:getxnative/views/home/widget/homeProductList.dart';
// // widget
// import 'package:getxnative/widget/alignWidget.dart';
// import 'package:getxnative/widget/dividerWidgets.dart';
// import 'package:getxnative/widget/iconButtonWidget.dart';
// import 'package:getxnative/widget/inputWidget.dart';
// import 'package:getxnative/widget/textButtonWidget.dart';
// import 'package:getxnative/widget/textWidget.dart';
import 'package:keep_app/widget/subCategoryWidget.dart';

import '../../Theme/nativeTheme.dart';
import '../../constant/colorConst.dart';
import '../../controller/cartController.dart';
import '../../controller/homeController.dart';
import '../../utils/string_res.dart';
import '../../widget/alignWidget.dart';
import '../../widget/dividerWidgets.dart';
import '../../widget/iconButtonWidget.dart';
import '../../widget/inputWidget.dart';
import '../../widget/productWidget.dart';
import '../../widget/textButtonWidget.dart';
import '../../widget/textWidget.dart';
import '../AddtoCard/cartScreen.dart';
import '../wishlist/wishlist_screen.dart';

class SubCategoryProductScreen extends StatefulWidget {
  String subCategory;

  SubCategoryProductScreen({super.key, required this.subCategory});

  @override
  State<SubCategoryProductScreen> createState() =>
      _SubCategoryProductScreenState();
}

class _SubCategoryProductScreenState extends State<SubCategoryProductScreen> {
  final SubCategoryController _controller = Get.find<SubCategoryController>();
  final ProductDetailsController productDetailsController =
      Get.find<ProductDetailsController>();

  final CartController cartController = Get.put(CartController());


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller.getSubCategoryProduct(widget.subCategory);
  }

  @override
  productRemove() {
    productDetailsController.isCart = false;
    productDetailsController.update();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: COLOR.greyLight,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            snap: false,
            floating: true,
            pinned: true,
            backgroundColor: COLOR.background,
            leading: InkWell(
              onTap: () {
                Get.back();
              },
              child: Icon(
                Icons.arrow_back_ios,
                color: COLOR.greyback,
                size: 20,
              ),
            ),
            actions: [
              IconButtonWidget(
                voidCallback: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => WishlistScreen(),
                      ));
                  // Get.to(() => ShareProductScreen());
                },
                icons: Icons.favorite_border,
                color: COLOR.black,
              ),
              Stack(
                children: [
                  IconButtonWidget(
                    voidCallback: () {
                      cartController.getCartDetails(cartController.customerModel!.value.customerId!);
                      cartController.getCartTotal(cartController.customerModel!.value.customerId!);

                      Get.to(() => CartScreen(
                          // removeCart: productRemove,
                          ));
                    },
                    icons: Icons.shopping_cart_outlined,
                    color: COLOR.black,
                  ),
                  Positioned(
                    right: 0,
                    top: 0,
                    child:
                        GetBuilder<CartController>(builder: (cartController) {
                      int cartCount = cartController.cartList.length;
                      return cartCount > 0
                          ? Container(
                              padding: EdgeInsets.all(5),
                              alignment: Alignment.centerLeft,
                              decoration: BoxDecoration(
                                color: Colors.red,
                                shape: BoxShape.circle,
                              ),
                              child: Text(
                                cartCount.toString(),
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
            elevation: 0,
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
              ],
            ),
          ),

          GetBuilder<SubCategoryController>(builder: (controller) {
            if (controller.subCategoryProductList.isEmpty) {
              return SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Center(child: Text(StringRes.dataNotFound)),
                ),
              );
            } else {
              return SliverGrid(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final products = controller.subCategoryProductList[index];
                    return ProductComponent(products: products);
                  },
                  childCount: controller.subCategoryProductList.length,
                ),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1 / 1.4,
                  crossAxisSpacing: 2,
                  mainAxisSpacing: 2,
                ),
              );
            }
          })
        ],
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
                          title: StringRes.addDeliveryLocation,
                          style: Themes.light.textTheme.displaySmall!
                              .copyWith(color: COLOR.black),
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
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                alignment: Alignment.centerLeft,
                child: Form(
                  child: GetBuilder<HomeController>(
                    builder: (_controller) => SizedBox(
                        width: MediaQuery.of(context).size.width * 0.6,
                        child: InputFiledArea(
                          keyboardType: TextInputType.number,
                          controller: _controller.deliveryPincode,
                          maxlength: 6,
                          labelText: StringRes.typeDeliveryPincode,
                          focusNode: _controller.fdeliveryPincode,
                          suffixIcon: Container(
                            child: TextButtonWidget(
                              text: StringRes.submit,
                              style: Themes.light.textTheme.displaySmall!
                                  .copyWith(color: COLOR.appBaseColor),
                              border: 1,
                              onPressed: (_controller.deliveryPincode.text
                                      .trim()
                                      .isNotEmpty)
                                  ? () {
                                      Get.back();
                                    }
                                  : null,
                            ),
                          ),
                          counterText: '',
                        )),
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
