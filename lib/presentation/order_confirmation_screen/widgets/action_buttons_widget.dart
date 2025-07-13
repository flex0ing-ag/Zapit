import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class ActionButtonsWidget extends StatelessWidget {
  final VoidCallback onTrackOrder;
  final VoidCallback onReorder;
  final VoidCallback onShareOrder;

  const ActionButtonsWidget({
    super.key,
    required this.onTrackOrder,
    required this.onReorder,
    required this.onShareOrder,
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
          Text(
            'Quick Actions',
            style: AppTheme.lightTheme.textTheme.titleLarge,
          ),

          SizedBox(height: 3.h),

          // Primary Action - Track Order
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: onTrackOrder,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primaryOrange,
                foregroundColor: AppTheme.pureWhite,
                padding: EdgeInsets.symmetric(vertical: 4.w),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 2,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomIconWidget(
                    iconName: 'track_changes',
                    color: AppTheme.pureWhite,
                    size: 20,
                  ),
                  SizedBox(width: 2.w),
                  Text(
                    'Track Order',
                    style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                      color: AppTheme.pureWhite,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),

          SizedBox(height: 2.h),

          // Secondary Actions Row
          Row(
            children: [
              // Reorder Button
              Expanded(
                child: OutlinedButton(
                  onPressed: onReorder,
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppTheme.primaryOrange,
                    side: BorderSide(
                      color: AppTheme.primaryOrange,
                      width: 1.5,
                    ),
                    padding: EdgeInsets.symmetric(vertical: 3.w),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomIconWidget(
                        iconName: 'refresh',
                        color: AppTheme.primaryOrange,
                        size: 18,
                      ),
                      SizedBox(width: 2.w),
                      Text(
                        'Reorder',
                        style:
                            AppTheme.lightTheme.textTheme.titleSmall?.copyWith(
                          color: AppTheme.primaryOrange,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(width: 3.w),

              // Share Button
              Expanded(
                child: OutlinedButton(
                  onPressed: onShareOrder,
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppTheme.secondaryGray,
                    side: BorderSide(
                      color: AppTheme.lightBorder,
                      width: 1.5,
                    ),
                    padding: EdgeInsets.symmetric(vertical: 3.w),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomIconWidget(
                        iconName: 'share',
                        color: AppTheme.secondaryGray,
                        size: 18,
                      ),
                      SizedBox(width: 2.w),
                      Text(
                        'Share',
                        style:
                            AppTheme.lightTheme.textTheme.titleSmall?.copyWith(
                          color: AppTheme.secondaryGray,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 2.h),

          // Additional Action Buttons
          Row(
            children: [
              // Rate Order Button
              Expanded(
                child: TextButton(
                  onPressed: () {
                    _showRatingDialog(context);
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: AppTheme.successGreen,
                    padding: EdgeInsets.symmetric(vertical: 2.w),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomIconWidget(
                        iconName: 'star',
                        color: AppTheme.successGreen,
                        size: 16,
                      ),
                      SizedBox(width: 2.w),
                      Text(
                        'Rate Order',
                        style:
                            AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                          color: AppTheme.successGreen,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Report Issue Button
              Expanded(
                child: TextButton(
                  onPressed: () {
                    _showReportDialog(context);
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: AppTheme.alertRed,
                    padding: EdgeInsets.symmetric(vertical: 2.w),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomIconWidget(
                        iconName: 'report_problem',
                        color: AppTheme.alertRed,
                        size: 16,
                      ),
                      SizedBox(width: 2.w),
                      Text(
                        'Report Issue',
                        style:
                            AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                          color: AppTheme.alertRed,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showRatingDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Rate Your Order',
            style: AppTheme.lightTheme.textTheme.titleLarge,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'How was your experience with this order?',
                style: AppTheme.lightTheme.textTheme.bodyMedium,
              ),
              SizedBox(height: 2.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(5, (index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content:
                              Text('Thank you for rating ${index + 1} stars!'),
                          backgroundColor: AppTheme.successGreen,
                        ),
                      );
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 1.w),
                      child: CustomIconWidget(
                        iconName: 'star_border',
                        color: AppTheme.primaryOrange,
                        size: 8.w,
                      ),
                    ),
                  );
                }),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  void _showReportDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Report an Issue',
            style: AppTheme.lightTheme.textTheme.titleLarge,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'What issue would you like to report?',
                style: AppTheme.lightTheme.textTheme.bodyMedium,
              ),
              SizedBox(height: 2.h),
              TextField(
                maxLines: 3,
                decoration: InputDecoration(
                  hintText: 'Describe the issue...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                        'Issue reported successfully. We will look into it.'),
                    backgroundColor: AppTheme.successGreen,
                  ),
                );
              },
              child: Text('Submit'),
            ),
          ],
        );
      },
    );
  }
}
