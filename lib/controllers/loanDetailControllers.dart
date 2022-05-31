import 'package:banja/controllers/userDetailsController.dart';
import 'package:banja/models/loan_application_details_model.dart';
import 'package:banja/screens/dashboard.dart';
import 'package:banja/services/local_db.dart';
import 'package:banja/services/server.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lottie/lottie.dart';

import '../screens/loan_detail.dart';

class LoanDetailController extends GetxController {
  var loanDetails = [].obs;
  var userDetails = Get.find<UserDetailsController>();

  @override
  void onReady() async {
    super.onReady();
    getDetails();
  }

  void getDetails() {
    LocalDB.getLoanDetails().then((data) {
      if (data.isNotEmpty) {
        loanDetails.addAll(data);
      } else {
        Server.fetchMyLoanRecords().then((value) {
          loanDetails.addAll(value['payload']);
        });
      }
    });
  }

  void updateDetails() {
    LocalDB.getLoanDetails().then((data) {
      loanDetails.add(data.last);
      Get.to(() => const Dashboard());
    });
  }

  void requestLoan(BuildContext context, String loanCategory,
      AnimationController controller) {
    bool userHasProfile = GetStorage().read('userHasProfileAlready') ?? false;

    if (userHasProfile) {
      Get.to(() => LoanDetail(title: loanCategory));
    } else {
      userDetails.showRegPop(context, controller);
    }
  }

  void applyForLoan(
      BuildContext context, LoanApplicationModel loanApplicationModel) {
    HapticFeedback.lightImpact();
    if (loanDetails.isNotEmpty) {
      showDialog(
          context: context,
          builder: (context) {
            return Dialog(
              elevation: 24.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(17.r),
              ),
              child: Padding(
                padding: EdgeInsets.all(20.w),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Lottie.asset('assets/lotties/max_loan_error.json',
                        width: 350.w),
                    SizedBox(
                      height: 30.h,
                    ),
                    Text(
                      'Oh you have reached the limit of loans you can apply for!',
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 19.sp,
                          fontWeight: FontWeight.w600),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Text(
                      'You\'ve got to clear your current loan and then apply for a new one or you can talk to our managers for more assistance and arrangements.',
                      style: TextStyle(fontFamily: 'Poppins', fontSize: 17.sp),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 25.h,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                        HapticFeedback.lightImpact();
                      },
                      child: Container(
                        width: 230.0,
                        height: 60.0,
                        decoration: BoxDecoration(
                            color: Colors.blueGrey,
                            borderRadius: BorderRadius.circular(17.r)),
                        child: Center(
                          child: Text('Okay, got it!',
                              style: TextStyle(
                                fontSize: 18.sp,
                                color: Colors.white,
                                fontFamily: 'Poppins',
                              )),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          });
    } else {
      try {
        Server.syncLoanApplication(context, loanApplicationModel);
      } catch (e) {
        print(e);
      }
    }
  }

  int calculateAmount(var principal, var rate, var time) {
    double result = (principal * rate * time) / 100;

    return result.toInt();
  }
}
