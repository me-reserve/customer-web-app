import 'package:get/get.dart';
import 'package:me_reserve_bem_estar/controller/theme_controller.dart';

class SettingsBinding extends Bindings{
  @override
  void dependencies() async {
    Get.lazyPut(() => ThemeController(sharedPreferences: Get.find()));
  }

}