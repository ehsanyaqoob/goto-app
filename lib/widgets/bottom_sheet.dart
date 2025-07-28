// import 'package:goto/Constants/exports.dart';
// import 'package:goto/widgets/custom_text.dart';


// void showWhatsAppLikeBottomSheet({
//   required VoidCallback onCameraTap,
//   required VoidCallback onGalleryTap,
//   required VoidCallback onDeleteTap,
//   required bool showDeleteOption,
// }) {
//   showCustomBottomSheet(
//     content: Column(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         Container(
//           width: 100,
//           height: 5,
//           margin: EdgeInsets.only(bottom: 20),
//           decoration: BoxDecoration(
//             color: AppColors.primaryBlue,
//             borderRadius: BorderRadius.circular(10),
//           ),
//         ),
//         ListTile(
//           leading: Icon(Icons.camera_alt, color: AppColors.primaryBlue, size: 22,),
//           title:
//               CustomText(text: 'Camera', fontSize: 18, ),
//           onTap: () {
//             onCameraTap();
//             Get.back();
//           },
//         ),
//         ListTile(
//           leading: Icon(Icons.photo_library, color: AppColors.appPrimary, size: 22,),
//           title:
//               CustomText(text: 'Gallery', fontSize: 18, ),
//           onTap: () {
//             onGalleryTap();
//             Get.back();
//           },
//         ),
//         if (showDeleteOption) ...[
//           Divider(color: AppColors.appPrimary),
//           ListTile(
//             leading: Icon(Icons.delete, color: AppColors.appPrimary),
//             title: Text(
//               'Delete',
//               style: TextStyle(fontSize: 18, color: AppColors.appPrimary),
//             ),
//             onTap: () {
//               onDeleteTap();
//               Get.back();
//             },
//           ),
//         ],
//       ],
//     ),
//   );
// }

// /// Function to show custom bottom sheet
// void showCustomBottomSheet({
//   Widget? header,
//   Widget? content,
//   Widget? footer,
// }) {
//   Get.bottomSheet(
//     CustomBottomSheet(
//       header: header,
//       content: content,
//       footer: footer,
//     ),
//     backgroundColor: AppColors.appSecondary,
//   );
// }

