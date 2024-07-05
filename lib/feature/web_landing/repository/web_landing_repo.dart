import 'package:me_reserve_bem_estar/data/provider/client_api.dart';
import 'package:me_reserve_bem_estar/feature/notification/repository/notification_repo.dart';
import 'package:me_reserve_bem_estar/utils/app_constants.dart';

class WebLandingRepo {
  final ApiClient apiClient;

  WebLandingRepo({required this.apiClient});

  Future<Response> getWebLandingContents() async {
    return await apiClient.getData(AppConstants.webLandingContents);
  }

}