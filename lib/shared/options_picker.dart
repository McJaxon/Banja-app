import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OptionsPicker<T> extends StatefulWidget {
  const OptionsPicker(
      {Key? key,
      required this.dropdown,
      required this.onChanged,
      required this.title})
      : super(key: key);
  final String title;
  final List<DropdownMenuItem<T>> dropdown;
  final ValueChanged<T?>? onChanged;

  @override
  State<OptionsPicker> createState() => _OptionsPickerState();
}

class _OptionsPickerState extends State<OptionsPicker> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: TextStyle(fontFamily: 'Poppins', fontSize: 16.8.sp),
        ),
         SizedBox(
          height: 6.h,
        ),
        Container(
          height: 60.h,
          decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: Colors.black12.withOpacity(0.07),
                    offset: const Offset(0, 1),
                    blurRadius: 20.0,
                    spreadRadius: 1)
              ],
              borderRadius: BorderRadius.circular(10.r)),
          child: DropdownButtonFormField(
              hint: Text(
                'Choose here',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                  fontSize: 14.sp,
                  //color: const Color(0xff007981)
                ),
              ),
              icon: const RotatedBox(
                  quarterTurns: 3,
                  child: Icon(Icons.arrow_back_ios_new_rounded,
                      color: Color(0xff007981), size: 16.0)),
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 20.0),
                border: InputBorder.none,
              ),
              items: widget.dropdown,
              onChanged: widget.onChanged),
        ),
      ],
    );
  }
}
