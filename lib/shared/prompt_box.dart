import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PromptBox extends StatelessWidget {
  const PromptBox(
      {Key? key,
      required this.title,
      required this.message,
      required this.action1,
      required this.action2})
      : super(key: key);

  final String title, message;
  final VoidCallback action1, action2;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
        10.r,
      )),
      child: SizedBox(
        width: 340.w,
        height: 220.h,
        child: Padding(
          padding: EdgeInsets.all(15.w),
          child: Column(
            children: [
              Text(title,
                  style: TextStyle(
                    fontSize: 23.sp,
                      fontFamily: 'Poppins',
                      color: Colors.black,
                      fontWeight: FontWeight.w600)),
              SizedBox(
                height: 20.h,
              ),
              Text(
                message,
                style: TextStyle(fontFamily: 'Poppins', fontSize: 17.5.sp),
                textAlign: TextAlign.center,
              ),
              const Spacer(),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: action1,
                      child: Container(
                        height: 55.h,
                        child: const Center(
                            child: Text(
                          'NO',
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              color: Colors.white,
                              fontWeight: FontWeight.w500),
                        )),
                        decoration: BoxDecoration(
                            color: Colors.red.shade400,
                            borderRadius: BorderRadius.circular(
                              10.r,
                            )),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 15.w,
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: action2,
                      child: Container(
                        height: 55.h,
                        child: const Center(
                            child: Text('YES',
                                style: TextStyle(
                                    fontFamily: 'Poppins',
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600))),
                        decoration: BoxDecoration(
                            color: Colors.green.shade400,
                            borderRadius: BorderRadius.circular(
                              10.r,
                            )),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
