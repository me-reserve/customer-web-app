import 'package:get/get.dart';
import 'package:me_reserve_bem_estar/components/core_export.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final String? subTitle;
  final bool? isBackButtonExist;
  final Function()? onBackPressed;
  final bool? showCart;
  final bool? centerTitle;
  final Color? bgColor;
  final Widget? actionWidget;

  const CustomAppBar({
    super.key,
    required this.title,
    this.isBackButtonExist = true,
    this.onBackPressed,
    this.showCart = false,
    this.centerTitle = true,
    this.bgColor,
    this.actionWidget,
    this.subTitle
  });

  @override
  Widget build(BuildContext context) {
    return ResponsiveHelper.isDesktop(context) ? const WebMenuBar() : AppBar(
      backgroundColor: Colors.transparent,
      centerTitle: centerTitle,
      shape: Border(bottom: BorderSide(width: .4, color: Theme.of(context).primaryColorLight.withOpacity(.2))), elevation: 0,
      titleSpacing: 0,
      title: Column(crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title!, style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeLarge, color:  Color(0xFF595959)),),
          if(subTitle!=null) Text(subTitle!,style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeSmall,color:  Theme.of(context).primaryColorLight),),

        ],
      ),

      leading: isBackButtonExist! ? IconButton(
        hoverColor:Colors.transparent,
        icon: Icon(Icons.arrow_back_ios,color: Color(0xFF595959)),
        color: Theme.of(context).textTheme.bodyLarge!.color,
        onPressed: () => onBackPressed != null ? onBackPressed!() : Navigator.pop(context),
      ) : const SizedBox(),

      actions: showCart! ? [
        IconButton(
          onPressed: () => Get.toNamed(RouteHelper.getCartRoute()),
          icon:  CartWidget(color: Get.isDarkMode ? Theme.of(context).primaryColorLight : Colors.white, size: Dimensions.cartWidgetSize),
        )] : actionWidget != null ? [actionWidget!] : null,
    );
  }
  @override
  Size get preferredSize => Size(Dimensions.webMaxWidth, ResponsiveHelper.isDesktop(Get.context) ? Dimensions.preferredSizeWhenDesktop : Dimensions.preferredSize );
}