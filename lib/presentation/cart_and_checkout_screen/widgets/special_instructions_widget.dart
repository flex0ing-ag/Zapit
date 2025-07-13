import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class SpecialInstructionsWidget extends StatelessWidget {
  final String instructions;
  final Function(String) onChanged;

  const SpecialInstructionsWidget({
    super.key,
    required this.instructions,
    required this.onChanged,
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
                iconName: 'edit_note',
                color: AppTheme.primaryOrange,
                size: 20,
              ),
              SizedBox(width: 2.w),
              Text(
                'Special Instructions',
                style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SizedBox(height: 1.h),

          Text(
            'Any dietary preferences or preparation notes?',
            style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
              color: AppTheme.secondaryGray,
            ),
          ),
          SizedBox(height: 2.h),

          TextFormField(
            initialValue: instructions,
            onChanged: onChanged,
            maxLines: 3,
            maxLength: 200,
            decoration: InputDecoration(
              hintText: 'e.g., Extra spicy, no onions, less oil...',
              hintStyle: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                color: AppTheme.secondaryGray,
              ),
              filled: true,
              fillColor: AppTheme.warmGray,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: AppTheme.lightBorder),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: AppTheme.lightBorder),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide:
                    const BorderSide(color: AppTheme.primaryOrange, width: 2),
              ),
              contentPadding: EdgeInsets.all(3.w),
              counterStyle: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                color: AppTheme.secondaryGray,
              ),
            ),
            style: AppTheme.lightTheme.textTheme.bodyMedium,
          ),

          SizedBox(height: 2.h),

          // Quick suggestion chips
          Wrap(
            spacing: 2.w,
            runSpacing: 1.h,
            children: [
              'Less spicy',
              'Extra spicy',
              'No onions',
              'Less oil',
              'Extra sauce',
              'Well done',
            ].map((suggestion) {
              return InkWell(
                onTap: () {
                  final currentInstructions = instructions.trim();
                  final newInstructions = currentInstructions.isEmpty
                      ? suggestion
                      : '$currentInstructions, $suggestion';
                  onChanged(newInstructions);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
                  decoration: BoxDecoration(
                    color: AppTheme.warmGray,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: AppTheme.lightBorder),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CustomIconWidget(
                        iconName: 'add',
                        color: AppTheme.primaryOrange,
                        size: 14,
                      ),
                      SizedBox(width: 1.w),
                      Text(
                        suggestion,
                        style:
                            AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                          color: AppTheme.textCharcoal,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
