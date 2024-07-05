import 'package:me_reserve_bem_estar/components/core_export.dart';
import 'package:get/get.dart';

class HomeSearchWidget extends StatelessWidget {
  const HomeSearchWidget({super.key}) ;

  @override
  Widget build(BuildContext context) {
    return  SliverPersistentHeader(
      pinned: true,
      delegate: SliverDelegate(extentSize: 60,
        child: InkWell(

          onTap: () => Get.dialog(const SearchSuggestionDialog(), transitionCurve: Curves.easeIn),

          child: Padding(padding: const EdgeInsets.only(left: Dimensions.paddingSizeDefault, right: Dimensions.paddingSizeDefault, top: Dimensions.paddingSizeExtraSmall,),
            child: Container(
              padding: EdgeInsets.only(
                left: Get.find<LocalizationController>().isLtr ? Dimensions.paddingSizeDefault : 0,
                right:   Get.find<LocalizationController>().isLtr ? 0 : Dimensions.paddingSizeDefault,
              ),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: Border.all(color: Color(0xFFB6B6B6)),
                borderRadius: BorderRadius.circular(Dimensions.paddingSizeExtraLarge),
                color: Color(0xFFF8F8F8),
              ),
              child: Row( children: [

                const SizedBox(width: Dimensions.paddingSizeExtraSmall,),
                Text('search_services'.tr, style: ubuntuRegular.copyWith(color: Theme.of(context).hintColor)),
                const Spacer(),
                Container(height: 45, width: 45,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor ,shape: BoxShape.circle
                  ),
                  margin: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeExtraSmall),
                  child: Padding(padding: const EdgeInsets.all(Dimensions.paddingSizeSmall + 3),
                    child: Image.asset(Images.searchIcon),
                  ),
                ),

              ]),
            ),
          ),
        ),
      ),
    );
  }
}


class SliverDelegate extends SliverPersistentHeaderDelegate {
  Widget? child;
  double? extentSize;
  SliverDelegate({@required this.child,@required this.extentSize});
  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child!;
  }
  @override
  double get maxExtent => extentSize!;
  @override
  double get minExtent => extentSize!;
  @override
  bool shouldRebuild(SliverDelegate oldDelegate) {
    return oldDelegate.maxExtent != maxExtent || oldDelegate.minExtent != maxExtent || child != oldDelegate.child;
  }
}