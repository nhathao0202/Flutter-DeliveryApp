import 'package:delivery_app/widgets/small_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/colors.dart';
import 'big_text.dart';
import 'icons_and_text.dart';

class AppColumn extends StatelessWidget {
  final String text;
  final double size;
  const AppColumn({super.key, required this.text, required this.size});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BigText(text: text),
        SizedBox(height: 10,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Wrap(
              children: List.generate(5, (index) {
                return Icon(Icons.star, color: AppColors.primaryElementStatus, size: 15);}
              ),
            ),
            SizedBox(width: 20,),

            SmallText(text: "4.5"),

            SizedBox(width: 20,),

            SmallText(text: "1287 comments")

          ],
        ),
        SizedBox(height: 20,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconAndTextWidget(
                icon: Icons.circle_sharp,
                text: "Normal",
                iconColor: AppColors.primaryElement),

            SizedBox(width: 20,),

            IconAndTextWidget(
                icon: Icons.location_on,
                text: "1.7km",
                iconColor: AppColors.primaryElementStatus),

            SizedBox(width: 20,),

            IconAndTextWidget(
                icon: Icons.access_time_rounded,
                text: "32min",
                iconColor: AppColors.primaryText)
          ],
        )
      ],
    );
  }
}
