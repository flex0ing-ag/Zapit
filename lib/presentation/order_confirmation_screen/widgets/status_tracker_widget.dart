import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class StatusTrackerWidget extends StatelessWidget {
  final String currentStatus;
  final List<dynamic> statusHistory;

  const StatusTrackerWidget({
    super.key,
    required this.currentStatus,
    required this.statusHistory,
  });

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> allStatuses = [
      {
        'status': 'Pending',
        'title': 'Order Received',
        'description': 'Your order is being reviewed',
        'icon': 'receipt',
      },
      {
        'status': 'Accepted',
        'title': 'Order Accepted',
        'description': 'Kitchen has accepted your order',
        'icon': 'check_circle',
      },
      {
        'status': 'Preparing',
        'title': 'Preparing',
        'description': 'Your food is being prepared',
        'icon': 'restaurant',
      },
      {
        'status': 'Ready',
        'title': 'Ready for Pickup',
        'description': 'Your order is ready to collect',
        'icon': 'done_all',
      },
    ];

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
                iconName: 'track_changes',
                color: AppTheme.primaryOrange,
                size: 24,
              ),
              SizedBox(width: 3.w),
              Text(
                'Order Status',
                style: AppTheme.lightTheme.textTheme.titleLarge,
              ),
            ],
          ),

          SizedBox(height: 3.h),

          // Status Timeline
          Column(
            children: allStatuses.asMap().entries.map((entry) {
              final int index = entry.key;
              final Map<String, dynamic> status = entry.value;
              final bool isCompleted = _isStatusCompleted(status['status']);
              final bool isCurrent = status['status'] == currentStatus;
              final bool isLast = index == allStatuses.length - 1;

              return _buildStatusItem(
                status: status,
                isCompleted: isCompleted,
                isCurrent: isCurrent,
                isLast: isLast,
                timestamp: _getTimestamp(status['status']),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  bool _isStatusCompleted(String status) {
    final List<String> statusOrder = [
      'Pending',
      'Accepted',
      'Preparing',
      'Ready'
    ];
    final int currentIndex = statusOrder.indexOf(currentStatus);
    final int statusIndex = statusOrder.indexOf(status);

    return statusIndex <= currentIndex;
  }

  String? _getTimestamp(String status) {
    final statusItem = statusHistory.firstWhere(
      (item) => item['status'] == status,
      orElse: () => null,
    );

    return statusItem?['time'];
  }

  Widget _buildStatusItem({
    required Map<String, dynamic> status,
    required bool isCompleted,
    required bool isCurrent,
    required bool isLast,
    String? timestamp,
  }) {
    final Color statusColor = isCompleted
        ? (isCurrent ? AppTheme.primaryOrange : AppTheme.successGreen)
        : AppTheme.lightBorder;

    final Color textColor =
        isCompleted ? AppTheme.textCharcoal : AppTheme.secondaryGray;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Timeline Indicator
        Column(
          children: [
            // Status Icon
            Container(
              width: 12.w,
              height: 12.w,
              decoration: BoxDecoration(
                color: isCompleted
                    ? statusColor
                    : AppTheme.lightTheme.scaffoldBackgroundColor,
                shape: BoxShape.circle,
                border: Border.all(
                  color: statusColor,
                  width: 2,
                ),
              ),
              child: Center(
                child: CustomIconWidget(
                  iconName: status['icon'],
                  color: isCompleted ? AppTheme.pureWhite : statusColor,
                  size: 6.w,
                ),
              ),
            ),

            // Connecting Line
            if (!isLast)
              Container(
                width: 2,
                height: 8.h,
                color: isCompleted ? statusColor : AppTheme.lightBorder,
                margin: EdgeInsets.symmetric(vertical: 1.h),
              ),
          ],
        ),

        SizedBox(width: 4.w),

        // Status Content
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(bottom: isLast ? 0 : 2.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Status Title and Time
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      status['title'],
                      style:
                          AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                        color: textColor,
                        fontWeight:
                            isCompleted ? FontWeight.w600 : FontWeight.w400,
                      ),
                    ),
                    if (timestamp != null)
                      Text(
                        timestamp,
                        style:
                            AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                          color: statusColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                  ],
                ),

                SizedBox(height: 0.5.h),

                // Status Description
                Text(
                  status['description'],
                  style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                    color: AppTheme.secondaryGray,
                  ),
                ),

                // Current Status Indicator
                if (isCurrent)
                  Container(
                    margin: EdgeInsets.only(top: 1.h),
                    padding:
                        EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.5.h),
                    decoration: BoxDecoration(
                      color: AppTheme.primaryOrange.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: AppTheme.primaryOrange.withValues(alpha: 0.3),
                        width: 1,
                      ),
                    ),
                    child: Text(
                      'Current Status',
                      style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                        color: AppTheme.primaryOrange,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
