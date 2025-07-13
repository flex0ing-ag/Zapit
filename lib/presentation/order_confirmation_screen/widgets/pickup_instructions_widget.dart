import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class PickupInstructionsWidget extends StatelessWidget {
  final String canteenLocation;
  final String tokenNumber;

  const PickupInstructionsWidget({
    super.key,
    required this.canteenLocation,
    required this.tokenNumber,
  });

  @override
  Widget build(BuildContext context) {
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
                iconName: 'info',
                color: AppTheme.primaryOrange,
                size: 24,
              ),
              SizedBox(width: 3.w),
              Text(
                'Pickup Instructions',
                style: AppTheme.lightTheme.textTheme.titleLarge,
              ),
            ],
          ),

          SizedBox(height: 3.h),

          // Location Card
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
                  iconName: 'location_on',
                  color: AppTheme.primaryOrange,
                  size: 20,
                ),
                SizedBox(width: 3.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Pickup Location',
                        style: AppTheme.lightTheme.textTheme.bodySmall,
                      ),
                      Text(
                        canteenLocation,
                        style:
                            AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 2.h),

          // Instructions List
          _buildInstructionItem(
            icon: 'schedule',
            title: 'Arrive on Time',
            description:
                'Please arrive at your scheduled pickup time to ensure food quality',
            color: AppTheme.successGreen,
          ),

          SizedBox(height: 1.5.h),

          _buildInstructionItem(
            icon: 'confirmation_number',
            title: 'Show Your Token',
            description: 'Present token $tokenNumber to the counter staff',
            color: AppTheme.primaryOrange,
          ),

          SizedBox(height: 1.5.h),

          _buildInstructionItem(
            icon: 'payment',
            title: 'Payment Completed',
            description:
                'Your payment has been processed. No additional payment required',
            color: AppTheme.successGreen,
          ),

          SizedBox(height: 1.5.h),

          _buildInstructionItem(
            icon: 'help',
            title: 'Need Help?',
            description:
                'Contact canteen staff if you have any questions or issues',
            color: AppTheme.secondaryGray,
          ),

          SizedBox(height: 2.h),

          // Important Note
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(3.w),
            decoration: BoxDecoration(
              color: AppTheme.alertRed.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: AppTheme.alertRed.withValues(alpha: 0.3),
                width: 1,
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomIconWidget(
                  iconName: 'warning',
                  color: AppTheme.alertRed,
                  size: 20,
                ),
                SizedBox(width: 3.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Important Note',
                        style:
                            AppTheme.lightTheme.textTheme.titleSmall?.copyWith(
                          color: AppTheme.alertRed,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 0.5.h),
                      Text(
                        'Orders not collected within 30 minutes of pickup time may be cancelled. Please arrive on time to avoid disappointment.',
                        style:
                            AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                          color: AppTheme.alertRed,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInstructionItem({
    required String icon,
    required String title,
    required String description,
    required Color color,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 10.w,
          height: 10.w,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: CustomIconWidget(
              iconName: icon,
              color: color,
              size: 5.w,
            ),
          ),
        ),
        SizedBox(width: 3.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 0.5.h),
              Text(
                description,
                style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                  color: AppTheme.secondaryGray,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
