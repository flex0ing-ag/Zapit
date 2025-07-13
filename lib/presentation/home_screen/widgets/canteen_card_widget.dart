import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class CanteenCardWidget extends StatelessWidget {
  final Map<String, dynamic> canteen;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;

  const CanteenCardWidget({
    super.key,
    required this.canteen,
    this.onTap,
    this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    final bool isOpen = canteen["isOpen"] ?? false;

    return GestureDetector(
      onTap: onTap,
      onLongPress: onLongPress,
      child: Container(
        decoration: BoxDecoration(
          color: AppTheme.pureWhite,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: AppTheme.shadowLight,
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hero Image Section
            Stack(
              children: [
                ClipRRect(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(16)),
                  child: CustomImageWidget(
                    imageUrl: canteen["heroImage"] ?? "",
                    width: double.infinity,
                    height: 20.h,
                    fit: BoxFit.cover,
                  ),
                ),
                // Status overlay
                Positioned(
                  top: 3.w,
                  right: 3.w,
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.w),
                    decoration: BoxDecoration(
                      color: isOpen ? AppTheme.successGreen : AppTheme.alertRed,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      isOpen ? 'OPEN' : 'CLOSED',
                      style: AppTheme.lightTheme.textTheme.labelSmall?.copyWith(
                        color: AppTheme.pureWhite,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                // Rating badge
                Positioned(
                  top: 3.w,
                  left: 3.w,
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.w),
                    decoration: BoxDecoration(
                      color: AppTheme.textCharcoal.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CustomIconWidget(
                          iconName: 'star',
                          color: Colors.amber,
                          size: 12,
                        ),
                        SizedBox(width: 1.w),
                        Text(
                          canteen["rating"]?.toString() ?? "0.0",
                          style: AppTheme.lightTheme.textTheme.labelSmall
                              ?.copyWith(
                            color: AppTheme.pureWhite,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // Favorite badge (optional enhancement from code 2)
                if (canteen['isFavorite'] == true)
                  Positioned(
                    bottom: 3.w,
                    right: 3.w,
                    child: Container(
                      padding: EdgeInsets.all(1.5.w),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.9),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: CustomIconWidget(
                        iconName: 'favorite',
                        color: AppTheme.lightTheme.colorScheme.error,
                        size: 16,
                      ),
                    ),
                  ),
              ],
            ),

            // Content Section
            Padding(
              padding: EdgeInsets.all(4.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Canteen name and food type indicators
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          canteen["name"] ?? "Unknown Canteen",
                          style: AppTheme.lightTheme.textTheme.titleLarge
                              ?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Row(
                        children: [
                          if (canteen["isVeg"] == true)
                            _buildFoodTypeDot(AppTheme.successGreen),
                          if (canteen["isNonVeg"] == true)
                            _buildFoodTypeDot(AppTheme.alertRed),
                        ],
                      ),
                    ],
                  ),

                  SizedBox(height: 1.h),

                  // Speciality
                  Text(
                    canteen["specialty"] ?? "",
                    style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                      color: AppTheme.secondaryGray,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),

                  SizedBox(height: 2.h),

                  // Operating hours and wait time
                  Row(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            CustomIconWidget(
                              iconName: 'access_time',
                              color: AppTheme.secondaryGray,
                              size: 16,
                            ),
                            SizedBox(width: 2.w),
                            Expanded(
                              child: Text(
                                '${canteen["openTime"]} - ${canteen["closeTime"]}',
                                style: AppTheme.lightTheme.textTheme.bodySmall
                                    ?.copyWith(
                                  color: AppTheme.secondaryGray,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 3.w, vertical: 1.w),
                        decoration: BoxDecoration(
                          color: isOpen
                              ? AppTheme.softOrange
                              : AppTheme.lightBorder,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          canteen["estimatedWaitTime"] ?? "N/A",
                          style: AppTheme.lightTheme.textTheme.labelSmall
                              ?.copyWith(
                            color: isOpen
                                ? AppTheme.primaryOrange
                                : AppTheme.secondaryGray,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 2.h),

                  // Total orders info
                  Row(
                    children: [
                      CustomIconWidget(
                        iconName: 'shopping_bag',
                        color: AppTheme.secondaryGray,
                        size: 16,
                      ),
                      SizedBox(width: 2.w),
                      Text(
                        '${canteen["totalOrders"]} orders completed',
                        style:
                            AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                          color: AppTheme.secondaryGray,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFoodTypeDot(Color color) {
    return Container(
      margin: EdgeInsets.only(left: 2.w),
      padding: EdgeInsets.all(1.w),
      decoration: BoxDecoration(
        border: Border.all(color: color, width: 2),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Container(
        width: 2.w,
        height: 2.w,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(2),
        ),
      ),
    );
  }
}
