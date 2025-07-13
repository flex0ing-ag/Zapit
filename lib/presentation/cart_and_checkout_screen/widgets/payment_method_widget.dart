import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class PaymentMethodWidget extends StatelessWidget {
  final String selectedMethod;
  final Function(String) onMethodChanged;

  const PaymentMethodWidget({
    super.key,
    required this.selectedMethod,
    required this.onMethodChanged,
  });

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> paymentMethods = [
      {
        'name': 'Credit Card',
        'icon': 'credit_card',
        'subtitle': 'Visa ending in 1234',
        'isEnabled': true,
      },
      {
        'name': 'Campus Card',
        'icon': 'school',
        'subtitle': 'Student ID: 2024001',
        'isEnabled': true,
      },
      {
        'name': 'Digital Wallet',
        'icon': 'account_balance_wallet',
        'subtitle': 'Apple Pay / Google Pay',
        'isEnabled': false,
      },
      {
        'name': 'Cash on Pickup',
        'icon': 'payments',
        'subtitle': 'Pay when you collect',
        'isEnabled': false,
      },
    ];

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
                iconName: 'payment',
                color: AppTheme.primaryOrange,
                size: 20,
              ),
              SizedBox(width: 2.w),
              Text(
                'Payment Method',
                style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SizedBox(height: 2.h),
          Column(
            children: paymentMethods.map((method) {
              final bool isSelected = method['name'] == selectedMethod;
              final bool isEnabled = method['isEnabled'] as bool;

              return Container(
                margin: EdgeInsets.only(bottom: 1.h),
                child: InkWell(
                  onTap:
                      isEnabled ? () => onMethodChanged(method['name']) : null,
                  child: Container(
                    padding: EdgeInsets.all(3.w),
                    decoration: BoxDecoration(
                      color:
                          isSelected ? AppTheme.softOrange : AppTheme.warmGray,
                      borderRadius: BorderRadius.circular(8),
                      border: isSelected
                          ? Border.all(color: AppTheme.primaryOrange, width: 2)
                          : Border.all(color: AppTheme.lightBorder),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(2.w),
                          decoration: BoxDecoration(
                            color: isEnabled
                                ? (isSelected
                                    ? AppTheme.primaryOrange
                                    : AppTheme.lightBorder)
                                : AppTheme.secondaryGray.withValues(alpha: 0.3),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: CustomIconWidget(
                            iconName: method['icon'],
                            color: isEnabled
                                ? (isSelected
                                    ? AppTheme.pureWhite
                                    : AppTheme.secondaryGray)
                                : AppTheme.secondaryGray,
                            size: 20,
                          ),
                        ),
                        SizedBox(width: 3.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    method['name'],
                                    style: AppTheme
                                        .lightTheme.textTheme.titleSmall
                                        ?.copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: isEnabled
                                          ? AppTheme.textCharcoal
                                          : AppTheme.secondaryGray,
                                    ),
                                  ),
                                  if (!isEnabled) ...[
                                    SizedBox(width: 2.w),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 2.w, vertical: 0.5.h),
                                      decoration: BoxDecoration(
                                        color: AppTheme.secondaryGray
                                            .withValues(alpha: 0.2),
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      child: Text(
                                        'COMING SOON',
                                        style: AppTheme
                                            .lightTheme.textTheme.labelSmall
                                            ?.copyWith(
                                          color: AppTheme.secondaryGray,
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
                                method['subtitle'],
                                style: AppTheme.lightTheme.textTheme.bodySmall
                                    ?.copyWith(
                                  color: isEnabled
                                      ? AppTheme.secondaryGray
                                      : AppTheme.secondaryGray
                                          .withValues(alpha: 0.7),
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (isEnabled)
                          Radio<String>(
                            value: method['name'],
                            groupValue: selectedMethod,
                            onChanged: (value) {
                              if (value != null) {
                                onMethodChanged(value);
                              }
                            },
                            activeColor: AppTheme.primaryOrange,
                          ),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
          if (!paymentMethods.any((method) =>
              method['isEnabled'] && method['name'] == selectedMethod))
            Container(
              padding: EdgeInsets.all(3.w),
              decoration: BoxDecoration(
                color: AppTheme.alertRed.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  CustomIconWidget(
                    iconName: 'info_outline',
                    color: AppTheme.alertRed,
                    size: 16,
                  ),
                  SizedBox(width: 2.w),
                  Expanded(
                    child: Text(
                      'Please select an available payment method',
                      style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                        color: AppTheme.alertRed,
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
