import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movies/core/helper/responsive.dart';
import 'package:movies/core/shared/custom_gradiant_container.dart';
import 'package:movies/core/theme/app_colors.dart';
import 'package:movies/core/theme/app_text_theme.dart';

Widget buildHeaderPodcastDetails({
  required String podcastImage,
  required String podcastPublisher,
  required String podcastTitle,
  required BuildContext context,
}) {
  return SizedBox(
    height: context.height * 0.6,
    child: Stack(
      children: [
        CachedNetworkImage(
          imageUrl: podcastImage,
          fit: BoxFit.cover,
          width: context.width,
          height: context.height * 0.6,
          placeholder: (context, url) =>
              const Center(child: CircularProgressIndicator(color: AppColors.gold)),
          errorWidget: (context, url, error) =>
              const Icon(Icons.broken_image, size: 50, color: Colors.grey),
        ),
        const CustomGradientContainer(),
        // header
        Positioned(
          top: context.height * 0.01,
          left: 0,
          right: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
                onPressed: () => Navigator.pop(context),
              ),
              IconButton(
                icon: const Icon(Icons.bookmark, color: AppColors.white),
                onPressed: () {},
              ),
            ],
          ),
        ),
        // podcast name & publisher
        Positioned(
          right: context.width * 0.02,
          left: context.width * 0.02,
          bottom: context.height * 0.02,
          child: Column(
            children: [
              AnimatedTextKit(
                animatedTexts: [
                  TypewriterAnimatedText(
                    textAlign: TextAlign.center,
                    podcastTitle,
                    textStyle: TextStyleHelper.font24WhiteBold.copyWith(
                      color: Colors.white,
                    ),
                    speed: const Duration(milliseconds: 100),
                  ),
                ],
                stopPauseOnTap : true,
                totalRepeatCount: 1
                ),

              SizedBox(height: context.height * 0.01),
              Text(
                podcastPublisher,
                textAlign: TextAlign.center,
                style: TextStyleHelper.font18WhiteBold.copyWith(
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
