import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SocialAuthWidget extends StatelessWidget {
  final bool isLoading;
  final VoidCallback? onAuthSuccess;
  final Function(String)? onAuthError;
  final Function(bool)? onLoadingChange;

  const SocialAuthWidget({
    super.key,
    required this.isLoading,
    this.onAuthSuccess,
    this.onAuthError,
    this.onLoadingChange,
  });

  // Future<void> _handleGoogleAuth() async {
  //   if (isLoading) return;

  //   onLoadingChange?.call(true);

  //   try {
  //     // Simulate Google OAuth process
  //     await Future.delayed(const Duration(seconds: 2));

  //     // Mock successful authentication
  //     HapticFeedback.lightImpact();
  //     onAuthSuccess?.call();
  //   } catch (e) {
  //     onAuthError?.call('Google authentication failed. Please try again.');
  //   }
  // }

  Future<void> _handleGoogleAuth() async {
    if (isLoading) return;
    onLoadingChange?.call(true);

    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        onLoadingChange?.call(false);
        return;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);
      HapticFeedback.lightImpact();
      onAuthSuccess?.call();
    } on FirebaseAuthException catch (e) {
      onAuthError?.call(e.message ?? 'Google authentication failed');
    } catch (_) {
      onAuthError?.call('Google authentication failed. Please try again.');
    } finally {
      onLoadingChange?.call(false);
    }
  }

  Future<void> _handleBiometricAuth() async {
    if (isLoading) return;

    onLoadingChange?.call(true);

    try {
      // Simulate biometric authentication
      await Future.delayed(const Duration(seconds: 1));

      // Mock successful biometric authentication
      HapticFeedback.lightImpact();
      onAuthSuccess?.call();
    } catch (e) {
      onAuthError?.call('Biometric authentication failed. Please try again.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildGoogleAuthButton(),
        SizedBox(height: 2.h),
        _buildBiometricAuthButton(),
      ],
    );
  }

  Widget _buildGoogleAuthButton() {
    return SizedBox(
      width: double.infinity,
      height: 6.h,
      child: OutlinedButton(
        onPressed: isLoading ? null : _handleGoogleAuth,
        style: OutlinedButton.styleFrom(
          side: BorderSide(
            color:
                AppTheme.lightTheme.colorScheme.outline.withValues(alpha: 0.3),
            width: 1,
          ),
          backgroundColor: Colors.white,
          foregroundColor: AppTheme.lightTheme.colorScheme.onSurface,
        ),
        child: isLoading
            ? SizedBox(
                width: 5.w,
                height: 5.w,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    AppTheme.lightTheme.primaryColor,
                  ),
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomImageWidget(
                    imageUrl:
                        'https://developers.google.com/identity/images/g-logo.png',
                    width: 5.w,
                    height: 5.w,
                    fit: BoxFit.contain,
                  ),
                  SizedBox(width: 3.w),
                  Text(
                    'Continue with Google',
                    style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  Widget _buildBiometricAuthButton() {
    return SizedBox(
      width: double.infinity,
      height: 6.h,
      child: OutlinedButton(
        onPressed: isLoading ? null : _handleBiometricAuth,
        style: OutlinedButton.styleFrom(
          side: BorderSide(
            color:
                AppTheme.lightTheme.colorScheme.outline.withValues(alpha: 0.3),
            width: 1,
          ),
          backgroundColor: AppTheme.lightTheme.cardColor,
          foregroundColor: AppTheme.lightTheme.colorScheme.onSurface,
        ),
        child: isLoading
            ? SizedBox(
                width: 5.w,
                height: 5.w,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    AppTheme.lightTheme.primaryColor,
                  ),
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomIconWidget(
                    iconName: 'fingerprint',
                    color: AppTheme.lightTheme.primaryColor,
                    size: 24,
                  ),
                  SizedBox(width: 3.w),
                  Text(
                    'Use Biometric Authentication',
                    style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
