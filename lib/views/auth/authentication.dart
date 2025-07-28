// import 'dart:ui';

// import 'package:flutter/material.dart';
// import 'package:flutter_animate/flutter_animate.dart';
// import 'package:get/get.dart';
// import 'package:goto/constants/exports.dart';
// import 'package:goto/controllers/auth-cont.dart';
// import 'package:goto/widgets/custom_button.dart';
// import 'package:goto/widgets/custom_text.dart';
// import 'package:goto/widgets/styling/animated_layer.dart';
// import 'package:sizer/sizer.dart';

// class AuthScreen extends StatefulWidget {
//   AuthScreen({super.key});

//   @override
//   State<AuthScreen> createState() => _AuthScreenState();
// }

// class _AuthScreenState extends State<AuthScreen> {
//   final AuthController authController = Get.put(AuthController());

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           /// 🌌 Live Gradient + Particles
//           const Positioned.fill(child: AnimatedGradientBackground()),
//           const Positioned.fill(child: AnimatedParticleBackground()),

//           /// 📱 Foreground Content
//           Positioned.fill(
//             child: BackdropFilter(
//               filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
//               child: SingleChildScrollView(
//                 padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 10.h),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     Center(
//                       child: Container(
//                         padding: EdgeInsets.symmetric(
//                           horizontal: 5.w,
//                           vertical: 5.h,
//                         ),
//                         decoration: BoxDecoration(
//                           color: Colors.white.withOpacity(0.1),
//                           borderRadius: BorderRadius.circular(30),
//                           border: Border.all(
//                             color: Colors.white.withOpacity(0.2),
//                             width: 0.8,
//                           ),
//                         ),
//                         child: Obx(
//                           () => AnimatedSwitcher(
//   duration: 500.ms,
//   transitionBuilder: (Widget child, Animation<double> animation) {
//     return SlideTransition(
//       position: Tween<Offset>(
//         begin: Offset(
//           authController.isSignIn.isTrue
//               ? 1.0
//               : authController.isForgotPassword.isTrue
//                   ? -1.0
//                   : 0.0,
//           0.0,
//         ),
//         end: Offset.zero,
//       ).animate(animation),
//       child: FadeTransition(
//         opacity: animation,
//         child: child,
//       ),
//     );
//   },
//   child: authController.isForgotPassword.value
//       ? _buildForgotPasswordView()
//       : authController.isSignIn.value
//           ? _buildSignInView()
//           : _buildSignUpView(),
// ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildForgotPasswordView() {
//   return Obx(() => authController.isResetLinkSent.value
//       ? _buildResetLinkSentView()
//       : _buildForgotPasswordFormView());
// }

// Widget _buildForgotPasswordFormView() {
//   return Column(
//     key: const ValueKey('forgot_password_form_view'),
//     mainAxisSize: MainAxisSize.min,
//     crossAxisAlignment: CrossAxisAlignment.center,
//     children: [
//       /// 🔑 Icon
//       Container(
//         padding: EdgeInsets.all(4.w),
//         decoration: BoxDecoration(
//           shape: BoxShape.circle,
//           gradient: RadialGradient(
//             colors: [
//               AppColors.primary.withOpacity(0.3),
//               AppColors.primary.withOpacity(0.1),
//             ],
//           ),
//         ),
//         child: Icon(
//           Icons.lock_reset_rounded,
//           size: 18.w,
//           color: AppColors.primary,
//         ),
//       ).animate().scale(duration: 500.ms).fadeIn(),

//       /// 📝 Title
//       CustomText(
//         text: 'Reset Password',
//         fontSize: 22.sp,
//         fontWeight: FontWeight.bold,
//         color: Colors.white,
//       ).animate().fadeIn(duration: 400.ms),

//       /// 📝 Instructions
//       CustomText(
//         text: 'Enter your email to receive a reset link',
//         fontSize: 13.sp,
//         color: Colors.white.withOpacity(0.8),
//       ).animate().fadeIn(duration: 500.ms, delay: 100.ms),

//       SizedBox(height: 3.h),

//       /// 📧 Email Field
//       CustomTextFormField(
//         controller: authController.emailController,
//         hint: "Enter your email",
//         title: 'Email',
//         inputType: TextInputType.emailAddress,
//         prefix: Icon(
//           Icons.email_rounded,
//           color: AppColors.primary,
//           size: 20.sp,
//         ),
//       ).animate().fadeIn(duration: 500.ms, delay: 200.ms),

