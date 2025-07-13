import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class OrderStatsWidget extends StatelessWidget {
  final List<Map<String, dynamic>> orders;

  const OrderStatsWidget({
    super.key,
    required this.orders,
  });

  @override
  Widget build(BuildContext context) {
    final totalOrders = orders.length;
    final favoriteCanteen = _getFavoriteCanteen();
    final totalSpent = _getTotalSpent();

    return Container(
      margin: EdgeInsets.all(4.w),
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: AppTheme.lightTheme.cardColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: AppTheme.lightTheme.colorScheme.shadow,
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: _buildStatItem(
              icon: 'receipt_long',
              value: totalOrders.toString(),
              label: 'Total Orders',
            ),
          ),
          Container(
            width: 1,
            height: 8.h,
            color:
                AppTheme.lightTheme.colorScheme.outline.withValues(alpha: 0.3),
          ),
          Expanded(
            child: _buildStatItem(
              icon: 'restaurant',
              value: favoriteCanteen,
              label: 'Favorite Canteen',
            ),
          ),
          Container(
            width: 1,
            height: 8.h,
            color:
                AppTheme.lightTheme.colorScheme.outline.withValues(alpha: 0.3),
          ),
          Expanded(
            child: _buildStatItem(
              icon: 'account_balance_wallet',
              value: totalSpent,
              label: 'Total Spent',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem({
    required String icon,
    required String value,
    required String label,
  }) {
    return Column(
      children: [
        CustomIconWidget(
          iconName: icon,
          color: AppTheme.lightTheme.colorScheme.primary,
          size: 24,
        ),
        SizedBox(height: 1.h),
        Text(
          value,
          style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
            color: AppTheme.lightTheme.colorScheme.onSurface,
          ),
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        SizedBox(height: 0.5.h),
        Text(
          label,
          style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
            color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
          ),
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  String _getFavoriteCanteen() {
    if (orders.isEmpty) return 'None';

    final canteenCounts = <String, int>{};
    for (final order in orders) {
      final canteen = order['canteenName'] as String;
      canteenCounts[canteen] = (canteenCounts[canteen] ?? 0) + 1;
    }

    String favorite = canteenCounts.keys.first;
    int maxCount = canteenCounts[favorite]!;

    for (final entry in canteenCounts.entries) {
      if (entry.value > maxCount) {
        favorite = entry.key;
        maxCount = entry.value;
      }
    }

    // Shorten long canteen names
    if (favorite.length > 12) {
      return '${favorite.substring(0, 9)}...';
    }

    return favorite;
  }

  String _getTotalSpent() {
    if (orders.isEmpty) return '\$0.00';

    double total = 0.0;
    for (final order in orders) {
      final amountString = order['totalAmount'] as String;
      final amount = double.tryParse(amountString.replaceAll('\$', '')) ?? 0.0;
      total += amount;
    }

    return '\$${total.toStringAsFixed(2)}';
  }
}
