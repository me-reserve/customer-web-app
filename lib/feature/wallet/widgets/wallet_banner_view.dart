import 'package:me_reserve_bem_estar/components/core_export.dart';
import 'package:me_reserve_bem_estar/feature/wallet/model/bonus_model.dart';
import 'package:get/get.dart';

class WalletBannerView extends StatelessWidget {
  final BonusModel? bonusModel;
  const WalletBannerView({super.key, this.bonusModel}) ;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault,vertical: Dimensions.paddingSizeDefault),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
        border: Border.all(color: Theme.of(context).colorScheme.primary.withOpacity(0.6),width: 0.5),
        color: Theme.of(context).hoverColor,
      ),
      child: Stack( clipBehavior: Clip.none, children: [

        Positioned(
          right: Get.find<LocalizationController>().isLtr ? 0 : null,
          left: Get.find<LocalizationController>().isLtr ? null : 0,
          child: Image.asset(Images.walletBannerBackground, width: 60,height: 80, opacity: const AlwaysStoppedAnimation(.3) ),
        ),

        Column(crossAxisAlignment: CrossAxisAlignment.start,children: [

          Text( bonusModel?.bonusTitle ?? "",style: ubuntuBold.copyWith(color: Theme.of(context).colorScheme.primary),overflow: TextOverflow.ellipsis,),

          Padding(padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall-2),
            child: Text( "${'valid_till'.tr} ${DateConverter.stringToLocalDateOnly(bonusModel!.endDate!)}",style: ubuntuMedium.copyWith(color: Theme.of(context).textTheme.bodyMedium!.color!.withOpacity(0.8),)),
          ),
          Text( bonusModel?.shortDescription ?? "",style: ubuntuRegular.copyWith(color: Theme.of(context).colorScheme.primary),overflow: TextOverflow.ellipsis,),

        ],),
      ]),
    );
  }
}
