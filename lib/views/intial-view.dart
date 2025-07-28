import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goto/constants/Theme/app_assets.dart';
import 'package:goto/constants/Theme/app_colors.dart';
import 'package:goto/views/auth/authentication.dart';
import 'package:goto/views/home/navbar.dart';
import 'package:goto/widgets/custom_button.dart';
import 'package:goto/widgets/custom_text.dart';
import 'package:sizer/sizer.dart';

class InitialView extends StatefulWidget {
  const InitialView({super.key});

  @override
  State<InitialView> createState() => _InitialViewState();
}

class _InitialViewState extends State<InitialView>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _imageSlide;
  late Animation<Offset> _bottomSlide;
  late Animation<double> _imageFade;

  bool _isImagePrecached = false;

void goToAuthScreen(BuildContext context) {
  Navigator.of(context).push(PageRouteBuilder(
    transitionDuration: const Duration(milliseconds: 500),
    pageBuilder: (_, __, ___) => MainNavigation(),
    transitionsBuilder: (_, animation, __, child) {
      const begin = Offset(1.0, 0.0); // slide from right
      const end = Offset.zero;
      const curve = Curves.easeInOut;

      final tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      final opacity = Tween<double>(begin: 0.0, end: 1.0).animate(animation);

      return SlideTransition(
        position: animation.drive(tween),
        child: FadeTransition(
          opacity: opacity,
          child: child,
        ),
      );
    },
  ));
}

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1300),
    );

    final curvedAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOutCubic,
    );

    _imageSlide = Tween<Offset>(
      begin: const Offset(0, -1.2),
      end: Offset.zero,
    ).animate(curvedAnimation);

    _imageFade = Tween<double>(begin: 0.0, end: 1.0).animate(curvedAnimation);

    _bottomSlide = Tween<Offset>(
      begin: const Offset(0, 1.0),
      end: Offset.zero,
    ).animate(curvedAnimation);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isImagePrecached) {
      precacheImage(AssetImage(AppAssets.boardingScreen1), context).then((_) {
        _isImagePrecached = true;
        _controller.forward();
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: Stack(
        children: [
          FadeTransition(
            opacity: _imageFade,
            child: SlideTransition(
              position: _imageSlide,
              child: SizedBox(
                height: 70.h,
                width: double.infinity,
                child: Image.asset(
                  AppAssets.boardingScreen1,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: SlideTransition(
              position: _bottomSlide,
              child: Container(
                height: 38.h,
                width: double.infinity,
                child: ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(56),
                  ),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                    child: Container(
                      decoration: const BoxDecoration(
                        color: AppColors.whiteColor,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 12,
                            offset: Offset(0, -6),
                          ),
                        ],
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: 6.w,
                        vertical: 3.h,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          CustomText(
                            text: 'Manage Your Daily\nActivity So Easily',
                            fontSize: 28.sp,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary,
                            textAlign: TextAlign.center,
                          ),
                          CustomText(
                            text:
                                'Plan tasks, set priorities, and stay focused.\nGoTo makes productivity effortless.',
                            fontSize: 12.sp,
                            color: AppColors.greycolor,
                            textAlign: TextAlign.center,
                          ),
                          CustomButton(
  borderRadius: 12.0,
  onTap: () => goToAuthScreen(context),

  title: 'Get Started',
  fillColor: true,
),

                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
