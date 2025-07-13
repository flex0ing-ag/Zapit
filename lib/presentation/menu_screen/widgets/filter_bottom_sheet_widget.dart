import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';
import '../../../theme/app_theme.dart';

class FilterBottomSheetWidget extends StatefulWidget {
  final Function(Map<String, dynamic>) onApplyFilters;

  const FilterBottomSheetWidget({
    super.key,
    required this.onApplyFilters,
  });

  @override
  State<FilterBottomSheetWidget> createState() =>
      _FilterBottomSheetWidgetState();
}

class _FilterBottomSheetWidgetState extends State<FilterBottomSheetWidget> {
  bool vegOnly = false;
  bool nonVegOnly = false;
  bool availableOnly = true;
  RangeValues priceRange = const RangeValues(0, 50);
  RangeValues prepTimeRange = const RangeValues(0, 30);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80.h,
      decoration: BoxDecoration(
        color: AppTheme.lightTheme.scaffoldBackgroundColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          // Handle bar
          Container(
            margin: EdgeInsets.only(top: 2.h),
            width: 12.w,
            height: 0.5.h,
            decoration: BoxDecoration(
              color: AppTheme.lightBorder,
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          // Header
          Padding(
            padding: EdgeInsets.all(4.w),
            child: Row(
              children: [
                Text(
                  'Filter Options',
                  style: AppTheme.lightTheme.textTheme.headlineSmall,
                ),
                const Spacer(),
                TextButton(
                  onPressed: () {
                    setState(() {
                      vegOnly = false;
                      nonVegOnly = false;
                      availableOnly = true;
                      priceRange = const RangeValues(0, 50);
                      prepTimeRange = const RangeValues(0, 30);
                    });
                  },
                  child: Text(
                    'Clear All',
                    style: AppTheme.lightTheme.textTheme.labelLarge?.copyWith(
                      color: AppTheme.primaryOrange,
                    ),
                  ),
                ),
              ],
            ),
          ),

          Divider(color: AppTheme.lightBorder),

          // Filter content
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(4.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Dietary preferences
                  Text(
                    'Dietary Preferences',
                    style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 2.h),

                  CheckboxListTile(
                    title: Row(
                      children: [
                        Container(
                          width: 4.w,
                          height: 4.w,
                          decoration: BoxDecoration(
                            color: AppTheme.successGreen,
                            shape: BoxShape.circle,
                          ),
                        ),
                        SizedBox(width: 2.w),
                        Text(
                          'Vegetarian Only',
                          style: AppTheme.lightTheme.textTheme.bodyMedium,
                        ),
                      ],
                    ),
                    value: vegOnly,
                    onChanged: (value) {
                      setState(() {
                        vegOnly = value ?? false;
                        if (vegOnly) nonVegOnly = false;
                      });
                    },
                    contentPadding: EdgeInsets.zero,
                  ),

                  CheckboxListTile(
                    title: Row(
                      children: [
                        Container(
                          width: 4.w,
                          height: 4.w,
                          decoration: BoxDecoration(
                            color: AppTheme.alertRed,
                            shape: BoxShape.circle,
                          ),
                        ),
                        SizedBox(width: 2.w),
                        Text(
                          'Non-Vegetarian Only',
                          style: AppTheme.lightTheme.textTheme.bodyMedium,
                        ),
                      ],
                    ),
                    value: nonVegOnly,
                    onChanged: (value) {
                      setState(() {
                        nonVegOnly = value ?? false;
                        if (nonVegOnly) vegOnly = false;
                      });
                    },
                    contentPadding: EdgeInsets.zero,
                  ),

                  CheckboxListTile(
                    title: Text(
                      'Available Items Only',
                      style: AppTheme.lightTheme.textTheme.bodyMedium,
                    ),
                    value: availableOnly,
                    onChanged: (value) {
                      setState(() {
                        availableOnly = value ?? false;
                      });
                    },
                    contentPadding: EdgeInsets.zero,
                  ),

                  SizedBox(height: 3.h),

                  // Price range
                  Text(
                    'Price Range',
                    style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 1.h),

                  Text(
                    '\$${priceRange.start.round()} - \$${priceRange.end.round()}',
                    style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                      color: AppTheme.primaryOrange,
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                  RangeSlider(
                    values: priceRange,
                    min: 0,
                    max: 50,
                    divisions: 10,
                    labels: RangeLabels(
                      '\$${priceRange.start.round()}',
                      '\$${priceRange.end.round()}',
                    ),
                    onChanged: (values) {
                      setState(() {
                        priceRange = values;
                      });
                    },
                  ),

                  SizedBox(height: 3.h),

                  // Preparation time
                  Text(
                    'Preparation Time',
                    style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 1.h),

                  Text(
                    '${prepTimeRange.start.round()} - ${prepTimeRange.end.round()} minutes',
                    style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                      color: AppTheme.primaryOrange,
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                  RangeSlider(
                    values: prepTimeRange,
                    min: 0,
                    max: 60,
                    divisions: 12,
                    labels: RangeLabels(
                      '${prepTimeRange.start.round()}m',
                      '${prepTimeRange.end.round()}m',
                    ),
                    onChanged: (values) {
                      setState(() {
                        prepTimeRange = values;
                      });
                    },
                  ),
                ],
              ),
            ),
          ),

          // Apply button
          Padding(
            padding: EdgeInsets.all(4.w),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  final filters = {
                    'vegOnly': vegOnly,
                    'nonVegOnly': nonVegOnly,
                    'availableOnly': availableOnly,
                    'priceRange': priceRange,
                    'prepTimeRange': prepTimeRange,
                  };
                  widget.onApplyFilters(filters);
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 2.h),
                ),
                child: Text(
                  'Apply Filters',
                  style: AppTheme.lightTheme.textTheme.labelLarge?.copyWith(
                    color: AppTheme.pureWhite,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
