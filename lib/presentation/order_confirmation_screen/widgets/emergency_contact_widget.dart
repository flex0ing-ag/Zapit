import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class EmergencyContactWidget extends StatelessWidget {
  final String canteenPhone;
  final String canteenName;

  const EmergencyContactWidget({
    super.key,
    required this.canteenPhone,
    required this.canteenName,
  });

  void _makePhoneCall() {
    // Mock phone call functionality
    Fluttertoast.showToast(
      msg: "Calling $canteenPhone...",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: AppTheme.primaryOrange,
      textColor: AppTheme.pureWhite,
    );
  }

  void _sendMessage() {
    // Mock message functionality
    Fluttertoast.showToast(
      msg: "Opening message app...",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: AppTheme.successGreen,
      textColor: AppTheme.pureWhite,
    );
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              CustomIconWidget(
                iconName: 'support_agent',
                color: AppTheme.primaryOrange,
                size: 24,
              ),
              SizedBox(width: 3.w),
              Text(
                'Need Help?',
                style: AppTheme.lightTheme.textTheme.titleLarge,
              ),
            ],
          ),

          SizedBox(height: 2.h),

          // Contact Information
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Contact $canteenName',
                  style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 1.h),
                Row(
                  children: [
                    CustomIconWidget(
                      iconName: 'phone',
                      color: AppTheme.primaryOrange,
                      size: 18,
                    ),
                    SizedBox(width: 2.w),
                    Text(
                      canteenPhone,
                      style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 0.5.h),
                Text(
                  'Available during canteen operating hours',
                  style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                    color: AppTheme.secondaryGray,
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 2.h),

          // Contact Actions
          Row(
            children: [
              // Call Button
              Expanded(
                child: ElevatedButton(
                  onPressed: _makePhoneCall,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.successGreen,
                    foregroundColor: AppTheme.pureWhite,
                    padding: EdgeInsets.symmetric(vertical: 3.w),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomIconWidget(
                        iconName: 'call',
                        color: AppTheme.pureWhite,
                        size: 18,
                      ),
                      SizedBox(width: 2.w),
                      Text(
                        'Call Now',
                        style:
                            AppTheme.lightTheme.textTheme.titleSmall?.copyWith(
                          color: AppTheme.pureWhite,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(width: 3.w),

              // Message Button
              Expanded(
                child: OutlinedButton(
                  onPressed: _sendMessage,
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
                        iconName: 'message',
                        color: AppTheme.primaryOrange,
                        size: 18,
                      ),
                      SizedBox(width: 2.w),
                      Text(
                        'Message',
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
            ],
          ),

          SizedBox(height: 2.h),

          // Help Topics
          Text(
            'Common Issues',
            style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),

          SizedBox(height: 1.h),

          _buildHelpTopic(
            icon: 'schedule',
            title: 'Order Delay',
            description: 'If your order is taking longer than expected',
          ),

          SizedBox(height: 1.h),

          _buildHelpTopic(
            icon: 'cancel',
            title: 'Cancel Order',
            description: 'Need to cancel your order? Contact us immediately',
          ),

          SizedBox(height: 1.h),

          _buildHelpTopic(
            icon: 'edit',
            title: 'Modify Order',
            description: 'Want to change items or pickup time?',
          ),

          SizedBox(height: 1.h),

          _buildHelpTopic(
            icon: 'payment',
            title: 'Payment Issues',
            description: 'Problems with payment or refunds',
          ),
        ],
      ),
    );
  }

  Widget _buildHelpTopic({
    required String icon,
    required String title,
    required String description,
  }) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(3.w),
      margin: EdgeInsets.only(bottom: 1.h),
      decoration: BoxDecoration(
        color: AppTheme.warmGray.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: AppTheme.lightBorder.withValues(alpha: 0.5),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 8.w,
            height: 8.w,
            decoration: BoxDecoration(
              color: AppTheme.primaryOrange.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: CustomIconWidget(
                iconName: icon,
                color: AppTheme.primaryOrange,
                size: 4.w,
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
                  style: AppTheme.lightTheme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
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
      ),
    );
  }
}
