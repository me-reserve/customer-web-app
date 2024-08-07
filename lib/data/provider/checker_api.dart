import 'package:get/get.dart';
import 'package:me_reserve_bem_estar/components/custom_snackbar.dart';
import 'package:me_reserve_bem_estar/core/helper/route_helper.dart';
import 'package:me_reserve_bem_estar/feature/auth/controller/auth_controller.dart';

class ApiChecker {
  static void checkApi(Response response) {
    if(response.statusCode == 401) {
      Get.find<AuthController>().clearSharedData();
      if(Get.currentRoute != RouteHelper.getSignInRoute('splash')){
        Get.offAllNamed(RouteHelper.getSignInRoute(RouteHelper.main));
        customSnackBar("${response.statusCode!}".tr);
      }
    }else if(response.statusCode == 500){
      customSnackBar("${response.statusCode!}".tr);
    }
    else{
      customSnackBar("${response.body['message']}");
    }
  }
}