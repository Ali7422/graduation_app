import 'package:flutter/material.dart';
import 'package:movies/core/helper/responsive.dart';

import '../theme/app_colors.dart';

class CustomGradientContainer extends StatelessWidget {
  const CustomGradientContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.height * 0.6,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.backGroundColor.withAlpha(80),
            AppColors.backGroundColor,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
    );
  }
}
