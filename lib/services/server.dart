//  DISABILITY INFORMATION MANAGEMENT SYSTEM - DMIS
//
//  Created by Ronnie Zad.
//  2021, Centric Solutions-UG. All rights reserved.
//

//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.

// ignore_for_file: unused_local_variable

import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:banja/controllers/loan_detail_controllers.dart';
import 'package:banja/models/loan_application_details_model.dart';
import 'package:banja/screens/dashboard.dart';
import 'package:banja/screens/success_screen.dart';
import 'package:banja/utils/customOverlay.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show HapticFeedback;
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:banja/constants/constants.dart';
import 'package:intl/intl.dart';

enum Category {
  loanCategories,
  userProfileData,
  dashboard,
}

class Server {
  static final accessToken = GetStorage().read('accessToken') ?? '';

  ///creating user
  static Future createUser(EndUserModel userDetailModel) async {
    try {
      CustomOverlay.showLoaderOverlay(duration: 6);
      await Future.delayed(const Duration(seconds: 6));

      CustomOverlay.showToast(
          'Creating your account, please wait', Colors.green, Colors.white);
      var request =
          http.MultipartRequest('POST', Uri.parse('$baseUrl/user/register'))
            ..fields.addAll(
              {
                'full_names': userDetailModel.fullNames!,
                'phone_number': userDetailModel.phoneNumber!,
                'email': userDetailModel.emailAddress!,
                'location': userDetailModel.location!,
                'nin': userDetailModel.nin!,
                "password": userDetailModel.password!,
                "password_confirmation": userDetailModel.passwordConfirm!,
                "profile_pic": userDetailModel.profilePic!,
                "role_id": '2',
                'dob': userDetailModel.dob!,
                'gender': userDetailModel.gender!,
                'have_other_loans': userDetailModel.haveOtherLoans!,
                'loan_purpose': userDetailModel.loanPurpose!,
                'monthly_income': userDetailModel.monthlyIncome!,
                'next_of_kin': userDetailModel.nextOfKin!,
                'profession': userDetailModel.profession!
                //'referral_id': element['referral_id'],
                //'sex': element['sex'],
              },
            );

      ///clean up data before sending it
      // ignore: avoid_single_cascade_in_expression_statements
      request..fields.removeWhere((key, value) => value == '');

      var response = await request.send();

      final message = await http.Response.fromStream(response);

      HapticFeedback.selectionClick();

      debugPrint(message.body);
      debugPrint('${response.statusCode}');

      if (json.decode(message.body)['success'] == true) {
        GetStorage().write('userHasProfileAlready', true);
        GetStorage()
            .write('accessToken', json.decode(message.body)['access_token']);
        GetStorage()
            .write('userID', json.decode(message.body)['payload']['id']);
        GetStorage().write(
            'fullNames', json.decode(message.body)['payload']['full_names']);
        GetStorage().write(
            'emailAddress', json.decode(message.body)['payload']['email']);
        GetStorage().write(
            'profilePic', json.decode(message.body)['payload']['profile_pic']);
        GetStorage().write('nin', json.decode(message.body)['payload']['nin']);
        //  GetStorage().write('nidobn', json.decode(message.body)['payload']['nin']);
        GetStorage().write(
            'location', json.decode(message.body)['payload']['location']);
        GetStorage().write('phoneNumber',
            json.decode(message.body)['payload']['phone_number']);
        CustomOverlay.showToast(
            'Account created successfully!', Colors.green, Colors.white);
        // reset current app state
        await Get.deleteAll(force: true);
// restart app
        Phoenix.rebirth(Get.context!);
// reset get state
        Get.reset();
      } else {
        print(json.decode(message.body));
        if (json.decode(message.body)['errors'] == null) {
          CustomOverlay.showToast(json.decode(message.body)['errors'].first,
              Colors.red, Colors.white);
        } else {
          CustomOverlay.showToast(
              'Something went wrong', Colors.red, Colors.white);
        }
      }
    } catch (e) {
      print(e.toString());
      CustomOverlay.showToast(
          'Something went wrong, try again later', Colors.red, Colors.white);
    }
    Get.back();
  }

