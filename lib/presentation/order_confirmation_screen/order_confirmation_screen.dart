import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import './widgets/action_buttons_widget.dart';
import './widgets/celebration_card_widget.dart';
import './widgets/emergency_contact_widget.dart';
import './widgets/order_summary_widget.dart';
import './widgets/pickup_instructions_widget.dart';
import './widgets/preparation_time_widget.dart';
import './widgets/status_tracker_widget.dart';

class OrderConfirmationScreen extends StatefulWidget {
  const OrderConfirmationScreen({super.key});

  @override
  State<OrderConfirmationScreen> createState() =>
      _OrderConfirmationScreenState();
}

class _OrderConfirmationScreenState extends State<OrderConfirmationScreen>
    with TickerProviderStateMixin {
  late AnimationController _checkmarkController;
  late AnimationController _fadeController;
  late Animation<double> _checkmarkAnimation;
  late Animation<double> _fadeAnimation;

  bool _notificationsEnabled = true;
  String _currentOrderStatus = 'Pending';

  // Mock order data
  final Map<String, dynamic> _orderData = {
    "orderId": "ORD-2024-001",
    "tokenNumber": "A-47",
    "canteenName": "Central Canteen",
    "items": [
      {
        "name": "Chicken Biryani",
        "quantity": 2,
        "price": 12.99,
        "isVeg": false,
      },
      {
        "name": "Masala Chai",
        "quantity": 1,
        "price": 2.50,
        "isVeg": true,
      },
      {
        "name": "Samosa",
        "quantity": 3,
        "price": 1.99,
        "isVeg": true,
      }
    ],
    "totalAmount": 34.45,
    "pickupTime": "2:30 PM",
    "estimatedPrepTime": "25 minutes",
    "orderTime": "1:45 PM",
    "canteenLocation": "Ground Floor, Academic Block A",
    "canteenPhone": "+1 (555) 123-4567",
    "status": "Pending",
    "statusHistory": [
      {
        "status": "Pending",
        "time": "1:45 PM",
        "description": "Order received and being reviewed"
      }
    ]
  };

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _startAnimations();
    _simulateOrderProgress();
  }

  void _initializeAnimations() {
    _checkmarkController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _checkmarkAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _checkmarkController,
      curve: Curves.elasticOut,
    ));

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeInOut,
    ));
  }

  void _startAnimations() {
    Future.delayed(const Duration(milliseconds: 300), () {
      _checkmarkController.forward();
    });

    Future.delayed(const Duration(milliseconds: 500), () {
      _fadeController.forward();
    });
  }

  void _simulateOrderProgress() {
    // Simulate order status changes
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        setState(() {
          _currentOrderStatus = 'Accepted';
          _orderData['status'] = 'Accepted';
          (_orderData['statusHistory'] as List).add({
            "status": "Accepted",
            "time": "1:47 PM",
            "description": "Order accepted by kitchen staff"
          });
        });
      }
    });

    Future.delayed(const Duration(seconds: 8), () {
      if (mounted) {
        setState(() {
          _currentOrderStatus = 'Preparing';
          _orderData['status'] = 'Preparing';
          (_orderData['statusHistory'] as List).add({
            "status": "Preparing",
            "time": "1:52 PM",
            "description": "Your order is being prepared"
          });
        });
      }
    });
  }

  void _copyTokenToClipboard() {
    Clipboard.setData(ClipboardData(text: _orderData['tokenNumber']));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Token number copied to clipboard'),
        backgroundColor: AppTheme.successGreen,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _toggleNotifications(bool value) {
    setState(() {
      _notificationsEnabled = value;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content:
            Text(value ? 'Notifications enabled' : 'Notifications disabled'),
        backgroundColor: value ? AppTheme.successGreen : AppTheme.secondaryGray,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _shareOrder() {
    // Mock share functionality
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Order details shared successfully'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _reorder() {
    Navigator.pushNamed(context, '/menu-screen');
  }

  void _trackOrder() {
    Navigator.pushNamed(context, '/order-status-screen');
  }

  void _continueShoppingPressed() {
    Navigator.pushNamed(context, '/home-screen');
  }

  void _viewAllOrdersPressed() {
    Navigator.pushNamed(context, '/order-history-screen');
  }

  @override
  void dispose() {
    _checkmarkController.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.lightTheme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          'Order Confirmation',
          style: AppTheme.lightTheme.textTheme.titleLarge,
        ),
        backgroundColor: AppTheme.lightTheme.appBarTheme.backgroundColor,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: CustomIconWidget(
            iconName: 'arrow_back',
            color: AppTheme.lightTheme.colorScheme.onSurface,
            size: 24,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Celebration Card with Animation
            AnimatedBuilder(
              animation: _checkmarkAnimation,
              builder: (context, child) {
                return Transform.scale(
                  scale: _checkmarkAnimation.value,
                  child: CelebrationCardWidget(
                    tokenNumber: _orderData['tokenNumber'],
                    onCopyPressed: _copyTokenToClipboard,
                  ),
                );
              },
            ),

            SizedBox(height: 3.h),

            // Order Summary
            FadeTransition(
              opacity: _fadeAnimation,
              child: OrderSummaryWidget(
                orderData: _orderData,
              ),
            ),

            SizedBox(height: 2.h),

            // Preparation Time Card
            FadeTransition(
              opacity: _fadeAnimation,
              child: PreparationTimeWidget(
                estimatedTime: _orderData['estimatedPrepTime'],
                pickupTime: _orderData['pickupTime'],
              ),
            ),

            SizedBox(height: 2.h),

            // Status Tracker
            FadeTransition(
              opacity: _fadeAnimation,
              child: StatusTrackerWidget(
                currentStatus: _currentOrderStatus,
                statusHistory: _orderData['statusHistory'],
              ),
            ),

            SizedBox(height: 2.h),

            // Notification Toggle
            FadeTransition(
              opacity: _fadeAnimation,
              child: Container(
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
                child: Row(
                  children: [
                    CustomIconWidget(
                      iconName: 'notifications',
                      color: AppTheme.primaryOrange,
                      size: 24,
                    ),
                    SizedBox(width: 3.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Push Notifications',
                            style: AppTheme.lightTheme.textTheme.titleMedium,
                          ),
                          Text(
                            'Get updates about your order status',
                            style: AppTheme.lightTheme.textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ),
                    Switch(
                      value: _notificationsEnabled,
                      onChanged: _toggleNotifications,
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 2.h),

            // Pickup Instructions
            FadeTransition(
              opacity: _fadeAnimation,
              child: PickupInstructionsWidget(
                canteenLocation: _orderData['canteenLocation'],
                tokenNumber: _orderData['tokenNumber'],
              ),
            ),

            SizedBox(height: 2.h),

            // Emergency Contact
            FadeTransition(
              opacity: _fadeAnimation,
              child: EmergencyContactWidget(
                canteenPhone: _orderData['canteenPhone'],
                canteenName: _orderData['canteenName'],
              ),
            ),

            SizedBox(height: 3.h),

            // Action Buttons
            FadeTransition(
              opacity: _fadeAnimation,
              child: ActionButtonsWidget(
                onTrackOrder: _trackOrder,
                onReorder: _reorder,
                onShareOrder: _shareOrder,
              ),
            ),

            SizedBox(height: 3.h),

            // Bottom Navigation Buttons
            FadeTransition(
              opacity: _fadeAnimation,
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: _continueShoppingPressed,
                      child: Text('Continue Shopping'),
                    ),
                  ),
                  SizedBox(width: 4.w),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _viewAllOrdersPressed,
                      child: Text('View All Orders'),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 2.h),
          ],
        ),
      ),
    );
  }
}
