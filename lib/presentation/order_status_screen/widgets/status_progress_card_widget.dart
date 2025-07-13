import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';
import '../../../theme/app_theme.dart';

class StatusProgressCardWidget extends StatelessWidget {
  final String status;
  final Animation<double> progressAnimation;
  final int preparationProgress;

  const StatusProgressCardWidget({
    super.key,
    required this.status,
    required this.progressAnimation,
    required this.preparationProgress,
  });

  String _getStatusMessage(String status) {
    switch (status) {
      case 'Pending':
        return 'Your order is waiting to be confirmed';
      case 'Accepted':
        return 'Your order has been accepted by the canteen';
      case 'Preparing':
        return 'Your delicious food is being prepared';
      case 'Ready':
        return 'Your order is ready for pickup!';
      default:
        return 'Processing your order...';
    }
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Pending':
        return AppTheme.secondaryGray;
      case 'Accepted':
        return AppTheme.primaryOrange;
      case 'Preparing':
        return AppTheme.primaryOrange;
      case 'Ready':
        return AppTheme.successGreen;
      default:
        return AppTheme.secondaryGray;
    }
  }

  IconData _getStatusIcon(String status) {
    switch (status) {
      case 'Pending':
        return Icons.schedule;
      case 'Accepted':
        return Icons.check_circle_outline;
      case 'Preparing':
        return Icons.restaurant;
      case 'Ready':
        return Icons.check_circle;
      default:
        return Icons.info_outline;
    }
  }

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
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(2.w),
                decoration: BoxDecoration(
                  color: _getStatusColor(status).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  _getStatusIcon(status),
                  color: _getStatusColor(status),
                  size: 24,
                ),
              ),
              SizedBox(width: 3.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      status,
                      style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
                        color: _getStatusColor(status),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 0.5.h),
                    Text(
                      _getStatusMessage(status),
                      style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                        color: AppTheme.secondaryGray,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (status == 'Preparing') ...[
            SizedBox(height: 3.h),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Preparation Progress',
                      style:
                          AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      '$preparationProgress%',
                      style:
                          AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                        color: AppTheme.primaryOrange,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 1.h),
                AnimatedBuilder(
                  animation: progressAnimation,
                  builder: (context, child) {
                    return LinearProgressIndicator(
                      value: progressAnimation.value,
                      backgroundColor: AppTheme.lightBorder,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        AppTheme.primaryOrange,
                      ),
                      minHeight: 8,
                    );
                  },
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}
