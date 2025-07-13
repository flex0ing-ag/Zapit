import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import './widgets/ai_suggestion_widget.dart';
import './widgets/cart_item_widget.dart';
import './widgets/order_summary_widget.dart';
import './widgets/payment_method_widget.dart';
import './widgets/pickup_time_widget.dart';
import './widgets/special_instructions_widget.dart';

class CartAndCheckoutScreen extends StatefulWidget {
  const CartAndCheckoutScreen({super.key});

  @override
  State<CartAndCheckoutScreen> createState() => _CartAndCheckoutScreenState();
}

class _CartAndCheckoutScreenState extends State<CartAndCheckoutScreen> {
  bool _isLoading = false;
  DateTime? _selectedPickupTime;
  String _specialInstructions = '';
  String _selectedPaymentMethod = 'Credit Card';

  // Mock cart data
  final List<Map<String, dynamic>> _cartItems = [
    {
      "id": 1,
      "name": "Chicken Biryani",
      "image":
          "https://images.pexels.com/photos/1893556/pexels-photo-1893556.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
      "price": 12.99,
      "quantity": 2,
      "isVeg": false,
      "preparationTime": "25-30 mins",
      "canteenName": "Main Canteen"
    },
    {
      "id": 2,
      "name": "Margherita Pizza",
      "image":
          "https://images.pexels.com/photos/315755/pexels-photo-315755.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
      "price": 8.50,
      "quantity": 1,
      "isVeg": true,
      "preparationTime": "15-20 mins",
      "canteenName": "Food Court"
    },
    {
      "id": 3,
      "name": "Cold Coffee",
      "image":
          "https://images.pexels.com/photos/302899/pexels-photo-302899.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
      "price": 4.25,
      "quantity": 3,
      "isVeg": true,
      "preparationTime": "5-10 mins",
      "canteenName": "Cafe Corner"
    }
  ];

  double get _subtotal {
    return _cartItems.fold(
        0.0,
        (sum, item) =>
            sum + ((item['price'] as double) * (item['quantity'] as int)));
  }

  double get _taxes => _subtotal * 0.08;
  double get _total => _subtotal + _taxes;

  void _updateQuantity(int itemId, int newQuantity) {
    setState(() {
      if (newQuantity <= 0) {
        _cartItems.removeWhere((item) => item['id'] == itemId);
      } else {
        final itemIndex = _cartItems.indexWhere((item) => item['id'] == itemId);
        if (itemIndex != -1) {
          _cartItems[itemIndex]['quantity'] = newQuantity;
        }
      }
    });
  }

