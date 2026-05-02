 import 'package:flutter/material.dart';
import 'package:movies/core/helper/responsive.dart';
import 'package:movies/core/theme/app_colors.dart';
import 'package:movies/core/theme/app_text_theme.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});
  static const String routeName = "/SearchScreen";

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title
              Text(
                "Search",
                style: TextStyleHelper.font24WhiteBold,
              ),
              SizedBox(height: context.height * 0.02),

              // Search Field
              TextField(
                controller: _searchController,
                style: const TextStyle(color: Colors.white),
                onChanged: (value) {
                  setState(() {
                    _searchQuery = value;
                  });
                },
                decoration: InputDecoration(
                  hintText: "Search for podcasts...",
                  hintStyle: TextStyle(color: Colors.grey[500]),
                  prefixIcon: const Icon(Icons.search, color: AppColors.gold),
                  suffixIcon: _searchQuery.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear, color: AppColors.gray),
                          onPressed: () {
                            _searchController.clear();
                            setState(() {
                              _searchQuery = '';
                            });
                          },
                        )
                      : null,
                  filled: true,
                  fillColor: AppColors.blackOne,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(color: AppColors.blackFour, width: 1),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(color: AppColors.gold, width: 1.5),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                ),
              ),

              SizedBox(height: context.height * 0.04),

              // Results / Empty State
              Expanded(
                child: _searchQuery.isEmpty
                    ? _buildEmptyState(context)
                    : _buildSearchPlaceholder(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.podcasts,
            size: 80,
            color: AppColors.gold.withOpacity(0.4),
          ),
          SizedBox(height: context.height * 0.02),
          Text(
            "Discover Podcasts",
            style: TextStyleHelper.font18WhiteBold,
          ),
          SizedBox(height: context.height * 0.01),
          Text(
            "Search by title, author, or category",
            style: TextStyleHelper.font14GreyRegular,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildSearchPlaceholder(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search_off,
            size: 60,
            color: AppColors.gray.withOpacity(0.5),
          ),
          SizedBox(height: context.height * 0.02),
          Text(
            "Searching for \"$_searchQuery\"...",
            style: TextStyleHelper.font16WhiteBold,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: context.height * 0.01),
          Text(
            "Search results will appear here",
            style: TextStyleHelper.font14GreyRegular,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
