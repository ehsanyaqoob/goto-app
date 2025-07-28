
// import 'custom_text_formfield.dart';
// import 'package:goto/Constants/exports.dart';

// class CustomRadioButton extends StatefulWidget {
//   final List<String> items;
//   final String selectedValue;
//   final Function(String) onSelected;

//   const CustomRadioButton(
//       {super.key,
//       required this.items,
//       required this.selectedValue,
//       required this.onSelected});

//   @override
//   _CustomRadioButtonState createState() => _CustomRadioButtonState();
// }

// class _CustomRadioButtonState extends State<CustomRadioButton> {
//   String? _selectedItem;

//   @override
//   void initState() {
//     super.initState();
//     _selectedItem = widget.selectedValue;
//   }

//   void _handleTap(String value) {
//     setState(() {
//       _selectedItem = value;
//     });
//     widget.onSelected(value);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: widget.items.map((item) {
//         return GestureDetector(
//           onTap: () => _handleTap(item),
//           child: Container(
//             padding: const EdgeInsets.symmetric(horizontal: 12),
//             height: 45,
//             decoration: BoxDecoration(
//                 border: widget.items.first == item
//                     ? Border(
//                         top: BorderSide(
//                             color: AppColors.fieldFontColor, width: 1),
//                         left: BorderSide(
//                             color: AppColors.fieldFontColor, width: 1),
//                         bottom: BorderSide(
//                             color: AppColors.fieldFontColor, width: 1),
//                         right: BorderSide(
//                             color: AppColors.fieldFontColor, width: 1))
//                     : Border(
//                         top: BorderSide(
//                             color: AppColors.fieldFontColor, width: 1),
//                         bottom: BorderSide(
//                             color: AppColors.fieldFontColor, width: 1),
//                         right: BorderSide(
//                             color: AppColors.fieldFontColor, width: 1)),
//                 borderRadius: BorderRadius.only(
//                   topLeft: widget.items.first == item
//                       ? const Radius.circular(10)
//                       : Radius.zero,
//                   bottomLeft: widget.items.first == item
//                       ? const Radius.circular(10)
//                       : Radius.zero,
//                   topRight: widget.items.last == item
//                       ? const Radius.circular(10)
//                       : Radius.zero,
//                   bottomRight: widget.items.last == item
//                       ? const Radius.circular(10)
//                       : Radius.zero,
//                 )),
//             child: Row(
//               children: [
//                 Container(
//                   width: 15,
//                   height: 15,
//                   margin: const EdgeInsets.only(right: 4),
//                   child: Radio(
//                       value: item,
//                       groupValue: _selectedItem ?? widget.items.first,
//                       onChanged: (value) {
//                         if (value != null) {
//                           _handleTap(value);
//                         }
//                       },
//                       activeColor: AppColors.appWhite),
//                 ),
//                 SizedBox(
//                   width: 4,
//                 ),
//                 CustomText(
//                   text: item,
//                   color: AppColors.appWhite,
//                   fontSize: 12.sp,
//                   fontWeight: FontWeight.w600,
//                 )
//               ],
//             ),
//           ),
//         );
//       }).toList(),
//     );
//   }
// }
