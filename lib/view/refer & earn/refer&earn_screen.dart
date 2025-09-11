// class Refer&earnScreen extends StatefulWidget {
//   const Refer&earnScreen({super.key});
//
//   @override
//   State<Refer&earnScreen> createState() => _Refer&earnScreenState();
// }
//
// class _Refer&earnScreenState extends State<Refer&earnScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return const Placeholder();
//   }
// }




import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:keep_app/utils/string_res.dart';
import 'package:share_plus/share_plus.dart';

import '../../Theme/nativeTheme.dart';
import '../../controller/homeController.dart';
import '../../widget/appBarWidget.dart';
import '../../widget/textWidget.dart';

class ReferAndEarnScreen extends StatefulWidget {
  const ReferAndEarnScreen({Key? key}) : super(key: key);

  @override
  _ReferAndEarnScreenState createState() => _ReferAndEarnScreenState();
}

class _ReferAndEarnScreenState extends State<ReferAndEarnScreen>
    with SingleTickerProviderStateMixin {

  final HomeController _controller = Get.find();

   String referralCode = 'AMITXV500';
  bool copied = false;
  late AnimationController _sparkleController;
  late Animation<double> _sparkleAnimation1;
  late Animation<double> _sparkleAnimation2;
  late Animation<double> _sparkleAnimation3;
  late Animation<double> _sparkleAnimation4;
  late Animation<double> _sparkleAnimation5;

  @override
  void initState() {
    super.initState();
    _controller.getPrefs();
    // print("=========> Refer Code ${_controller.m1!.customerReferCode}");
    referralCode = _controller.customerModel?.value.customerReferCode ?? "";
    _sparkleController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _sparkleAnimation1 = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _sparkleController,
        curve: const Interval(0.0, 0.8, curve: Curves.easeInOut),
      ),
    );
    _sparkleAnimation2 = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _sparkleController,
        curve: const Interval(0.2, 1.0, curve: Curves.easeInOut),
      ),
    );
    _sparkleAnimation3 = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _sparkleController,
        curve: const Interval(0.4, 1.0, curve: Curves.easeInOut),
      ),
    );
    _sparkleAnimation4 = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _sparkleController,
        curve: const Interval(0.6, 1.0, curve: Curves.easeInOut),
      ),
    );
    _sparkleAnimation5 = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _sparkleController,
        curve: const Interval(0.8, 1.0, curve: Curves.easeInOut),
      ),
    );
  }

  @override
  void dispose() {
    _sparkleController.dispose();
    super.dispose();
  }

  void _copyCode() {
    Clipboard.setData(ClipboardData(text: referralCode)).then((_) {
      setState(() {
        copied = true;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content:  Text(StringRes.codeCopied),
          duration: const Duration(seconds: 2),
          backgroundColor: const Color(0xFF226706),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      );
      Future.delayed(const Duration(seconds: 2), () {
        if (mounted) {
          setState(() {
            copied = false;
          });
        }
      });
    });
  }

  void _handleShare() async {
    final String shareText =
        '🌱 Hey there! I am using JantuNashak – a smart Agriculture app for farmers.\n\n'
        '🚜 Get the latest crop prices, expert tips, seeds, fertilizers, and much more.\n\n'
        '✨ Use my *Referral Code*:\n'
        '🔑 👉 [$referralCode] 👈\n'
        '📲 Download now & make your farming smarter.\n'
        'Also, both of us can earn rewards up to ₹500!\n';
        // 'Download now and make your farming smarter.';
    // final String shareText =
    //     'Hey friends! Get amazing deals on this awesome app. Use my referral code $referralCode to get ₹250 off your first order and a chance to earn up to ₹500!';
    final String shareUrl = 'Download the JantuNashak App for get better Product at Farmers.\n\nhttps://play.google.com/store/apps/details?id=com.reliable.jantunashak';
        // 'https://yourapplink.com/refer ';

    await Share.share(
      '$shareText $shareUrl',
      subject: 'Shopees Referral Invite',
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final double cardWidth = size.width > 600 ? 500 : size.width * 0.95;

    return SafeArea(
      top: false,
      bottom: true,
      child: Scaffold(

        appBar: MyCustomAppBar(
          actionPadding: 10,
          height: 90,
          appbarPadding: 0,
          elevation: 1,
          title: TextWiget(
            title: StringRes.referAndEarn,
            style: Themes.light.textTheme.headlineLarge,
          ),
        ),
        // appBar: AppBar(actionsPadding: EdgeInsets.all(10),
        //   elevation: 1,
        //   // actionsPadding: 10,
        //   title: const Text('Refer & Earn',style: TextStyle(color: Colors.white70),),
        //   backgroundColor: const Color(0xFF226706),
        // ),
        // appBar: MyCustomAppBar(
        //   actionPadding: 10,
        //   height: 90,
        //   appbarPadding: 0,
        //   elevation: 1,
        //   title: TextWiget(
        //     title: "Refer & Earn",
        //     style: Themes.light.textTheme.headlineLarge,
        //   ),
        // ),
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFF226706), // Base color
                Color(0xFF1A4F05), // Darker shade for gradient
              ],
            ),
          ),
          child: SafeArea(
            child: SingleChildScrollView(
              // padding: const EdgeInsets.all(16.0),
              child: Stack(
                children: [
                  // Sparkle Effects
                  _buildSparkle(size, _sparkleAnimation1, const Offset(0.20, 0.10),
                      Colors.yellow.shade200, 12, const Offset(60, -60)),
                  _buildSparkle(size, _sparkleAnimation2, const Offset(0.75, 0.20),
                      Colors.amber.shade200, 10, const Offset(-40, -50)),
                  _buildSparkle(size, _sparkleAnimation3, const Offset(0.15, 0.45),
                      Colors.lime.shade200, 8, const Offset(50, -30)),
                  _buildSparkle(size, _sparkleAnimation4, const Offset(0.80, 0.55),
                      Colors.teal.shade200, 9, const Offset(-50, -40)),
                  _buildSparkle(size, _sparkleAnimation5, const Offset(0.35, 0.75),
                      Colors.yellow.shade300, 11, const Offset(60, 20)),

                  // Main Content
                  Center(
                    child: Container(
                      // constraints: BoxConstraints(maxWidth: cardWidth),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        // borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF226706).withOpacity(0.3),
                            spreadRadius: 3,
                            blurRadius: 15,
                            offset: const Offset(0, 10),
                          ),
                        ],
                        // border: const Border(
                        //   top: BorderSide(color: Color(0xFFFFCA28), width: 6),
                        // ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // App Bar
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //   children: [
                            //     IconButton(
                            //       icon: const Icon(Icons.arrow_back,
                            //           color: Colors.grey),
                            //       onPressed: () => Navigator.pop(context),
                            //     ),
                            //     Text(
                            //       '4:21 PM',
                            //       style: TextStyle(
                            //         fontSize: size.width * 0.035,
                            //         fontWeight: FontWeight.w600,
                            //         color: Colors.grey,
                            //       ),
                            //     ),
                            //     Row(
                            //       children: [
                            //         Text(
                            //           '100%',
                            //           style: TextStyle(
                            //             fontSize: size.width * 0.03,
                            //             color: Colors.grey,
                            //             fontWeight: FontWeight.w500,
                            //           ),
                            //         ),
                            //         const SizedBox(width: 4),
                            //         const Icon(Icons.battery_charging_full,
                            //             size: 20, color: Colors.grey),
                            //       ],
                            //     ),
                            //   ],
                            // ),
                            // const SizedBox(height: 20),

                            // Header
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.network(
                                'https://static.wixstatic.com/media/5f869d_7f6b0438ef9f441db860ba8772acfed8~mv2.jpg/v1/fill/w_568,h_320,al_c,q_80,usm_0.66_1.00_0.01,enc_avif,quality_auto/5f869d_7f6b0438ef9f441db860ba8772acfed8~mv2.jpg',
                                // 'https://placehold.co/400x200/226706/ffffff?text=Invite+Friends,+Earn+Rewards!',
                                height: size.width * 0.4,
                                width: double.infinity,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) =>
                                    Image.network(
                                      'https://placehold.co/400x200/226706/ffffff?text=Refer+&+Earn+Rewards!',
                                      height: size.width * 0.4,
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                    ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            Text(
                              StringRes.referNowAnd,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: size.width * 0.06,
                                fontWeight: FontWeight.w800,
                                color: Colors.grey[900],
                              ),
                            ),
                            Text(
                              StringRes.earnUpTo500,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: size.width * 0.06,
                                fontWeight: FontWeight.w900,
                                color: const Color(0xFFFFCA28),
                              ),
                            ),
                            const SizedBox(height: 12),
                            Padding(
                              padding:
                              const EdgeInsets.symmetric(horizontal: 12.0),
                              child: Text(
                                StringRes.inviteyourfriendstotheappandget250offtheirfirstorderplusearn200cashbackforyourself,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: size.width * 0.035,
                                  color: Colors.grey[700],
                                ),
                              ),
                            ),
                            const SizedBox(height: 24),

                            // Referral Code
                            Container(
                              width: 220,
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.15),
                                    spreadRadius: 4,
                                    blurRadius: 8,
                                    offset: const Offset(0, 5),
                                  ),
                                ],
                                border: Border.all(
                                    color: const Color(0xFFFFD54F), width: 0.8),
                                // ),
                              ),
                              // decoration: BoxDecoration(
                              //   color: Colors.white,
                              //   // gradient: const LinearGradient(
                              //   //   colors: [
                              //   //     Colors.white12,
                              //   //     Colors.black12, // Lighter green shade
                              //   //   ],
                              //     // begin: Alignment.topLeft,
                              //     // end: Alignment.bottomRight,
                              //   // ),
                              //   borderRadius: BorderRadius.circular(16),
                              //   boxShadow: [
                              //     BoxShadow(
                              //       color:  Colors.white,
                              // // (0xffffffff),
                              //           // .withOpacity(0.4),
                              //       spreadRadius: -20,
                              //       blurRadius: 50,
                              //       offset: const Offset(0, 5),
                              //     ),
                              //   ],
                              //   border: Border.all(
                              //       color: const Color(0xFFFFD54F), width: 2),
                              // ),
                              child: Column(
                                children: [
                                  Text(
                                    StringRes.yourReferralCode,
                                    style: TextStyle(
                                      fontSize: size.width * 0.04,
                                      fontWeight: FontWeight.w600,
                                      color:  Color(0xFF226706),
                                      // Colors.white,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    referralCode,
                                    style: TextStyle(
                                      fontSize: size.width * 0.06,
                                      fontWeight: FontWeight.w900,
                                      color:   Color(0xFF226706),
                                      // Colors.white,
                                      letterSpacing: 1.5,
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  ElevatedButton.icon(
                                    onPressed: _copyCode,
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFF388E3C),
                                      foregroundColor: Colors.white,iconSize: 40,fixedSize: Size(200, 50),
                                    ),
                                    icon: const Icon(Icons.copy, size: 20),
                                    label: Text(
                                      copied ? StringRes.copied : StringRes.copyCode,
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 24),

                            // How It Works
                            Text(
                              StringRes.howItWorks,
                              style: TextStyle(
                                fontSize: size.width * 0.05,
                                fontWeight: FontWeight.w800,
                                color: Colors.grey[800],
                              ),
                            ),
                            const SizedBox(height: 16),
                            _buildHowItWorksStep(
                              icon: Icons.person_add_alt_1,
                              iconBgColor: const Color(0xFF226706).withOpacity(0.1),
                              iconColor: const Color(0xFF226706),
                              title: '1.${StringRes.inviteAFriend}',
                              description:
                              StringRes.inviteYourFriendToRegisterOnShopees,
                              size: size,
                            ),
                            const SizedBox(height: 12),
                            _buildHowItWorksStep(
                              icon: Icons.emoji_events,
                              iconBgColor: const Color(0xFF226706).withOpacity(0.1),
                              iconColor: const Color(0xFF226706),
                              title: '2. ${StringRes.earnRewardPoints}',
                              description:
                              StringRes.whenYourFriendRegisters,
                              size: size,
                            ),
                            const SizedBox(height: 12),
                            _buildHowItWorksStep(
                              icon: Icons.credit_card,
                              iconBgColor: const Color(0xFF226706).withOpacity(0.1),
                              iconColor: const Color(0xFF226706),
                              title: '3. ${StringRes.useOnOrders}',
                              description:
                              StringRes.rewardPointsUsedOnOrder,
                              size: size,
                            ),
                            const SizedBox(height: 24),

                            // Share Button
                            Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [
                                    Color(0xFF226706),
                                    Color(0xFF388E3C),
                                  ],
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                ),
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(0xFF226706).withOpacity(0.5),
                                    spreadRadius: 2,
                                    blurRadius: 4,
                                    offset: const Offset(0, 5),
                                  ),
                                ],
                              ),
                              child: ElevatedButton(
                                onPressed: _handleShare,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.transparent,
                                  shadowColor: Colors.transparent,
                                  padding:
                                  const EdgeInsets.symmetric(vertical: 16),
                                ),
                                child: Text(
                                  StringRes.referNowAnd,
                                  style: TextStyle(
                                    fontSize: size.width * 0.045,
                                    fontWeight: FontWeight.w900,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),

                            // Terms and Conditions
                            TextButton(
                              onPressed: () {},
                              child: Text(
                                StringRes.readTermsConditions,
                                style: TextStyle(
                                  fontSize: size.width * 0.035,
                                  color: Colors.grey,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSparkle(Size size, Animation<double> animation,
      Offset positionFactor, Color color, double sparkleSize, Offset animationOffset) {
    return Positioned(
      top: size.height * positionFactor.dy,
      left: size.width * positionFactor.dx,
      child: AnimatedBuilder(
        animation: animation,
        builder: (context, child) {
          return Transform.translate(
            offset: Offset(
              animationOffset.dx * animation.value,
              animationOffset.dy * animation.value,
            ),
            child: Transform.scale(
              scale: 1.0 + animation.value * 0.3,
              child: Opacity(
                opacity: animation.value,
                child: Container(
                  width: sparkleSize,
                  height: sparkleSize,
                  decoration: BoxDecoration(
                    color: color,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: color.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 8,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildHowItWorksStep({
    required IconData icon,
    required Color iconBgColor,
    required Color iconColor,
    required String title,
    required String description,
    required Size size,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.15),
            spreadRadius: 1,
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: iconBgColor,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: iconBgColor.withOpacity(0.4),
                  spreadRadius: -1,
                  blurRadius: 2,
                ),
              ],
            ),
            child: Icon(icon, size: size.width * 0.06, color: iconColor),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: size.width * 0.04,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[800],
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: size.width * 0.035,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}