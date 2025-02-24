// flutter
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
//package
import 'package:get/get.dart';

import 'package:keep_app/widget/productWidget.dart';

import '../../Theme/nativeTheme.dart';
import '../../constant/app_constant.dart';
import '../../constant/colorConst.dart';
import '../../constant/imagesConst.dart';
import '../../controller/homeController.dart';
import '../../widget/alignWidget.dart';
import '../../widget/appBarWidget.dart';
import '../../widget/buttonWidget.dart';
import '../../widget/inputWidget.dart';
import '../../widget/textWidget.dart';
import '../home/widget/homeProductHeader.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key}) : super(key: key);
  final HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    final snackBar = SnackBar(
      backgroundColor: COLOR.background,
      content: SingleChildScrollView(
        child: ListBody(
          children: [
            GestureDetector(
              child: TextWiget(title: 'Gallary', style: Themes.light.textTheme.displayLarge),
              onTap: () {
                _openGallary(context);
              },
            ),
            const Padding(padding: EdgeInsets.all(10)),
            GestureDetector(
              child: TextWiget(
                title: 'Camera',
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

    return Scaffold(
      appBar: MyCustomAppBar(
        height: 90,
        appbarPadding: 0,
        elevation: 0,
        title: Container(
          padding: EdgeInsets.only(right: 20),
          alignment: Alignment.centerLeft,
          child: Form(
            child: GetBuilder<HomeController>(
              builder: (_controller) => SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                  width: MediaQuery.of(context).size.width,
                  child: InputFiledArea(
                    onChanged: _controller.onSearchChanged,
                    keyboardType: TextInputType.text,
                    controller: _controller.searchController,
                    hintText: 'Search Keyword or Product ID',
                    contentPadding: EdgeInsets.only(top: 10, left: 10),
                    border: 1,
                    suffixIcon: Container(
                      width: 50,
                      child: Row(
                        children: [
                          VerticalDivider(thickness: 1, color: COLOR.grey),
                          InkWell(
                            onTap: () {
                              ScaffoldMessenger.of(context).showSnackBar(snackBar);
                            },
                            child: Icon(
                              Icons.camera_alt_outlined,
                              color: COLOR.grey,
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
        titleSpacing: 0,
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: Container(
            child: Icon(
              Icons.arrow_back_ios,
              color: COLOR.greyback,
              size: 20,
            ),
          ),
        ),
      ),
      backgroundColor: COLOR.greyLight,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Container(
                padding: EdgeInsets.all(15),
                width: MediaQuery.of(context).size.width,
                color: COLOR.background,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 50,
                      width: (MediaQuery.of(context).size.width * 9) / 100,
                      decoration: BoxDecoration(
                        color: COLOR.pinkLight,
                        image: DecorationImage(
                          image: AssetImage(Images.phone),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Container(
                      height: 50,
                      padding: EdgeInsets.only(left: 10),
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: AlignWidget(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Upload product images to find similsr products',
                          style: Themes.light.textTheme.bodyMedium,
                          maxLines: 2,
                        ),
                      ),
                    ),
                    Container(
                      height: Get.height > 800 ? MediaQuery.of(context).size.height * 0.04 : MediaQuery.of(context).size.height * 0.05,
                      width: (MediaQuery.of(context).size.width * 25) / 100,
                      child: ButtonWidgets(
                        title: 'Search by Image',
                        voidCallback: () {
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        },
                        color: COLOR.pink400,
                        style: Themes.light.textTheme.displayLarge!.copyWith(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
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
                          title: 'Popular Searches',
                          style: Themes.dark.textTheme.displayMedium!.copyWith(
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
                              title: 'Saree',
                              voidCallback: () {
                                homeController.getSearchData('Saree');
                                // Get.to(() => PriceStroeScreen());
                              },
                              color: COLOR.greyLight,
                              bordercolor: COLOR.searchgrey,
                            ),
                            ProfileContainer(
                              title: 'Kurti',
                              color: COLOR.greyLight,
                              bordercolor: COLOR.searchgrey,
                              voidCallback: () {
                                homeController.getSearchData('Kurti');

                                // Get.to(() => PriceStroeScreen());
                              },
                            ),
                            ProfileContainer(
                              title: 'tops for women',
                              color: COLOR.greyLight,
                              bordercolor: COLOR.searchgrey,
                              voidCallback: () {
                                // Get.to(() => PriceStroeScreen());
                              },
                            ),
                            ProfileContainer(
                              title: 'watch',
                              color: COLOR.greyLight,
                              bordercolor: COLOR.searchgrey,
                              voidCallback: () {
                                // Get.to(() => PriceStroeScreen());
                              },
                            ),
                            ProfileContainer(
                              title: 'Jewellery',
                              voidCallback: () {
                                // Get.to(() => PriceStroeScreen());
                              },
                              color: COLOR.greyLight,
                              bordercolor: COLOR.searchgrey,
                            ),
                            ProfileContainer(
                              title: 'shoes',
                              voidCallback: () {
                                // Get.to(() => PriceStroeScreen());
                              },
                              color: COLOR.greyLight,
                              bordercolor: COLOR.searchgrey,
                            ),
                            ProfileContainer(
                              title: 'sarees new collection',
                              voidCallback: () {
                                // Get.to(() => PriceStroeScreen());
                              },
                              color: COLOR.greyLight,
                              bordercolor: COLOR.searchgrey,
                            ),
                            ProfileContainer(
                              title: 'smart watch',
                              voidCallback: () {
                                // Get.to(() => PriceStroeScreen());
                              },
                              color: COLOR.greyLight,
                              bordercolor: COLOR.searchgrey,
                            ),
                            ProfileContainer(
                              title: 't-shirt',
                              voidCallback: () {
                                // Get.to(() => PriceStroeScreen());
                              },
                              color: COLOR.greyLight,
                              bordercolor: COLOR.searchgrey,
                            ),
                            ProfileContainer(
                              title: 'top',
                              voidCallback: () {
                                // Get.to(() => PriceStroeScreen());
                              },
                              color: COLOR.greyLight,
                              bordercolor: COLOR.searchgrey,
                            ),
                            ProfileContainer(
                              title: 'Sarees',
                              voidCallback: () {
                                // Get.to(() => PriceStroeScreen());
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
            SizedBox(height: MediaQuery.sizeOf(context).height * 0.01,),

            Obx(() {
              if(homeController.isLoading.value)
              {
                return Center(child: CircularProgressIndicator());

              }
              else if(homeController.searchList.isEmpty)
              {
                return Center(child: Text('No products found'));

              }
              return
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.7, // Ensuring proper scroll
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: Get.width >= 480 ? 1.15 / 2 : 1 / 2.1,
                      crossAxisSpacing: 2,
                      mainAxisSpacing: 2,
                    ),
                    itemCount: homeController.searchList.length,
                    itemBuilder: (context, index) {
                      return ProductComponent(products: homeController.searchList[index]);
                    },
                  ),
                );
            },)

          ],
        ),
      ),
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