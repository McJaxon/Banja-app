import 'package:banja/controllers/auth_controller.dart';
import 'package:banja/controllers/homepage_controller.dart';
import 'package:banja/controllers/loan_detail_controllers.dart';
import 'package:banja/controllers/notifications_controller.dart';
import 'package:banja/controllers/user_detail_controller.dart';
import 'package:banja/utils/file_picker.dart';
import 'package:get/instance_manager.dart';

class HomeBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FilePicker());
    Get.lazyPut(() => UserDetailsController());
    Get.lazyPut(() => LoanDetailController());
    Get.lazyPut(() => HomePageController());
    Get.lazyPut(() => AuthController());
  }
}
