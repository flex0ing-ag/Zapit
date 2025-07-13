import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import './widgets/empty_state_widget.dart';
import './widgets/filter_bottom_sheet_widget.dart';
import './widgets/order_card_widget.dart';
import './widgets/order_stats_widget.dart';

class OrderHistoryScreen extends StatefulWidget {
  const OrderHistoryScreen({super.key});

  @override
  State<OrderHistoryScreen> createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends State<OrderHistoryScreen>
    with TickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();

  bool _isLoading = false;
  bool _isSearching = false;
  String _searchQuery = '';
  Map<String, dynamic> _filters = {};

  late TabController _tabController;

  // Mock order data
  final List<Map<String, dynamic>> _allOrders = [
    {
      "id": "ORD001",
      "canteenName": "Central Canteen",
      "orderDate": DateTime.now().subtract(Duration(hours: 2)),
      "totalAmount": "\$24.50",
      "status": "completed",
      "items": [
        {
          "name": "Chicken Biryani",
          "quantity": 1,
          "price": "\$12.00",
          "image":
              "https://images.pexels.com/photos/1893556/pexels-photo-1893556.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"
        },
        {
          "name": "Mango Lassi",
          "quantity": 2,
          "price": "\$6.25",
          "image":
              "https://images.pexels.com/photos/1337825/pexels-photo-1337825.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"
        }
      ],
      "tokenNumber": "T001",
      "pickupTime": "2:30 PM",
      "rating": 4.5
    },
    {
      "id": "ORD002",
      "canteenName": "North Campus Cafe",
      "orderDate": DateTime.now().subtract(Duration(hours: 5)),
      "totalAmount": "\$18.75",
      "status": "pending",
      "items": [
        {
          "name": "Veggie Burger",
          "quantity": 1,
          "price": "\$8.50",
          "image":
              "https://images.pexels.com/photos/1639557/pexels-photo-1639557.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"
        },
        {
          "name": "French Fries",
          "quantity": 1,
          "price": "\$4.25",
          "image":
              "https://images.pexels.com/photos/1583884/pexels-photo-1583884.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"
        },
        {
          "name": "Coke",
          "quantity": 1,
          "price": "\$6.00",
          "image":
              "https://images.pexels.com/photos/50593/coca-cola-cold-drink-soft-drink-coke-50593.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"
        }
      ],
      "tokenNumber": "T002",
      "pickupTime": "6:00 PM"
    },
    {
      "id": "ORD003",
      "canteenName": "South Block Snacks",
      "orderDate": DateTime.now().subtract(Duration(days: 1)),
      "totalAmount": "\$15.30",
      "status": "completed",
      "items": [
        {
          "name": "Samosa",
          "quantity": 3,
          "price": "\$4.50",
          "image":
              "https://images.pexels.com/photos/14477797/pexels-photo-14477797.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"
        },
        {
          "name": "Chai",
          "quantity": 2,
          "price": "\$5.40",
          "image":
              "https://images.pexels.com/photos/1638280/pexels-photo-1638280.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"
        },
        {
          "name": "Pakora",
          "quantity": 1,
          "price": "\$5.40",
          "image":
              "https://images.pexels.com/photos/5560763/pexels-photo-5560763.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"
        }
      ],
      "tokenNumber": "T003",
      "pickupTime": "4:15 PM",
      "rating": 4.0
    },
    {
      "id": "ORD004",
      "canteenName": "Central Canteen",
      "orderDate": DateTime.now().subtract(Duration(days: 3)),
      "totalAmount": "\$32.80",
      "status": "completed",
      "items": [
        {
          "name": "Paneer Tikka",
          "quantity": 1,
          "price": "\$14.00",
          "image":
              "https://images.pexels.com/photos/2474661/pexels-photo-2474661.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"
        },
        {
          "name": "Naan",
          "quantity": 2,
          "price": "\$8.00",
          "image":
              "https://images.pexels.com/photos/5560763/pexels-photo-5560763.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"
        },
        {
          "name": "Dal Makhani",
          "quantity": 1,
          "price": "\$10.80",
          "image":
              "https://images.pexels.com/photos/5560763/pexels-photo-5560763.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"
        }
      ],
      "tokenNumber": "T004",
      "pickupTime": "1:45 PM",
      "rating": 5.0
    },
    {
      "id": "ORD005",
      "canteenName": "North Campus Cafe",
      "orderDate": DateTime.now().subtract(Duration(days: 7)),
      "totalAmount": "\$21.60",
      "status": "completed",
      "items": [
        {
          "name": "Pizza Slice",
          "quantity": 2,
          "price": "\$12.00",
          "image":
              "https://images.pexels.com/photos/315755/pexels-photo-315755.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"
        },
        {
          "name": "Garlic Bread",
          "quantity": 1,
          "price": "\$5.60",
          "image":
              "https://images.pexels.com/photos/4109111/pexels-photo-4109111.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"
        },
        {
          "name": "Pepsi",
          "quantity": 1,
          "price": "\$4.00",
          "image":
              "https://images.pexels.com/photos/50593/coca-cola-cold-drink-soft-drink-coke-50593.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"
        }
      ],
      "tokenNumber": "T005",
      "pickupTime": "7:30 PM",
      "rating": 4.2
    }
  ];

