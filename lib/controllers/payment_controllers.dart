import 'package:banja/constants/secrets.dart';
import 'package:banja/models/loan_application_details_model.dart';
import 'package:banja/services/server.dart';
import 'package:flutter/material.dart';
import 'package:flutterwave/core/flutterwave.dart';
import 'package:flutterwave/models/responses/charge_response.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:nanoid/nanoid.dart';

class PaymentController extends GetxController {
  payWithMobileMoney(
      BuildContext context, String loanID, String amountToPay) async {
    try {
      var transactionRef = 'txf-' + customAlphabet('1234567890abcdef', 10);

      Flutterwave flutterwave = Flutterwave.forUIPayment(
        isMobileMoney: true,
        context: context,
        encryptionKey: Secrets.flutterwaveEncryptionKey,
        publicKey: Secrets.flutterwavePublicKey,
        currency: 'UGX',
        amount: amountToPay,
        email: GetStorage().read('emailAddress'),
        fullName: GetStorage().read('fullNames'),
        txRef: transactionRef,
        isDebugMode: false,
        phoneNumber: "${GetStorage().read('phoneNumber')}",
        acceptUgandaPayment: true,
      );

      final ChargeResponse response =
          await flutterwave.initializeForUiPayments();

      if (response.data!.status == 'successful') {
        var paymentDetails = PaymentModel(
            userID: GetStorage().read('userID'),
            loanApplicationID: loanID,
            amountPaid: response.data!.amount,
            paymentDate: DateFormat.yMMMd().format(DateTime.now()),
            transactionID: response.data!.txRef,
            transactionMode: 'Mobile Money');

        Server.makePayment(context, paymentDetails);
      }
    } catch (error) {
      print(error);
      //handleError(error);
    }
  }

  payWithBank(BuildContext context, String loanID, String amountToPay) async {
    try {
      var transactionRef = 'txf-' + customAlphabet('1234567890abcdef', 10);

      Flutterwave flutterwave = Flutterwave.forUIPayment(
          isMobileMoney: false,
          context: context,
          encryptionKey: Secrets.flutterwaveEncryptionKey,
          publicKey: Secrets.flutterwavePublicKey,
          currency: 'UGX',
          amount: amountToPay,
          email: GetStorage().read('emailAddress'),
          fullName: GetStorage().read('fullNames'),
          txRef: transactionRef,
          isDebugMode: false,
          phoneNumber: "${GetStorage().read('phoneNumber')}",
          acceptBankTransfer: true,
          acceptUgandaPayment: false);

      final ChargeResponse response =
          await flutterwave.initializeForUiPayments();

      if (response.data!.status == 'successful') {
        var paymentDetails = PaymentModel(
            userID: GetStorage().read('userID'),
            loanApplicationID: loanID,
            amountPaid: response.data!.amount,
            paymentDate: DateFormat.yMMMd().format(DateTime.now()),
            transactionID: response.data!.txRef,
            transactionMode: 'Mobile Money');

        Server.makePayment(context, paymentDetails);
      }

      print(response.data!.status);
    } catch (error) {
      //handleError(error);
    }
  }
}