// /// Show options to add money
// void showAddMoneyOptions({
//   required VoidCallback onAddMoneyTap,
// }) {
//   showCustomBottomSheet(
//     content: Container(
//       height: 300.h,
//       width: double.infinity,
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Container(
//             width: 100,
//             height: 5,
//             margin: EdgeInsets.only(bottom: 20),
//             decoration: BoxDecoration(
//               color: AppColors.appPrimary,
//               borderRadius: BorderRadius.circular(10),
//             ),
//           ),
//           ListTile(
//             leading: Icon(
//               Icons.account_balance_wallet,
//               color: AppColors.appPrimary,
//             ),
//             title: CustomText(
//               text: 'Add Money',
//               fontSize: 18,
//               color: AppColors.appWhite,
//             ),
//             onTap: () {
//               onAddMoneyTap();
//               Get.back();
//             },
//           ),
//           SizedBox(
//             height: 10,
//           ),
//         ],
//       ),
//     ),
//   );
// }

// /// Show options to send money
// void showSendMoneyOptions({
//   required VoidCallback onSendMoneyTap,
// }) {
//   showCustomBottomSheet(
//     content: Column(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         Container(
//           width: 100,
//           height: 5,
//           margin: EdgeInsets.only(bottom: 20),
//           decoration: BoxDecoration(
//             color: AppColors.appPrimary,
//             borderRadius: BorderRadius.circular(10),
//           ),
//         ),
//         ListTile(
//           leading: Icon(Icons.send, color: AppColors.appPrimary),
//           title: CustomText(
//               text: 'Send Money', fontSize: 18, color: AppColors.appWhite),
//           onTap: () {
//             onSendMoneyTap();
//             Get.back();
//           },
//         ),
//       ],
//     ),
//   );
// }

// /// Show options to view transactions
// void showTransactionOptions({
//   required VoidCallback onTransactionTap,
// }) {
//   showCustomBottomSheet(
//     content: Column(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         Container(
//           width: 100,
//           height: 5,
//           margin: EdgeInsets.only(bottom: 20),
//           decoration: BoxDecoration(
//             color: AppColors.appPrimary,
//             borderRadius: BorderRadius.circular(10),
//           ),
//         ),
//         ListTile(
//           leading: Icon(Icons.receipt, color: AppColors.appPrimary),
//           title: CustomText(
//               text: 'Transactions', fontSize: 18, color: AppColors.appWhite),
//           onTap: () {
//             onTransactionTap();
//             Get.back();
//           },
//         ),
//       ],
//     ),
//   );
// }
// /// Function to show options to check balance
// void showCheckBalanceOptions({
//   required VoidCallback onCheckBalanceTap,
// }) {
//   showCustomBottomSheet(
//     content: Column(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         Container(
//           width: 100,
//           height: 5,
//           margin: EdgeInsets.only(bottom: 20),
//           decoration: BoxDecoration(
//             color: AppColors.appPrimary,
//             borderRadius: BorderRadius.circular(10),
//           ),
//         ),
//         ListTile(
//           leading: Icon(Icons.account_balance, color: AppColors.appPrimary),
//           title: CustomText(
//             text: 'Check Balance',
//             fontSize: 18,
//             color: AppColors.appWhite,
//           ),
//           onTap: () {
//             onCheckBalanceTap();
//             Get.back();
//           },
//         ),
//       ],
//     ),
//   );
// }

// /// Function to show options to transfer funds
// void showTransferFundsOptions({
//   required VoidCallback onTransferFundsTap,
// }) {
//   showCustomBottomSheet(
//     content: Column(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         Container(
//           width: 100,
//           height: 5,
//           margin: EdgeInsets.only(bottom: 20),
//           decoration: BoxDecoration(
//             color: AppColors.appPrimary,
//             borderRadius: BorderRadius.circular(10),
//           ),
//         ),
//         ListTile(
//           leading: Icon(Icons.sync_alt, color: AppColors.appPrimary),
//           title: CustomText(
//             text: 'Transfer Funds',
//             fontSize: 18,
//             color: AppColors.appWhite,
//           ),
//           onTap: () {
//             onTransferFundsTap();
//             Get.back();
//           },
//         ),
//       ],
//     ),
//   );
// }

// /// Function to show options to view statements
// void showViewStatementsOptions({
//   required VoidCallback onViewStatementsTap,
// }) {
//   showCustomBottomSheet(
//     content: Column(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         Container(
//           width: 100,
//           height: 5,
//           margin: EdgeInsets.only(bottom: 20),
//           decoration: BoxDecoration(
//             color: AppColors.appPrimary,
//             borderRadius: BorderRadius.circular(10),
//           ),
//         ),
//         ListTile(
//           leading: Icon(Icons.description, color: AppColors.appPrimary),
//           title: CustomText(
//             text: 'View Statements',
//             fontSize: 18,
//             color: AppColors.appWhite,
//           ),
//           onTap: () {
//             onViewStatementsTap();
//             Get.back();
//           },
//         ),
//       ],
//     ),
//   );
// }

// /// Show options to pay for electricity
// void showElectricityPaymentOptions({
//   required VoidCallback onPayTap,
// }) {
//   showCustomBottomSheet(
//     content: Column(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         Container(
//           width: 100,
//           height: 5,
//           margin: EdgeInsets.only(bottom: 20),
//           decoration: BoxDecoration(
//             color: AppColors.appPrimary,
//             borderRadius: BorderRadius.circular(10),
//           ),
//         ),
//         ListTile(
//           leading: Icon(Icons.lightbulb_outline, color: AppColors.appPrimary),
//           title: CustomText(
//             text: 'Pay Electricity Bill',
//             fontSize: 18,
//             color: AppColors.appWhite,
//           ),
//           onTap: () {
//             onPayTap();
//             Get.back();
//           },
//         ),
//       ],
//     ),
//   );
// }

// /// Show options to pay for water
// void showWaterPaymentOptions({
//   required VoidCallback onPayTap,
// }) {
//   showCustomBottomSheet(
//     content: Column(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         Container(
//           width: 100,
//           height: 5,
//           margin: EdgeInsets.only(bottom: 20),
//           decoration: BoxDecoration(
//             color: AppColors.appPrimary,
//             borderRadius: BorderRadius.circular(10),
//           ),
//         ),
//         ListTile(
//           leading: Icon(Icons.water_damage_outlined, color: AppColors.appPrimary),
//           title: CustomText(
//             text: 'Pay Water Bill',
//             fontSize: 18,
//             color: AppColors.appWhite,
//           ),
//           onTap: () {
//             onPayTap();
//             Get.back();
//           },
//         ),
//       ],
//     ),
//   );
// }

// /// Show options to recharge mobile
// void showMobileRechargeOptions({
//   required VoidCallback onRechargeTap,
// }) {
//   showCustomBottomSheet(
//     content: Column(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         Container(
//           width: 100,
//           height: 5,
//           margin: EdgeInsets.only(bottom: 20),
//           decoration: BoxDecoration(
//             color: AppColors.appPrimary,
//             borderRadius: BorderRadius.circular(10),
//           ),
//         ),
//         ListTile(
//           leading: Icon(Icons.phone_android, color: AppColors.appPrimary),
//           title: CustomText(
//             text: 'Mobile Recharge',
//             fontSize: 18,
//             color: AppColors.appWhite,
//           ),
//           onTap: () {
//             onRechargeTap();
//             Get.back();
//           },
//         ),
//       ],
//     ),
//   );
// }