  void _removeItem(int itemId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Remove Item',
            style: AppTheme.lightTheme.textTheme.titleLarge,
          ),
          content: Text(
            'Are you sure you want to remove this item from your cart?',
            style: AppTheme.lightTheme.textTheme.bodyMedium,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _cartItems.removeWhere((item) => item['id'] == itemId);
                });
                Navigator.of(context).pop();
              },
              child: const Text('Remove'),
            ),
          ],
        );
      },
    );
  }

  void _onPickupTimeSelected(DateTime time) {
    setState(() {
      _selectedPickupTime = time;
    });
  }

  void _onSpecialInstructionsChanged(String instructions) {
    setState(() {
      _specialInstructions = instructions;
    });
  }

  void _onPaymentMethodChanged(String method) {
    setState(() {
      _selectedPaymentMethod = method;
    });
  }

  Future<void> _placeOrder() async {
    if (_cartItems.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Your cart is empty')),
      );
      return;
    }

    if (_selectedPickupTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a pickup time')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      // Simulate order processing
      await Future.delayed(const Duration(seconds: 2));

      // Generate order token
      final orderToken =
          'CB${DateTime.now().millisecondsSinceEpoch.toString().substring(8)}';

      // Navigate to order confirmation
      Navigator.pushNamed(context, '/order-confirmation-screen', arguments: {
        'orderToken': orderToken,
        'items': _cartItems,
        'total': _total,
        'pickupTime': _selectedPickupTime,
        'specialInstructions': _specialInstructions,
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Order failed: ${e.toString()}')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.lightTheme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          'Your Order',
          style: AppTheme.lightTheme.textTheme.titleLarge,
        ),
        backgroundColor: AppTheme.lightTheme.scaffoldBackgroundColor,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: CustomIconWidget(
            iconName: 'arrow_back',
            color: AppTheme.lightTheme.colorScheme.onSurface,
            size: 24,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () => Navigator.pushNamed(context, '/menu-screen'),
            icon: CustomIconWidget(
              iconName: 'edit',
              color: AppTheme.primaryOrange,
              size: 24,
            ),
          ),
        ],
      ),
      body: _cartItems.isEmpty
          ? _buildEmptyCart()
          : Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding:
                        EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Cart Items Section
                        Text(
                          'Items (${_cartItems.length})',
                          style: AppTheme.lightTheme.textTheme.titleMedium
                              ?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 2.h),
                        ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: _cartItems.length,
                          separatorBuilder: (context, index) =>
                              SizedBox(height: 1.h),
                          itemBuilder: (context, index) {
                            final item = _cartItems[index];
                            return CartItemWidget(
                              item: item,
                              onQuantityChanged: (quantity) =>
                                  _updateQuantity(item['id'], quantity),
                              onRemove: () => _removeItem(item['id']),
                            );
                          },
                        ),
                        SizedBox(height: 3.h),

                        // Order Summary
                        OrderSummaryWidget(
                          subtotal: _subtotal,
                          taxes: _taxes,
                          total: _total,
                        ),
                        SizedBox(height: 3.h),

                        // Pickup Time Section
                        PickupTimeWidget(
                          selectedTime: _selectedPickupTime,
                          onTimeSelected: _onPickupTimeSelected,
                        ),
                        SizedBox(height: 2.h),

                        // AI Suggestion
                        AiSuggestionWidget(
                          onSuggestionSelected: _onPickupTimeSelected,
                        ),
                        SizedBox(height: 3.h),

                        // Special Instructions
                        SpecialInstructionsWidget(
                          instructions: _specialInstructions,
                          onChanged: _onSpecialInstructionsChanged,
                        ),
                        SizedBox(height: 3.h),

                        // Payment Method
                        PaymentMethodWidget(
                          selectedMethod: _selectedPaymentMethod,
                          onMethodChanged: _onPaymentMethodChanged,
                        ),
                        SizedBox(height: 10.h),
                      ],
                    ),
                  ),
                ),

                // Place Order Button
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(4.w),
                  decoration: BoxDecoration(
                    color: AppTheme.lightTheme.scaffoldBackgroundColor,
                    boxShadow: [
                      BoxShadow(
                        color: AppTheme.shadowLight,
                        blurRadius: 8,
                        offset: const Offset(0, -2),
                      ),
                    ],
                  ),
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _placeOrder,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.primaryOrange,
                      foregroundColor: AppTheme.pureWhite,
                      padding: EdgeInsets.symmetric(vertical: 2.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: _isLoading
                        ? SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              color: AppTheme.pureWhite,
                              strokeWidth: 2,
                            ),
                          )
                        : Text(
                            'Place Order • \$${_total.toStringAsFixed(2)}',
                            style: AppTheme.lightTheme.textTheme.titleMedium
                                ?.copyWith(
                              color: AppTheme.pureWhite,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                  ),
                ),
              ],
            ),
    );
  }

  Widget _buildEmptyCart() {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(8.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomIconWidget(
              iconName: 'shopping_cart_outlined',
              color: AppTheme.secondaryGray,
              size: 80,
            ),
            SizedBox(height: 3.h),
            Text(
              'Your cart is empty',
              style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
                color: AppTheme.secondaryGray,
              ),
            ),
            SizedBox(height: 1.h),
            Text(
              'Add some delicious items from our menu',
              style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                color: AppTheme.secondaryGray,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 4.h),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/menu-screen'),
              child: const Text('Browse Menu'),
            ),
          ],
        ),
      ),
    );
  }
}
