import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import '../shared/shared.dart';

class NotificationsController extends GetxController {
  showNotificationModalPage(BuildContext context, Function build) {
    HapticFeedback.lightImpact();
    showCupertinoModalBottomSheet(
      context: context,
      builder: (context) {
        return const NotificationSheet();
      },
    );
  }
}
