//flutter
import 'dart:convert';

import 'package:flutter/material.dart';
//packages
import 'package:get/get.dart';
import 'package:keep_app/constant/api_endpoints.dart';
import 'package:keep_app/controller/networkController.dart';
import 'package:keep_app/models/subCategoryModel.dart';
import '../models/categoryModel.dart';
import '../models/customerModel.dart';
import '../models/productsModel.dart';
import '../utils/services/api_services.dart';
import '../utils/sharedPrefs.dart';

class HomeController extends GetxController
    with GetSingleTickerProviderStateMixin {
  // getxcontroller instance
  NetworkController networkController = Get.put(NetworkController());
  SharedHelper helper = SharedHelper();

  var search = TextEditingController();
  var cHomesearch = TextEditingController();
  var deliveryPincode = TextEditingController();

  var fdeliveryPincode = FocusNode();
  var userName = "";
  TabController? myTabController;
  Rx<CustomerModel>? customerModel = CustomerModel().obs;
  var activeIndex = 0.obs;
  var categoryCheckBox = false.obs;
  var selectedFilterIndex = 0.obs;
  var sortValue = 1.obs;
  List<Category> categoryList = [];
  List<SubCategory> subCategoryList = [];

  PageController filterPage = PageController();
  RxBool isCategory = false.obs;


  changeCategory() {
    try {
      categoryCheckBox.value = !categoryCheckBox.value;
      update();
    } on Exception catch (e) {
      print('Exception -  PaymentController' + e.toString());
    }
  }

  @override
  void onInit() async {
    myTabController = TabController(vsync: this, length: filters.length);
    getPrefs();
    fetchCategoryData();
    super.onInit();
  }

  @override
  void dispose() {
    myTabController!.dispose();
    filterPage.dispose();
    super.dispose();
  }

  getPrefs() async {
    CustomerModel? customer = await helper.getCustomer();
    if (customer != null) {
      customerModel!.value = customer;
      print("Phone  Number ${customerModel!.value.customerPhoneNo}");
    }
    update();
  }

  List<String> filters = [
    'Category',
    'Gender',
    'Fabric',
    'Color',
    'Price',
    'Discount',
    'Rating',
    'Size',
    'Combo',
    'Material',
    'Bottom Length',
    'Bottom Style',
    'Bottomwear Fabric',
    'Ornmentation'
  ];

  //Categorey List home screen
  // final List<CatergoryList> categoryList = [
  //   CatergoryList(
  //     id: 1,
  //     name: 'Kurti & Suit',
  //     isCheck: false,
  //     imageUrl: 'assets/images/logo1.png',
  //   ),
  //   CatergoryList(
  //     id: 2,
  //     name: 'Men',
  //     isCheck: false,
  //     imageUrl: 'assets/images/logo2.png',
  //   ),
  //   CatergoryList(
  //     id: 3,
  //     name: 'Westernwear',
  //     isCheck: false,
  //     imageUrl: 'assets/images/logo3.png',
  //   ),
  //   // CatergoryList(
  //   //   id: 4,
  //   //   name: 'Saree',
  //   //   isCheck: false,
  //   //   imageUrl: 'https://assets.ajio.com/medias/sys_master/root/20220112/6wFC/61ddf6b7f997dd66231cc8c3/-473Wx593H-463646653-blue-MODEL.jpg',
  //   // ),
  //   // CatergoryList(
  //   //   id: 5,
  //   //   name: 'Accessories',
  //   //   isCheck: false,
  //   //   imageUrl: 'https://i.pinimg.com/originals/44/14/3f/44143fd00203e71a634fa8d026bb9591.jpg',
  //   // ),
  //   // CatergoryList(
  //   //   id: 6,
  //   //   name: 'Jewllery',
  //   //   isCheck: false,
  //   //   imageUrl: 'https://i.pinimg.com/originals/09/8d/4b/098d4ba2c3ef201f0a41717d4c668d2c.jpg',
  //   // ),
  //   // CatergoryList(
  //   //   id: 7,
  //   //   name: 'Kids',
  //   //   isCheck: false,
  //   //   imageUrl: 'https://image.shutterstock.com/image-photo/little-boy-girl-ready-journey-260nw-186099026.jpg',
  //   // ),
  //   // CatergoryList(
  //   //   id: 8,
  //   //   name: 'Beauty',
  //   //   isCheck: false,
  //   //   imageUrl: 'https://img.huffingtonpost.com/asset/57b626c0170000ae02c7416b.png?ops=1778_1000',
  //   // ),
  //   // CatergoryList(
  //   //   id: 9,
  //   //   name: 'Footwear',
  //   //   isCheck: false,
  //   //   imageUrl: 'https://threadcurve.com/wp-content/uploads/2020/06/footwear-june272020.jpg',
  //   // ),
  //   // CatergoryList(
  //   //   id: 9,
  //   //   name: 'Electronics',
  //   //   isCheck: false,
  //   //   imageUrl: 'https://english.cdn.zeenews.com/sites/default/files/styles/zm_700x400/public/2022/01/27/1009314-untitled-design-7.jpg',
  //   // ),
  //   // CatergoryList(
  //   //   id: 10,
  //   //   name: 'Healthcare',
  //   //   isCheck: false,
  //   //   imageUrl: 'https://5.imimg.com/data5/AE/MF/GLADMIN-6919448/allopathic-medicines-gen-medica-500x500.png',
  //   // ),
  // ];

  //Home screen best offer banner
  final sliderImage = [
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTnpypoGHJOi_GjgqS0jKzaXweNDZE1IaZGXQ&usqp=CAU',
    'https://i.ytimg.com/vi/9Relbr59GX0/maxresdefault.jpg',
    'https://play-lh.googleusercontent.com/N9TPdDLUluBvsOG3wAGsourZ5VspzXqKPqy-L5YvARYXq0jC2qZNUixeXTViDzk-eg4',
    'https://i.ytimg.com/vi/sk56DPAk-1c/maxresdefault.jpg',
  ];
  //pricelist
  final price = [99, 199, 299, 399, 499];
  //bestSeller list
  // final List<BestSeller> bestSellerlist = [
  //   BestSeller(
  //     id: 1,
  //     name: 'Men Top Wear',
  //     image:
  //         'https://p1.hiclipart.com/preview/822/526/452/exo-render-spao-two-men-wearing-dress-shirts-standing-png-clipart.jpg',
  //     price: 149,
  //   ),
  //   BestSeller(
  //     id: 2,
  //     name: 'Electromics',
  //     image:
  //         'https://mpng.subpng.com/20180706/ag/kisspng-home-appliance-senheng-electric-electronics-samsun-electronics-home-appliances-5b3f783965f519.9948579415308862014176.jpg',
  //     price: 69,
  //   ),
  //   BestSeller(
  //     id: 3,
  //     name: 'Kurtis & Kurtas',
  //     image:
  //         'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcREOnWU56_PyKGDjxXujZr1GysRg4XZcmd5lA&usqp=CAU',
  //     price: 149,
  //   ),
  //   BestSeller(
  //     id: 4,
  //     name: 'Women Sarees',
  //     image:
  //         'https://e7.pngegg.com/pngimages/475/472/png-clipart-sari-saree-saree-sari-thumbnail.png',
  //     price: 249,
  //   ),
  //   BestSeller(
  //     id: 5,
  //     name: 'Jewellery',
  //     image:
  //         'https://e7.pngegg.com/pngimages/278/717/png-clipart-woman-wearing-brown-and-red-cap-sleeved-dress-jewelry-design-kerala-jewellery-necklace-earring-jewellery-miscellaneous-gemstone.png',
  //     price: 79,
  //   ),
  //   BestSeller(
  //     id: 6,
  //     name: 'Watches',
  //     image:
  //         'https://i5.walmartimages.com/asr/66190ef2-ef12-4476-9d05-871b05b85932.a42c7db0db9cbab6f06c1d090b4aed11.jpeg', //'https://esquilo.io/png/thumb/03m4LdjMQXB4qpB-Smartwatch-PNG-Transparent.png',
  //     price: 149,
  //   ),
  //   BestSeller(
  //     id: 7,
  //     name: 'Personal Care',
  //     image:
  //         'https://icon2.cleanpng.com/20180124/vle/kisspng-cosmetics-makeup-brush-mirror-toiletry-bag-makeup-department-5a694bbae78da8.7198981815168501069485.jpg',
  //     price: 89,
  //   ),
  // ];
  // //Top Demand list home screen
  // final List<TopDemand> topDemandList = [
  //   TopDemand(
  //     id: 1,
  //     name: 'Electromics',
  //     image:
  //         'https://p7.hiclipart.com/preview/381/468/936/home-appliance-kitchen-consumer-electronics-house-kitchen.jpg',
  //     price: 149,
  //   ),
  //   TopDemand(
  //     id: 2,
  //     name: 'Footwear',
  //     image:
  //         'https://mpng.subpng.com/20180319/ptq/kisspng-puma-shoe-sneakers-nike-footwear-green-running-shoes-png-5ab042899cea58.7492755915215008096428.jpg',
  //     price: 119,
  //   ),
  //   TopDemand(
  //     id: 3,
  //     name: 'Trendy Watches',
  //     image:
  //         'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQTesmMzJ4TAXjR62AMYQgwBH5UXw3_swm_1EqKdWSxzPBlVXtBA8YIpUkOXqDKCdWmtAY&usqp=CAU',
  //     price: 149,
  //   ),
  //   TopDemand(
  //     id: 4,
  //     name: 'Top Accessories',
  //     image:
  //         'https://spng.subpng.com/20180306/wdq/kisspng-denim-skirt-miniskirt-top-court-shoe-women-with-5a9e7166ab7db7.1979518815203331587024.jpg',
  //     price: 69,
  //   ),
  //   TopDemand(
  //     id: 5,
  //     name: 'Bages',
  //     image:
  //         'https://icon2.cleanpng.com/20180926/gyt/kisspng-tote-bag-leather-handbag-birkin-bag-herms-5bac451258b041.7528313615380165303633.jpg',
  //     price: 149,
  //   ),
  //   TopDemand(
  //     id: 6,
  //     name: 'Shirts',
  //     image:
  //         'https://toppng.com/uploads/preview/man-thinking-blue-shirt-11549008060psrtv186sr.png',
  //     price: 159,
  //   ),
  //   TopDemand(
  //     id: 7,
  //     name: 'Kids Dresses',
  //     image:
  //         'https://toppng.com/uploads/preview/kids-garment-11563282242xdz5hd3fog.png',
  //     price: 139,
  //   ),
  // ];
  // //Trending list
  // final List<Treanding> trendingList = [
  //   Treanding(
  //     id: 1,
  //     name: 'Player\'s Pick',
  //     image:
  //         'https://p1.hiclipart.com/preview/378/460/985/modi-virat-kohli-statue-india-narendra-modi-clothing-facial-hair-tshirt-png-clipart.jpg',
  //     price: 99,
  //   ),
  //   Treanding(
  //     id: 2,
  //     name: 'Combo Store',
  //     image:
  //         'https://p1.hiclipart.com/preview/58/369/248/karol-sevilla-y-ruggero-pasquarelli-005-two-smiling-girl-and-boy-standing-png-clipart-thumbnail.jpg',
  //     price: 79,
  //   ),
  //   Treanding(
  //     id: 3,
  //     name: 'Men Footwear',
  //     image:
  //         'https://p7.hiclipart.com/preview/309/202/420/leather-dress-shoe-clothing-footwear-shoe-repair.jpg',
  //     price: 149,
  //   ),
  //   Treanding(
  //     id: 4,
  //     name: 'Men Accessory',
  //     image:
  //         'https://cdn.imgbin.com/2/18/23/imgbin-vintage-fashion-accessories-clothing-accessories-man-vintage-clothing-man-xMFy2btR1JpUnZTXr171YyQDe.jpg',
  //     price: 99,
  //   ),
  //   Treanding(
  //     id: 5,
  //     name: 'Women Topwear',
  //     image:
  //         'https://p1.hiclipart.com/preview/510/577/289/two-women-talking-photo-together-png-clipart.jpg',
  //     price: 149,
  //   ),
  //   Treanding(
  //     id: 6,
  //     name: 'Kids Clothing',
  //     image:
  //         'https://p7.hiclipart.com/preview/425/313/225/children-s-clothing-online-shopping-footwear-kids-clothing-logo.jpg',
  //     price: 129,
  //   ),
  //   Treanding(
  //     id: 7,
  //     name: 'Women Footwear',
  //     image:
  //         'https://toppng.com/uploads/preview/ink-women-shoes-png-image-women-shoes-transparent-background-11563550651v41t0milf1.png',
  //     price: 129,
  //   ),
  // ];
  //
  final List<Products> productsList = [
    Products(
      id: 1,
      name: 'Myra Fashionable Krutis',

      imageUrl:
          'https://images.meesho.com/images/products/236112652/9i5ay_512.jpg', //'https://www.pinkvilla.com/files/styles/amp_metadata_content_image/public/159963742_1849427255226394_5869188102905440561_n.jpg',
      details: [
        'Name: Trendy Attractive Kurtis',
        'Fabric: Rayon',
        'Sleeve Length: Three-Quater sleeves',
        'Pattern: Solid',
        'Combo of: Single',
        'Sizes:\n M,L,XL,XXL',
        'Country of Origin: India'
      ],
      price: 490,
      rate: 3.8,
      isFavorite: false,
    ),
    Products(
      id: 2,
      name: 'Classy Partywear Women Ethnic',
      imageUrl:
          'https://images.meesho.com/images/products/72603024/lbe1e_512.jpg',
      details: [
        'Name: Jivika Sensational Kurtis',
        'Fabric: Rayon',
        'Sleeve Length: Short Sleeves',
        'Pattern: Printed',
        'Combo of: Single ',
        'Sizes:\n M,L,XL,XXL',
        'Country of Origin: India'
      ],
      price: 454,
      rate: 4,
      isFavorite: false,
    ),
    Products(
      id: 3,
      name: 'Twinkling Elegant Jewwllery with Matching Earring',
      imageUrl:
          'https://assets.myntassets.com/h_1440,q_90,w_1080/v1/assets/images/productimage/2021/5/11/b0cad4c3-95e9-4d45-9739-4cda1bdb83c91620727699168-1.jpg',
      details: [
        'Name:Gold Plated Designer Jewelry with Chain/Chain Pendant Set',
        'Base Metal: Alloy',
        'Plating : Brass Plated',
        'Stone Type : American Diamond',
        'Sizing : Adjustable',
        'Type: Chain',
        'Net Quantity(N): 3',
      ],
      price: 153,
      rate: 4.1,
      isFavorite: false,
    ),
    Products(
      id: 4,
      name: 'Gentle hair oil 150ml & onion hair shapoo 250ml',
      imageUrl:
          'https://asset20.ckassets.com/resources/image/ckseller/CKS-Hair-Care-000009_1-1611115943.jpg',
      details: [
        'Name: Onion ha Hair Oils',
        'Product Name: onion Hair Oil',
        'Multipack: 1',
        'Flavour: Almond',
        'BOOSTS HAIR GROWTH : Onion Oil, in combination with Redensyl, reduces hair fall and promotes growth of lost hair.',
        'ADDS STRENGTH & SHINE : Full of nature\'s goodness,Amla Oil, Hibiscus Oil, etc.',
      ],
      price: 12,
      rate: 3.2,
      isFavorite: false,
    ),
    Products(
      id: 5,
      name: 'Pretty Comfy Boys & Girls Multi-Color Top ',
      imageUrl:
          'https://static-01.daraz.pk/p/cbcd5b6381e639f0455312df85103114.jpg',
      details: [
        'Name: Cute Casual Skirts(Single)',
        'Fabric: Cotton',
        'Pattern: Printed',
        'Net Quantity(N): 1',
        'Combo of: Single ',
        'Sizes : \n 6-12 Months, 0-1 Years, 1-2 Years, 2-3 Years, 3-4 Years, 4-5 Years'
            'Country of Origin: India'
      ],
      price: 113,
      rate: 3.2,
      isFavorite: false,
    ),
    Products(
      id: 6,
      name: 'Modem Fashionable Men Shoes-Running Shoes',
      imageUrl:
          'https://5.imimg.com/data5/CI/DI/GY/SELLER-32493408/00-500x500.jpg',
      details: [
        'Name:Modern Attractive Men Casual Shoes',
        'Material: Syntethic Leather',
        'Sole Material: Rubber',
        'Fastening & Back Detail: Lace-Up',
        'Multipack: 1 ',
        'Sizes:\n IND-6,IND-7,IND-9,IND-10',
        'Country of Origin: India'
      ],
      price: 276,
      rate: 3.5,
      isFavorite: false,
    ),
    Products(
      id: 7,
      name: 'Chitrarekha Attractive Krutis',
      imageUrl:
          'https://rukminim2.flixcart.com/image/832/832/kmkxbww0/ethnic-set/x/y/3/xxl-bandej-001-sarara-original-imagffhg8cwzb4wd.jpeg?q=70',
      details: [
        'Name: Ladies Cotton Kurtis',
        'Fabric: Cotton',
        'Sleeve Length: Three-Quater sleeves',
        'Pattern: Printed',
        'Combo of: Single ',
        'Sizes:\n M,L,XL,XXL',
        'Country of Origin: India'
      ],
      price: 369,
      rate: 3.9,
      isFavorite: false,
    ),
    Products(
      id: 8,
      name: 'Pretty Fashionable Women Top',
      imageUrl:
          'https://img3.junaroad.com/uiproducts/18252074/pri_175_p-1644228854.jpg',
      details: [
        'Name: Trendy Ravishing Women Top & tunics',
        'Fabric: Crepe',
        'Sleeve Length: Three-Quater sleeves',
        'Pattern: Printed',
        'Combo of: Single ',
        'Net Quantity(N): 1',
        'Sizes:\n XS,S,M,L,XL,XXL,XXXL',
        'Country of Origin: India'
      ],
      price: 177,
      rate: 3.6,
      isFavorite: false,
    ),
  ];
  // List<NotificationList> filtergenderButton = [
  //   NotificationList(id: 1, name: 'Boys', isCheck: false),
  //   NotificationList(id: 2, name: 'Girls', isCheck: false),
  //   NotificationList(id: 3, name: 'Men', isCheck: false),
  //   NotificationList(id: 4, name: 'Women', isCheck: false),
  // ];
  //
  // final List<NotificationList> fabricList = [
  //   NotificationList(id: 1, name: 'Acrylic', isCheck: false),
  //   NotificationList(id: 2, name: 'Art Silk', isCheck: false),
  //   NotificationList(id: 3, name: 'Bamboo', isCheck: false),
  //   NotificationList(id: 4, name: 'Chanderi Cotton', isCheck: false),
  //   NotificationList(id: 5, name: 'Chanderi Silk', isCheck: false),
  //   NotificationList(id: 6, name: 'Denim', isCheck: false),
  //   NotificationList(id: 7, name: 'Poly Cotton', isCheck: false),
  //   NotificationList(id: 8, name: 'Silk', isCheck: false),
  //   NotificationList(id: 9, name: 'Silk Blend', isCheck: false),
  //   NotificationList(id: 10, name: 'Soft Silk', isCheck: false),
  // ];
  //
  // List<NotificationList> filtercolorButton = [
  //   NotificationList(id: 1, name: 'Beige', isCheck: false),
  //   NotificationList(id: 2, name: 'Black', isCheck: false),
  //   NotificationList(id: 3, name: 'Blue', isCheck: false),
  //   NotificationList(id: 4, name: 'Combo Of Maroon Shade', isCheck: false),
  //   NotificationList(id: 5, name: 'Combo Of Pink Shade', isCheck: false),
  //   NotificationList(id: 6, name: 'Combo Of Red Shaade', isCheck: false),
  //   NotificationList(id: 7, name: 'Gold', isCheck: false),
  //   NotificationList(id: 8, name: 'Grey', isCheck: false),
  //   NotificationList(id: 9, name: 'Khaki', isCheck: false),
  //   NotificationList(id: 10, name: 'Light Pink', isCheck: false),
  //   NotificationList(id: 11, name: 'Maroon', isCheck: false),
  //   NotificationList(id: 12, name: 'Multicolor', isCheck: false),
  //   NotificationList(id: 13, name: 'Nude', isCheck: false),
  //   NotificationList(id: 14, name: 'Olive', isCheck: false),
  //   NotificationList(id: 15, name: 'Orange', isCheck: false),
  //   NotificationList(id: 16, name: 'Peach', isCheck: false),
  //   NotificationList(id: 17, name: 'Pink', isCheck: false),
  //   NotificationList(id: 18, name: 'Purple', isCheck: false),
  //   NotificationList(id: 19, name: 'Red', isCheck: false),
  //   NotificationList(id: 20, name: 'Rose Gold', isCheck: false),
  //   NotificationList(id: 21, name: 'Silver', isCheck: false),
  //   NotificationList(id: 22, name: 'Skin', isCheck: false),
  //   NotificationList(id: 23, name: 'Transparent', isCheck: false),
  //   NotificationList(id: 24, name: 'White', isCheck: false),
  // ];
  //
  // List<NotificationList> filterPriceButton = [
  //   NotificationList(id: 1, name: 'Undaer ₹ 149', isCheck: false),
  //   NotificationList(id: 2, name: 'Undaer ₹ 199', isCheck: false),
  //   NotificationList(id: 3, name: 'Undaer ₹ 249', isCheck: false),
  //   NotificationList(id: 4, name: 'Undaer ₹ 299', isCheck: false),
  //   NotificationList(id: 5, name: 'Undaer ₹ 349', isCheck: false),
  //   NotificationList(id: 6, name: 'Undaer ₹ 399', isCheck: false),
  //   NotificationList(id: 7, name: 'Undaer ₹ 449', isCheck: false),
  //   NotificationList(id: 8, name: 'Undaer ₹ 499', isCheck: false),
  //   NotificationList(id: 9, name: 'Undaer ₹ 99', isCheck: false),
  //   NotificationList(id: 10, name: '₹ 0 - ₹ 99', isCheck: false),
  //   NotificationList(id: 11, name: '₹ 100 - ₹ 149', isCheck: false),
  //   NotificationList(id: 12, name: '₹ 150 - ₹ 199', isCheck: false),
  //   NotificationList(id: 13, name: '₹ 200 - ₹ 249', isCheck: false),
  //   NotificationList(id: 14, name: '₹ 250 - ₹ 299', isCheck: false),
  //   NotificationList(id: 15, name: '₹ 300 - ₹ 399', isCheck: false),
  //   NotificationList(id: 16, name: '₹ 400 - ₹ 499', isCheck: false),
  //   NotificationList(id: 17, name: '₹ 500 - ₹ 599', isCheck: false),
  //   NotificationList(id: 18, name: '₹ 600 - ₹ 699', isCheck: false),
  //   NotificationList(id: 19, name: '₹ 700 - ₹ 799', isCheck: false),
  //   NotificationList(id: 20, name: '₹ 800 - ₹ 800 & above', isCheck: false),
  // ];
  //
  // List<NotificationList> filterDiscountButton = [
  //   NotificationList(id: 1, name: '10% and above', isCheck: false),
  //   NotificationList(id: 2, name: 'All discounted', isCheck: false),
  //   NotificationList(id: 3, name: 'Undaer ₹ 249', isCheck: false),
  //   NotificationList(id: 4, name: 'deals', isCheck: false),
  // ];
  //
  // List<NotificationList> filterRatinglist = [
  //   NotificationList(id: 1, name: '2.0 and above', isCheck: false),
  //   NotificationList(id: 2, name: '3.0 and above', isCheck: false),
  //   NotificationList(id: 3, name: '3.5 and above', isCheck: false),
  //   NotificationList(id: 4, name: '4.0 and above', isCheck: false),
  //   NotificationList(id: 5, name: 'M-trusted', isCheck: false),
  // ];
  //
  // List<NotificationList> filterSizelist = [
  //   NotificationList(id: 1, name: '0-2 Years', isCheck: false),
  //   NotificationList(id: 2, name: '1.5 meters', isCheck: false),
  //   NotificationList(id: 3, name: '1.75 meters', isCheck: false),
  //   NotificationList(id: 4, name: '10', isCheck: false),
  //   NotificationList(id: 5, name: '10-16 Years', isCheck: false),
  //   NotificationList(id: 6, name: '10 XL', isCheck: false),
  //   NotificationList(id: 7, name: '11', isCheck: false),
  //   NotificationList(id: 8, name: '12', isCheck: false),
  //   NotificationList(id: 9, name: '13', isCheck: false),
  //   NotificationList(id: 10, name: '14', isCheck: false),
  //   NotificationList(id: 11, name: '16', isCheck: false),
  //   NotificationList(id: 12, name: '2 meters', isCheck: false),
  //   NotificationList(id: 13, name: '2-5 Years', isCheck: false),
  //   NotificationList(id: 14, name: '22', isCheck: false),
  //   NotificationList(id: 15, name: '23', isCheck: false),
  //   NotificationList(id: 16, name: '24', isCheck: false),
  //   NotificationList(id: 17, name: '25', isCheck: false),
  //   NotificationList(id: 18, name: '2.5 meters', isCheck: false),
  //   NotificationList(id: 19, name: '2.6', isCheck: false),
  //   NotificationList(id: 20, name: '24', isCheck: false),
  // ];
  //
  // List<NotificationList> filterCombolist = [
  //   NotificationList(id: 1, name: 'Combos', isCheck: false),
  //   NotificationList(id: 2, name: 'Multipack', isCheck: false),
  //   NotificationList(id: 3, name: 'Pack of 1', isCheck: false),
  //   NotificationList(id: 4, name: 'Pack of 12', isCheck: false),
  //   NotificationList(id: 5, name: 'Pack of 2', isCheck: false),
  //   NotificationList(id: 6, name: 'Pack of 3', isCheck: false),
  //   NotificationList(id: 7, name: 'Pack of 4', isCheck: false),
  //   NotificationList(id: 8, name: 'Pack of 5', isCheck: false),
  //   NotificationList(id: 9, name: 'Pack of 6', isCheck: false),
  //   NotificationList(id: 10, name: 'Pack of 7', isCheck: false),
  //   NotificationList(id: 11, name: 'Pack of 8', isCheck: false),
  //   NotificationList(id: 12, name: 'Pack of 9', isCheck: false),
  // ];
  //
  // List<NotificationList> filterMateriallist = [
  //   NotificationList(id: 1, name: 'Acrylic', isCheck: false),
  //   NotificationList(id: 2, name: 'Aluminium', isCheck: false),
  //   NotificationList(id: 3, name: 'Bone China', isCheck: false),
  //   NotificationList(id: 4, name: 'Brass', isCheck: false),
  //   NotificationList(id: 5, name: 'Ceramic', isCheck: false),
  //   NotificationList(id: 6, name: 'Clay', isCheck: false),
  //   NotificationList(id: 7, name: 'Copper', isCheck: false),
  //   NotificationList(id: 8, name: 'Cotton', isCheck: false),
  //   NotificationList(id: 9, name: 'Foam', isCheck: false),
  //   NotificationList(id: 10, name: 'Glass', isCheck: false),
  //   NotificationList(id: 11, name: 'Iron', isCheck: false),
  //   NotificationList(id: 12, name: 'Leather', isCheck: false),
  //   NotificationList(id: 13, name: 'Melamine', isCheck: false),
  //   NotificationList(id: 14, name: 'Nylon', isCheck: false),
  //   NotificationList(id: 15, name: 'Plastic', isCheck: false),
  //   NotificationList(id: 16, name: 'Poly Cotton', isCheck: false),
  //   NotificationList(id: 17, name: 'Polyester', isCheck: false),
  //   NotificationList(id: 18, name: 'Polyethylene', isCheck: false),
  //   NotificationList(id: 19, name: 'Silicon', isCheck: false),
  //   NotificationList(id: 20, name: 'Steel', isCheck: false),
  // ];
  // List<NotificationList> filterBottomLength = [
  //   NotificationList(id: 1, name: '2 mtrs', isCheck: false),
  //   NotificationList(id: 2, name: '2.1 mtrs', isCheck: false),
  //   NotificationList(id: 3, name: '2.2 mtrs', isCheck: false),
  //   NotificationList(id: 4, name: '2.25 mtrs', isCheck: false),
  //   NotificationList(id: 5, name: '2.3 mtrs', isCheck: false),
  //   NotificationList(id: 6, name: '2.4 mtrs', isCheck: false),
  //   NotificationList(id: 7, name: '2.5 mtrs', isCheck: false),
  //   NotificationList(id: 8, name: '2.6 mtrs', isCheck: false),
  //   NotificationList(id: 9, name: '2.7 mtrs', isCheck: false),
  //   NotificationList(id: 10, name: '2.8 mtrs', isCheck: false),
  //   NotificationList(id: 11, name: '3 mtrs', isCheck: false),
  // ];
  // List<NotificationList> filterBottomStyle = [
  //   NotificationList(id: 1, name: 'Anarkali', isCheck: false),
  //   NotificationList(id: 2, name: 'Banarasi', isCheck: false),
  //   NotificationList(id: 3, name: 'Flared', isCheck: false),
  //   NotificationList(id: 4, name: 'Gathered', isCheck: false),
  //   NotificationList(id: 5, name: 'Gujarati', isCheck: false),
  //   NotificationList(id: 6, name: 'Indo Western', isCheck: false),
  //   NotificationList(id: 7, name: 'Layered', isCheck: false),
  //   NotificationList(id: 8, name: 'Panelled', isCheck: false),
  //   NotificationList(id: 9, name: 'Rajputani', isCheck: false),
  // ];
  // List<NotificationList> filterBottomFabric = [
  //   NotificationList(id: 1, name: 'Art Silk', isCheck: false),
  //   NotificationList(id: 2, name: 'Georgette', isCheck: false),
  //   NotificationList(id: 3, name: 'Net', isCheck: false),
  //   NotificationList(id: 4, name: 'Satin', isCheck: false),
  //   NotificationList(id: 5, name: 'Silk', isCheck: false),
  //   NotificationList(id: 6, name: 'Taffets Silk', isCheck: false),
  //   NotificationList(id: 7, name: 'Velvet', isCheck: false),
  // ];
  // List<NotificationList> filterOrnamentationlist = [
  //   NotificationList(id: 1, name: 'Aari Work', isCheck: false),
  //   NotificationList(id: 2, name: 'Applique', isCheck: false),
  //   NotificationList(id: 3, name: 'Beads & Stones', isCheck: false),
  //   NotificationList(id: 4, name: 'Brocade', isCheck: false),
  //   NotificationList(id: 5, name: 'Buckle', isCheck: false),
  //   NotificationList(id: 6, name: 'Embelished', isCheck: false),
  //   NotificationList(id: 7, name: 'Embroidered', isCheck: false),
  //   NotificationList(id: 8, name: 'Frills', isCheck: false),
  //   NotificationList(id: 9, name: 'Jacquard', isCheck: false),
  //   NotificationList(id: 10, name: 'Lace border', isCheck: false),
  //   NotificationList(id: 11, name: 'Mirror Work', isCheck: false),
  //   NotificationList(id: 12, name: 'Sequinned', isCheck: false),
  //   NotificationList(id: 13, name: 'Show Button', isCheck: false),
  //   NotificationList(id: 14, name: 'Tassels', isCheck: false),
  //   NotificationList(id: 15, name: 'Tassels And Latkans', isCheck: false),
  // ];

  fetchCategoryData() async {
    categoryList.clear();
    try {
      final Map<String, dynamic> body = {
        'CustomerPhoneNo': customerModel!.value.customerPhoneNo,
        'CustomerFCMToken': customerModel!.value.customerFCMToken,
      };

      var response = await ApiService.post(endpoint: getCategory, body: body);

      print(response.data);

      if (response.data['IsSuccess'] == true) {
        categoryList = (response.data['Data'] as List)
            .map((categoryJson) => Category.fromJson(categoryJson))
            .toList();
        print("category data ${categoryList}");
        update();
      } else {
        throw Exception("Error: ${response.data['Message']}");
      }
    } catch (e) {
      print("Error in fetchCategoryData: $e");
      throw Exception("Failed to fetch category data");
    }
  }
  fetchSubCategoryData(String categoryId) async {
    subCategoryList.clear();
    try {
      final Map<String, dynamic> body = {
        'CategoryId': categoryId,
      };

      var response = await ApiService.post(endpoint: getSubcategorybyCategoryId, body: body);

      print("sub category data ${response.data}");

      if (response.data['IsSuccess'] == true) {
        subCategoryList = (response.data['Data'] as List)
            .map((subCategoryJson) => SubCategory.fromJson(subCategoryJson))
            .toList();
        print("sub category data ${subCategoryList.length}");
        isCategory = true.obs;
        update();
      } else {
        throw Exception("Error: ${response.data['Message']}");
      }
    } catch (e) {
      print("Error in fetchCategoryData: $e");
      throw Exception("Failed to fetch category data");
    }
  }
}
