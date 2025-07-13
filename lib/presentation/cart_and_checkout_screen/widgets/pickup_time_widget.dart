import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class PickupTimeWidget extends StatelessWidget {
  final DateTime? selectedTime;
  final Function(DateTime) onTimeSelected;

  const PickupTimeWidget({
    super.key,
    required this.selectedTime,
    required this.onTimeSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: AppTheme.pureWhite,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: AppTheme.shadowLight,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CustomIconWidget(
                iconName: 'schedule',
                color: AppTheme.primaryOrange,
                size: 20,
              ),
              SizedBox(width: 2.w),
              Text(
                'Pickup Time',
                style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SizedBox(height: 2.h),
          Text(
            'Select your preferred pickup time (minimum 30 minutes from now)',
            style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
              color: AppTheme.secondaryGray,
            ),
          ),
          SizedBox(height: 2.h),
          InkWell(
            onTap: () => _showTimePicker(context),
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.all(4.w),
              decoration: BoxDecoration(
                border: Border.all(
                  color: selectedTime != null
                      ? AppTheme.primaryOrange
                      : AppTheme.lightBorder,
                  width: selectedTime != null ? 2 : 1,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    selectedTime != null
                        ? _formatTime(selectedTime!)
                        : 'Select pickup time',
                    style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                      color: selectedTime != null
                          ? AppTheme.textCharcoal
                          : AppTheme.secondaryGray,
                      fontWeight: selectedTime != null
                          ? FontWeight.w500
                          : FontWeight.w400,
                    ),
                  ),
                  CustomIconWidget(
                    iconName: 'access_time',
                    color: selectedTime != null
                        ? AppTheme.primaryOrange
                        : AppTheme.secondaryGray,
                    size: 20,
                  ),
                ],
              ),
            ),
          ),
          if (selectedTime != null) ...[
            SizedBox(height: 2.h),
            Container(
              padding: EdgeInsets.all(3.w),
              decoration: BoxDecoration(
                color: AppTheme.softOrange,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  CustomIconWidget(
                    iconName: 'info_outline',
                    color: AppTheme.primaryOrange,
                    size: 16,
                  ),
                  SizedBox(width: 2.w),
                  Expanded(
                    child: Text(
                      'Your order will be ready by ${_formatTime(selectedTime!)}',
                      style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                        color: AppTheme.deepOrange,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  void _showTimePicker(BuildContext context) async {
    final now = DateTime.now();
    final minimumTime = now.add(const Duration(minutes: 30));

    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(minimumTime),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            timePickerTheme: TimePickerThemeData(
              backgroundColor: AppTheme.pureWhite,
              hourMinuteTextColor: AppTheme.textCharcoal,
              hourMinuteColor: AppTheme.softOrange,
              dialHandColor: AppTheme.primaryOrange,
              dialBackgroundColor: AppTheme.warmGray,
              entryModeIconColor: AppTheme.primaryOrange,
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedTime != null) {
      final selectedDateTime = DateTime(
        now.year,
        now.month,
        now.day,
        pickedTime.hour,
        pickedTime.minute,
      );

      // Validate minimum time
      if (selectedDateTime.isBefore(minimumTime)) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Pickup time must be at least 30 minutes from now'),
          ),
        );
        return;
      }

      // Validate canteen operating hours (8 AM to 10 PM)
      if (pickedTime.hour < 8 || pickedTime.hour >= 22) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Canteen operates from 8:00 AM to 10:00 PM'),
          ),
        );
        return;
      }

      onTimeSelected(selectedDateTime);
    }
  }

  String _formatTime(DateTime dateTime) {
    final hour = dateTime.hour;
    final minute = dateTime.minute;
    final period = hour >= 12 ? 'PM' : 'AM';
    final displayHour = hour > 12 ? hour - 12 : (hour == 0 ? 12 : hour);
    final displayMinute = minute.toString().padLeft(2, '0');

    return '$displayHour:$displayMinute $period';
  }
}
