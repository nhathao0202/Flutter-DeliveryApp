import 'package:delivery_app/controllers/popular_product_controller.dart';
import 'package:delivery_app/controllers/recommended_product_controller.dart';
import 'package:delivery_app/model/products_model.dart';
import 'package:delivery_app/pages/food/popular_food_details.dart';
import 'package:delivery_app/routes/route_helper.dart';
import 'package:delivery_app/utils/app_constants.dart';
import 'package:delivery_app/utils/colors.dart';
import 'package:delivery_app/utils/dimensions.dart';
import 'package:delivery_app/widgets/app_column.dart';
import 'package:delivery_app/widgets/big_text.dart';
import 'package:delivery_app/widgets/icons_and_text.dart';
import 'package:delivery_app/widgets/small_text.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BodyFoodPage extends StatefulWidget {
  const BodyFoodPage({super.key});

  @override
  State<BodyFoodPage> createState() => _BodyFoodPageState();
}

class _BodyFoodPageState extends State<BodyFoodPage> {
  PageController pageController = PageController(viewportFraction: 0.9);
  var currPageValue = 0.0;
  double _scaleFactor = 0.8;
  double _heigth = Dimensions.pageViewContainer;
  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      setState(() {
        currPageValue = pageController.page!;

      });
    });
  }

  @override
  void dispose() {
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GetBuilder<PopularProductController>(builder: (popularProducts) {
          return popularProducts.isLoaded?Container(
            height: Dimensions.pageView,
              child: PageView.builder(
                  controller: pageController,
                  itemCount: popularProducts.popularProductList.length,
                  itemBuilder: (context, position) {
                    return _buildPageItem(position,popularProducts.popularProductList[position]);
                  }),
          ):CircularProgressIndicator(
            color: AppColors.primaryElementStatus,
          );
        }),
        GetBuilder<PopularProductController>(builder: (popuplarProducts) {
          return DotsIndicator(
            dotsCount: popuplarProducts.popularProductList.isEmpty?1:popuplarProducts.popularProductList.length,
            position: currPageValue,
            decorator: DotsDecorator(
              activeColor: AppColors.primaryElementStatus,
              size: const Size.square(9.0),
              activeSize: const Size(18.0, 9.0),
              activeShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
            ),
          );
        }),
        SizedBox(height: 15,),
        Container(
          margin: EdgeInsets.only(left: 20),
          child: Row(
            children: [
              BigText(text: "Recommended"),
              SizedBox(width:15,),
              Container(
                child: BigText(text: ".",color: Colors.black26,),
                margin: EdgeInsets.only(bottom: 10),
              ),
              SizedBox(width:15,),
              SmallText(text: "Food pairing")
            ],
          ),
        ),
        GetBuilder<RecommendedProductController>(builder: (recommendedProduct) {
          return recommendedProduct.isLoaded?ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: recommendedProduct.recommendedProductList.length,
              itemBuilder: (context, index){
                return GestureDetector(
                  onTap: () {
                    Get.toNamed(RouteHelper.getRecommendedFood(index));
                  },
                  child: Container(
                    margin: EdgeInsets.only(left: 20, right: 20, bottom: 15),
                    child: Row(
                      children: [
                        Container(
                          width:120,
                          height: 120,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(
                                      AppConstants.BASE_URL+ AppConstants.UPLOAD_URL+ recommendedProduct.recommendedProductList[index].img!
                                  )
                              )
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: 100,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(20),
                                  bottomRight: Radius.circular(20)
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(left: 10, right: 10),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  BigText(text: recommendedProduct.recommendedProductList[index].name!),
                                  SizedBox(height: 10,),
                                  SmallText(text: "With chinese characteristics",),
                                  SizedBox(height: 10,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      IconAndTextWidget(
                                          icon: Icons.circle_sharp,
                                          text: "Fast",
                                          iconColor: AppColors.primaryElement),

                                      SizedBox(width: 10,),

                                      IconAndTextWidget(
                                          icon: Icons.location_on,
                                          text: "0.5km",
                                          iconColor: AppColors.primaryElementStatus),

                                      SizedBox(width: 10,),

                                      IconAndTextWidget(
                                          icon: Icons.access_time_rounded,
                                          text: "32min",
                                          iconColor: AppColors.primaryText)
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              }):CircularProgressIndicator(
            color: AppColors.primaryElementStatus,
          );
        })
      ],
    );
  }

  Widget _buildPageItem(int index, ProductModel popularProduct){
    Matrix4 matrix = new Matrix4.identity();
    if(index == currPageValue.floor()){
      var currScale = 1 - (currPageValue - index) * (1 - _scaleFactor);
      var currTrans = _heigth * (1-currScale) /2 ;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0,currTrans,0);

    }else if(index == currPageValue.floor() + 1) {
      var currScale = _scaleFactor + (currPageValue - index + 1) * (1 - _scaleFactor);
      var currTrans = _heigth * (1-currScale) /2 ;
      matrix = Matrix4.diagonal3Values(1, currScale, 1);
      matrix = Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0,currTrans,0);

    } else if(index == currPageValue.floor() - 1) {
      var currScale = 1 - (currPageValue - index) * (1 - _scaleFactor);
      var currTrans = _heigth * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1);
      matrix = Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, currTrans, 0);
    }else {
      var currScale = 0.8;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, _heigth*(1-_scaleFactor)/2, 1);
    }

    return Transform(
      transform: matrix,
      child: Stack(
        children: [
          GestureDetector(
            onTap: () {

              Get.toNamed(RouteHelper.getPopularFood(index));
            },
            child: Container(
              margin: EdgeInsets.only(left: 10, right: 10),
              height: Dimensions.pageViewContainer,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: index.isEven?Color(0xFF69c5df):Color(0xFF9294cc),
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                          AppConstants.BASE_URL+ AppConstants.UPLOAD_URL+ popularProduct.img!
                      )
                  )
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: EdgeInsets.only(left: 30, right: 30,bottom: 30),
              height: Dimensions.pageViewTextContainer,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xFFe8e8e8),
                      blurRadius: 4.0,
                      offset: Offset(6, 6)
                    ),
                    BoxShadow(
                      color: Colors.white,
                      offset: Offset(-5, 0),

                    )
                  ]
              ),
              child: Container(
                padding: EdgeInsets.only(top:15,left: 15,right: 15),
                child: AppColumn(text: popularProduct.name!,size: Dimensions.font20,),
              ),
            ),
          )
        ],
      ),
    );
  }
}
