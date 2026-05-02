import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies/core/helper/font_whight_helper.dart';
import 'package:movies/core/theme/app_colors.dart';

class TextStyleHelper {
static TextStyle font24WhiteBold = TextStyle(
    fontSize: 24.sp,
    fontWeight: FontWeightHelper.bold,
    color: Colors.white,
    fontFamily: "Roboto"
  );
  static TextStyle font18WhiteBold = TextStyle(
    fontSize: 18.sp,
    fontWeight: FontWeightHelper.bold,
    color:Colors.white,
    fontFamily: "Roboto"
  );
  static TextStyle font16WhiteBold = TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeightHelper.bold,
    color: Colors.white,
    fontFamily: "Roboto"
  );
  static TextStyle font14GreyRegular = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeightHelper.regular,
    color: Colors.grey,
    fontFamily: "Roboto",
  );
  static TextStyle font14goldBold = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeightHelper.bold,
    color: AppColors.gold,
    fontFamily: "Roboto",
  );
    static TextStyle font10goldBold = TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeightHelper.regular,
    color: AppColors.gold,
    fontFamily: "Roboto",
  );
  static TextStyle font15WhiteRegular = TextStyle(
    fontSize: 15.sp,
    fontWeight: FontWeightHelper.regular,
    color: Colors.white,
    fontFamily: "Roboto",
  );
   static TextStyle font17WhiteRegular = TextStyle(
    fontSize: 17.sp,
    fontWeight: FontWeightHelper.regular,
    color: Colors.white,
    fontFamily: "Roboto",
  );
}
