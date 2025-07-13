import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import '../../theme/app_theme.dart';
import './widgets/auth_form_widget.dart';
import './widgets/forgot_password_modal.dart';
import './widgets/social_auth_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
class AuthenticationScreen extends StatefulWidget {
  const AuthenticationScreen({super.key});

  @override
  State<AuthenticationScreen> createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool _isLoading = false;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _showForgotPasswordModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => ForgotPasswordModal(),
    );
  }

  // void _handleAuthSuccess() {
  //   HapticFeedback.lightImpact();
  //   Navigator.pushReplacementNamed(context, '/home-screen');
  // }

  void _handleAuthSuccess() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setBool('isLoggedIn', true); // ✅ Save login state
  HapticFeedback.lightImpact();
  Navigator.pushReplacementNamed(context, '/home-screen');
}

  void _handleAuthError(String error) {
    setState(() {
      _errorMessage = error;
      _isLoading = false;
    });
  }

  void _handleLoadingState(bool loading) {
    setState(() {
      _isLoading = loading;
      if (loading) _errorMessage = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.lightTheme.scaffoldBackgroundColor,
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Column(
            children: [
              _buildHeader(),
              _buildTabSection(),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    _buildAuthForm(),
                    // _buildAuthForm(false),
                  ],
                ),
              ),
              _buildSocialAuth(),
              SizedBox(height: 2.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 4.h),
      child: Column(
        children: [
          Container(
            width: 20.w,
            height: 20.w,
            decoration: BoxDecoration(
              color: AppTheme.lightTheme.primaryColor,
              borderRadius: BorderRadius.circular(4.w),
              boxShadow: [
                BoxShadow(
                  color: AppTheme.lightTheme.primaryColor.withOpacity(0.3),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Center(
              child: Text(
                'Z',
                style: AppTheme.lightTheme.textTheme.headlineMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SizedBox(height: 2.h),
          Text(
            'Welcome to Zapit',
            style: AppTheme.lightTheme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 1.h),
          Text(
            'Skip the queue, pick your time',
            style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
              color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabSection() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 6.w),
      decoration: BoxDecoration(
        color: AppTheme.lightTheme.cardColor,
        borderRadius: BorderRadius.circular(3.w),
        border: Border.all(
          color: AppTheme.lightTheme.colorScheme.outline.withOpacity(0.2),
        ),
      ),
      child: TabBar(
        controller: _tabController,
        indicator: BoxDecoration(
          color: AppTheme.lightTheme.primaryColor,
          borderRadius: BorderRadius.circular(2.5.w),
        ),
        indicatorSize: TabBarIndicatorSize.tab,
        indicatorPadding: EdgeInsets.all(1.w),
        labelColor: Colors.white,
        unselectedLabelColor: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
        labelStyle: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: AppTheme.lightTheme.textTheme.titleMedium,
        dividerColor: Colors.transparent,
        tabs: const [
          Tab(text: 'Login'),
          Tab(text: 'Sign Up'),
        ],
      ),
    );
  }

  // Widget _buildAuthForm(bool isLogin) {
  //   return Padding(
  //     padding: EdgeInsets.all(6.w),
  //     child: AuthFormWidget(
  //       isLogin: isLogin,
  //       isLoading: _isLoading,
  //       errorMessage: _errorMessage,
  //       onForgotPassword: _showForgotPasswordModal,
  //       onAuthSuccess: _handleAuthSuccess,
  //       onAuthError: _handleAuthError,
  //       onLoadingChange: _handleLoadingState,
  //     ),
  //   );
  // }

  Widget _buildAuthForm() {
    return Container(
        padding: EdgeInsets.all(6.w),
        height: 60.h, // 👈 gives TabBarView a proper bounded height
        child: TabBarView(
          controller: _tabController,
          physics:
              const NeverScrollableScrollPhysics(), // optional, if you want to prevent swipe
          children: List.generate(2, (index) {
            final isLogin = index == 0;
            return AuthFormWidget(
              isLogin: isLogin,
              isLoading: _isLoading,
              errorMessage: _errorMessage,
              onForgotPassword: _showForgotPasswordModal,
              onAuthSuccess: _handleAuthSuccess,
              onAuthError: _handleAuthError,
              onLoadingChange: _handleLoadingState,
            );
          }),
        ));
  }

  Widget _buildSocialAuth() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6.w),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Divider(
                  color:
                      AppTheme.lightTheme.colorScheme.outline.withOpacity(0.3),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.w),
                child: Text(
                  'or continue with',
                  style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                    color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.w),
                child: Text(
                  'or continue with',
                  style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                    color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
              Expanded(
                child: Divider(
                  color:
                      AppTheme.lightTheme.colorScheme.outline.withOpacity(0.3),
                ),
              ),
            ],
          ),
          SizedBox(height: 3.h),
          SocialAuthWidget(
            isLoading: _isLoading,
            onAuthSuccess: _handleAuthSuccess,
            onAuthError: _handleAuthError,
            onLoadingChange: _handleLoadingState,
          ),
        ],
      ),
    );
  }
}
