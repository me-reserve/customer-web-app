import 'package:get/get.dart';
import 'package:me_reserve_bem_estar/components/core_export.dart';

class RowText extends StatelessWidget {
  final String title;
  final int? quantity;
  final double price;

  const RowText({super.key,required this.title,required this.price,this.quantity}) ;

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.only(bottom: 5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: quantity == null ? Colors.transparent : Color(0xFF05C6F1),
                  ),
                  child: Text( quantity == null ? "" : " x $quantity", style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold
                  ),)
                ),

                SizedBox(width: 10),

                SizedBox(
                  width: ResponsiveHelper.isWeb() ? 200 : Get.width / 2,
                  child: Text(title,
                    maxLines: 2, overflow: TextOverflow.ellipsis,
                    style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeDefault,
                    fontWeight: FontWeight.bold
                    
                    ),),
                ),
                
              ],
            ),
          ),
          Directionality(
            textDirection: TextDirection.ltr,
            child: Text('${title.contains('Discount') || title.contains('خصم') ? '(-)': title == 'VAT' || title == 'برميل'? '(+)':''} ${PriceConverter.convertPrice(double.parse(price.toString()),isShowLongPrice:true)}',
              textAlign: TextAlign.right,),
          )
        ],
      ),
    );
  }
}