//       SizedBox(height: 4.h),

//       /// 🔘 Send Reset Link Button
//       Obx(
//         () => CustomButton(
//           title: "Send Reset Link",
//           isLoading: authController.isLoading.value,
//           onTap: () => authController.sendPasswordResetEmail(),
//         ),
//       ).animate().fadeIn(duration: 500.ms, delay: 300.ms),

//       SizedBox(height: 3.h),

//       /// ↩️ Back to Sign In
//       GestureDetector(
//         onTap: () => authController.backToSignIn(),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(
//               Icons.arrow_back_rounded,
//               color: Colors.white70,
//               size: 16.sp,
//             ),
//             SizedBox(width: 2.w),
//             CustomText(
//               text: "Back to Sign In",
//               fontSize: 12.sp,
//               fontWeight: FontWeight.w600,
//               color: Colors.white,
//             ),
//           ],
//         ),
//       ).animate().fadeIn(duration: 500.ms, delay: 400.ms),
//     ],
//   );
// }

// Widget _buildResetLinkSentView() {
//   return Column(
//     key: const ValueKey('reset_link_sent_view'),
//     mainAxisSize: MainAxisSize.min,
//     crossAxisAlignment: CrossAxisAlignment.center,
//     children: [
//       /// ✅ Success Icon
//       Container(
//         padding: EdgeInsets.all(4.w),
//         decoration: BoxDecoration(
//           shape: BoxShape.circle,
//           gradient: RadialGradient(
//             colors: [
//               AppColors.secondary.withOpacity(0.3),
//               AppColors.secondary.withOpacity(0.1),
//             ],
//           ),
//         ),
//         child: Icon(
//           Icons.check_circle_rounded,
//           size: 18.w,
//           color: AppColors.secondary,
//         ),
//       ).animate().scale(duration: 500.ms).fadeIn(),

//       /// 📝 Title
//       CustomText(
//         text: 'Email Sent!',
//         fontSize: 22.sp,
//         fontWeight: FontWeight.bold,
//         color: Colors.white,
//       ).animate().fadeIn(duration: 400.ms),

//       /// 📝 Instructions
//       Column(
//         children: [
//           CustomText(
//             text: 'We sent a password reset link to',
//             fontSize: 13.sp,
//             color: Colors.white.withOpacity(0.8),
//           ),
//           SizedBox(height: 1.h),
//           CustomText(
//             text: authController.emailController.text.trim(),
//             fontSize: 13.sp,
//             fontWeight: FontWeight.bold,
//             color: Colors.white,
//           ),
//         ],
//       ).animate().fadeIn(duration: 500.ms, delay: 100.ms),

//       SizedBox(height: 3.h),

//       /// ℹ️ Additional Info
//       Container(
//         padding: EdgeInsets.all(4.w),
//         decoration: BoxDecoration(
//           color: Colors.white.withOpacity(0.1),
//           borderRadius: BorderRadius.circular(12),
//         ),
//         child: Column(
//           children: [
//             Icon(
//               Icons.info_outline_rounded,
//               color: Colors.white70,
//               size: 16.sp,
//             ),
//             SizedBox(height: 1.h),
//             CustomText(
//               text: 'Check your spam folder if you don\'t see the email',
//               fontSize: 11.sp,
//               textAlign: TextAlign.center,
//               color: Colors.white.withOpacity(0.8),
//             ),
//           ],
//         ),
//       ).animate().fadeIn(duration: 500.ms, delay: 200.ms),

//       SizedBox(height: 4.h),

