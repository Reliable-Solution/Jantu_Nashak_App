import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:keep_app/constant/app_constant.dart';
import 'package:keep_app/controller/splashController.dart';

import '../../constant/imagesConst.dart';

class RewardScreen extends StatefulWidget {
  const RewardScreen({super.key});

  @override
  State<RewardScreen> createState() => _RewardScreenState();
}

class _RewardScreenState extends State<RewardScreen> {
  SplashController controller = SplashController();

  @override
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.getSettingData();
  }

  Widget build(BuildContext context) {
    return GetBuilder<SplashController>(
      builder: (controller) =>
      // () =>
          // child:
          Center(
        child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: controller.settingList[0].settingImage != null  || controller.settingList.isNotEmpty ||controller.settingList[0].settingImage!.isNotEmpty
                      ? NetworkImage(IMAGE_URL +
                          controller.settingList[0].settingImage! ??
                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ-sMD1XKD1dz39UAaJnWmW8UlkT1Ec6Vh_aPLsm6WN81Gp10rPLlH5j8d6wNnAJQC-Smg&usqp=CAU') :
                  AssetImage(Images.profileicon)

             ,onError: (exception, stackTrace) => AssetImage(Images.profileicon), )
          ),
        ),
        // Column(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: [
        //     Container(decoration: BoxDecoration(image: DecorationImage(image: NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ-sMD1XKD1dz39UAaJnWmW8UlkT1Ec6Vh_aPLsm6WN81Gp10rPLlH5j8d6wNnAJQC-Smg&usqp=CAU'))),)
        //     // const Icon(Icons.card_giftcard, size: 60, color: Colors.orange),
        //     // const SizedBox(height: 20),
        //     // const Text(
        //     //   'Rewards Screen',
        //     //   style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        //     // ),
        //     // const SizedBox(height: 10),
        //     // const Text('Here you will see your earned rewards.'),
        //     // const SizedBox(height: 30),
        //     // ElevatedButton(
        //     //   onPressed: () {
        //     //     Fluttertoast.showToast(msg: 'Reward claimed!');
        //     //   },
        //     //   child: const Text('Claim Reward'),
        //     // ),
        //   ],
        // ),
      ),
    );
  }
}
