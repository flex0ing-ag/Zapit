// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:sizer/sizer.dart';

// import '../../../core/app_export.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// class ForgotPasswordModal extends StatefulWidget {
//   const ForgotPasswordModal({super.key});

//   @override
//   State<ForgotPasswordModal> createState() => _ForgotPasswordModalState();
// }

// class _ForgotPasswordModalState extends State<ForgotPasswordModal> {
//   final _formKey = GlobalKey<FormState>();
//   final _emailController = TextEditingController();
//   bool _isLoading = false;
//   bool _isEmailSent = false;
//   String _errorMessage = '';

//   @override
//   void dispose() {
//     _emailController.dispose();
//     super.dispose();
//   }

//   // Future<void> _handlePasswordReset() async {
//   //   if (!_formKey.currentState!.validate()) return;

//   //   setState(() {
//   //     _isLoading = true;
//   //     _errorMessage = '';
//   //   });

//   //   try {
//   //     // Simulate password reset email sending
//   //     await Future.delayed(const Duration(seconds: 2));

//   //     setState(() {
//   //       _isEmailSent = true;
//   //       _isLoading = false;
//   //     });

//   //     HapticFeedback.lightImpact();
//   //   } catch (e) {
//   //     setState(() {
//   //       _errorMessage = 'Failed to send reset email. Please try again.';
//   //       _isLoading = false;
//   //     });
//   //   }
//   // }

//   // Firebase password reset logic

//   Future<void> _handlePasswordReset() async {
//     if (!_formKey.currentState!.validate()) return;

//     setState(() {
//       _isLoading = true;
//       _errorMessage = '';
//     });

//     try {
//       await FirebaseAuth.instance.sendPasswordResetEmail(
//         email: _emailController.text.trim(),
//       );

//       setState(() {
//         _isEmailSent = true;
//         _isLoading = false;
//       });

