import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class TextBox extends StatefulWidget {
  const TextBox({
    Key? key,
    this.isDate = false,
    this.obscureText = false,
    this.textType = TextInputType.text,
    this.textCapitalization = TextCapitalization.none,
    this.dataVerify,
    this.maxLength,
    this.focusNode,
    required this.title,
    required this.hintText,
    required this.textController,
  }) : super(key: key);

  final TextEditingController textController;
  final String hintText;
  final bool isDate, obscureText;
  final String title;
  final TextInputType textType;
  final FormFieldValidator<String>? dataVerify;
  final TextCapitalization textCapitalization;
  final FocusNode? focusNode;
  final int? maxLength;

  @override
  State<TextBox> createState() => _TextBoxState();
}

class _TextBoxState extends State<TextBox> {
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
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
                color: Colors.black12.withOpacity(0.07),
                offset: const Offset(0, 1),
                blurRadius: 20.0,
                spreadRadius: 1)
          ], borderRadius: BorderRadius.circular(10.0), color: Colors.white),
          child: TextFormField(
            readOnly: widget.isDate,
            maxLength: widget.maxLength,
            textCapitalization: widget.textCapitalization,
            obscureText: widget.obscureText,
            validator: widget.dataVerify,
            controller: widget.textController,
            keyboardType: widget.textType,
            onTap: () async {
              if (widget.isDate) {
                DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1930),
                    lastDate: DateTime(2023));
                if (pickedDate != null) {
                  //pickedDate output format => 2021-03-10 00:00:00.000
                  String formattedDate =
                      DateFormat('yyyy-MM-dd').format(pickedDate);
                  //formatted date output using intl package =>  2021-03-16
                  //you can implement different kind of Date Format here according to your requirement

                  setState(() {
                    widget.textController.text =
                        formattedDate; //set output date to TextField value.
                  });
                } else {
                  print("Date is not selected");
                }
              }
            },
            onChanged: (value) {
              setState(() {});
            },
            decoration: InputDecoration(
                counterText: '',
                suffixText: widget.maxLength != null
                    ? '${widget.textController.text.length}/${widget.maxLength}'
                    : '',
                prefixText: widget.maxLength == 9 ? '+256' : '',
                suffixStyle: const TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w800,
                ),
                prefixStyle: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                    fontSize: 17.5.sp),
                hintText: widget.hintText,
                hintStyle:
                    TextStyle(fontSize: 15.sp, color: const Color(0xffBDBDBD)),
                contentPadding: EdgeInsets.symmetric(horizontal: 20.w),
                border: InputBorder.none),
          ),
        ),
      ],
    );
  }
}

class PinTextBox extends StatefulWidget {
  const PinTextBox(
      {Key? key, this.textEditingController, required this.focusNode})
      : super(key: key);
  final TextEditingController? textEditingController;
  final FocusNode focusNode;

  @override
  State<PinTextBox> createState() => _PinTextBoxState();
}

class _PinTextBoxState extends State<PinTextBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 52.0,
      width: 52.0,
      decoration: BoxDecoration(
          // boxShadow: [
          //   BoxShadow(
          //       color: Colors.black12.withOpacity(0.07),
          //       offset: const Offset(0, 1),
          //       blurRadius: 20.0,
          //       spreadRadius: 1)
          // ],
          borderRadius: BorderRadius.circular(10.0),
          color: const Color(0xffF2F2F2)),
      child: TextFormField(
        textAlign: TextAlign.center,
        onChanged: (_) => FocusScope.of(context).nextFocus(),
        keyboardType: TextInputType.number,
        focusNode: widget.focusNode,
        controller: widget.textEditingController,
        obscureText: true,
        maxLength: 1,
        textInputAction: TextInputAction.next,
        style: const TextStyle(fontSize: 30),
        decoration: const InputDecoration(
          hintText: '',
          counterText: '',
          hintStyle: TextStyle(fontSize: 12.0, color: Color(0xffBDBDBD)),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
