import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/app_export.dart';
import './widgets/account_settings_widget.dart';
import './widgets/order_history_widget.dart';
import './widgets/preferences_section_widget.dart';
import './widgets/profile_header_widget.dart';
import './widgets/quick_actions_widget.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int _currentIndex = 3; // Profile tab active
  bool _isLoading = false;

  // Mock user data
  final Map<String, dynamic> _userData = {
    "id": "user123",
    "name": "Sarah Johnson",
    "email": "sarah.johnson@university.edu",
    "university": "Tech University",
    "profileImage":
        "https://images.unsplash.com/photo-1494790108755-2616b9a1e0e0?fm=jpg&q=60&w=400&ixlib=rb-4.0.3",
    "joinDate": "September 2023",
    "totalOrders": 47,
    "favoriteCanteen": "Central Cafeteria"
  };

  // Mock order history data
  final List<Map<String, dynamic>> _orderHistory = [
    {
      "id": "ORD001",
      "date": "2024-01-15",
      "canteen": "Central Cafeteria",
      "items": ["Chicken Burger", "French Fries", "Coke"],
      "total": "\$12.50",
      "status": "Completed",
      "token": "A23",
      "pickupTime": "12:30 PM"
    },
    {
      "id": "ORD002",
      "date": "2024-01-14",
      "canteen": "Food Court",
      "items": ["Veggie Pizza", "Garlic Bread"],
      "total": "\$8.75",
      "status": "Completed",
      "token": "B15",
      "pickupTime": "1:15 PM"
    },
    {
      "id": "ORD003",
      "date": "2024-01-12",
      "canteen": "Snack Corner",
      "items": ["Sandwich", "Coffee", "Cookies"],
      "total": "\$6.25",
      "status": "Completed",
      "token": "C08",
      "pickupTime": "10:45 AM"
    }
  ];

  Future<void> _refreshProfile() async {
    setState(() {
      _isLoading = true;
    });

    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      _isLoading = false;
    });
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Logout',
            style: AppTheme.lightTheme.textTheme.titleLarge,
          ),
          content: Text(
            'Are you sure you want to logout?',
            style: AppTheme.lightTheme.textTheme.bodyMedium,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            // ElevatedButton(
            //   onPressed: () {
            //     Navigator.of(context).pop();
            //     // Handle logout logic here
            //     Navigator.pushReplacementNamed(context, '/login-screen');
            //   },
            //   child: const Text('Logout'),
            // ),
            ElevatedButton(
              onPressed: () async {
                final prefs = await SharedPreferences.getInstance();
                await prefs.setBool(
                    'isLoggedIn', false); // Set login state to false
                Navigator.of(context).pop();
                Navigator.pushReplacementNamed(context, '/login-screen');
              },
              child: const Text('Logout'),
            ),
          ],
        );
      },
    );
  }

  void _onBottomNavTap(int index) {
    setState(() {
      _currentIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.pushReplacementNamed(context, '/home-screen');
        break;
      case 1:
        Navigator.pushReplacementNamed(context, '/menu-screen');
        break;
      case 2:
        Navigator.pushReplacementNamed(context, '/orders-screen');
        break;
      case 3:
        // Already on profile screen
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.lightTheme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          'Profile',
          style: AppTheme.lightTheme.appBarTheme.titleTextStyle,
        ),
        backgroundColor: AppTheme.lightTheme.appBarTheme.backgroundColor,
        elevation: AppTheme.lightTheme.appBarTheme.elevation,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/settings-screen');
            },
            icon: CustomIconWidget(
              iconName: 'settings',
              color: AppTheme.lightTheme.colorScheme.onSurface,
              size: 24,
            ),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _refreshProfile,
        color: AppTheme.lightTheme.colorScheme.primary,
        child: _isLoading
            ? Center(
                child: CircularProgressIndicator(
                  color: AppTheme.lightTheme.colorScheme.primary,
                ),
              )
            : SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  children: [
                    SizedBox(height: 2.h),
                    ProfileHeaderWidget(userData: _userData),
                    SizedBox(height: 3.h),
                    OrderHistoryWidget(orderHistory: _orderHistory),
                    SizedBox(height: 3.h),
                    PreferencesSectionWidget(),
                    SizedBox(height: 3.h),
                    AccountSettingsWidget(),
                    SizedBox(height: 3.h),
                    QuickActionsWidget(),
                    SizedBox(height: 3.h),
                    Container(
                      width: 90.w,
                      margin: EdgeInsets.symmetric(horizontal: 5.w),
                      child: ElevatedButton(
                        onPressed: _showLogoutDialog,
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              AppTheme.lightTheme.colorScheme.error,
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(vertical: 2.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomIconWidget(
                              iconName: 'logout',
                              color: Colors.white,
                              size: 20,
                            ),
                            SizedBox(width: 2.w),
                            Text(
                              'Logout',
                              style: AppTheme.lightTheme.textTheme.titleMedium
                                  ?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      'Zapit v1.0.0',
                      style: AppTheme.lightTheme.textTheme.bodySmall,
                    ),
                    SizedBox(height: 1.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/terms-screen');
                          },
                          child: Text(
                            'Terms of Service',
                            style: AppTheme.lightTheme.textTheme.bodySmall
                                ?.copyWith(
                              color: AppTheme.lightTheme.colorScheme.primary,
                            ),
                          ),
                        ),
                        Text(
                          ' • ',
                          style: AppTheme.lightTheme.textTheme.bodySmall,
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/privacy-screen');
                          },
                          child: Text(
                            'Privacy Policy',
                            style: AppTheme.lightTheme.textTheme.bodySmall
                                ?.copyWith(
                              color: AppTheme.lightTheme.colorScheme.primary,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 3.h),
                  ],
                ),
              ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onBottomNavTap,
        type: BottomNavigationBarType.fixed,
        backgroundColor:
            AppTheme.lightTheme.bottomNavigationBarTheme.backgroundColor,
        selectedItemColor:
            AppTheme.lightTheme.bottomNavigationBarTheme.selectedItemColor,
        unselectedItemColor:
            AppTheme.lightTheme.bottomNavigationBarTheme.unselectedItemColor,
        selectedLabelStyle:
            AppTheme.lightTheme.bottomNavigationBarTheme.selectedLabelStyle,
        unselectedLabelStyle:
            AppTheme.lightTheme.bottomNavigationBarTheme.unselectedLabelStyle,
        elevation: AppTheme.lightTheme.bottomNavigationBarTheme.elevation ?? 8,
        items: [
          BottomNavigationBarItem(
            icon: CustomIconWidget(
              iconName: 'home',
              color: _currentIndex == 0
                  ? AppTheme.lightTheme.colorScheme.primary
                  : AppTheme.lightTheme.colorScheme.onSurfaceVariant,
              size: 24,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: CustomIconWidget(
              iconName: 'restaurant_menu',
              color: _currentIndex == 1
                  ? AppTheme.lightTheme.colorScheme.primary
                  : AppTheme.lightTheme.colorScheme.onSurfaceVariant,
              size: 24,
            ),
            label: 'Menu',
          ),
          BottomNavigationBarItem(
            icon: CustomIconWidget(
              iconName: 'receipt_long',
              color: _currentIndex == 2
                  ? AppTheme.lightTheme.colorScheme.primary
                  : AppTheme.lightTheme.colorScheme.onSurfaceVariant,
              size: 24,
            ),
            label: 'Orders',
          ),
          BottomNavigationBarItem(
            icon: CustomIconWidget(
              iconName: 'person',
              color: _currentIndex == 3
                  ? AppTheme.lightTheme.colorScheme.primary
                  : AppTheme.lightTheme.colorScheme.onSurfaceVariant,
              size: 24,
            ),
            label: 'Profile',
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/chat-assistant-screen');
        },
        backgroundColor:
            AppTheme.lightTheme.floatingActionButtonTheme.backgroundColor,
        child: CustomIconWidget(
          iconName: 'chat',
          color: Colors.white,
          size: 24,
        ),
      ),
    );
  }
}
