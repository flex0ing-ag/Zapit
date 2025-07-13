import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import './widgets/ai_suggestion_card_widget.dart';
import './widgets/cart_summary_bar_widget.dart';
import './widgets/category_tab_widget.dart';
import './widgets/filter_bottom_sheet_widget.dart';
import './widgets/food_item_card_widget.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> with TickerProviderStateMixin {
  late TabController _tabController;
  final ScrollController _scrollController = ScrollController();
  String selectedCategory = 'Snacks';
  bool isLoading = false;
  int cartItemCount = 3;
  double cartTotal = 245.50;

  // Mock data for categories
  final List<String> categories = ['Snacks', 'Main Course', 'Beverages'];

  // Mock data for AI suggestion
  final Map<String, dynamic> aiSuggestion = {
    "title": "Masala Dosa",
    "reason":
        "Perfect for lunch time! Light, crispy, and popular among students right now.",
    "prepTime": "12 mins",
    "image":
        "https://images.unsplash.com/photo-1630383249896-424e482df921?fm=jpg&q=60&w=3000",
    "price": "\$8.50"
  };

  // Mock data for food items
  final List<Map<String, dynamic>> foodItems = [
    {
      "id": 1,
      "name": "Chicken Biryani",
      "price": "\$12.99",
      "image":
          "https://images.unsplash.com/photo-1563379091339-03246963d51a?fm=jpg&q=60&w=3000",
      "isVeg": false,
      "isAvailable": true,
      "prepTime": "25 mins",
      "category": "Main Course",
      "description":
          "Aromatic basmati rice cooked with tender chicken pieces and traditional spices",
      "rating": 4.5,
      "quantity": 0
    },
    {
      "id": 2,
      "name": "Samosa",
      "price": "\$3.50",
      "image":
          "https://images.unsplash.com/photo-1601050690597-df0568f70950?fm=jpg&q=60&w=3000",
      "isVeg": true,
      "isAvailable": true,
      "prepTime": "8 mins",
      "category": "Snacks",
      "description":
          "Crispy golden pastry filled with spiced potatoes and peas",
      "rating": 4.2,
      "quantity": 2
    },
    {
      "id": 3,
      "name": "Masala Chai",
      "price": "\$2.25",
      "image":
          "https://images.unsplash.com/photo-1571934811356-5cc061b6821f?fm=jpg&q=60&w=3000",
      "isVeg": true,
      "isAvailable": true,
      "prepTime": "5 mins",
      "category": "Beverages",
      "description":
          "Traditional Indian spiced tea brewed with milk and aromatic spices",
      "rating": 4.7,
      "quantity": 1
    },
    {
      "id": 4,
      "name": "Paneer Butter Masala",
      "price": "\$10.75",
      "image":
          "https://images.unsplash.com/photo-1631452180519-c014fe946bc7?fm=jpg&q=60&w=3000",
      "isVeg": true,
      "isAvailable": false,
      "prepTime": "20 mins",
      "category": "Main Course",
      "description": "Soft paneer cubes in rich tomato and butter gravy",
      "rating": 4.3,
      "quantity": 0
    },
    {
      "id": 5,
      "name": "Vada Pav",
      "price": "\$4.00",
      "image":
          "https://images.unsplash.com/photo-1606491956689-2ea866880c84?fm=jpg&q=60&w=3000",
      "isVeg": true,
      "isAvailable": true,
      "prepTime": "10 mins",
      "category": "Snacks",
      "description":
          "Mumbai's favorite street food - spiced potato fritter in a bun",
      "rating": 4.1,
      "quantity": 0
    },
    {
      "id": 6,
      "name": "Fresh Lime Soda",
      "price": "\$3.25",
      "image":
          "https://images.unsplash.com/photo-1513558161293-cdaf765ed2fd?fm=jpg&q=60&w=3000",
      "isVeg": true,
      "isAvailable": true,
      "prepTime": "3 mins",
      "category": "Beverages",
      "description": "Refreshing lime juice with soda water and mint",
      "rating": 4.0,
      "quantity": 0
    }
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: categories.length, vsync: this);
    _tabController.addListener(_handleTabChange);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _handleTabChange() {
    if (_tabController.indexIsChanging) {
      setState(() {
        selectedCategory = categories[_tabController.index];
      });
    }
  }

  List<Map<String, dynamic>> get filteredItems {
    return foodItems
        .where((item) => (item['category'] as String) == selectedCategory)
        .toList();
  }

  void _updateQuantity(int itemId, int change) {
    setState(() {
      final itemIndex = foodItems.indexWhere((item) => item['id'] == itemId);
      if (itemIndex != -1) {
        final currentQuantity = foodItems[itemIndex]['quantity'] as int;
        final newQuantity = (currentQuantity + change).clamp(0, 10);
        foodItems[itemIndex]['quantity'] = newQuantity;

        // Update cart count and total
        _updateCartSummary();
      }
    });
  }

  void _updateCartSummary() {
    int totalItems = 0;
    double total = 0.0;

    for (var item in foodItems) {
      final quantity = item['quantity'] as int;
      if (quantity > 0) {
        totalItems += quantity;
        final priceString = item['price'] as String;
        final price = double.parse(priceString.replaceAll('\$', ''));
        total += price * quantity;
      }
    }

    cartItemCount = totalItems;
    cartTotal = total;
  }

  Future<void> _refreshMenu() async {
    setState(() {
      isLoading = true;
    });

    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      isLoading = false;
    });
  }

  void _showFilterBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => FilterBottomSheetWidget(
        onApplyFilters: (filters) {
          // Handle filter application
          Navigator.pop(context);
        },
      ),
    );
  }

  void _navigateToSearch() {
    // Navigate to search screen
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Search functionality coming soon!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.lightTheme.scaffoldBackgroundColor,
      body: Stack(
        children: [
          CustomScrollView(
            controller: _scrollController,
            slivers: [
              // App Bar
              SliverAppBar(
                backgroundColor: AppTheme.lightTheme.scaffoldBackgroundColor,
                elevation: 0,
                pinned: true,
                floating: false,
                expandedHeight: 12.h,
                leading: IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: CustomIconWidget(
                    iconName: 'arrow_back',
                    color: AppTheme.lightTheme.colorScheme.onSurface,
                    size: 24,
                  ),
                ),
                title: Text(
                  'Central Canteen',
                  style: AppTheme.lightTheme.textTheme.titleLarge,
                ),
                actions: [
                  IconButton(
                    onPressed: _navigateToSearch,
                    icon: CustomIconWidget(
                      iconName: 'search',
                      color: AppTheme.lightTheme.colorScheme.onSurface,
                      size: 24,
                    ),
                  ),
                  IconButton(
                    onPressed: _showFilterBottomSheet,
                    icon: CustomIconWidget(
                      iconName: 'tune',
                      color: AppTheme.lightTheme.colorScheme.onSurface,
                      size: 24,
                    ),
                  ),
                  Stack(
                    children: [
                      IconButton(
                        onPressed: () => Navigator.pushNamed(
                            context, '/cart-and-checkout-screen'),
                        icon: CustomIconWidget(
                          iconName: 'shopping_cart',
                          color: AppTheme.lightTheme.colorScheme.onSurface,
                          size: 24,
                        ),
                      ),
                      if (cartItemCount > 0)
                        Positioned(
                          right: 8,
                          top: 8,
                          child: Container(
                            padding: EdgeInsets.all(0.5.w),
                            decoration: BoxDecoration(
                              color: AppTheme.primaryOrange,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            constraints: BoxConstraints(
                              minWidth: 4.w,
                              minHeight: 4.w,
                            ),
                            child: Text(
                              cartItemCount.toString(),
                              style: AppTheme.lightTheme.textTheme.labelSmall
                                  ?.copyWith(
                                color: AppTheme.pureWhite,
                                fontWeight: FontWeight.w600,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                    ],
                  ),
                  SizedBox(width: 2.w),
                ],
              ),

              // Category Tabs
              SliverPersistentHeader(
                pinned: true,
                delegate: _SliverAppBarDelegate(
                  minHeight: 8.h,
                  maxHeight: 8.h,
                  child: Container(
                    color: AppTheme.lightTheme.scaffoldBackgroundColor,
                    child: CategoryTabWidget(
                      tabController: _tabController,
                      categories: categories,
                      selectedCategory: selectedCategory,
                    ),
                  ),
                ),
              ),

              // AI Suggestion Card
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
                  child: AiSuggestionCardWidget(
                    suggestion: aiSuggestion,
                    onTap: () {
                      // Handle AI suggestion tap
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('AI suggestion tapped!')),
                      );
                    },
                  ),
                ),
              ),

              // Food Items List
              SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: 4.w),
                sliver: isLoading
                    ? SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) => _buildSkeletonCard(),
                          childCount: 6,
                        ),
                      )
                    : SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            final item = filteredItems[index];
                            return Padding(
                              padding: EdgeInsets.only(bottom: 2.h),
                              child: FoodItemCardWidget(
                                item: item,
                                onQuantityChanged: _updateQuantity,
                                onTap: () => _showItemDetails(item),
                              ),
                            );
                          },
                          childCount: filteredItems.length,
                        ),
                      ),
              ),

              // Bottom spacing for cart summary bar
              SliverToBoxAdapter(
                child: SizedBox(height: 12.h),
              ),
            ],
          ),

          // Pull to refresh indicator
          if (isLoading)
            Positioned(
              top: 20.h,
              left: 0,
              right: 0,
              child: Center(
                child: CircularProgressIndicator(
                  color: AppTheme.primaryOrange,
                ),
              ),
            ),
        ],
      ),

      // Cart Summary Bar
      bottomSheet: cartItemCount > 0
          ? CartSummaryBarWidget(
              itemCount: cartItemCount,
              total: cartTotal,
              onCheckout: () =>
                  Navigator.pushNamed(context, '/cart-and-checkout-screen'),
            )
          : null,
    );
  }

  Widget _buildSkeletonCard() {
    return Container(
      margin: EdgeInsets.only(bottom: 2.h),
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
          Container(
            width: 20.w,
            height: 20.w,
            decoration: BoxDecoration(
              color: AppTheme.lightBorder,
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          SizedBox(width: 4.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 2.h,
                  width: 60.w,
                  color: AppTheme.lightBorder,
                ),
                SizedBox(height: 1.h),
                Container(
                  height: 1.5.h,
                  width: 40.w,
                  color: AppTheme.lightBorder,
                ),
                SizedBox(height: 1.h),
                Container(
                  height: 1.5.h,
                  width: 30.w,
                  color: AppTheme.lightBorder,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showItemDetails(Map<String, dynamic> item) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: 70.h,
        decoration: BoxDecoration(
          color: AppTheme.lightTheme.scaffoldBackgroundColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          children: [
            // Handle bar
            Container(
              margin: EdgeInsets.only(top: 2.h),
              width: 12.w,
              height: 0.5.h,
              decoration: BoxDecoration(
                color: AppTheme.lightBorder,
                borderRadius: BorderRadius.circular(2),
              ),
            ),

            // Item details content
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(4.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Item image
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: CustomImageWidget(
                        imageUrl: item['image'] as String,
                        width: double.infinity,
                        height: 25.h,
                        fit: BoxFit.cover,
                      ),
                    ),

                    SizedBox(height: 2.h),

                    // Item name and veg indicator
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            item['name'] as String,
                            style: AppTheme.lightTheme.textTheme.headlineSmall,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(1.w),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: (item['isVeg'] as bool)
                                  ? AppTheme.successGreen
                                  : AppTheme.alertRed,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Container(
                            width: 2.w,
                            height: 2.w,
                            decoration: BoxDecoration(
                              color: (item['isVeg'] as bool)
                                  ? AppTheme.successGreen
                                  : AppTheme.alertRed,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 1.h),

                    // Price and prep time
                    Row(
                      children: [
                        Text(
                          item['price'] as String,
                          style: AppTheme.lightTheme.textTheme.titleLarge
                              ?.copyWith(
                            color: AppTheme.primaryOrange,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const Spacer(),
                        CustomIconWidget(
                          iconName: 'access_time',
                          color: AppTheme.secondaryGray,
                          size: 16,
                        ),
                        SizedBox(width: 1.w),
                        Text(
                          item['prepTime'] as String,
                          style: AppTheme.lightTheme.textTheme.bodySmall,
                        ),
                      ],
                    ),

                    SizedBox(height: 2.h),

                    // Description
                    Text(
                      'Description',
                      style: AppTheme.lightTheme.textTheme.titleMedium,
                    ),
                    SizedBox(height: 1.h),
                    Text(
                      item['description'] as String,
                      style: AppTheme.lightTheme.textTheme.bodyMedium,
                    ),

                    const Spacer(),

                    // Add to cart button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: (item['isAvailable'] as bool)
                            ? () {
                                _updateQuantity(item['id'] as int, 1);
                                Navigator.pop(context);
                              }
                            : null,
                        child: Text(
                          (item['isAvailable'] as bool)
                              ? 'Add to Cart'
                              : 'Out of Stock',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final double minHeight;
  final double maxHeight;
  final Widget child;

  _SliverAppBarDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => maxHeight;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}
