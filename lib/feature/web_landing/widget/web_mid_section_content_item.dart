import 'package:me_reserve_bem_estar/utils/dimensions.dart';
import 'package:me_reserve_bem_estar/utils/styles.dart';
import 'package:flutter/material.dart';

class WebMidSectionContentItem extends StatelessWidget {
  final String title;
  final String subTitle;
  const WebMidSectionContentItem({super.key, required this.title,required this.subTitle}) ;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title, textAlign: TextAlign.center,
          style: ubuntuBold.copyWith(fontSize: Dimensions.fontSizeLarge),
        ),
        const SizedBox(height: Dimensions.paddingSizeExtraLarge),
        Text(
          subTitle, textAlign: TextAlign.start,
          style: ubuntuRegular.copyWith(
              color: Theme.of(context).disabledColor,
              fontSize: Dimensions.fontSizeSmall
          ),
        ),
        const SizedBox(height: Dimensions.paddingSizeLarge),
      ],
    );
  }
}

