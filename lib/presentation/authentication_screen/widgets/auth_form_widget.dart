// import 'package:flutter/material.dart';
// import 'package:sizer/sizer.dart';

// import '../../../core/app_export.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// class AuthFormWidget extends StatefulWidget {
//   final bool isLogin;
//   final bool isLoading;
//   final String errorMessage;
//   final VoidCallback? onForgotPassword;
//   final VoidCallback? onAuthSuccess;
//   final Function(String)? onAuthError;
//   final Function(bool)? onLoadingChange;

//   const AuthFormWidget({
//     super.key,
//     required this.isLogin,
//     required this.isLoading,
//     required this.errorMessage,
//     this.onForgotPassword,
//     this.onAuthSuccess,
//     this.onAuthError,
//     this.onLoadingChange,
//   });

//   @override
//   State<AuthFormWidget> createState() => _AuthFormWidgetState();
// }

// class _AuthFormWidgetState extends State<AuthFormWidget> {
//   final _formKey = GlobalKey<FormState>();
//   final _nameController = TextEditingController();
//   final _emailController = TextEditingController();
//   final _passwordController = TextEditingController();

//   bool _isPasswordVisible = false;
//   bool _acceptTerms = false;
//   String _passwordStrength = '';
//   Color _passwordStrengthColor = Colors.grey;

//   // Mock credentials for testing
//   final Map<String, String> _mockCredentials = {
//     'student@college.edu': 'student123',
//     'admin@college.edu': 'admin123',
//     'test@zapit.com': 'test123',
//   };

//   @override
//   void dispose() {
//     _nameController.dispose();
//     _emailController.dispose();
//     _passwordController.dispose();
//     super.dispose();
//   }

//   void _checkPasswordStrength(String password) {
//     if (password.isEmpty) {
//       setState(() {
//         _passwordStrength = '';
//         _passwordStrengthColor = Colors.grey;
//       });
//       return;
//     }

//     int score = 0;
//     if (password.length >= 8) score++;
//     if (password.contains(RegExp(r'[A-Z]'))) score++;
//     if (password.contains(RegExp(r'[a-z]'))) score++;
//     if (password.contains(RegExp(r'[0-9]'))) score++;
//     if (password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) score++;

//     setState(() {
//       switch (score) {
//         case 0:
//         case 1:
//           _passwordStrength = 'Weak';
//           _passwordStrengthColor = AppTheme.errorLight;
//           break;
//         case 2:
//         case 3:
//           _passwordStrength = 'Medium';
//           _passwordStrengthColor = AppTheme.warningLight;
//           break;
//         case 4:
//         case 5:
//           _passwordStrength = 'Strong';
//           _passwordStrengthColor = AppTheme.successLight;
//           break;
//       }
//     });
//   }

//   // Future<void> _handleAuthentication() async {
//   //   if (!_formKey.currentState!.validate()) return;

//   //   if (!widget.isLogin && !_acceptTerms) {
//   //     widget.onAuthError?.call('Please accept the terms and conditions');
//   //     return;
//   //   }

//   //   widget.onLoadingChange?.call(true);

//   //   // Simulate network delay
//   //   await Future.delayed(const Duration(seconds: 2));

//   //   try {
//   //     // if (widget.isLogin) {
//   //     //   // Mock login validation
//   //     //   final email = _emailController.text.trim();
//   //     //   final password = _passwordController.text;

//   //     //   if (_mockCredentials.containsKey(email) &&
//   //     //       _mockCredentials[email] == password) {
//   //     //     widget.onAuthSuccess?.call();
//   //     //   } else {
//   //     //     widget.onAuthError?.call(
//   //     //         'Invalid email or password. Try: student@college.edu / student123');
//   //     //   }
//   //     // }
//   //     if (widget.isLogin) {
//   //       try {
//   //         await FirebaseAuth.instance.signInWithEmailAndPassword(
//   //           email: _emailController.text.trim(),
//   //           password: _passwordController.text,
//   //         );
//   //         widget.onAuthSuccess?.call();
//   //       } on FirebaseAuthException catch (e) {
//   //         widget.onAuthError?.call(e.message ?? 'Login failed');
//   //       }
//   //     } else {
//   //       // Mock registration
//   //       // if (_passwordStrength == 'Weak') {
//   //       //   widget.onAuthError?.call('Please choose a stronger password');
//   //       //   return;
//   //       // }
//   //       // widget.onAuthSuccess?.call();

//   //       if (_passwordStrength == 'Weak') {
//   //         widget.onAuthError?.call('Please choose a stronger password');
//   //         return;
//   //       }

