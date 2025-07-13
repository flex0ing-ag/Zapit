import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class OrderTimelineWidget extends StatelessWidget {
  final List<Map<String, dynamic>> timeline;

  const OrderTimelineWidget({
    super.key,
    required this.timeline,
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
          Text(
            'Order Timeline',
            style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 2.h),
          ...timeline.asMap().entries.map((entry) {
            final int index = entry.key;
            final Map<String, dynamic> item = entry.value;
            final bool isLast = index == timeline.length - 1;

            return _buildTimelineItem(
              item: item,
              isLast: isLast,
            );
          }),
        ],
      ),
    );
  }

  Widget _buildTimelineItem({
    required Map<String, dynamic> item,
    required bool isLast,
  }) {
    final bool completed = item["completed"] as bool;
    final String status = item["status"] as String;
    final String time = item["time"] as String? ?? "";
    final String description = item["description"] as String;
    final String? estimated = item["estimated"] as String?;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                color: completed ? AppTheme.successGreen : AppTheme.lightBorder,
                shape: BoxShape.circle,
                border: Border.all(
                  color: completed
                      ? AppTheme.successGreen
                      : AppTheme.secondaryGray,
                  width: 2,
                ),
              ),
              child: completed
                  ? CustomIconWidget(
                      iconName: 'check',
                      color: AppTheme.pureWhite,
                      size: 12,
                    )
                  : null,
            ),
            if (!isLast)
              Container(
                width: 2,
                height: 40,
                color: completed ? AppTheme.successGreen : AppTheme.lightBorder,
              ),
          ],
        ),
        SizedBox(width: 3.w),
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(bottom: isLast ? 0 : 2.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        status,
                        style:
                            AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: completed
                              ? AppTheme.textCharcoal
                              : AppTheme.secondaryGray,
                        ),
                      ),
                    ),
                    if (time.isNotEmpty)
                      Text(
                        time,
                        style:
                            AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                          color: AppTheme.secondaryGray,
                        ),
                      ),
                  ],
                ),
                SizedBox(height: 0.5.h),
                Text(
                  description,
                  style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                    color: AppTheme.secondaryGray,
                  ),
                ),
                if (estimated != null && !completed) ...[
                  SizedBox(height: 0.5.h),
                  Text(
                    'Estimated: $estimated',
                    style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                      color: AppTheme.primaryOrange,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ],
    );
  }
}
