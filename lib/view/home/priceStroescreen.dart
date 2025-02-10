// flutter
import 'package:flutter/material.dart';

// package
import 'package:get/get.dart';

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
import 'package:keep_app/view/home/widget/homeProductList.dart';

import '../../Theme/nativeTheme.dart';
import '../../constant/app_constant.dart';
import '../../constant/colorConst.dart';
import '../../controller/homeController.dart';
import '../../widget/alignWidget.dart';
import '../../widget/dividerWidgets.dart';
import '../../widget/iconButtonWidget.dart';
import '../../widget/inputWidget.dart';
import '../../widget/textButtonWidget.dart';
import '../../widget/textWidget.dart';

class SubCategoryScreen extends StatefulWidget {
  String category;

  SubCategoryScreen({super.key, required this.category});

  @override
  State<SubCategoryScreen> createState() => _SubCategoryScreenState();
}

class _SubCategoryScreenState extends State<SubCategoryScreen> {
  // String category;
  final HomeController _controller = Get.find<HomeController>();

  // PriceStroeScreen({Key? key,required this.category}) : super(key: key);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller.getDashboardData(widget.category);
  }

  @override
  // Widget build(BuildContext context) {
  //   return const Placeholder();
  // }
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
            title: Obx(() => TextWiget(
              title: _controller.customerModel != null
                  ? _controller.customerModel!.value.customerName
                  : "",
              style: Themes.light.textTheme.displayLarge,
            )),
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
                  // Get.to(() => ShareProductScreen());
                },
                icons: Icons.favorite_border,
                color: COLOR.black,
              ),
              IconButtonWidget(
                voidCallback: () {
                  // Get.to(() => AddToCardScreen());
                },
                icons: Icons.shopping_cart_outlined,
                color: COLOR.black,
              ),
            ],
            elevation: 0,
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
                            style: Themes.dark.textTheme.displayLarge,
                          ),
                          Icon(Icons.navigate_next),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Container(
          //   color: Colors.white,
          //   margin: EdgeInsets.all(2),
          //   padding: EdgeInsets.all(6),
          //   // padding: EdgeInsets.symmetric(vertical: 10),
          //   width: MediaQuery.of(context).size.width,
          //   child:
          //    _controller.isCategory == true?
          GetBuilder<HomeController>(builder: (controller) {

            if (controller.isCategory.value) {
              if (controller.subCategoryList.isEmpty) {
                return  SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Text("No data found"),
                    ),
                  ),
                );
              }
              else{
                controller.isCategory.value = false;

                return  SliverGrid.builder(
                  // shrinkWrap: true,
                  // physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 1.6 / 2,
                      // crossAxisSpacing: 7,
                      // mainAxisSpacing: 7,
                    ),
                    // padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    itemCount: controller.subCategoryList.length,
                    itemBuilder: (context, index) {
                      // if(_controller.isCategory.value == true) {
                      //    if(index < controller.subCategoryList.length)   {
                      return Container(
                        color: COLOR.background,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () {
                                // controller.fetchSubCategoryData(
                                //     controller.categoryList[index].categoryId);
                                // // Get.to(() => PriceStroeScreen());
                              },
                              child: Container(
                                height: Get.width > 360
                                    ? MediaQuery.of(context).size.height * 0.14
                                    : MediaQuery.of(context).size.height * 0.15,
                                decoration: BoxDecoration(
                                  color: COLOR.amber,
                                  image: DecorationImage(
                                    // colorFilter: new ColorFilter.mode(
                                    //     COLOR.black.withOpacity(0.8),
                                    //     BlendMode.dstATop),
                                    image: NetworkImage(
                                      '$IMAGE_URL${controller.subCategoryList[index].categoryImage}',
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                  // border: Border.all(width: 5)
                                ),
                              ),
                            ),
                            Expanded(
                              child: AlignWidget(
                                alignment: Alignment.center,
                                child: TextWiget(
                                  title: controller
                                      .subCategoryList[index].subcategoryName,
                                  style: Themes.light.textTheme.displaySmall!
                                      .copyWith(fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                  //   else
                  //   {
                  //     return Center(
                  //       child: Text("Invalid Index"),
                  //     );
                  //   }
                  //  }
                  // else{
                  //   return Center(child: CircularProgressIndicator());
                  // }
                  // :Center(child: CircularProgressIndicator());
                  // },
                );
              }
            }
            else{
              return  SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              );
            }
            // else if (controller.subCategoryList.isEmpty) {
            //   return SliverToBoxAdapter(
            //     child: Padding(
            //       padding: const EdgeInsets.all(8.0),
            //       child: Center(
            //         child: Text("No data found"),
            //       ),
            //     ),
            //   );
            // }
            return SliverGrid.builder(
              // shrinkWrap: true,
              // physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 1.6 / 2,
                  // crossAxisSpacing: 7,
                  // mainAxisSpacing: 7,
                ),
                // padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                itemCount: controller.subCategoryList.length,
                itemBuilder: (context, index) {
                  // if(_controller.isCategory.value == true) {
                  //    if(index < controller.subCategoryList.length)   {
                  return Container(
                    color: COLOR.background,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            // controller.fetchSubCategoryData(
                            //     controller.categoryList[index].categoryId);
                            // // Get.to(() => PriceStroeScreen());
                          },
                          child: Container(
                            height: Get.width > 360
                                ? MediaQuery.of(context).size.height * 0.14
                                : MediaQuery.of(context).size.height * 0.15,
                            decoration: BoxDecoration(
                              color: COLOR.amber,
                              image: DecorationImage(
                                // colorFilter: new ColorFilter.mode(
                                //     COLOR.black.withOpacity(0.8),
                                //     BlendMode.dstATop),
                                image: NetworkImage(
                                  '$IMAGE_URL${controller.subCategoryList[index].categoryImage}',
                                ),
                                fit: BoxFit.cover,
                              ),
                              // border: Border.all(width: 5)
                            ),
                          ),
                        ),
                        Expanded(
                          child: AlignWidget(
                            alignment: Alignment.center,
                            child: TextWiget(
                              title: controller
                                  .subCategoryList[index].subcategoryName,
                              style: Themes.light.textTheme.displaySmall!
                                  .copyWith(fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }
              //   else
              //   {
              //     return Center(
              //       child: Text("Invalid Index"),
              //     );
              //   }
              //  }
              // else{
              //   return Center(child: CircularProgressIndicator());
              // }
              // :Center(child: CircularProgressIndicator());
              // },
            );
          }),
          // :Center(child: CircularProgressIndicator()),
          // ),
          // SliverPersistentHeader(
          //   floating: false,
          //   pinned: true,
          //   // delegate: SliverAppBarDelegate(
          //   //   child: PreferredSize(
          //   //     preferredSize: Size.fromHeight(45),
          //   //     child: InkWell(
          //   //       onTap: () {},
          //   //       child: Container(),
          //   //     ),
          //   //   ),
          //   // ),
          // ),
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
                          labelText: 'Type Delivery Pincode',
                          focusNode: _controller.fdeliveryPincode,
                          suffixIcon: Container(
                            child: TextButtonWidget(
                              text: 'SUBMIT',
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
// void dispose() {
//   _controller.subCategoryList.clear(); // Clear the list on dispose
//   super.dispose();
// }
}
