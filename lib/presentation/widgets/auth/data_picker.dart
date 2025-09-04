// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:intl/intl.dart';
//
// import '../../core/constans/color.dart';
//
// class CustomDatePickerField extends StatefulWidget {
//   const CustomDatePickerField({Key? key}) : super(key: key);
//
//   @override
//   State<CustomDatePickerField> createState() => _CustomDatePickerFieldState();
// }
//
// class _CustomDatePickerFieldState extends State<CustomDatePickerField> {
//   final TextEditingController _dateController = TextEditingController();
//
//   Future<void> _selectDate(BuildContext context) async {
//     DateTime selectedDate = DateTime.now();
//
//     await showDialog(
//       context: context,
//       builder: (context) {
//         return Center(
//           child: Material(
//             color: Colors.transparent,
//             child: Container(
//               width: 320.w,
//               padding: const EdgeInsets.all(16),
//               decoration: BoxDecoration(
//                 color: AppColor.white, // ← تغيير لون خلفية التقويم
//                 borderRadius: BorderRadius.circular(16),
//               ),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Theme(
//
//               data: Theme.of(context).copyWith(
//                 colorScheme: ColorScheme.light(
//                   primary: Colors.blue, // ✅ خلفية اليوم المختار ← تم التعديل
//                   onPrimary: AppColor.primaryColor, // ✅ لون النص داخل اليوم المختار ← تم التعديل
//                   onSurface: AppColor.Dark, // ← لون باقي النصوص
//                 ),
//                 textTheme: TextTheme(
//                   bodyMedium: TextStyle(
//                     color: AppColor.Dark, // ← لون الأيام الأخرى (غير المختارة)
//                     fontFamily: 'Manrope',
//                   ),
//                 ),
//               ),
//               child: CalendarDatePicker(
//                 initialDate: selectedDate,
//                 firstDate: DateTime(2000),
//                 lastDate: DateTime(2100),
//                 onDateChanged: (date) {
//                   selectedDate = date;
//                 },
//               ),
//             ),
//
//                   const SizedBox(height: 20),
//
//                   Row(
//                     children: [
//                       Spacer(),
//                       SizedBox(
//                         width: 85.w,
//                         child: ElevatedButton(
//                           onPressed: () {
//                             String formattedDate =
//                             DateFormat('yyyy-MM-dd').format(selectedDate);
//                             setState(() {
//                               _dateController.text = formattedDate;
//                             });
//                             Navigator.pop(context);
//                           },
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: AppColor.primaryColor, // ← لون زر Set
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(10.r),
//                             ),
//                             padding: const EdgeInsets.symmetric(vertical: 14),
//                           ),
//                           child: Text(
//                             "Set",
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontSize: 13.sp,
//                               fontWeight: FontWeight.w400,
//                               fontFamily: "Manrope",
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: 350.w,
//       child: TextField(
//
//         controller: _dateController,
//         readOnly: true,
//         decoration: InputDecoration(
//           contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
//           hintText: 'Birthday',
//           hintStyle: TextStyle(
//             color: AppColor.gry,
//               fontSize: 14.sp,// ← لون النص داخل الـ hint
//             fontFamily: "Manrope",
//             fontWeight: FontWeight.w400
//
//           ),
//           filled: true,
//           fillColor: AppColor.white, // ← لون خلفية حقل التاريخ
//           suffixIcon: IconButton(
//             icon: SvgPicture.asset(
//               'assets/icons/date.svg',
//               height: 24,
//               width: 24,
//               color: AppColor.Dark, // ← تغيير لون الأيقونة إلى الأبيض
//             ),
//             onPressed: () => _selectDate(context),
//           ),
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(12),
//             borderSide: BorderSide.none,
//           ),
//         ),
//         style: TextStyle(
//           color: Colors.white, // ← لون النص داخل الحقل
//           fontFamily: "Manrope",
//         ),
//         onTap: () => _selectDate(context),
//       ),
//     );
//   }
// }
