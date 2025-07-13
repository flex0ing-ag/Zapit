import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';
import '../../../theme/app_theme.dart';

class CategoryTabWidget extends StatelessWidget {
  final TabController tabController;
  final List<String> categories;
  final String selectedCategory;

  const CategoryTabWidget({
    super.key,
    required this.tabController,
    required this.categories,
    required this.selectedCategory,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 1.h),
      decoration: BoxDecoration(
        color: AppTheme.lightTheme.scaffoldBackgroundColor,
        border: Border(
          bottom: BorderSide(
            color: AppTheme.lightBorder,
            width: 1,
          ),
        ),
      ),
      child: TabBar(
        controller: tabController,
        isScrollable: true,
        tabAlignment: TabAlignment.start,
        indicator: BoxDecoration(
          color: AppTheme.primaryOrange,
          borderRadius: BorderRadius.circular(25),
        ),
        indicatorSize: TabBarIndicatorSize.tab,
        indicatorPadding:
            EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.5.h),
        labelColor: AppTheme.pureWhite,
        unselectedLabelColor: AppTheme.secondaryGray,
        labelStyle: AppTheme.lightTheme.textTheme.labelLarge?.copyWith(
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle:
            AppTheme.lightTheme.textTheme.labelLarge?.copyWith(
          fontWeight: FontWeight.w400,
        ),
        tabs: categories.map((category) {
          return Tab(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
              child: Text(category),
            ),
          );
        }).toList(),
      ),
    );
  }
}
