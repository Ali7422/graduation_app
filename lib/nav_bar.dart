
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:movies/core/helper/responsive.dart';

import 'core/theme/app_colors.dart';
import 'features/home_feature/presentation/browse_tab/browes_tab.dart';
import 'features/home_feature/presentation/home_tab/home_tab.dart';
import 'features/home_feature/presentation/profile_tab/profile_screen.dart';
import 'features/podcast_search/presentation/pages/podcast_search_page.dart';

class HomeNavBar extends StatefulWidget {
  const HomeNavBar({super.key});
static const String routeName = '/homeNavBar';
  @override
  State<HomeNavBar> createState() => _HomeNavBarState();
}

class _HomeNavBarState extends State<HomeNavBar> {
  int selectedIndex = 0;
  String? selectedCategory;

  void navigateToBrowse(String category) {
    setState(() {
      selectedCategory = category;
      selectedIndex = 2;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      HomeTabs(onSeeMore: navigateToBrowse),
      const PodcastSearchPage(),

      BrowseTab(
        selectedCategory: selectedCategory,
        key: ValueKey(selectedCategory),
      ),
      const ProfileScreen(),
    ];

    return Scaffold(
      body: Stack(
        children: [
          pages[selectedIndex],
          Positioned(
            bottom: context.height * 0.02,
            right: context.width * 0.04,
            left: context.width * 0.04,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(context.width * 0.06),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(
                  height: context.height * 0.08,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(context.width * 0.06),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 20,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildNavItem(icon: Icons.home_rounded, index: 0),
                      _buildNavItem(icon: Icons.search_rounded, index: 1),
                      _buildNavItem(icon: Icons.grid_view_rounded, index: 2),
                      _buildNavItem(icon: Icons.person_rounded, index: 3),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem({required IconData icon, required int index}) {
    final isSelected = selectedIndex == index;
    final width = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () => setState(() {
        selectedIndex = index;
        if (index != 2) {
          selectedCategory = null;
        }
      }),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            padding: EdgeInsets.all(width * 0.025),
            decoration: BoxDecoration(
              color: isSelected
                  ? AppColors.gold.withOpacity(0.15)
                  : Colors.transparent,
              shape: BoxShape.circle,
              border: isSelected
                  ? Border.all(
                color: AppColors.gold.withOpacity(0.4),
                width: 1.5,
              )
                  : null,
              boxShadow: isSelected
                  ? [
                BoxShadow(
                  color: AppColors.gold.withOpacity(0.3),
                  blurRadius: 12,
                  spreadRadius: 2,
                ),
              ]
                  : null,
            ),
            child: Icon(
              icon,
              color: isSelected ? AppColors.gold : Colors.white60,
              size: width * 0.06,
            ),
          ),
          SizedBox(height: width * 0.01),
        ],
      ),
    );
  }
}