//   //       try {
//   //         await FirebaseAuth.instance.createUserWithEmailAndPassword(
//   //           email: _emailController.text.trim(),
//   //           password: _passwordController.text,
//   //         );
//   //         widget.onAuthSuccess?.call();
//   //       } on FirebaseAuthException catch (e) {
//   //         widget.onAuthError?.call(e.message ?? 'Registration failed');
//   //       }
//   //     }
//   //   } catch (e) {
//   //     widget.onAuthError?.call('Network error. Please try again.');
//   //   }
//   // }

//   Future<void> _handleAuthentication() async {
//     if (!_formKey.currentState!.validate()) return;

//     if (!widget.isLogin && !_acceptTerms) {
//       widget.onAuthError?.call('Please accept the terms and conditions');
//       return;
//     }

//     widget.onLoadingChange?.call(true);

//     try {
//       if (widget.isLogin) {
//         // Login with Firebase Auth
//         await FirebaseAuth.instance.signInWithEmailAndPassword(
//           email: _emailController.text.trim(),
//           password: _passwordController.text,
//         );
//         widget.onAuthSuccess?.call();
//       } else {
//         if (_passwordStrength == 'Weak') {
//           widget.onAuthError?.call('Please choose a stronger password');
//           return;
//         }

//         // Register with Firebase Auth
//         await FirebaseAuth.instance.createUserWithEmailAndPassword(
//           email: _emailController.text.trim(),
//           password: _passwordController.text,
//         );
//         widget.onAuthSuccess?.call();
//       }
//     } on FirebaseAuthException catch (e) {
//       widget.onAuthError?.call(e.message ?? 'Authentication failed');
//     } catch (e) {
//       widget.onAuthError?.call('Unexpected error. Please try again.');
//     } finally {
//       widget.onLoadingChange?.call(false);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Form(
//       key: _formKey,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           if (!widget.isLogin) ...[
//             _buildNameField(),
//             SizedBox(height: 2.h),
//           ],
//           _buildEmailField(),
//           SizedBox(height: 2.h),
//           _buildPasswordField(),
//           if (!widget.isLogin && _passwordController.text.isNotEmpty) ...[
//             SizedBox(height: 1.h),
//             _buildPasswordStrengthIndicator(),
//           ],
//           if (widget.isLogin) ...[
//             SizedBox(height: 1.h),
//             _buildForgotPasswordLink(),
//           ],
//           if (!widget.isLogin) ...[
//             SizedBox(height: 2.h),
//             _buildTermsCheckbox(),
//           ],
//           SizedBox(height: 3.h),
//           _buildSubmitButton(),
//           if (widget.errorMessage.isNotEmpty) ...[
//             SizedBox(height: 2.h),
//             _buildErrorMessage(),
//           ],
//         ],
//       ),
//     );
//   }

//   Widget _buildNameField() {
//     return TextFormField(
//       controller: _nameController,
//       keyboardType: TextInputType.name,
//       textInputAction: TextInputAction.next,
//       decoration: InputDecoration(
//         labelText: 'Full Name',
//         hintText: 'Enter your full name',
//         prefixIcon: Padding(
//           padding: EdgeInsets.all(3.w),
//           child: CustomIconWidget(
//             iconName: 'person',
//             color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
//             size: 20,
//           ),
//         ),
//       ),
//       validator: (value) {
//         if (value == null || value.trim().isEmpty) {
//           return 'Please enter your full name';
//         }
//         if (value.trim().length < 2) {
//           return 'Name must be at least 2 characters';
//         }
//         return null;
//       },
//     );
//   }

//   Widget _buildEmailField() {
//     return TextFormField(
//       controller: _emailController,
//       keyboardType: TextInputType.emailAddress,
//       textInputAction: TextInputAction.next,
//       decoration: InputDecoration(
//         labelText: 'Email',
//         hintText: 'Enter your email address',
//         prefixIcon: Padding(
//           padding: EdgeInsets.all(3.w),
//           child: CustomIconWidget(
//             iconName: 'email',
//             color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
//             size: 20,
//           ),
//         ),
//       ),
//       validator: (value) {
//         if (value == null || value.trim().isEmpty) {
//           return 'Please enter your email';
//         }
//         if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
//           return 'Please enter a valid email address';
//         }
//         return null;
//       },
//     );
//   }

//   Widget _buildPasswordField() {
//     return TextFormField(
//       controller: _passwordController,
//       obscureText: !_isPasswordVisible,
//       textInputAction: TextInputAction.done,
//       onChanged: widget.isLogin ? null : _checkPasswordStrength,
//       decoration: InputDecoration(
//         labelText: 'Password',
//         hintText: 'Enter your password',
//         prefixIcon: Padding(
//           padding: EdgeInsets.all(3.w),
//           child: CustomIconWidget(
//             iconName: 'lock',
//             color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
//             size: 20,
//           ),
//         ),
//         suffixIcon: IconButton(
//           icon: CustomIconWidget(
//             iconName: _isPasswordVisible ? 'visibility_off' : 'visibility',
//             color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
//             size: 20,
//           ),
//           onPressed: () {
//             setState(() {
//               _isPasswordVisible = !_isPasswordVisible;
//             });
//           },
//         ),
//       ),
//       validator: (value) {
//         if (value == null || value.isEmpty) {
//           return 'Please enter your password';
//         }
//         if (!widget.isLogin && value.length < 6) {
//           return 'Password must be at least 6 characters';
//         }
//         return null;
//       },
//     );
//   }

