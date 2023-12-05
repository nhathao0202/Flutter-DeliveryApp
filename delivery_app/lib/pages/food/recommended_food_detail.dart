import 'package:delivery_app/controllers/recommended_product_controller.dart';
import 'package:delivery_app/routes/route_helper.dart';
import 'package:delivery_app/utils/app_constants.dart';
import 'package:delivery_app/utils/colors.dart';
import 'package:delivery_app/widgets/big_text.dart';
import 'package:delivery_app/widgets/expandable_text_widget.dart';
import 'package:delivery_app/widgets/icon.dart';
import 'package:delivery_app/widgets/small_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/dimensions.dart';

class RecommendedFoodDetail extends StatelessWidget {
  final int pageId;
  const RecommendedFoodDetail({super.key, required this.pageId});

  @override
  Widget build(BuildContext context) {
    var product = Get.find<RecommendedProductController>().recommendedProductList[pageId];
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            toolbarHeight: 70,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Get.toNamed(RouteHelper.getInitial());
                  },
                  child: AppIcon(icon: Icons.clear),
                ),
                AppIcon(icon: Icons.shopping_cart_outlined)
              ],
            ),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(40),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.blueGrey[200],
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      topLeft: Radius.circular(20),
                  )
                ),
                child: Center(child: BigText(size: Dimensions.font26,text:"Chinese Side")),
                width: double.maxFinite,
                padding: EdgeInsets.only(top: 10, bottom: 10),
              ),
            ),
            pinned: true,
            backgroundColor: Colors.white,
            expandedHeight: 300,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                  AppConstants.BASE_URL+AppConstants.UPLOAD_URL+product.img!,
                  width: double.maxFinite,
                  fit: BoxFit.cover,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(left: 20,right: 20),
                  child: ExpandableTextWidget(text: product.description!),
                )
              ],
              )
            )
        ],
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.only(left: 50, right: 50, top:20, bottom: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppIcon(
                  iconColor:Colors.white,
                  icon: Icons.remove,
                  backgroundColor: AppColors.primaryElementStatus,),
                BigText(text: "\$12.88" + " X " + " 0 ",size: Dimensions.font26,),
                AppIcon(
                  iconColor:Colors.white,
                  icon: Icons.add,
                  backgroundColor: AppColors.primaryElementStatus,),
              ],
            ),
          ),
          Container(
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
                  child:
                      Icon(Icons.favorite,color: AppColors.primaryElementStatus,)
                ),
                Container(
                  padding: EdgeInsets.only(top: 18, bottom: 18, left: 18, right: 18),
                  child: BigText(text: "\$28 | Add to cart",color: Colors.white,),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: AppColors.primaryElementStatus
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
