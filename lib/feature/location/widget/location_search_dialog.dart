import 'package:get/get.dart';
import 'package:me_reserve_bem_estar/components/core_export.dart';

class LocationSearchDialog extends StatelessWidget {
  final GoogleMapController? mapController;
  const LocationSearchDialog({super.key, required this.mapController});

  @override
  Widget build(BuildContext context) {

    return Container(
      margin: EdgeInsets.only(top: ResponsiveHelper.isDesktop(context) ? 120 : 0),
      padding: const EdgeInsets.symmetric(horizontal:Dimensions.paddingSizeSmall),
      alignment: Alignment.topCenter,
      child: Material(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimensions.radiusSmall)),
        child: GetBuilder<LocationController>(builder: (locationController){
          return SizedBox(width: Dimensions.webMaxWidth-30, child: TypeAheadField(
            textFieldConfiguration: TextFieldConfiguration(
              onSubmitted: (value){
                if(locationController.firstPredictionModel !=null){
                  Get.find<LocationController>().setLocation(locationController.firstPredictionModel!.placeId!, locationController.firstPredictionModel!.description!, mapController!);
                  Get.back();
                }
              },
              controller: Get.find<LocationController>().searchController,
              textInputAction: TextInputAction.search,
              autofocus: true,
              textCapitalization: TextCapitalization.words,
              keyboardType: TextInputType.streetAddress,
              decoration: InputDecoration(
                hintText: 'search_location'.tr,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(style: BorderStyle.none, width: 0),
                ),
                hintStyle: Theme.of(context).textTheme.displayMedium!.copyWith(
                  fontSize: Dimensions.fontSizeDefault, color: Theme.of(context).disabledColor,
                ),
                filled: true, fillColor: Theme.of(context).cardColor,
              ),
              style: Theme.of(context).textTheme.displayMedium!.copyWith(
                color: Theme.of(context).textTheme.bodyLarge!.color, fontSize: Dimensions.fontSizeLarge,
              ),
            ),
            hideSuggestionsOnKeyboardHide: false,
            suggestionsCallback: (pattern) async {
              return await Get.find<LocationController>().searchLocation(context, pattern);
            },
            itemBuilder: (context, PredictionModel suggestion) {
              return Padding(
                padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                child: Row(children: [
                  const Icon(Icons.location_on),
                  Expanded(
                    child: Text(suggestion.description!, maxLines: 1, overflow: TextOverflow.ellipsis, style: Theme.of(context).textTheme.displayMedium!.copyWith(
                      color: Theme.of(context).textTheme.bodyLarge!.color, fontSize: Dimensions.fontSizeLarge,
                    )),
                  ),
                ]),
              );
            },
            onSuggestionSelected: (PredictionModel suggestion) {
              Get.find<LocationController>().setLocation(suggestion.placeId!, suggestion.description!, mapController!);
              Get.back();
            },
            noItemsFoundBuilder: (value) {
              return const SizedBox();
            },
          ),);
        }),
      ),
    );
  }

}
