import 'package:get_storage/get_storage.dart';

var loanCategory = [
  {"asset": "car.svg", "category": "Emergency Loan"},
  {"asset": "school.svg", "category": "School Loan"},
  {"asset": "asset.svg", "category": "Asset Financing"},
  {"asset": "money.svg", "category": "Salary Advances"},
  {"asset": "lorry.svg", "category": "Logbook Loan"}
];

var actionCategory = [
  {"asset": "arrow_right.svg", "category": "Make a loan"},
  {"asset": "arrow_down.svg", "category": "Make a deposit"},
  {"asset": "record.svg", "category": "Record"},
  {"asset": "repeat.svg", "category": "Cash back"},
  {"asset": "settings.svg", "category": "Settings"},
  {"asset": "download.svg", "category": "Download slips"}
];

List transactionSource = [
  {"title": "Mobile Money Transfer"},
  {"title": "Bank Money Transfer"},
  {"title": "Cash Payment"}
];

///api uri links
///base url
var baseUrl = 'http://tuulacredit.com/jubilant-waddle/public/api/v1';

var userID = GetStorage().read('userID');

///get loan categories
Uri getLoanCategories = Uri.parse('$baseUrl/loan_categories');

///get my loan details
Uri getMyLoanDetails =
    Uri.parse('$baseUrl/loan/get_user_loan_applications/$userID');

///get payment details
Uri getMyPaymentDetails =
    Uri.parse('$baseUrl/payments/get_user_payments/$userID');

///get loan categories
Uri getUser = Uri.parse('$baseUrl/end_users');

///add payment
Uri addPayment = Uri.parse('$baseUrl/payments/add_payment');

///phone number sign in
Uri phoneSignInUri = Uri.parse('$baseUrl/user/phone_sign_in');

///create user tag
Uri userTagUri = Uri.parse('$baseUrl/user/create_user_tag');
