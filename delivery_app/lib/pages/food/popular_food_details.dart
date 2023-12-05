import 'package:delivery_app/controllers/popular_product_controller.dart';
import 'package:delivery_app/pages/home/main_food_page.dart';
import 'package:delivery_app/utils/app_constants.dart';
import 'package:delivery_app/widgets/expandable_text_widget.dart';
import 'package:delivery_app/widgets/icon.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utils/colors.dart';
import '../../utils/dimensions.dart';
import '../../widgets/app_column.dart';
import '../../widgets/big_text.dart';
import '../../widgets/icons_and_text.dart';
import '../../widgets/small_text.dart';

class PopularFoodDetail extends StatelessWidget {
  final int pageId;
  const PopularFoodDetail({Key? key, required this.pageId}) :super (key:key);

  @override
  Widget build(BuildContext context) {
    var product = Get.find<PopularProductController>().popularProductList[pageId];
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned(
              left: 0,
              right: 0,
              child: Container(
                width: double.maxFinite,
                height: Dimensions.popularFoodImageSize,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                      AppConstants.BASE_URL+AppConstants.UPLOAD_URL+product.img!
                    )
                  )
                ),
          )),
          Positioned(
              top: 45,
              left: 20,
              right: 20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.to(() => MainFoodPage());
                  },
                      child:
                        AppIcon(icon: Icons.arrow_back_ios)),
                  AppIcon(icon: Icons.shopping_cart_outlined)
                ],
          )),
          Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              top: Dimensions.popularFoodImageSize - 20,
              child: Container(
                padding: EdgeInsets.only(left: 20, right: 20, top:20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20),
                    topLeft: Radius.circular(20),
                  ),
                  color: Colors.white
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppColumn(text: product.name!,size: Dimensions.font26,),
                    SizedBox(height: 20,),
                    BigText(text: "Introduce", size: Dimensions.font20,),
                    SizedBox(height: 10,),
                    Expanded(child: SingleChildScrollView(child: ExpandableTextWidget(text: product.description!)))
                  ],
                ),
              )
          ),
        ],
      ),
      bottomNavigationBar: Container(
        height: 120,
        padding: EdgeInsets.only(top:30, bottom: 30, left: 20, right: 20),
        decoration: BoxDecoration(
          color: AppColors.primarySecondaryBackground,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20)
          )
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: EdgeInsets.only(top: 18, bottom: 18, left: 18, right: 18),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white
              ),
              child: Row(
                children: [
                  Icon(Icons.remove, color: Colors.grey,),
                  SizedBox(width: 10,),
                  BigText(text: "0"),
                  SizedBox(width: 10,),
                  Icon(Icons.add, color: Colors.grey,)
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 18, bottom: 18, left: 18, right: 18),
              child: BigText(text: "\$10 | Add to cart",color: Colors.white,),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: AppColors.primaryElementStatus
              ),
            )
          ],
        ),
      ),
    );
  }
}
