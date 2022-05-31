import 'package:banja/controllers/authControllers.dart';
import 'package:banja/controllers/homePageController.dart';
import 'package:banja/controllers/loanDetailControllers.dart';
import 'package:banja/controllers/notifications_controller.dart';
import 'package:banja/controllers/userDetailsController.dart';
import 'package:banja/utils/file_picker.dart';
import 'package:get/instance_manager.dart';

class HomeBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FilePicker());
    Get.lazyPut(() => UserDetailsController());
    Get.lazyPut(() => LoanDetailController());
    Get.lazyPut(() => HomePageController());
    Get.lazyPut(() => NotificationsController());
    Get.lazyPut(() => AuthController());

  }
}
