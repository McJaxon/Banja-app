//  TUULA CREDIT FINANCIAL SERVICES LIMITED
//
//  Created by Ronnie Zad.
//  2021, Zaren Inc. All rights reserved.
//

//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.

class LoanApplicationModel {
  LoanApplicationModel(
      {required this.approvedStatus,
      required this.loanType,
      required this.loanID,
      required this.loanAmount,
      required this.tenurePeriod,
      required this.paymentFrequency,
      required this.interestRate,
      required this.transactionSource,
      required this.principal,
      required this.interest,
      required this.outstandingBalance,
      required this.payOffDate,
      required this.payBack,
      required this.isCleared,
      required this.loanPeriod,
      required this.paymentMode,
      required this.paymentTime});

  factory LoanApplicationModel.fromJson(Map<String, dynamic> json) {
    return LoanApplicationModel(
      approvedStatus: json['approved_status'] == 0 ? false : true,
      loanAmount: json['loan_amount'],
      loanID: json['loan_id'],
      tenurePeriod: json['tenure_period'],
      payBack: json['pay_back'],
      interest: json['interest'],
      interestRate: json['interest_rate'],
      outstandingBalance: json['outstanding_balance'],
      isCleared: json['is_cleared'] == 0 ? false : true,
      payOffDate: json['pay_off_date'],
      paymentFrequency: json['payment_frequency'],
      loanType: json['loan_type'],
      transactionSource: json['transaction_source'],
      principal: json['principal'],
      loanPeriod: json['loan_period'],
      paymentMode: json['payment_mode'],
      paymentTime: json['payment_time'],
    );
  }

  final int? loanAmount,
      interest,
      tenurePeriod,
      payBack,
      interestRate,
      outstandingBalance,
      principal,
      paymentFrequency;
  final DateTime payOffDate;
  final bool approvedStatus, isCleared;
  final String loanType, loanID, transactionSource;
  String paymentMode, loanPeriod, paymentTime;

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'loan_type': loanType,
      'loan_id': loanID,
      'loan_amount': loanAmount,
      'tenure_period': tenurePeriod,
      'payment_frequency': paymentFrequency,
      'interest_rate': interestRate,
      'transaction_source': transactionSource,
      'principal': principal,
      'interest': interest,
      'outstanding_balance': outstandingBalance,
      'pay_off_date': payOffDate.toIso8601String(),
      'pay_back': payBack,
      'is_cleared': isCleared == false ? 0 : 1,
      'approved_status': approvedStatus == false ? 0 : 1,
      'payment_mode': paymentMode,
      'payment_time': paymentTime,
      'loan_period': loanPeriod
    };

    return map
      ..removeWhere((String key, dynamic value) =>
          key.isEmpty || value == null || value == '');
  }
}

class LoanCategoryModel {
  LoanCategoryModel(
      {this.abbreviation,
      required this.id,
      required this.loanType,
      required this.description});

  factory LoanCategoryModel.fromJson(Map<String, dynamic> json) {
    return LoanCategoryModel(
      id: json['id'],
      loanType: json['loan_type'],
      abbreviation: json['abbreviation'],
      description: json['description'],
    );
  }

  final int id;
  final String loanType;
  final String? abbreviation, description;

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': id,
      'loan_type': loanType,
      'abbreviation': abbreviation,
      'description': description
    };

    return map;
  }
}

class EndUserModel {
  EndUserModel(
      {this.profilePic,
      this.phoneNumber,
      this.nin,
      this.fullNames,
      this.location,
      this.emailAddress,
      this.password,
      this.passwordConfirm,
      this.referralID});

  factory EndUserModel.fromJson(Map<String, dynamic> json) {
    return EndUserModel(
      phoneNumber: json['phone_number'],
      profilePic: json['profile_pic'],
      nin: json['nin'],
      emailAddress: json['email_address'],
      location: json['location'],
      referralID: json['referral_id'],
      fullNames: json['full_names'],
    );
  }

  final String? nin, fullNames, emailAddress, location, profilePic, phoneNumber;
  final String? referralID, password, passwordConfirm;

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'phone_number': phoneNumber,
      'profile_pic': profilePic,
      'full_names': fullNames,
      'nin': nin,
      'location': location,
      'referral_id': referralID,
      'email_address': emailAddress,
      'password': password,
      'password_confirm': passwordConfirm
    };

    return map..removeWhere((key, value) => value == '' || value == null);
  }
}

class PaymentModel {
  PaymentModel({
    this.userID,
    this.loanApplicationID,
    this.amountPaid,
    this.paymentDate,
    this.transactionID,
    this.transactionMode,
  });

  factory PaymentModel.fromJson(Map<String, dynamic> json) {
    return PaymentModel(
      userID: json['user_id'],
      loanApplicationID: json['loan_app_id'],
      amountPaid: json['paid_amount'],
      paymentDate: json['payment_date'],
      transactionID: json['transaction_id'],
      transactionMode: json['transaction_mode'],
    );
  }

  final String? userID,
      loanApplicationID,
      amountPaid,
      paymentDate,
      transactionID,
      transactionMode;

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'user_id': userID,
      'loan_app_id': loanApplicationID,
      'paid_amount': amountPaid,
      'payment_date': paymentDate,
      'transaction_id': transactionID,
      'transaction_mode': transactionMode,
    };

    return map..removeWhere((key, value) => value == '' || value == null);
  }
}