//       /// 🔘 Back to Sign In Button
//       CustomButton(
//         title: "Back to Sign In",
//         onTap: () => authController.backToSignIn(),
//       ).animate().fadeIn(duration: 500.ms, delay: 300.ms),
//     ],
//   );
// }
//   Widget _buildSignInView() {
//     return Column(
//       key: const ValueKey('signin_view'),
//       mainAxisSize: MainAxisSize.min,
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: [
//         /// 🌟 Icon Avatar
//         Container(
//           padding: EdgeInsets.all(4.w),
//           decoration: BoxDecoration(
//             shape: BoxShape.circle,
//             gradient: RadialGradient(
//               colors: [
//                 AppColors.primary.withOpacity(0.3),
//                 AppColors.secondary.withOpacity(0.1),
//               ],
//             ),
//           ),
//           child: Icon(
//             Icons.check_circle_rounded,
//             size: 18.w,
//             color: AppColors.appWhite,
//           ),
//         ).animate().scale(duration: 500.ms).fadeIn(),

//         /// 🌈 Headline
//         CustomText(
//           text: 'Welcome to GoTo',
//           fontSize: 22.sp,
//           fontWeight: FontWeight.bold,
//           color: Colors.white,
//         ).animate().fadeIn(duration: 400.ms),

//         /// 📝 Subtitle
//         CustomText(
//           text: 'Organize your tasks effortlessly',
//           fontSize: 13.sp,
//           color: Colors.white.withOpacity(0.8),
//         ).animate().fadeIn(duration: 500.ms, delay: 100.ms),

//         /// 📧 Email
//         CustomTextFormField(
//           controller: authController.emailController,
//           hint: "Enter your email",
//           title: 'Email',
//           inputType: TextInputType.emailAddress,
//           prefix: Icon(
//             Icons.email_rounded,
//             color: AppColors.primary,
//             size: 20.sp,
//           ),
//         ).animate().fadeIn(duration: 500.ms, delay: 200.ms),

//         SizedBox(height: 3.h),

//         /// 🔒 Password
//         Obx(
//           () => CustomTextFormField(
//             controller: authController.passwordController,
//             hint: "Enter your password",
//             title: 'Password',
//             isObscure: !authController.visiblePassword.value,
//             prefix: Icon(
//               Icons.lock_rounded,
//               color: AppColors.primary,
//               size: 20.sp,
//             ),
//             suffix: IconButton(
//               icon: Icon(
//                 authController.visiblePassword.value
//                     ? Icons.visibility_rounded
//                     : Icons.visibility_off_rounded,
//                 color: AppColors.primary,
//               ),
//               onPressed: () => authController.visiblePassword.toggle(),
//             ),
//           ),
//         ).animate().fadeIn(duration: 500.ms, delay: 300.ms),

//         SizedBox(height: 2.h),

//         // Replace the existing GestureDetector with:
// Align(
//   alignment: Alignment.centerRight,
//   child: GestureDetector(
//     onTap: () => authController.showForgotPassword(),
//     child: CustomText(
//       text: "Forgot Password?",
//       fontSize: 12.sp,
//       fontWeight: FontWeight.w600,
//       color: Colors.white,
//     ),
//   ),
// ).animate().fadeIn(duration: 400.ms, delay: 350.ms),

//         SizedBox(height: 4.h),

//         /// 🔘 Sign In Button
//         Obx(
//           () => CustomButton(
//             title: "Sign In",
//             isLoading: authController.isLoading.value,
//             onTap: () => authController.signIn(),
//           ),
//         ).animate().fadeIn(duration: 500.ms, delay: 400.ms),

//         SizedBox(height: 3.h),

//         /// 📝 Footer - Switch to Sign Up
//         Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             CustomText(
//               text: "Don't have an account?",
//               fontSize: 12.sp,
//               color: Colors.white70,
//             ),
//             SizedBox(width: 2.w),
//             GestureDetector(
//               onTap: () => authController.toggleAuthMode(),
//               child: CustomText(
//                 text: "Sign Up",
//                 fontSize: 12.sp,
//                 fontWeight: FontWeight.w600,
//                 color: Colors.white,
//               ),
//             ),
//           ],
//         ).animate().fadeIn(duration: 500.ms, delay: 500.ms),
//       ],
//     );
//   }

//   Widget _buildSignUpView() {
//     return Column(
//       key: const ValueKey('signup_view'),
//       mainAxisSize: MainAxisSize.min,
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: [
//         /// 🌟 Icon Avatar
//         Container(
//           padding: EdgeInsets.all(4.w),
//           decoration: BoxDecoration(
//             shape: BoxShape.circle,
//             gradient: RadialGradient(
//               colors: [
//                 AppColors.secondary.withOpacity(0.3),
//                 AppColors.primary.withOpacity(0.1),
//               ],
//             ),
//           ),
//           child: Icon(
//             Icons.person_add_rounded,
//             size: 18.w,
//             color: AppColors.secondary,
//           ),
//         ).animate().scale(duration: 500.ms).fadeIn(),

//         /// 🌈 Headline
//         CustomText(
//           text: 'Create Account',
//           fontSize: 22.sp,
//           fontWeight: FontWeight.bold,
//           color: Colors.white,
//         ).animate().fadeIn(duration: 400.ms),

//         /// 📝 Subtitle
//         CustomText(
//           text: 'Join us to get started',
//           fontSize: 13.sp,
//           color: Colors.white.withOpacity(0.8),
//         ).animate().fadeIn(duration: 500.ms, delay: 100.ms),

//         /// 👤 Name
//         CustomTextFormField(
//           controller: authController.nameController,
//           hint: "Enter your name",
//           title: 'Name',
//           inputType: TextInputType.name,
//           prefix: Icon(
//             Icons.person_rounded,
//             color: AppColors.secondary,
//             size: 20.sp,
//           ),
//         ).animate().fadeIn(duration: 500.ms, delay: 200.ms),

//         /// 📧 Email
//         CustomTextFormField(
//           controller: authController.emailController,
//           hint: "Enter your email",
//           title: 'Email',
//           inputType: TextInputType.emailAddress,
//           prefix: Icon(
//             Icons.email_rounded,
//             color: AppColors.secondary,
//             size: 20.sp,
//           ),
//         ).animate().fadeIn(duration: 500.ms, delay: 300.ms),

//         SizedBox(height: 3.h),

//         /// 🔒 Password
//         Obx(
//           () => CustomTextFormField(
//             controller: authController.passwordController,
//             hint: "Enter your password",
//             title: 'Password',
//             isObscure: !authController.visiblePassword.value,
//             prefix: Icon(
//               Icons.lock_rounded,
//               color: AppColors.secondary,
//               size: 20.sp,
//             ),
//             suffix: IconButton(
//               icon: Icon(
//                 authController.visiblePassword.value
//                     ? Icons.visibility_rounded
//                     : Icons.visibility_off_rounded,
//                 color: AppColors.secondary,
//               ),
//               onPressed: () => authController.visiblePassword.toggle(),
//             ),
//           ),
//         ).animate().fadeIn(duration: 500.ms, delay: 400.ms),

//         SizedBox(height: 3.h),

//         /// 🔒 Confirm Password
//         Obx(
//           () => CustomTextFormField(
//             controller: authController.confirmPasswordController,
//             hint: "Confirm your password",
//             title: 'Confirm Password',
//             isObscure: !authController.visibleConfirmPassword.value,
//             prefix: Icon(
//               Icons.lock_rounded,
//               color: AppColors.secondary,
//               size: 20.sp,
//             ),
//             suffix: IconButton(
//               icon: Icon(
//                 authController.visibleConfirmPassword.value
//                     ? Icons.visibility_rounded
//                     : Icons.visibility_off_rounded,
//                 color: AppColors.secondary,
//               ),
//               onPressed: () => authController.visibleConfirmPassword.toggle(),
//             ),
//           ),
//         ).animate().fadeIn(duration: 500.ms, delay: 500.ms),

//         SizedBox(height: 4.h),

//         /// 🔘 Sign Up Button
//         Obx(
//           () => CustomButton(
//             title: "Sign Up",
//             isLoading: authController.isLoading.value,
//             onTap: () => authController.signUp(),
//           ),
//         ).animate().fadeIn(duration: 500.ms, delay: 600.ms),

//         SizedBox(height: 3.h),

//         /// 📝 Footer - Switch to Sign In
//         Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             CustomText(
//               text: "Already have an account?",
//               fontSize: 12.sp,
//               color: Colors.white70,
//             ),
//             SizedBox(width: 2.w),
//             GestureDetector(
//               onTap: () => authController.toggleAuthMode(),
//               child: CustomText(
//                 text: "Sign In",
//                 fontSize: 12.sp,
//                 fontWeight: FontWeight.w600,
//                 color: Colors.white,
//               ),
//             ),
//           ],
//         ).animate().fadeIn(duration: 500.ms, delay: 700.ms),
//       ],
//     );
//   }
// }
