import 'package:flutter/material.dart';
import '../presentation/home_screen/home_screen.dart';
import '../presentation/cart_and_checkout_screen/cart_and_checkout_screen.dart';
import '../presentation/menu_screen/menu_screen.dart';
import '../presentation/order_status_screen/order_status_screen.dart';
import '../presentation/order_history_screen/order_history_screen.dart';
import '../presentation/order_confirmation_screen/order_confirmation_screen.dart';
import '../presentation/chat_assistant_screen/chat_assistant_screen.dart';
import '../presentation/profile_screen/profile_screen.dart';
import '../presentation/splash_screen/splash_screen.dart';
import '../presentation/onboarding_flow/onboarding_flow.dart';
import '../presentation/authentication_screen/authentication_screen.dart';

class AppRoutes {
  // TODO: Add routes here

  static const String initial = '/';
  static const String splashScreen = '/splash-screen';
  static const String onboardingFlow = '/onboarding-flow';
  static const String homeScreen = '/home-screen';
  static const String authenticationScreen = '/authentication-screen';
  // static const String homeScreen = '/home-screen';
  
  static const String cartAndCheckoutScreen = '/cart-and-checkout-screen';
  static const String menuScreen = '/menu-screen';
  static const String orderStatusScreen = '/order-status-screen';
  static const String orderHistoryScreen = '/order-history-screen';
  static const String orderConfirmationScreen = '/order-confirmation-screen';
  static const String chatAssistantScreen = '/chat-assistant-screen';
  static const String profileScreen = '/profile-screen';

  static Map<String, WidgetBuilder> routes = {
    initial: (context) => const SplashScreen(),
    splashScreen: (context) => const SplashScreen(),
    onboardingFlow: (context) => const OnboardingFlow(),
    homeScreen: (context) => const HomeScreen(),
    authenticationScreen: (context) => const AuthenticationScreen(),
    // initial: (context) => const HomeScreen(),
    // homeScreen: (context) => const HomeScreen(),
    cartAndCheckoutScreen: (context) => const CartAndCheckoutScreen(),
    menuScreen: (context) => const MenuScreen(),
    orderStatusScreen: (context) => const OrderStatusScreen(),
    orderHistoryScreen: (context) => const OrderHistoryScreen(),
    orderConfirmationScreen: (context) => const OrderConfirmationScreen(),
    chatAssistantScreen: (context) => ChatAssistantScreen(),
    profileScreen: (context) => ProfileScreen(),

  };
}
