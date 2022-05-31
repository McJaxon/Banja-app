import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextBox extends StatefulWidget {
  const TextBox(
      {Key? key,
      this.textInputType = TextInputType.text,
      this.textCapitalization = TextCapitalization.none,
      this.isPassword = false,
      this.maxLength,
      this.validator,
      required this.textEditingController,
      required this.focusNode,
      required this.title,
      required this.hint})
      : super(key: key);
  final bool isPassword;
  final TextEditingController textEditingController;
  final FocusNode focusNode;
  final String title;
  final String hint;
  final TextInputType? textInputType;
  final int? maxLength;
  final TextCapitalization? textCapitalization;
  final FormFieldValidator<String>? validator;

  @override
  State<TextBox> createState() => _TextBoxState();
}

class _TextBoxState extends State<TextBox> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.title,
            style: TextStyle(
                fontSize: 17.sp,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500)),
        SizedBox(
          height: 7.h,
        ),
        Container(
            height: 46.0,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
                color: const Color(0xffF2F2F2)),
            child: TextFormField(
              obscureText: widget.isPassword,
              validator: widget.validator,
              textCapitalization: widget.textCapitalization!,
              focusNode: widget.focusNode,
              controller: widget.textEditingController,
              keyboardType: widget.textInputType,
              maxLength: widget.maxLength,
              decoration: InputDecoration(
                  suffixText: widget.maxLength != null
                      ? '${widget.textEditingController.text.length}/${widget.maxLength}'
                      : '',
                  suffixStyle: const TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w800,
                  ),
                  counterText: '',
                  prefixText: widget.maxLength == 9 ? '+256' : '',
                  prefixStyle: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                      fontSize: 17.5.sp),
                  hintText: widget.hint,
                  hintStyle: TextStyle(
                      fontSize: 15.sp, color: const Color(0xffBDBDBD)),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 20.w)),
              onChanged: (value) {
                setState(() {});
              },
            )),
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
