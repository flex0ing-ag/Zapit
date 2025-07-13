import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class AiSuggestionWidget extends StatefulWidget {
  final Function(DateTime) onSuggestionSelected;

  const AiSuggestionWidget({
    super.key,
    required this.onSuggestionSelected,
  });

  @override
  State<AiSuggestionWidget> createState() => _AiSuggestionWidgetState();
}

class _AiSuggestionWidgetState extends State<AiSuggestionWidget> {
  bool _isLoading = false;
  List<Map<String, dynamic>> _suggestions = [];

  @override
  void initState() {
    super.initState();
    _generateSuggestions();
  }

  void _generateSuggestions() {
    setState(() {
      _isLoading = true;
    });

    // Simulate AI processing
    Future.delayed(const Duration(seconds: 1), () {
      final now = DateTime.now();
      final suggestions = [
        {
          'time': now.add(const Duration(minutes: 35)),
          'demand': 'Low',
          'color': AppTheme.successGreen,
          'waitTime': '5-10 mins',
          'isRecommended': true,
        },
        {
          'time': now.add(const Duration(minutes: 50)),
          'demand': 'Medium',
          'color': AppTheme.primaryOrange,
          'waitTime': '10-15 mins',
          'isRecommended': false,
        },
        {
          'time': now.add(const Duration(minutes: 75)),
          'demand': 'High',
          'color': AppTheme.alertRed,
          'waitTime': '15-20 mins',
          'isRecommended': false,
        },
      ];

      setState(() {
        _suggestions = suggestions;
        _isLoading = false;
      });
    });
  }

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
              Container(
                padding: EdgeInsets.all(1.w),
                decoration: BoxDecoration(
                  color: AppTheme.softOrange,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: CustomIconWidget(
                  iconName: 'auto_awesome',
                  color: AppTheme.primaryOrange,
                  size: 16,
                ),
              ),
              SizedBox(width: 2.w),
              Text(
                'AI Suggested Pickup Times',
                style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SizedBox(height: 1.h),
          Text(
            'Based on current kitchen load and historical data',
            style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
              color: AppTheme.secondaryGray,
            ),
          ),
          SizedBox(height: 2.h),
          if (_isLoading)
            Center(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 2.h),
                child: CircularProgressIndicator(
                  color: AppTheme.primaryOrange,
                  strokeWidth: 2,
                ),
              ),
            )
          else
            Column(
              children: _suggestions.map((suggestion) {
                return _buildSuggestionCard(suggestion);
              }).toList(),
            ),
        ],
      ),
    );
  }

  Widget _buildSuggestionCard(Map<String, dynamic> suggestion) {
    final DateTime time = suggestion['time'];
    final String demand = suggestion['demand'];
    final Color color = suggestion['color'];
    final String waitTime = suggestion['waitTime'];
    final bool isRecommended = suggestion['isRecommended'];

    return Container(
      margin: EdgeInsets.only(bottom: 1.h),
      child: InkWell(
        onTap: () => widget.onSuggestionSelected(time),
        child: Container(
          padding: EdgeInsets.all(3.w),
          decoration: BoxDecoration(
            color: isRecommended ? AppTheme.softOrange : AppTheme.warmGray,
            borderRadius: BorderRadius.circular(8),
            border: isRecommended
                ? Border.all(color: AppTheme.primaryOrange, width: 1)
                : null,
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          _formatTime(time),
                          style: AppTheme.lightTheme.textTheme.titleSmall
                              ?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        if (isRecommended) ...[
                          SizedBox(width: 2.w),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 2.w, vertical: 0.5.h),
                            decoration: BoxDecoration(
                              color: AppTheme.primaryOrange,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              'RECOMMENDED',
                              style: AppTheme.lightTheme.textTheme.labelSmall
                                  ?.copyWith(
                                color: AppTheme.pureWhite,
                                fontWeight: FontWeight.w600,
                                fontSize: 8.sp,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                    SizedBox(height: 0.5.h),
                    Text(
                      'Expected wait: $waitTime',
                      style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                        color: AppTheme.secondaryGray,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: color,
                        shape: BoxShape.circle,
                      ),
                    ),
                    SizedBox(width: 1.w),
                    Text(
                      '$demand Demand',
                      style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                        color: color,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
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
