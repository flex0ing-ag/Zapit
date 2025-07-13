import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class OrderSummaryWidget extends StatelessWidget {
  final Map<String, dynamic> orderData;

  const OrderSummaryWidget({
    super.key,
    required this.orderData,
  });

  @override
  Widget build(BuildContext context) {
    final List<dynamic> items = orderData['items'] ?? [];
    final double totalAmount = orderData['totalAmount'] ?? 0.0;
    final String pickupTime = orderData['pickupTime'] ?? '';
    final String canteenName = orderData['canteenName'] ?? '';

    return Container(
      width: double.infinity,
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              CustomIconWidget(
                iconName: 'receipt_long',
                color: AppTheme.primaryOrange,
                size: 24,
              ),
              SizedBox(width: 3.w),
              Text(
                'Order Summary',
                style: AppTheme.lightTheme.textTheme.titleLarge,
              ),
            ],
          ),

          SizedBox(height: 2.h),

          // Canteen Name
          Container(
            padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
            decoration: BoxDecoration(
              color: AppTheme.softOrange,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                CustomIconWidget(
                  iconName: 'store',
                  color: AppTheme.primaryOrange,
                  size: 18,
                ),
                SizedBox(width: 2.w),
                Text(
                  canteenName,
                  style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                    color: AppTheme.primaryOrange,
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 2.h),

          // Items List
          ...items.map<Widget>((item) => _buildOrderItem(item)),

          SizedBox(height: 2.h),

          // Divider
          Divider(
            color: AppTheme.lightBorder,
            thickness: 1,
          ),

          SizedBox(height: 1.h),

          // Total Amount
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total Amount',
                style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '\$${totalAmount.toStringAsFixed(2)}',
                style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                  color: AppTheme.primaryOrange,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          SizedBox(height: 2.h),

          // Pickup Time
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(3.w),
            decoration: BoxDecoration(
              color: AppTheme.warmGray,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: AppTheme.lightBorder,
                width: 1,
              ),
            ),
            child: Row(
              children: [
                CustomIconWidget(
                  iconName: 'schedule',
                  color: AppTheme.successGreen,
                  size: 20,
                ),
                SizedBox(width: 3.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Pickup Time',
                      style: AppTheme.lightTheme.textTheme.bodySmall,
                    ),
                    Text(
                      pickupTime,
                      style:
                          AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                        color: AppTheme.successGreen,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderItem(Map<String, dynamic> item) {
    final String name = item['name'] ?? '';
    final int quantity = item['quantity'] ?? 0;
    final double price = item['price'] ?? 0.0;
    final bool isVeg = item['isVeg'] ?? true;

    return Padding(
      padding: EdgeInsets.only(bottom: 1.5.h),
      child: Row(
        children: [
          // Veg/Non-veg Indicator
          Container(
            width: 5.w,
            height: 5.w,
            decoration: BoxDecoration(
              border: Border.all(
                color: isVeg ? AppTheme.successGreen : AppTheme.alertRed,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(2),
            ),
            child: Center(
              child: Container(
                width: 2.w,
                height: 2.w,
                decoration: BoxDecoration(
                  color: isVeg ? AppTheme.successGreen : AppTheme.alertRed,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),

          SizedBox(width: 3.w),

          // Item Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: AppTheme.lightTheme.textTheme.titleMedium,
                ),
                Text(
                  'Qty: $quantity',
                  style: AppTheme.lightTheme.textTheme.bodySmall,
                ),
              ],
            ),
          ),

          // Price
          Text(
            '\$${(price * quantity).toStringAsFixed(2)}',
            style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
