import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class ActionButtonsWidget extends StatelessWidget {
  final VoidCallback onGetDirections;
  final VoidCallback onCallCanteen;
  final VoidCallback onReportIssue;
  final VoidCallback onReorderItems;
  final VoidCallback onRateExperience;

  const ActionButtonsWidget({
    super.key,
    required this.onGetDirections,
    required this.onCallCanteen,
    required this.onReportIssue,
    required this.onReorderItems,
    required this.onRateExperience,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Primary Action Buttons
        Row(
          children: [
            Expanded(
              child: ElevatedButton.icon(
                onPressed: onGetDirections,
                icon: CustomIconWidget(
                  iconName: 'directions',
                  color: AppTheme.pureWhite,
                  size: 20,
                ),
                label: const Text('Get Directions'),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 2.h),
                ),
              ),
            ),
            SizedBox(width: 3.w),
            Expanded(
              child: OutlinedButton.icon(
                onPressed: onCallCanteen,
                icon: CustomIconWidget(
                  iconName: 'phone',
                  color: AppTheme.primaryOrange,
                  size: 20,
                ),
                label: const Text('Call Canteen'),
                style: OutlinedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 2.h),
                ),
              ),
            ),
          ],
        ),

        SizedBox(height: 2.h),

        // Secondary Action Button
        SizedBox(
          width: double.infinity,
          child: TextButton.icon(
            onPressed: onReportIssue,
            icon: CustomIconWidget(
              iconName: 'report_problem',
              color: AppTheme.alertRed,
              size: 20,
            ),
            label: const Text('Report Issue'),
            style: TextButton.styleFrom(
              foregroundColor: AppTheme.alertRed,
              padding: EdgeInsets.symmetric(vertical: 1.5.h),
            ),
          ),
        ),

        SizedBox(height: 3.h),

        // Bottom Action Buttons
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(4.w),
          decoration: BoxDecoration(
            color: AppTheme.warmGray,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              Text(
                'Quick Actions',
                style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 2.h),
              Row(
                children: [
                  Expanded(
                    child: _buildQuickActionCard(
                      icon: 'refresh',
                      title: 'Reorder Items',
                      subtitle: 'Order the same items again',
                      onTap: onReorderItems,
                      color: AppTheme.primaryOrange,
                    ),
                  ),
                  SizedBox(width: 3.w),
                  Expanded(
                    child: _buildQuickActionCard(
                      icon: 'star_rate',
                      title: 'Rate Experience',
                      subtitle: 'Share your feedback',
                      onTap: onRateExperience,
                      color: AppTheme.successGreen,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildQuickActionCard({
    required String icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    required Color color,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(3.w),
        decoration: BoxDecoration(
          color: AppTheme.pureWhite,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: color.withValues(alpha: 0.3),
            width: 1,
          ),
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(2.w),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: CustomIconWidget(
                iconName: icon,
                color: color,
                size: 24,
              ),
            ),
            SizedBox(height: 1.h),
            Text(
              title,
              style: AppTheme.lightTheme.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 0.5.h),
            Text(
              subtitle,
              style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                color: AppTheme.secondaryGray,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