  List<Map<String, dynamic>> _filteredOrders = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _filteredOrders = List.from(_allOrders);
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      _loadMoreOrders();
    }
  }

  void _loadMoreOrders() {
    if (!_isLoading) {
      setState(() {
        _isLoading = true;
      });

      // Simulate loading more orders
      Future.delayed(Duration(seconds: 1), () {
        setState(() {
          _isLoading = false;
        });
      });
    }
  }

  void _onSearchChanged(String query) {
    setState(() {
      _searchQuery = query;
      _filteredOrders = _allOrders.where((order) {
        final canteenName = order['canteenName'].toString().toLowerCase();
        final items = (order['items'] as List)
            .map((item) => item['name'].toString().toLowerCase())
            .join(' ');
        return canteenName.contains(query.toLowerCase()) ||
            items.contains(query.toLowerCase());
      }).toList();
    });
  }

  void _showFilterBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => FilterBottomSheetWidget(
        currentFilters: _filters,
        onFiltersApplied: (filters) {
          setState(() {
            _filters = filters;
            _applyFilters();
          });
        },
      ),
    );
  }

  void _applyFilters() {
    List<Map<String, dynamic>> filtered = List.from(_allOrders);

    if (_filters['status'] != null && _filters['status'] != 'all') {
      filtered = filtered
          .where((order) => order['status'] == _filters['status'])
          .toList();
    }

    if (_filters['canteen'] != null && _filters['canteen'] != 'all') {
      filtered = filtered
          .where((order) => order['canteenName'] == _filters['canteen'])
          .toList();
    }

    if (_filters['dateRange'] != null) {
      final dateRange = _filters['dateRange'] as DateTimeRange;
      filtered = filtered.where((order) {
        final orderDate = order['orderDate'] as DateTime;
        return orderDate.isAfter(dateRange.start.subtract(Duration(days: 1))) &&
            orderDate.isBefore(dateRange.end.add(Duration(days: 1)));
      }).toList();
    }

    setState(() {
      _filteredOrders = filtered;
    });
  }

  void _onReorder(Map<String, dynamic> order) {
    Navigator.pushNamed(context, '/cart-and-checkout-screen');
  }

  void _onTrackOrder(Map<String, dynamic> order) {
    Navigator.pushNamed(context, '/order-status-screen');
  }

  void _onDeleteOrder(Map<String, dynamic> order) {
    setState(() {
      _allOrders.removeWhere((o) => o['id'] == order['id']);
      _filteredOrders.removeWhere((o) => o['id'] == order['id']);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Order deleted successfully'),
        backgroundColor: AppTheme.lightTheme.colorScheme.error,
      ),
    );
  }

  void _onViewReceipt(Map<String, dynamic> order) {
    // Show receipt dialog or navigate to receipt screen
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Order Receipt'),
        content: Text('Receipt for Order #${order['tokenNumber']}'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Close'),
          ),
        ],
      ),
    );
  }

  void _onRateOrder(Map<String, dynamic> order) {
    // Show rating dialog
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Rate Your Order'),
        content: Text('How was your experience with ${order['canteenName']}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Submit'),
          ),
        ],
      ),
    );
  }

  Map<String, List<Map<String, dynamic>>> _groupOrdersByDate() {
    final Map<String, List<Map<String, dynamic>>> grouped = {};
    final now = DateTime.now();

    for (final order in _filteredOrders) {
      final orderDate = order['orderDate'] as DateTime;
      final difference = now.difference(orderDate).inDays;

      String key;
      if (difference == 0) {
        key = 'Today';
      } else if (difference == 1) {
        key = 'Yesterday';
      } else if (difference <= 7) {
        key = 'This Week';
      } else {
        key = 'Earlier';
      }

      if (!grouped.containsKey(key)) {
        grouped[key] = [];
      }
      grouped[key]!.add(order);
    }

    return grouped;
  }

  Future<void> _onRefresh() async {
    setState(() {
      _isLoading = true;
    });

    // Simulate refresh
    await Future.delayed(Duration(seconds: 1));

    setState(() {
      _isLoading = false;
      _filteredOrders = List.from(_allOrders);
    });
  }

  @override
  Widget build(BuildContext context) {
    final groupedOrders = _groupOrdersByDate();

    return Scaffold(
      backgroundColor: AppTheme.lightTheme.scaffoldBackgroundColor,
      appBar: AppBar(
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
        title: _isSearching
            ? TextField(
                controller: _searchController,
                autofocus: true,
                decoration: InputDecoration(
                  hintText: 'Search orders...',
                  border: InputBorder.none,
                  hintStyle: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                    color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                  ),
                ),
                style: AppTheme.lightTheme.textTheme.bodyMedium,
                onChanged: _onSearchChanged,
              )
            : Text(
                'Order History',
                style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                _isSearching = !_isSearching;
                if (!_isSearching) {
                  _searchController.clear();
                  _onSearchChanged('');
                }
              });
            },
            icon: CustomIconWidget(
              iconName: _isSearching ? 'close' : 'search',
              color: AppTheme.lightTheme.colorScheme.onSurface,
              size: 24,
            ),
          ),
          IconButton(
            onPressed: _showFilterBottomSheet,
            icon: CustomIconWidget(
              iconName: 'filter_list',
              color: AppTheme.lightTheme.colorScheme.onSurface,
              size: 24,
            ),
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: 'All Orders'),
            Tab(text: 'Completed'),
            Tab(text: 'Pending'),
          ],
        ),
      ),
      body: _filteredOrders.isEmpty
          ? EmptyStateWidget(
              onStartOrdering: () =>
                  Navigator.pushNamed(context, '/home-screen'),
            )
          : Column(
              children: [
                OrderStatsWidget(orders: _allOrders),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      _buildOrdersList(groupedOrders),
                      _buildOrdersList(_groupOrdersByStatus('completed')),
                      _buildOrdersList(_groupOrdersByStatus('pending')),
                    ],
                  ),
                ),
              ],
            ),
    );
  }

  Map<String, List<Map<String, dynamic>>> _groupOrdersByStatus(String status) {
    final filteredByStatus =
        _filteredOrders.where((order) => order['status'] == status).toList();
    final Map<String, List<Map<String, dynamic>>> grouped = {};
    final now = DateTime.now();

    for (final order in filteredByStatus) {
      final orderDate = order['orderDate'] as DateTime;
      final difference = now.difference(orderDate).inDays;

      String key;
      if (difference == 0) {
        key = 'Today';
      } else if (difference == 1) {
        key = 'Yesterday';
      } else if (difference <= 7) {
        key = 'This Week';
      } else {
        key = 'Earlier';
      }

      if (!grouped.containsKey(key)) {
        grouped[key] = [];
      }
      grouped[key]!.add(order);
    }

    return grouped;
  }

  Widget _buildOrdersList(
      Map<String, List<Map<String, dynamic>>> groupedOrders) {
    if (groupedOrders.isEmpty) {
      return Center(
        child: Text(
          'No orders found',
          style: AppTheme.lightTheme.textTheme.bodyLarge?.copyWith(
            color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
          ),
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: _onRefresh,
      color: AppTheme.lightTheme.colorScheme.primary,
      child: ListView.builder(
        controller: _scrollController,
        padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
        itemCount: groupedOrders.length + (_isLoading ? 1 : 0),
        itemBuilder: (context, index) {
          if (index == groupedOrders.length) {
            return Center(
              child: Padding(
                padding: EdgeInsets.all(4.w),
                child: CircularProgressIndicator(
                  color: AppTheme.lightTheme.colorScheme.primary,
                ),
              ),
            );
          }

          final section = groupedOrders.keys.elementAt(index);
          final orders = groupedOrders[section]!;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 1.h),
                child: Text(
                  section,
                  style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppTheme.lightTheme.colorScheme.onSurface,
                  ),
                ),
              ),
              ...orders
                  .map((order) => OrderCardWidget(
                        order: order,
                        onReorder: () => _onReorder(order),
                        onTrackOrder: () => _onTrackOrder(order),
                        onDelete: () => _onDeleteOrder(order),
                        onViewReceipt: () => _onViewReceipt(order),
                        onRateOrder: () => _onRateOrder(order),
                      ))
                  ,
              SizedBox(height: 2.h),
            ],
          );
        },
      ),
    );
  }
}