//   Widget _buildPasswordStrengthIndicator() {
//     return Row(
//       children: [
//         Text(
//           'Password strength: ',
//           style: AppTheme.lightTheme.textTheme.bodySmall,
//         ),
//         Text(
//           _passwordStrength,
//           style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
//             color: _passwordStrengthColor,
//             fontWeight: FontWeight.w600,
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildForgotPasswordLink() {
//     return Align(
//       alignment: Alignment.centerRight,
//       child: TextButton(
//         onPressed: widget.onForgotPassword,
//         child: Text(
//           'Forgot Password?',
//           style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
//             color: AppTheme.lightTheme.primaryColor,
//             fontWeight: FontWeight.w500,
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildTermsCheckbox() {
//     return Row(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Checkbox(
//           value: _acceptTerms,
//           onChanged: (value) {
//             setState(() {
//               _acceptTerms = value ?? false;
//             });
//           },
//         ),
//         Expanded(
//           child: GestureDetector(
//             onTap: () {
//               setState(() {
//                 _acceptTerms = !_acceptTerms;
//               });
//             },
//             child: Padding(
//               padding: EdgeInsets.only(top: 3.w),
//               child: RichText(
//                 text: TextSpan(
//                   style: AppTheme.lightTheme.textTheme.bodySmall,
//                   children: [
//                     const TextSpan(text: 'I agree to the '),
//                     TextSpan(
//                       text: 'Terms of Service',
//                       style: TextStyle(
//                         color: AppTheme.lightTheme.primaryColor,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                     const TextSpan(text: ' and '),
//                     TextSpan(
//                       text: 'Privacy Policy',
//                       style: TextStyle(
//                         color: AppTheme.lightTheme.primaryColor,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildSubmitButton() {
//     return SizedBox(
//       width: double.infinity,
//       height: 6.h,
//       child: ElevatedButton(
//         onPressed: widget.isLoading ? null : _handleAuthentication,
//         child: widget.isLoading
//             ? SizedBox(
//                 width: 5.w,
//                 height: 5.w,
//                 child: CircularProgressIndicator(
//                   strokeWidth: 2,
//                   valueColor: AlwaysStoppedAnimation<Color>(
//                     AppTheme.lightTheme.colorScheme.onPrimary,
//                   ),
//                 ),
//               )
//             : Text(
//                 widget.isLogin ? 'Login' : 'Create Account',
//                 style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
//                   color: AppTheme.lightTheme.colorScheme.onPrimary,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//       ),
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
//               widget.errorMessage,
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


import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../../core/app_export.dart';

class AuthFormWidget extends StatefulWidget {
  final bool isLogin;
  final bool isLoading;
  final String errorMessage;
  final VoidCallback? onForgotPassword;
  final VoidCallback? onAuthSuccess;
  final Function(String)? onAuthError;
  final Function(bool)? onLoadingChange;

  const AuthFormWidget({
    super.key,
    required this.isLogin,
    required this.isLoading,
    required this.errorMessage,
    this.onForgotPassword,
    this.onAuthSuccess,
    this.onAuthError,
    this.onLoadingChange,
  });

  @override
  State<AuthFormWidget> createState() => _AuthFormWidgetState();
}

class _AuthFormWidgetState extends State<AuthFormWidget> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isPasswordVisible = false;
  bool _acceptTerms = false;
  String _passwordStrength = '';
  Color _passwordStrengthColor = Colors.grey;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _checkPasswordStrength(String password) {
    int score = 0;
    if (password.length >= 8) score++;
    if (password.contains(RegExp(r'[A-Z]'))) score++;
    if (password.contains(RegExp(r'[a-z]'))) score++;
    if (password.contains(RegExp(r'[0-9]'))) score++;
    if (password.contains(RegExp(r'[!@#\$%^&*(),.?":{}|<>]'))) score++;

    setState(() {
      if (score <= 1) {
        _passwordStrength = 'Weak';
        _passwordStrengthColor = AppTheme.errorLight;
      } else if (score <= 3) {
        _passwordStrength = 'Medium';
        _passwordStrengthColor = AppTheme.warningLight;
      } else {
        _passwordStrength = 'Strong';
        _passwordStrengthColor = AppTheme.successLight;
      }
    });
  }

  Future<void> _handleAuthentication() async {
    if (!_formKey.currentState!.validate()) return;
    if (!widget.isLogin && !_acceptTerms) {
      widget.onAuthError?.call('Please accept the terms and conditions');
      return;
    }
    widget.onLoadingChange?.call(true);
    try {
      if (widget.isLogin) {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text,
        );
      } else {
        if (_passwordStrength == 'Weak') {
          widget.onAuthError?.call('Please choose a stronger password');
          return;
        }
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text,
        );
      }
      widget.onAuthSuccess?.call();
    } on FirebaseAuthException catch (e) {
      widget.onAuthError?.call(e.message ?? 'Authentication failed');
    } catch (e) {
      widget.onAuthError?.call('Unexpected error occurred.');
    } finally {
      widget.onLoadingChange?.call(false);
    }
  }

  Future<void> _handleGoogleSignIn() async {
    widget.onLoadingChange?.call(true);
    try {
      final googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) return;
      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      await FirebaseAuth.instance.signInWithCredential(credential);
      widget.onAuthSuccess?.call();
    } on FirebaseAuthException catch (e) {
      widget.onAuthError?.call(e.message ?? 'Google Sign-In failed');
    } catch (e) {
      widget.onAuthError?.call('Unexpected error during Google Sign-In');
    } finally {
      widget.onLoadingChange?.call(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          if (!widget.isLogin) ...[
            _buildNameField(),
            SizedBox(height: 2.h),
          ],
          _buildEmailField(),
          SizedBox(height: 2.h),
          _buildPasswordField(),
          if (!widget.isLogin && _passwordController.text.isNotEmpty) ...[
            SizedBox(height: 1.h),
            _buildPasswordStrengthIndicator(),
          ],
          if (widget.isLogin)
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: widget.onForgotPassword,
                child: Text('Forgot Password?', style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                  color: AppTheme.lightTheme.primaryColor,
                  fontWeight: FontWeight.w500,
                )),
              ),
            ),
          if (!widget.isLogin) _buildTermsCheckbox(),
          SizedBox(height: 2.h),
          _buildSubmitButton(),
          SizedBox(height: 1.5.h),
          _buildGoogleSignInButton(),
          if (widget.errorMessage.isNotEmpty) ...[
            SizedBox(height: 2.h),
            _buildErrorMessage(),
          ]
        ],
      ),
    );
  }

  Widget _buildNameField() => TextFormField(
        controller: _nameController,
        decoration: InputDecoration(labelText: 'Full Name'),
        validator: (value) => value == null || value.trim().length < 2
            ? 'Enter a valid name'
            : null,
      );

  Widget _buildEmailField() => TextFormField(
        controller: _emailController,
        decoration: InputDecoration(labelText: 'Email'),
        keyboardType: TextInputType.emailAddress,
        validator: (value) => value != null &&
                RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}\$').hasMatch(value)
            ? null
            : 'Enter a valid email',
      );

  Widget _buildPasswordField() => TextFormField(
        controller: _passwordController,
        obscureText: !_isPasswordVisible,
        decoration: InputDecoration(
          labelText: 'Password',
          suffixIcon: IconButton(
            icon: Icon(
                _isPasswordVisible ? Icons.visibility_off : Icons.visibility),
            onPressed: () =>
                setState(() => _isPasswordVisible = !_isPasswordVisible),
          ),
        ),
        onChanged: widget.isLogin ? null : _checkPasswordStrength,
        validator: (value) => value != null && value.length >= 6
            ? null
            : 'Password must be at least 6 characters',
      );

  Widget _buildPasswordStrengthIndicator() => Row(
        children: [
          Text('Password strength: '),
          Text(_passwordStrength, style: TextStyle(color: _passwordStrengthColor)),
        ],
      );

  Widget _buildTermsCheckbox() => CheckboxListTile(
        value: _acceptTerms,
        onChanged: (val) => setState(() => _acceptTerms = val ?? false),
        title: Text('I accept Terms of Service & Privacy Policy'),
        controlAffinity: ListTileControlAffinity.leading,
      );

  Widget _buildSubmitButton() => SizedBox(
        width: double.infinity,
        height: 6.h,
        child: ElevatedButton(
          onPressed: widget.isLoading ? null : _handleAuthentication,
          child: widget.isLoading
              ? CircularProgressIndicator(color: Colors.white)
              : Text(widget.isLogin ? 'Login' : 'Create Account'),
        ),
      );

  Widget _buildGoogleSignInButton() => OutlinedButton.icon(
        onPressed: widget.isLoading ? null : _handleGoogleSignIn,
        icon: Icon(Icons.g_mobiledata, color: Colors.red),
        label: Text('Continue with Google'),
      );

  // Widget _buildErrorMessage() => Text(
  //       widget.errorMessage,
  //       style: TextStyle(color: Colors.red),
  //     );

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
              widget.errorMessage,
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