  static sendLoanRequestNotification() async {
    var headersList = {
      'Accept': '*/*',
      'Authorization': 'Bearer ${Secrets.fcmServerKey}',
      'Content-Type': 'application/json'
    };
    var url = Uri.parse('https://fcm.googleapis.com/fcm/send');

    var body = {
      "to": "/topics/new_loan_request",
      "notification": {
        "title": "Loan Request",
        "body":
            "New Loan Application Request from ${GetStorage().read('fullNames')} at ${DateFormat.yMEd().format(DateTime.now())}"
      },
      "data": {"msgId": "msg_12342"}
    };
    var req = http.Request('POST', url);
    req.headers.addAll(headersList);
    req.body = json.encode(body);

    var res = await req.send();
    final resBody = await res.stream.bytesToString();

    if (res.statusCode >= 200 && res.statusCode < 300) {
      print(resBody);
    } else {
      print(res.reasonPhrase);
    }
  }

  ///user login
  static Future userLogIn(
      BuildContext context, EndUserModel userDetailModel) async {
    CustomOverlay.showLoaderOverlay(duration: 6);
    try {
      var request =
          http.MultipartRequest('POST', Uri.parse('$baseUrl/user/login'))
            ..fields.addAll(
              {
                'email': userDetailModel.emailAddress!,
                'password': userDetailModel.password!,
              },
            );

      ///clean up data before sending it
      // ignore: avoid_single_cascade_in_expression_statements
      request..fields.removeWhere((key, value) => value == '');

      var response = await request.send();

      final message = await http.Response.fromStream(response);

      HapticFeedback.selectionClick();

      debugPrint(message.body);
      debugPrint('${response.statusCode}');

      if (json.decode(message.body)['success'] == true) {
        GetStorage().write('isLoggedIn', true);
        GetStorage().write('userHasProfileAlready', true);
        GetStorage().write('user_tag', json.decode(message.body)['tag']);
        GetStorage().write('user_pin', json.decode(message.body)['pin']);
        GetStorage()
            .write('accessToken', json.decode(message.body)['access_token']);
        GetStorage()
            .write('userID', json.decode(message.body)['payload']['id']);
        GetStorage().write(
            'fullNames', json.decode(message.body)['payload']['full_names']);
        GetStorage().write(
            'emailAddress', json.decode(message.body)['payload']['email']);
        GetStorage().write(
            'profilePic', json.decode(message.body)['payload']['profile_pic']);
        GetStorage().write('nin', json.decode(message.body)['payload']['nin']);
        GetStorage().write(
            'location', json.decode(message.body)['payload']['location']);
        GetStorage().write('phoneNumber',
            json.decode(message.body)['payload']['phone_number']);
        CustomOverlay.showToast(
            'Hey there!, welcome back😊', Colors.green, Colors.white);
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const Dashboard()));
        await Get.deleteAll(force: true);
// restart app
        Phoenix.rebirth(Get.context!);
// reset get state
        Get.reset();
      } else {
        CustomOverlay.showToast(
            json.decode(message.body)['message'], Colors.red, Colors.white);
      }
    } catch (e) {
      CustomOverlay.showToast('Something went wrong', Colors.red, Colors.white);
    }
  }

  ///user login
  static Future phoneSignIn(BuildContext context, String phone) async {
    CustomOverlay.showLoaderOverlay(duration: 6);
    try {
      var request = http.MultipartRequest('POST', phoneSignInUri)
        ..fields.addAll(
          {
            'phone_number': '0' + phone,
          },
        );

      ///clean up data before sending it
      // ignore: avoid_single_cascade_in_expression_statements
      request..fields.removeWhere((key, value) => value == '');

      var response = await request.send();

      final message = await http.Response.fromStream(response);

      HapticFeedback.selectionClick();

      debugPrint(message.body);
      debugPrint('${response.statusCode}');

      if (json.decode(message.body)['success'] == true) {
        GetStorage().write('isLoggedIn', true);
        GetStorage().write('userHasProfileAlready', true);
        GetStorage().write('user_tag', json.decode(message.body)['tag']);
        GetStorage().write('user_pin', json.decode(message.body)['pin']);
        GetStorage()
            .write('accessToken', json.decode(message.body)['access_token']);
        GetStorage()
            .write('userID', json.decode(message.body)['payload']['id']);
        GetStorage().write(
            'fullNames', json.decode(message.body)['payload']['full_names']);
        GetStorage().write(
            'emailAddress', json.decode(message.body)['payload']['email']);
        GetStorage().write(
            'profilePic', json.decode(message.body)['payload']['profile_pic']);
        GetStorage().write('nin', json.decode(message.body)['payload']['nin']);
        GetStorage().write(
            'location', json.decode(message.body)['payload']['location']);
        GetStorage().write('phoneNumber',
            json.decode(message.body)['payload']['phone_number']);
        CustomOverlay.showToast(
            'Hey there!, welcome back😊', Colors.green, Colors.white);
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const Dashboard()));
        await Get.deleteAll(force: true);
// restart app
        Phoenix.rebirth(Get.context!);
// reset get state
        Get.reset();
      } else {
        CustomOverlay.showToast(
            json.decode(message.body)['message'], Colors.red, Colors.white);
      }
    } catch (e) {
      CustomOverlay.showToast('Something went wrong', Colors.red, Colors.white);
    }
  }

  ///user login
  static Future createUserPIN(BuildContext context, String pin) async {
    CustomOverlay.showLoaderOverlay(duration: 6);
    try {
      var request = http.MultipartRequest('POST', userPINUri)
        ..fields.addAll(
          {'user_id': GetStorage().read('userID').toString(), 'pin': pin},
        );

      ///clean up data before sending it
      // ignore: avoid_single_cascade_in_expression_statements
      request..fields.removeWhere((key, value) => value == '');

      var response = await request.send();

      final message = await http.Response.fromStream(response);

      HapticFeedback.selectionClick();

      print(message.body);
      debugPrint('${response.statusCode}');

      if (json.decode(message.body)['success'] == true) {
        GetStorage()
            .write('user_pin', json.decode(message.body)['payload']['pin']);

        GetStorage()
            .write('pin_id', json.decode(message.body)['payload']['id']);

        CustomOverlay.showToast(
            'PIN created successfully😊', Colors.green, Colors.white);

        return json.decode(message.body)['success'];
      } else {
        CustomOverlay.showToast(
            json.decode(message.body)['message'], Colors.red, Colors.white);
      }
    } catch (e) {
      log(e.toString());
      CustomOverlay.showToast('Something went wrong', Colors.red, Colors.white);
    }
  }

  ///update loan category data
  static Future updatePIN(var newPin) async {
    CustomOverlay.showLoaderOverlay(duration: 6);

    var pinID = GetStorage().read('pin_id') ?? 1;

    try {
      var headersList = {
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/json'
      };
      var url = Uri.parse('$baseUrl/settings/edit_pin/$pinID');

      var body = {
        'user_id': userID,
        'pin': newPin,
      };
      var req = http.Request('PUT', url);
      req.headers.addAll(headersList);
      req.body = json.encode(body);

      var res = await req.send();
      final resBody = await res.stream.bytesToString();

      if (res.statusCode >= 200 && res.statusCode < 300) {
        if (json.decode(resBody)['success'] == true) {
          CustomOverlay.showToast(
              'PIN updated Successfully', Colors.green, Colors.white);
          GetStorage()
              .write('user_pin', json.decode(resBody)['payload']['pin']);
        } else {
          CustomOverlay.showToast(
              json.decode(resBody)['message'], Colors.red, Colors.white);
          Get.back();
        }
      } else {
        print(res.reasonPhrase);
      }

      HapticFeedback.selectionClick();
    } catch (e) {
      CustomOverlay.showToast('Something went wrong', Colors.red, Colors.white);
    }
  }

  ///user login
  static Future createUserTag(BuildContext context, String tag) async {
    CustomOverlay.showLoaderOverlay(duration: 6);
    try {
      var request = http.MultipartRequest('POST', userTagUri)
        ..fields.addAll(
          {'user_id': GetStorage().read('userID').toString(), 'tag': tag},
        );

      ///clean up data before sending it
      // ignore: avoid_single_cascade_in_expression_statements
      request..fields.removeWhere((key, value) => value == '');

      var response = await request.send();

      final message = await http.Response.fromStream(response);

      HapticFeedback.selectionClick();

      print(message.body);
      debugPrint('${response.statusCode}');

      if (json.decode(message.body)['success'] == true) {
        GetStorage()
            .write('user_tag', json.decode(message.body)['payload']['tag']);

        CustomOverlay.showToast(
            'Tag created successfully😊', Colors.green, Colors.white);
        return json.decode(message.body)['success'];
      } else {
        CustomOverlay.showToast(
            json.decode(message.body)['message'], Colors.red, Colors.white);
      }
    } catch (e) {
      print(e);
      CustomOverlay.showToast('Something went wrong', Colors.red, Colors.white);
    }
  }

  ///make payment
  static Future makePayment(
      BuildContext context, PaymentModel paymentDetails) async {
    CustomOverlay.showLoaderOverlay(duration: 6);
    try {
      var request = http.MultipartRequest('POST', addPayment)
        ..fields.addAll(
          {
            "user_id": paymentDetails.userID!,
            "loan_app_id": paymentDetails.loanApplicationID!,
            "paid_amount": paymentDetails.amountPaid!,
            "payment_date": paymentDetails.paymentDate!,
            "transaction_id": paymentDetails.transactionID!,
            "transaction_mode": paymentDetails.transactionMode!,
          },
        );

      ///clean up data before sending it
      // ignore: avoid_single_cascade_in_expression_statements
      request..fields.removeWhere((key, value) => value == '');

      var response = await request.send();

      final message = await http.Response.fromStream(response);

      HapticFeedback.selectionClick();

      debugPrint(message.body);
      debugPrint('${response.statusCode}');

      if (json.decode(message.body)['success'] == true) {
        CustomOverlay.showToast(
            'Payment added successfully😊', Colors.green, Colors.white);
      } else {
        CustomOverlay.showToast(
            json.decode(message.body)['message'], Colors.red, Colors.white);
      }
    } catch (e) {
      CustomOverlay.showToast('Something went wrong', Colors.red, Colors.white);
    }
  }

  ///synchronize loan application record with the server
  static Future syncLoanApplication(
      BuildContext context, LoanApplicationModel loanApplicationDetails) async {
    CustomOverlay.showLoaderOverlay(duration: 6);
    final loanController = Get.put(LoanDetailController());

    var request = http.MultipartRequest(
        'POST', Uri.parse('$baseUrl/loan/new_loan_application'))
      ..headers.addAll(
        {"Authorization": 'Bearer $accessToken'},
      )
      ..fields.addAll(
        {
          'loan_type': loanApplicationDetails.loanType,
          'loan_id': loanApplicationDetails.loanID,
          'user_id': GetStorage().read('userID').toString(),
          'loan_amount':
              loanApplicationDetails.loanAmounts['loan_amount'].toString(),
          'tenure_period':
              loanApplicationDetails.loanAmounts['tenure_period'].toString(),
          'payment_frequency': loanApplicationDetails
              .loanAmounts['payment_frequency']
              .toString(),
          'interest_rate': loanApplicationDetails.interestRate.toString(),
          'transaction_source': loanApplicationDetails.transactionSource,
          'principal':
              loanApplicationDetails.loanAmounts['principal'].toString(),
          'interest': loanApplicationDetails.loanAmounts['interest'].toString(),
          'outstanding_balance':
              loanApplicationDetails.loanAmounts['total_amount'].toString(),
          'pay_off_date': loanApplicationDetails.payOffDate.toString(),
          'payment_mode': loanApplicationDetails.loanAmounts['payment_mode'],
          'payment_time': loanApplicationDetails.loanAmounts['payment_time'],
          'loan_period': loanApplicationDetails.loanAmounts['loan_period'],
          'pay_back': loanApplicationDetails.loanAmounts['payback_breakdown']
              .toString(),
          'is_cleared': loanApplicationDetails.isCleared ? '1' : '0',
          'is_approved': loanApplicationDetails.approvedStatus ? '1' : '0',
          'is_denied': '0',
          'is_defaulter': '0'
        },
      );

    ///clean up data before sending it
    // ignore: avoid_single_cascade_in_expression_statements
    request..fields.removeWhere((key, value) => value == '');

    var response = await request.send();

    final message = await http.Response.fromStream(response);
    debugPrint(message.body);

    if (json.decode(message.body)['success'] == true) {
      GetStorage().write('hasOngoingLoan', true);
      CustomOverlay.showToast(
          'Loan application successful!', Colors.green, Colors.white);
      sendLoanRequestNotification();

      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: ((context) =>
                  SuccessScreen(loanDetails: loanApplicationDetails))));
    } else {
      CustomOverlay.showToast('Something went wrong', Colors.red, Colors.white);
    }

    HapticFeedback.selectionClick();

    return response;
  }

  static Future fetchMyLoanRecords() async {
    var request = await http.get(getMyLoanDetails,
        headers: {"Authorization": 'Bearer $accessToken'});

    if (request.statusCode == 200) {
      if (json.decode(request.body)['payload'].isEmpty) {
        return null;
      } else {
        return json.decode(request.body);
      }
    } else {
      return null;
    }
  }

  static Future fetchTransactions() async {
    var request = http.MultipartRequest('GET', getTransactionTypes)
      ..headers.addAll({"Authorization": 'Bearer $accessToken'});

    var response = await request.send();
    final message = await http.Response.fromStream(response);

    if (json.decode(message.body)['success'] == true) {
      return json.decode(message.body)['payload'];
    }
    return response;
  }

  static Future fetchAllLoanCategories() async {
    var request = http.MultipartRequest('GET', getAllLoanTypes)
      ..headers.addAll({"Authorization": 'Bearer $accessToken'});

    var response = await request.send();
    final message = await http.Response.fromStream(response);

    if (json.decode(message.body)['success'] == true) {
      return json.decode(message.body);
    }
    return response;
  }

  static Future fetchMyPaymentDetails() async {
    var request = await http.get(getMyPaymentDetails,
        headers: {"Authorization": 'Bearer $accessToken'});

    if (request.statusCode == 200) {
      return json.decode(request.body);
    } else {
      return null;
    }
  }

  static Future fetchAllFAQs() async {
    HapticFeedback.selectionClick();

    var request = http.MultipartRequest('GET', getFAQs)
      ..headers.addAll({"Authorization": 'Bearer $accessToken'});

    var response = await request.send();
    final message = await http.Response.fromStream(response);

    if (json.decode(message.body)['success'] == true) {
      if (jsonDecode(message.body)['payload'].isNotEmpty) {
        return json.decode(message.body);
      } else {
        return null;
      }
    }
    return response;
  }

  Future fetchData(BuildContext context, String accessToken) async {
    //CustomOverlay.showWorking();

    var responses = await Future.wait([
      //get loan categories
      http.get(getLoanCategories,
          headers: {"Authorization": 'Bearer $accessToken'}),

      //get user details
      http.get(getUser, headers: {"Authorization": 'Bearer $accessToken'}),
    ]);

    return [
      ..._getLoanCategories(responses[1]),
    ];
  }

  static _getLoanCategories(http.Response response) {
    return [
      if (response.statusCode == 200)
        if (json.decode(response.body)['success']) dashUpdate(response.body)
    ];
  }

  static dashUpdate(var obj) async {
    {
      // SharedPreferences preference = await SharedPreferences.getInstance();
      // preference.setString('dashboardJson', obj);
    }
  }
}
