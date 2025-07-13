import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';
import './menu_item_card_widget.dart';

class MessageBubbleWidget extends StatelessWidget {
  final Map<String, dynamic> message;
  final Function(Map<String, dynamic>) onAddToCart;

  const MessageBubbleWidget({
    super.key,
    required this.message,
    required this.onAddToCart,
  });

  @override
  Widget build(BuildContext context) {
    final bool isUser = message["isUser"] as bool;
    final String messageText = message["message"] as String;
    final String messageType = message["type"] as String? ?? "text";
    final List<dynamic>? menuItems = message["menuItems"] as List<dynamic>?;
    final DateTime timestamp = message["timestamp"] as DateTime;

    return Container(
      margin: EdgeInsets.symmetric(vertical: 1.h),
      child: Column(
        crossAxisAlignment:
            isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          // Message Bubble
          Row(
            mainAxisAlignment:
                isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (!isUser) ...[
                // AI Avatar
                Container(
                  width: 8.w,
                  height: 8.w,
                  decoration: BoxDecoration(
                    color: AppTheme.lightTheme.colorScheme.surface,
                    borderRadius: BorderRadius.circular(4.w),
                    border: Border.all(
                      color: AppTheme.lightTheme.dividerColor,
                      width: 1,
                    ),
                  ),
                  child: Center(
                    child: CustomIconWidget(
                      iconName: 'smart_toy',
                      color: AppTheme.lightTheme.primaryColor,
                      size: 16,
                    ),
                  ),
                ),
                SizedBox(width: 2.w),
              ],

              // Message Content
              Flexible(
                child: Container(
                  constraints: BoxConstraints(
                    maxWidth: 75.w,
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: 4.w,
                    vertical: 3.w,
                  ),
                  decoration: BoxDecoration(
                    color: isUser
                        ? AppTheme.lightTheme.primaryColor
                        : AppTheme.lightTheme.colorScheme.surface,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(4.w),
                      topRight: Radius.circular(4.w),
                      bottomLeft:
                          isUser ? Radius.circular(4.w) : Radius.circular(1.w),
                      bottomRight:
                          isUser ? Radius.circular(1.w) : Radius.circular(4.w),
                    ),
                    border: !isUser
                        ? Border.all(
                            color: AppTheme.lightTheme.dividerColor,
                            width: 1,
                          )
                        : null,
                  ),
                  child: Text(
                    messageText,
                    style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                      color: isUser
                          ? Colors.white
                          : AppTheme.lightTheme.colorScheme.onSurface,
                    ),
                  ),
                ),
              ),

              if (isUser) ...[
                SizedBox(width: 2.w),
                // User Avatar
                Container(
                  width: 8.w,
                  height: 8.w,
                  decoration: BoxDecoration(
                    color:
                        AppTheme.lightTheme.primaryColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(4.w),
                  ),
                  child: Center(
                    child: CustomIconWidget(
                      iconName: 'person',
                      color: AppTheme.lightTheme.primaryColor,
                      size: 16,
                    ),
                  ),
                ),
              ],
            ],
          ),

          // Menu Items (for AI responses)
          if (!isUser &&
              messageType == "menu_recommendation" &&
              menuItems != null)
            Container(
              margin: EdgeInsets.only(top: 2.h, left: 10.w),
              child: Column(
                children: menuItems.map((item) {
                  return MenuItemCardWidget(
                    item: item as Map<String, dynamic>,
                    onAddToCart: onAddToCart,
                  );
                }).toList(),
              ),
            ),

          // Timestamp
          Container(
            margin: EdgeInsets.only(
              top: 1.h,
              left: isUser ? 0 : 10.w,
              right: isUser ? 10.w : 0,
            ),
            child: Text(
              _formatTimestamp(timestamp),
              style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                fontSize: 10.sp,
              ),
              textAlign: isUser ? TextAlign.right : TextAlign.left,
            ),
          ),
        ],
      ),
    );
  }

  String _formatTimestamp(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inMinutes < 1) {
      return 'Just now';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h ago';
    } else {
      return '${timestamp.day}/${timestamp.month}/${timestamp.year}';
    }
  }
}
