import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:me_reserve_bem_estar/components/core_export.dart';

class CompletePage extends StatelessWidget {
  final String? token;

  const CompletePage({super.key, this.token}) ;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 80.0,),
            GetBuilder<CheckOutController>(builder: (controller) {
              return Column(children: [
                  

                  const SizedBox(height: Dimensions.paddingSizeExtraMoreLarge,),
                  SvgPicture.asset(
                    Images.orderComplete,
                    height: 200,
                    width: 200,
                  ),

                  SizedBox(height: 50),

                  Text(controller.isPlacedOrderSuccessfully ? 'Pagamento realizado com sucesso' : 'Falha no pagamento'.tr,
                    style: ubuntuMedium.copyWith(fontSize: 20,
                        color: controller.isPlacedOrderSuccessfully ? const Color(0xFF70BF4B) : Theme.of(context).colorScheme.error) ,
                  ),

                  if(controller.bookingReadableId.isNotEmpty)
                    Padding(padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault),
                      child: Text("${'booking_id'.tr} ${controller.bookingReadableId}", style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeExtraLarge, color: Theme.of(context).textTheme.bodyMedium!.color),),
                    ),

                     SizedBox(
                      width: 200,
                      height: 40,
                      child: ElevatedButton(
                        onPressed: () async {
                            Get.offNamed(RouteHelper.getBookingScreenRoute(true));
                      }, 
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF25AED0)
                        ),
                        child: Text("Visualizar vouchers",
                          style: TextStyle(
                            fontSize: 15
                          ),
                        )
                      ),
                    ),

                  if(ResponsiveHelper.isWeb())
                    const SizedBox(height: Dimensions.paddingSizeExtraMoreLarge,)
              ]);
            }),
          ],
        ),
      ),
    );
  }
}
