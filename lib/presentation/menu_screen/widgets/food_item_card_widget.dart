import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class FoodItemCardWidget extends StatelessWidget {
  final Map<String, dynamic> item;
  final Function(int, int) onQuantityChanged;
  final VoidCallback onTap;

  const FoodItemCardWidget({
    super.key,
    required this.item,
    required this.onQuantityChanged,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final bool isAvailable = item['isAvailable'] as bool;
    final bool isVeg = item['isVeg'] as bool;
    final int quantity = item['quantity'] as int;
    final int itemId = item['id'] as int;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(4.w),
        decoration: BoxDecoration(
          color: AppTheme.lightTheme.cardColor,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: AppTheme.shadowLight,
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Stack(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Food image
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: CustomImageWidget(
                        imageUrl: item['image'] as String,
                        width: 25.w,
                        height: 25.w,
                        fit: BoxFit.cover,
                      ),
                    ),

                    // Veg/Non-veg indicator
                    Positioned(
                      top: 2.w,
                      left: 2.w,
                      child: Container(
                        padding: EdgeInsets.all(1.w),
                        decoration: BoxDecoration(
                          color: AppTheme.pureWhite,
                          borderRadius: BorderRadius.circular(4),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.1),
                              blurRadius: 4,
                              offset: const Offset(0, 1),
                            ),
                          ],
                        ),
                        child: Container(
                          width: 3.w,
                          height: 3.w,
                          decoration: BoxDecoration(
                            color: isVeg
                                ? AppTheme.successGreen
                                : AppTheme.alertRed,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ),

                    // Out of stock overlay
                    if (!isAvailable)
                      Positioned.fill(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.black.withValues(alpha: 0.6),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Center(
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 2.w,
                                vertical: 0.5.h,
                              ),
                              decoration: BoxDecoration(
                                color: AppTheme.alertRed,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                'Out of Stock',
                                style: AppTheme.lightTheme.textTheme.labelSmall
                                    ?.copyWith(
                                  color: AppTheme.pureWhite,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),

                SizedBox(width: 4.w),

                // Food details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Food name
                      Text(
                        item['name'] as String,
                        style:
                            AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: isAvailable
                              ? AppTheme.textCharcoal
                              : AppTheme.secondaryGray,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),

                      SizedBox(height: 1.h),

                      // Price and prep time
                      Row(
                        children: [
                          Text(
                            item['price'] as String,
                            style: AppTheme.lightTheme.textTheme.titleMedium
                                ?.copyWith(
                              color: isAvailable
                                  ? AppTheme.primaryOrange
                                  : AppTheme.secondaryGray,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const Spacer(),
                          CustomIconWidget(
                            iconName: 'access_time',
                            color: isAvailable
                                ? AppTheme.secondaryGray
                                : AppTheme.lightBorder,
                            size: 14,
                          ),
                          SizedBox(width: 1.w),
                          Text(
                            item['prepTime'] as String,
                            style: AppTheme.lightTheme.textTheme.bodySmall
                                ?.copyWith(
                              color: isAvailable
                                  ? AppTheme.secondaryGray
                                  : AppTheme.lightBorder,
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 1.h),

                      // Rating
                      Row(
                        children: [
                          CustomIconWidget(
                            iconName: 'star',
                            color: Colors.amber,
                            size: 16,
                          ),
                          SizedBox(width: 1.w),
                          Text(
                            item['rating'].toString(),
                            style: AppTheme.lightTheme.textTheme.bodySmall
                                ?.copyWith(
                              fontWeight: FontWeight.w500,
                              color: isAvailable
                                  ? AppTheme.textCharcoal
                                  : AppTheme.secondaryGray,
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 2.h),

                      // Quantity picker
                      if (isAvailable)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            if (quantity == 0)
                              ElevatedButton(
                                onPressed: () => onQuantityChanged(itemId, 1),
                                style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 4.w,
                                    vertical: 1.h,
                                  ),
                                  minimumSize: Size(0, 5.h),
                                ),
                                child: Text(
                                  'Add',
                                  style: AppTheme
                                      .lightTheme.textTheme.labelMedium
                                      ?.copyWith(
                                    color: AppTheme.pureWhite,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              )
                            else
                              Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: AppTheme.primaryOrange,
                                    width: 1.5,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    GestureDetector(
                                      onTap: () =>
                                          onQuantityChanged(itemId, -1),
                                      child: Container(
                                        padding: EdgeInsets.all(2.w),
                                        child: CustomIconWidget(
                                          iconName: 'remove',
                                          color: AppTheme.primaryOrange,
                                          size: 18,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 3.w),
                                      child: Text(
                                        quantity.toString(),
                                        style: AppTheme
                                            .lightTheme.textTheme.titleMedium
                                            ?.copyWith(
                                          color: AppTheme.primaryOrange,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () => onQuantityChanged(itemId, 1),
                                      child: Container(
                                        padding: EdgeInsets.all(2.w),
                                        child: CustomIconWidget(
                                          iconName: 'add',
                                          color: AppTheme.primaryOrange,
                                          size: 18,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                          ],
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
