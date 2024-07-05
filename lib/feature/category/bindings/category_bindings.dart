import 'package:get/get.dart';
import 'package:me_reserve_bem_estar/components/core_export.dart';

class CategoryBindings extends Bindings {
  @override
  void dependencies() async {
    Get.lazyPut(() => ServiceController(serviceRepo: ServiceRepo(apiClient: Get.find())));

  }
}