//       HapticFeedback.lightImpact();
//     } on FirebaseAuthException catch (e) {
//       setState(() {
//         _errorMessage = e.message ?? 'Failed to send reset email.';
//         _isLoading = false;
//       });
//     } catch (_) {
//       setState(() {
//         _errorMessage = 'Failed to send reset email. Please try again.';
//         _isLoading = false;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.only(
//         bottom: MediaQuery.of(context).viewInsets.bottom,
//       ),
//       child: Container(
//         decoration: BoxDecoration(
//           color: AppTheme.lightTheme.scaffoldBackgroundColor,
//           borderRadius: const BorderRadius.vertical(
//             top: Radius.circular(20),
//           ),
//         ),
//         child: Padding(
//           padding: EdgeInsets.all(6.w),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               _buildHeader(),
//               SizedBox(height: 3.h),
//               _isEmailSent ? _buildSuccessContent() : _buildFormContent(),
//               SizedBox(height: 2.h),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildHeader() {
//     return Row(
//       children: [
//         Expanded(
//           child: Text(
//             _isEmailSent ? 'Check Your Email' : 'Reset Password',
//             style: AppTheme.lightTheme.textTheme.headlineSmall?.copyWith(
//               fontWeight: FontWeight.w600,
//             ),
//           ),
//         ),
//         IconButton(
//           onPressed: () => Navigator.pop(context),
//           icon: CustomIconWidget(
//             iconName: 'close',
//             color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
//             size: 24,
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildFormContent() {
//     return Form(
//       key: _formKey,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             'Enter your email address and we\'ll send you a link to reset your password.',
//             style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
//               color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
//             ),
//           ),
//           SizedBox(height: 3.h),
//           TextFormField(
//             controller: _emailController,
//             keyboardType: TextInputType.emailAddress,
//             textInputAction: TextInputAction.done,
//             decoration: InputDecoration(
//               labelText: 'Email Address',
//               hintText: 'Enter your email address',
//               prefixIcon: Padding(
//                 padding: EdgeInsets.all(3.w),
//                 child: CustomIconWidget(
//                   iconName: 'email',
//                   color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
//                   size: 20,
//                 ),
//               ),
//             ),
//             validator: (value) {
//               if (value == null || value.trim().isEmpty) {
//                 return 'Please enter your email address';
//               }
//               if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
//                   .hasMatch(value)) {
//                 return 'Please enter a valid email address';
//               }
//               return null;
//             },
//           ),
//           if (_errorMessage.isNotEmpty) ...[
//             SizedBox(height: 2.h),
//             _buildErrorMessage(),
//           ],
//           SizedBox(height: 4.h),
//           SizedBox(
//             width: double.infinity,
//             height: 6.h,
//             child: ElevatedButton(
//               onPressed: _isLoading ? null : _handlePasswordReset,
//               child: _isLoading
//                   ? SizedBox(
//                       width: 5.w,
//                       height: 5.w,
//                       child: CircularProgressIndicator(
//                         strokeWidth: 2,
//                         valueColor: AlwaysStoppedAnimation<Color>(
//                           AppTheme.lightTheme.colorScheme.onPrimary,
//                         ),
//                       ),
//                     )
//                   : Text(
//                       'Send Reset Link',
//                       style:
//                           AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
//                         color: AppTheme.lightTheme.colorScheme.onPrimary,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildSuccessContent() {
//     return Column(
//       children: [
//         Container(
//           width: 20.w,
//           height: 20.w,
//           decoration: BoxDecoration(
//             color: AppTheme.successLight.withValues(alpha: 0.1),
//             shape: BoxShape.circle,
//           ),
//           child: Center(
//             child: CustomIconWidget(
//               iconName: 'check_circle',
//               color: AppTheme.successLight,
//               size: 40,
//             ),
//           ),
//         ),
//         SizedBox(height: 3.h),
//         Text(
//           'Password reset link sent!',
//           style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
//             fontWeight: FontWeight.w600,
//           ),
//           textAlign: TextAlign.center,
//         ),
//         SizedBox(height: 2.h),
//         Text(
//           'We\'ve sent a password reset link to ${_emailController.text}. Please check your email and follow the instructions to reset your password.',
//           style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
//             color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
//           ),
//           textAlign: TextAlign.center,
//         ),
//         SizedBox(height: 4.h),
//         SizedBox(
//           width: double.infinity,
//           height: 6.h,
//           child: ElevatedButton(
//             onPressed: () => Navigator.pop(context),
//             child: Text(
//               'Done',
//               style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
//                 color: AppTheme.lightTheme.colorScheme.onPrimary,
//                 fontWeight: FontWeight.w600,
//               ),
//             ),
//           ),
//         ),
//         SizedBox(height: 2.h),
//         TextButton(
//           onPressed: () {
//             setState(() {
//               _isEmailSent = false;
//               _emailController.clear();
//             });
//           },
//           child: Text(
//             'Try different email',
//             style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
//               color: AppTheme.lightTheme.primaryColor,
//               fontWeight: FontWeight.w500,
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildErrorMessage() {
//     return Container(
//       padding: EdgeInsets.all(3.w),
//       decoration: BoxDecoration(
//         color: AppTheme.errorLight.withValues(alpha: 0.1),
//         borderRadius: BorderRadius.circular(2.w),
//         border: Border.all(
//           color: AppTheme.errorLight.withValues(alpha: 0.3),
//         ),
//       ),
//       child: Row(
//         children: [
//           CustomIconWidget(
//             iconName: 'error',
//             color: AppTheme.errorLight,
//             size: 16,
//           ),
//           SizedBox(width: 2.w),
//           Expanded(
//             child: Text(
//               _errorMessage,
//               style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
//                 color: AppTheme.errorLight,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }


import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

import '../../../core/app_export.dart';

class ForgotPasswordModal extends StatefulWidget {
  const ForgotPasswordModal({super.key});

  @override
  State<ForgotPasswordModal> createState() => _ForgotPasswordModalState();
}

class _ForgotPasswordModalState extends State<ForgotPasswordModal> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  bool _isLoading = false;
  bool _isEmailSent = false;
  String _errorMessage = '';

  bool _canResend = false;
  int _resendCountdown = 30;
  Timer? _resendTimer;

  final FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  @override
  void dispose() {
    _emailController.dispose();
    _resendTimer?.cancel();
    super.dispose();
  }

  Future<void> _handlePasswordReset() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: _emailController.text.trim(),
      );

      await analytics.logEvent(
        name: 'password_reset_requested',
        parameters: {
          'email': _emailController.text.trim(),
          'timestamp': DateTime.now().toIso8601String(),
        },
      );

      setState(() {
        _isEmailSent = true;
        _isLoading = false;
        _canResend = false;
        _resendCountdown = 30;
      });

      _startResendCooldown();
      HapticFeedback.lightImpact();
    } on FirebaseAuthException catch (e) {
      setState(() {
        if (e.code == 'user-not-found') {
          _errorMessage = 'No user found with this email.';
        } else {
          _errorMessage = e.message ?? 'Failed to send reset email.';
        }
        _isLoading = false;
      });
    } catch (_) {
      setState(() {
        _errorMessage = 'Failed to send reset email. Please try again.';
        _isLoading = false;
      });
    }
  }

  void _startResendCooldown() {
    _resendTimer?.cancel();
    _resendCountdown = 30;

    _resendTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_resendCountdown == 0) {
        setState(() {
          _canResend = true;
        });
        timer.cancel();
      } else {
        setState(() {
          _resendCountdown--;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: AppTheme.lightTheme.scaffoldBackgroundColor,
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(6.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              SizedBox(height: 3.h),
              _isEmailSent ? _buildSuccessContent() : _buildFormContent(),
              SizedBox(height: 2.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        Expanded(
          child: Text(
            _isEmailSent ? 'Check Your Email' : 'Reset Password',
            style: AppTheme.lightTheme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        IconButton(
          onPressed: () => Navigator.pop(context),
          icon: CustomIconWidget(
            iconName: 'close',
            color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
            size: 24,
          ),
        ),
      ],
    );
  }

  Widget _buildFormContent() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Enter your email address and we\'ll send you a link to reset your password.',
            style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
              color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
            ),
          ),
          SizedBox(height: 3.h),
          TextFormField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.done,
            decoration: InputDecoration(
              labelText: 'Email Address',
              hintText: 'Enter your email address',
              prefixIcon: Padding(
                padding: EdgeInsets.all(3.w),
                child: CustomIconWidget(
                  iconName: 'email',
                  color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                  size: 20,
                ),
              ),
            ),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Please enter your email address';
              }
              if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                  .hasMatch(value)) {
                return 'Please enter a valid email address';
              }
              return null;
            },
          ),
          if (_errorMessage.isNotEmpty) ...[
            SizedBox(height: 2.h),
            _buildErrorMessage(),
          ],
          SizedBox(height: 4.h),
          SizedBox(
            width: double.infinity,
            height: 6.h,
            child: ElevatedButton(
              onPressed: _isLoading ? null : _handlePasswordReset,
              child: _isLoading
                  ? SizedBox(
                      width: 5.w,
                      height: 5.w,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          AppTheme.lightTheme.colorScheme.onPrimary,
                        ),
                      ),
                    )
                  : Text(
                      'Send Reset Link',
                      style:
                          AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                        color: AppTheme.lightTheme.colorScheme.onPrimary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSuccessContent() {
    return Column(
      children: [
        Container(
          width: 20.w,
          height: 20.w,
          decoration: BoxDecoration(
            color: AppTheme.successLight.withValues(alpha: 0.1),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: CustomIconWidget(
              iconName: 'check_circle',
              color: AppTheme.successLight,
              size: 40,
            ),
          ),
        ),
        SizedBox(height: 3.h),
        Text(
          'Password reset link sent!',
          style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w600,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 2.h),
        Text(
          'We\'ve sent a password reset link to ${_emailController.text}. Please check your email and follow the instructions.',
          style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
            color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 4.h),
        SizedBox(
          width: double.infinity,
          height: 6.h,
          child: ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Done',
              style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                color: AppTheme.lightTheme.colorScheme.onPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        SizedBox(height: 2.h),
        if (!_canResend)
          Text(
            'You can resend after $_resendCountdown seconds',
            style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
              color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
            ),
          ),
        if (_canResend)
          TextButton(
            onPressed: _isLoading ? null : _handlePasswordReset,
            child: Text(
              'Resend Reset Link',
              style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                color: AppTheme.lightTheme.primaryColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        TextButton(
          onPressed: () {
            setState(() {
              _isEmailSent = false;
              _emailController.clear();
              _errorMessage = '';
              _canResend = false;
              _resendTimer?.cancel();
            });
          },
          child: Text(
            'Try different email',
            style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
              color: AppTheme.lightTheme.primaryColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildErrorMessage() {
    return Container(
      padding: EdgeInsets.all(3.w),
      decoration: BoxDecoration(
        color: AppTheme.errorLight.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(2.w),
        border: Border.all(
          color: AppTheme.errorLight.withValues(alpha: 0.3),
        ),
      ),
      child: Row(
        children: [
          CustomIconWidget(
            iconName: 'error',
            color: AppTheme.errorLight,
            size: 16,
          ),
          SizedBox(width: 2.w),
          Expanded(
            child: Text(
              _errorMessage,
              style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                color: AppTheme.errorLight,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
