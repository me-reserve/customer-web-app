import 'package:get/get.dart';
import 'package:me_reserve_bem_estar/components/core_export.dart';
import 'package:me_reserve_bem_estar/feature/profile/controller/edit_profile_tab_controller.dart';

class EditProfileBinding extends Bindings{
  @override
  void dependencies() async {
    Get.lazyPut(() => EditProfileTabController(userRepo: UserRepo(apiClient: Get.find())));
  }
}