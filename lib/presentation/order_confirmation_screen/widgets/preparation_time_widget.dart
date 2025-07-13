import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class PreparationTimeWidget extends StatefulWidget {
  final String estimatedTime;
  final String pickupTime;

  const PreparationTimeWidget({
    super.key,
    required this.estimatedTime,
    required this.pickupTime,
  });

  @override
  State<PreparationTimeWidget> createState() => _PreparationTimeWidgetState();
}

class _PreparationTimeWidgetState extends State<PreparationTimeWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  String _kitchenLoad = 'Medium';
  String _aiRecommendation = 'Optimal time for pickup';

  @override
  void initState() {
    super.initState();
    _initializePulseAnimation();
    _generateAIRecommendation();
  }

  void _initializePulseAnimation() {
    _pulseController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _pulseAnimation = Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _pulseController,
      curve: Curves.easeInOut,
    ));

    _pulseController.repeat(reverse: true);
  }

  void _generateAIRecommendation() {
    // Mock Gemini AI calculations
    final List<String> recommendations = [
      'Perfect timing! Kitchen is running smoothly',
      'Slight delay expected due to high demand',
      'Your order will be ready right on time',
      'Consider arriving 5 minutes early',
      'Kitchen is ahead of schedule today',
    ];

    final List<String> loadLevels = ['Low', 'Medium', 'High'];

    setState(() {
      _kitchenLoad = loadLevels[DateTime.now().millisecond % 3];
      _aiRecommendation =
          recommendations[DateTime.now().millisecond % recommendations.length];
    });
  }

  Color _getLoadColor() {
    switch (_kitchenLoad) {
      case 'Low':
        return AppTheme.successGreen;
      case 'Medium':
        return AppTheme.primaryOrange;
      case 'High':
        return AppTheme.alertRed;
      default:
        return AppTheme.primaryOrange;
    }
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
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
          // Header with AI Badge
          Row(
            children: [
              CustomIconWidget(
                iconName: 'psychology',
                color: AppTheme.primaryOrange,
                size: 24,
              ),
              SizedBox(width: 3.w),
              Text(
                'AI Preparation Insights',
                style: AppTheme.lightTheme.textTheme.titleLarge,
              ),
              const Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.5.h),
                decoration: BoxDecoration(
                  color: AppTheme.primaryOrange.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: AppTheme.primaryOrange.withValues(alpha: 0.3),
                    width: 1,
                  ),
                ),
                child: Text(
                  'Gemini AI',
                  style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                    color: AppTheme.primaryOrange,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 3.h),

          // Estimated Time Card
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(4.w),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppTheme.softOrange,
                  AppTheme.softOrange.withValues(alpha: 0.5),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: AppTheme.primaryOrange.withValues(alpha: 0.2),
                width: 1,
              ),
            ),
            child: Column(
              children: [
                AnimatedBuilder(
                  animation: _pulseAnimation,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: _pulseAnimation.value,
                      child: CustomIconWidget(
                        iconName: 'timer',
                        color: AppTheme.primaryOrange,
                        size: 12.w,
                      ),
                    );
                  },
                ),
                SizedBox(height: 2.h),
                Text(
                  'Estimated Preparation Time',
                  style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                    color: AppTheme.secondaryGray,
                  ),
                ),
                SizedBox(height: 1.h),
                Text(
                  widget.estimatedTime,
                  style: AppTheme.lightTheme.textTheme.headlineMedium?.copyWith(
                    color: AppTheme.primaryOrange,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 1.h),
                Text(
                  'Ready by ${widget.pickupTime}',
                  style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                    color: AppTheme.textCharcoal,
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 2.h),

          // Kitchen Load Indicator
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(3.w),
                  decoration: BoxDecoration(
                    color: AppTheme.warmGray,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CustomIconWidget(
                            iconName: 'restaurant',
                            color: _getLoadColor(),
                            size: 18,
                          ),
                          SizedBox(width: 2.w),
                          Text(
                            'Kitchen Load',
                            style: AppTheme.lightTheme.textTheme.bodySmall,
                          ),
                        ],
                      ),
                      SizedBox(height: 0.5.h),
                      Text(
                        _kitchenLoad,
                        style:
                            AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                          color: _getLoadColor(),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 3.w),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(3.w),
                  decoration: BoxDecoration(
                    color: AppTheme.warmGray,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CustomIconWidget(
                            iconName: 'trending_up',
                            color: AppTheme.successGreen,
                            size: 18,
                          ),
                          SizedBox(width: 2.w),
                          Text(
                            'Accuracy',
                            style: AppTheme.lightTheme.textTheme.bodySmall,
                          ),
                        ],
                      ),
                      SizedBox(height: 0.5.h),
                      Text(
                        '94%',
                        style:
                            AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                          color: AppTheme.successGreen,
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

          // AI Recommendation
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(3.w),
            decoration: BoxDecoration(
              color: AppTheme.successGreen.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: AppTheme.successGreen.withValues(alpha: 0.3),
                width: 1,
              ),
            ),
            child: Row(
              children: [
                CustomIconWidget(
                  iconName: 'lightbulb',
                  color: AppTheme.successGreen,
                  size: 20,
                ),
                SizedBox(width: 3.w),
                Expanded(
                  child: Text(
                    _aiRecommendation,
                    style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                      color: AppTheme.successGreen,
                      fontWeight: FontWeight.w500,
                    ),
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
