import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import './widgets/canteen_card_widget.dart';
import './widgets/greeting_header_widget.dart';
import './widgets/search_bar_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  int _currentIndex = 0;
  String _searchQuery = '';
  final TextEditingController _searchController = TextEditingController();
  bool _isRefreshing = false;

  final List<Map<String, dynamic>> canteenData = [
    {
      "id": 1,
      "name": "Central Canteen",
      "isOpen": true,
      "openTime": "7:00 AM",
      "closeTime": "10:00 PM",
      "estimatedWaitTime": "15-20 min",
      "isVeg": true,
      "isNonVeg": true,
      "heroImage": "https://images.pexels.com/photos/1640777/pexels-photo-1640777.jpeg",
      "rating": 4.5,
      "totalOrders": 1250,
      "specialty": "North Indian & Chinese",
      "isFavorite": true
    },
    {
      "id": 2,
      "name": "South Block Cafe",
      "isOpen": true,
      "openTime": "8:00 AM",
      "closeTime": "9:00 PM",
      "estimatedWaitTime": "10-15 min",
      "isVeg": true,
      "isNonVeg": false,
      "heroImage": "https://images.pexels.com/photos/1279330/pexels-photo-1279330.jpeg",
      "rating": 4.2,
      "totalOrders": 890,
      "specialty": "South Indian & Snacks",
      "isFavorite": false
    },
    {
      "id": 3,
      "name": "Snakie",
      "isOpen": true,
      "openTime": "8:00 AM",
      "closeTime": "9:00 PM",
      "estimatedWaitTime": "10-15 min",
      "isVeg": true,
      "isNonVeg": false,
      "heroImage": "https://images.pexels.com/photos/1279330/pexels-photo-1279330.jpeg",
      "rating": 4.2,
      "totalOrders": 890,
      "specialty": "South Indian & Snacks",
      "isFavorite": false
    },
  ];

  Future<void> _handleRefresh() async {
    setState(() {
      _isRefreshing = true;
    });
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      _isRefreshing = false;
    });
  }

  void _onSearchChanged(String query) {
    setState(() {
      _searchQuery = query;
    });
  }

  void _onBottomNavTap(int index) {
    setState(() {
      _currentIndex = index;
    });
    switch (index) {
      case 1:
        Navigator.pushNamed(context, '/order-history-screen');
        break;
      case 2:
        Navigator.pushNamed(context, '/profile-screen');
        break;
    }
  }

  void _onCanteenTap(Map<String, dynamic> canteen) {
    if (canteen["isOpen"] == true) {
      Navigator.pushNamed(context, '/menu-screen', arguments: canteen);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${canteen["name"]} is currently closed'),
          backgroundColor: AppTheme.alertRed,
        ),
      );
    }
  }

  void _onCanteenLongPress(Map<String, dynamic> canteen) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: EdgeInsets.all(4.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 12.w,
              height: 0.5.h,
              decoration: BoxDecoration(
                color: AppTheme.lightBorder,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            SizedBox(height: 3.h),
            Text(canteen["name"], style: AppTheme.lightTheme.textTheme.titleLarge),
            SizedBox(height: 3.h),
            ListTile(
              leading: Icon(Icons.menu_book),
              title: Text('View Menu'),
              onTap: () {
                Navigator.pop(context);
                _onCanteenTap(canteen);
              },
            ),
            ListTile(
              leading: Icon(Icons.favorite_border),
              title: Text('Set as Favorite'),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('${canteen["name"]} added to favorites')),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  List<Map<String, dynamic>> get _filteredCanteens {
    if (_searchQuery.isEmpty) return canteenData;
    return canteenData.where((canteen) {
      final name = (canteen['name'] as String).toLowerCase();
      final query = _searchQuery.toLowerCase();
      return name.contains(query);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.lightTheme.scaffoldBackgroundColor,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: _handleRefresh,
          color: AppTheme.primaryOrange,
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: GreetingHeaderWidget(
                  userName: "Alex",
                  notificationCount: 2,
                  onNotificationTap: () {
                    Navigator.pushNamed(context, '/order-status-screen');
                  },
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4.w),
                  child: SearchBarWidget(
                    controller: _searchController,
                    onChanged: _onSearchChanged,
                  ),
                ),
              ),
              SliverToBoxAdapter(child: SizedBox(height: 2.h)),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final canteen = _filteredCanteens[index];
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
                      child: CanteenCardWidget(
                        canteen: canteen,
                        onTap: () => _onCanteenTap(canteen),
                        onLongPress: () => _onCanteenLongPress(canteen),
                      ),
                    );
                  },
                  childCount: _filteredCanteens.length,
                ),
              ),
              SliverToBoxAdapter(child: SizedBox(height: 10.h)),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onBottomNavTap,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppTheme.primaryOrange,
        unselectedItemColor: AppTheme.secondaryGray,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.receipt_long), label: 'Orders'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        backgroundColor: AppTheme.primaryOrange,
        icon: Icon(Icons.auto_awesome),
        label: Text('AI Suggest'),
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
// This code defines a HomeScreen widget for a Flutter application that displays a list of canteens with search functionality, a greeting header, and a bottom navigation bar. It includes features like refreshing the list, searching canteens, and handling taps and long presses on canteen cards.