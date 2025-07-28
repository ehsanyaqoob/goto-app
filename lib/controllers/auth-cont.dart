// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:get/get.dart';
// import 'package:goto/constants/exports.dart';
// import 'package:goto/views/home/navbar.dart';

// class AuthController extends GetxController {
//   // State variables
//   final RxBool isSignIn = true.obs;
//   final RxBool visiblePassword = false.obs;
//   final RxBool visibleConfirmPassword = false.obs;
//   final RxBool isLoading = false.obs;
//   final RxBool isLoggedIn = false.obs;
//   final RxBool isForgotPassword = false.obs;
//   final RxBool isResetLinkSent = false.obs;

//   // Controllers
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();
//   final TextEditingController confirmPasswordController = TextEditingController();
//   final TextEditingController nameController = TextEditingController();

//   // Password visibility toggles
//   void togglePasswordVisibility() => visiblePassword.toggle();
//   void toggleConfirmPasswordVisibility() => visibleConfirmPassword.toggle();

//   // Auth mode toggle
//   void toggleAuthMode() {
//     isSignIn.toggle();
//     if (isSignIn.isFalse) {
//       confirmPasswordController.clear();
//       nameController.clear();
//     }
//   }

//   // Forgot password flow
//   void showForgotPassword() {
//     isForgotPassword(true);
//     isSignIn(false);
//     isResetLinkSent(false);
//     clearTextFields();
//   }

//   void backToSignIn() {
//     isForgotPassword(false);
//     isSignIn(true);
//     isResetLinkSent(false);
//     clearTextFields();
//   }

//   // Clear all text fields
//   void clearTextFields() {
//     emailController.clear();
//     passwordController.clear();
//     confirmPasswordController.clear();
//     nameController.clear();
//   }

//   // Password reset email
//   Future<void> sendPasswordResetEmail() async {
//     try {
//       final email = emailController.text.trim();
      
//       if (!GetUtils.isEmail(email)) {
//         _showErrorToast('Please enter a valid email address');
//         return;
//       }

//       isLoading(true);
//       await Future.delayed(const Duration(seconds: 2)); // Simulate network call
      
//       isResetLinkSent(true);
//       _showSuccessToast('Password reset link sent to $email');
//     } catch (e) {
//       _showErrorToast('Failed to send reset link: ${e.toString()}');
//     } finally {
//       isLoading(false);
//     }
//   }

//   // Sign in method
//   Future<void> signIn() async {
//     try {
//       final email = emailController.text.trim();
//       final password = passwordController.text.trim();

//       if (!_validateSignInInputs(email, password)) return;

//       isLoading(true);
//       await Future.delayed(const Duration(seconds: 2)); // Simulate network call
      
//       // Successful login
//       isLoggedIn(true);
//       clearTextFields();
//       Get.offAll(() => MainNavigation());
//     } catch (e) {
//       _showErrorToast('Login failed: ${e.toString()}');
//     } finally {
//       isLoading(false);
//     }
//   }

//   // Sign up method
//   Future<void> signUp() async {
//     try {
//       final email = emailController.text.trim();
//       final password = passwordController.text.trim();
//       final confirmPassword = confirmPasswordController.text.trim();
//       final name = nameController.text.trim();

//       if (!_validateSignUpInputs(email, password, confirmPassword, name)) return;

//       isLoading(true);
//       await Future.delayed(const Duration(seconds: 2)); // Simulate network call
      
//       // Successful registration
//       isLoggedIn(true);
//       clearTextFields();
//       Get.offAll(() => MainNavigation());
//     } catch (e) {
//       _showErrorToast('Registration failed: ${e.toString()}');
//     } finally {
//       isLoading(false);
//     }
//   }

//   // Validation methods
//   bool _validateSignInInputs(String email, String password) {
//     if (email.isEmpty || !GetUtils.isEmail(email)) {
//       _showErrorToast('Please enter a valid email address');
//       return false;
//     }

//     if (password.isEmpty) {
//       _showErrorToast('Please enter your password');
//       return false;
//     }

//     if (password.length < 6) {
//       _showErrorToast('Password must be at least 6 characters');
//       return false;
//     }

//     return true;
//   }

//   bool _validateSignUpInputs(String email, String password, String confirmPassword, String name) {
//     if (name.isEmpty) {
//       _showErrorToast('Please enter your name');
//       return false;
//     }

//     if (!_validateSignInInputs(email, password)) return false;

//     if (password != confirmPassword) {
//       _showErrorToast('Passwords do not match');
//       return false;
//     }

//     if (password.length < 8) {
//       _showErrorToast('Password must be at least 8 characters');
//       return false;
//     }

//     // Add more password complexity requirements if needed
//     if (!password.contains(RegExp(r'[A-Z]'))) {
//       _showErrorToast('Password must contain at least one uppercase letter');
//       return false;
//     }

//     if (!password.contains(RegExp(r'[0-9]'))) {
//       _showErrorToast('Password must contain at least one number');
//       return false;
//     }

//     return true;
//   }

//   // Helper methods
//   void _showErrorToast(String message) {
//     Fluttertoast.showToast(
//       msg: message,
//       toastLength: Toast.LENGTH_SHORT,
//       gravity: ToastGravity.BOTTOM,
//       backgroundColor: AppColors.appRed,
//       textColor: AppColors.appWhite,
//     );
//   }

//   void _showSuccessToast(String message) {
//     Fluttertoast.showToast(
//       msg: message,
//       toastLength: Toast.LENGTH_SHORT,
//       gravity: ToastGravity.BOTTOM,
//       backgroundColor: Colors.green,
//       textColor: Colors.white,
//     );
//   }

//   @override
//   void onClose() {
//     emailController.dispose();
//     passwordController.dispose();
//     confirmPasswordController.dispose();
//     nameController.dispose();
//     super.onClose();
//   }
// }