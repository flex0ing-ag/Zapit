import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import './widgets/action_buttons_widget.dart';
import './widgets/communication_section_widget.dart';
import './widgets/kitchen_updates_widget.dart';
import './widgets/order_items_summary_widget.dart';
import './widgets/order_status_header_widget.dart';
import './widgets/order_timeline_widget.dart';
import './widgets/pickup_details_card_widget.dart';
import './widgets/status_progress_card_widget.dart';

class OrderStatusScreen extends StatefulWidget {
  const OrderStatusScreen({super.key});

  @override
  State<OrderStatusScreen> createState() => _OrderStatusScreenState();
}

class _OrderStatusScreenState extends State<OrderStatusScreen>
    with TickerProviderStateMixin {
  late AnimationController _progressAnimationController;
  late Animation<double> _progressAnimation;

  // Mock order data
  final Map<String, dynamic> orderData = {
    "orderId": "CB2024001",
    "tokenNumber": "A-42",
    "status": "Preparing",
    "estimatedTime": "12 mins",
    "queuePosition": 3,
    "preparationProgress": 65,
    "canteenName": "Central Canteen",
    "canteenLocation": "Ground Floor, Main Building",
    "operatingHours": "8:00 AM - 8:00 PM",
    "specialInstructions": "Please collect from counter 2",
    "orderTime": "2:30 PM",
    "items": [
      {
        "name": "Chicken Biryani",
        "quantity": 1,
        "price": "\$8.50",
        "modifications": ["Extra spicy", "No onions"]
      },
      {
        "name": "Masala Chai",
        "quantity": 2,
        "price": "\$3.00",
        "modifications": []
      }
    ],
    "timeline": [
      {
        "status": "Order Placed",
        "time": "2:30 PM",
        "completed": true,
        "description": "Your order has been received"
      },
      {
        "status": "Order Accepted",
        "time": "2:32 PM",
        "completed": true,
        "description": "Canteen confirmed your order"
      },
      {
        "status": "Preparing",
        "time": "2:35 PM",
        "completed": false,
        "description": "Your food is being prepared",
        "estimated": "2:45 PM"
      },
      {
        "status": "Ready for Pickup",
        "time": "",
        "completed": false,
        "description": "Your order will be ready",
        "estimated": "2:50 PM"
      }
    ]
  };

  bool _notificationsEnabled = true;
  bool _showOrderDetails = false;

  @override
  void initState() {
    super.initState();
    _progressAnimationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _progressAnimation = Tween<double>(
      begin: 0.0,
      end: (orderData["preparationProgress"] as int) / 100.0,
    ).animate(CurvedAnimation(
      parent: _progressAnimationController,
      curve: Curves.easeInOut,
    ));
    _progressAnimationController.forward();
  }

  @override
  void dispose() {
    _progressAnimationController.dispose();
    super.dispose();
  }

  void _shareOrderToken() {
    // Mock share functionality
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Order token ${orderData["tokenNumber"]} shared!'),
        backgroundColor: AppTheme.successGreen,
      ),
    );
  }

  void _toggleNotifications() {
    setState(() {
      _notificationsEnabled = !_notificationsEnabled;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(_notificationsEnabled
            ? 'Notifications enabled'
            : 'Notifications disabled'),
      ),
    );
  }

  void _getDirections() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Opening maps...')),
    );
  }

  void _callCanteen() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Calling canteen...')),
    );
  }

  void _reportIssue() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Report Issue'),
        content: const TextField(
          decoration: InputDecoration(
            hintText: 'Describe the issue...',
            border: OutlineInputBorder(),
          ),
          maxLines: 3,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Issue reported successfully')),
              );
            },
            child: const Text('Submit'),
          ),
        ],
      ),
    );
  }

  void _reorderItems() {
    Navigator.pushNamed(context, '/menu-screen');
  }

  void _rateExperience() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Rate Your Experience'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('How was your order experience?'),
            SizedBox(height: 2.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(
                5,
                (index) => GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Rated ${index + 1} stars')),
                    );
                  },
                  child: CustomIconWidget(
                    iconName: 'star_border',
                    color: AppTheme.primaryOrange,
                    size: 32,
                  ),
                ),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.lightTheme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text('Order Status'),
        leading: IconButton(
          icon: CustomIconWidget(
            iconName: 'arrow_back',
            color: AppTheme.lightTheme.colorScheme.onSurface,
            size: 24,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: CustomIconWidget(
              iconName: 'home',
              color: AppTheme.lightTheme.colorScheme.onSurface,
              size: 24,
            ),
            onPressed: () => Navigator.pushNamed(context, '/home-screen'),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(4.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Order Status Header
            OrderStatusHeaderWidget(
              tokenNumber: orderData["tokenNumber"] as String,
              estimatedTime: orderData["estimatedTime"] as String,
              onShare: _shareOrderToken,
            ),

            SizedBox(height: 3.h),

            // Status Progress Card
            StatusProgressCardWidget(
              status: orderData["status"] as String,
              progressAnimation: _progressAnimation,
              preparationProgress: orderData["preparationProgress"] as int,
            ),

            SizedBox(height: 3.h),

            // Order Timeline
            OrderTimelineWidget(
              timeline:
                  (orderData["timeline"] as List).cast<Map<String, dynamic>>(),
            ),

            SizedBox(height: 3.h),

            // Kitchen Updates
            KitchenUpdatesWidget(
              queuePosition: orderData["queuePosition"] as int,
              preparationProgress: orderData["preparationProgress"] as int,
            ),

            SizedBox(height: 3.h),

            // Pickup Details
            PickupDetailsCardWidget(
              canteenName: orderData["canteenName"] as String,
              location: orderData["canteenLocation"] as String,
              operatingHours: orderData["operatingHours"] as String,
              specialInstructions: orderData["specialInstructions"] as String,
            ),

            SizedBox(height: 3.h),

            // Communication Section
            CommunicationSectionWidget(
              notificationsEnabled: _notificationsEnabled,
              onToggleNotifications: _toggleNotifications,
            ),

            SizedBox(height: 3.h),

            // Order Items Summary
            OrderItemsSummaryWidget(
              items: (orderData["items"] as List).cast<Map<String, dynamic>>(),
              showDetails: _showOrderDetails,
              onToggleDetails: () {
                setState(() {
                  _showOrderDetails = !_showOrderDetails;
                });
              },
            ),

            SizedBox(height: 3.h),

            // Action Buttons
            ActionButtonsWidget(
              onGetDirections: _getDirections,
              onCallCanteen: _callCanteen,
              onReportIssue: _reportIssue,
              onReorderItems: _reorderItems,
              onRateExperience: _rateExperience,
            ),

            SizedBox(height: 2.h),
          ],
        ),
      ),
    );
  }
}
