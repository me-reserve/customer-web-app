import 'package:me_reserve_bem_estar/data/provider/client_api.dart';
import 'package:me_reserve_bem_estar/utils/app_constants.dart';
import 'package:get/get.dart';

class LoyaltyPointRepo{
  final ApiClient apiClient;
  LoyaltyPointRepo({required this.apiClient});

  Future<Response> convertLoyaltyPoint(String point) async {
    return await apiClient.postData(AppConstants.convertLoyaltyPointUri,{"point":point});
  }

  Future<Response> getLoyaltyPointData(int offset) async {
    return await apiClient.getData("${AppConstants.loyaltyPointTransactionData}?limit=10&offset=$offset");
  }
}