import 'package:get/get.dart';
import 'package:me_reserve_bem_estar/core/common_model/user_model.dart';
import 'package:me_reserve_bem_estar/components/core_export.dart';
class ServiceManInfo extends StatelessWidget {
  final User user;
  const ServiceManInfo({super.key,required this.user, }) ;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
          child: Text("service_man_info".tr, style: ubuntuMedium.copyWith(
              fontSize: Dimensions.fontSizeDefault,
              color:Get.isDarkMode ? Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(.6):Theme.of(context).primaryColor))),
        Gaps.verticalGapOf(Dimensions.paddingSizeDefault),
        CustomerInfoCard(
          name: "${user.firstName!} ${user.lastName!}",
          phone: user.phone!,
          image: user.profileImage!,
        ),
        Gaps.verticalGapOf(Dimensions.paddingSizeDefault),
      ],
    );
  }
}
