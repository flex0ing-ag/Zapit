import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class OrderCardWidget extends StatelessWidget {
  final Map<String, dynamic> order;
  final VoidCallback onReorder;
  final VoidCallback onTrackOrder;
  final VoidCallback onDelete;
  final VoidCallback onViewReceipt;
  final VoidCallback onRateOrder;

  const OrderCardWidget({
    super.key,
    required this.order,
    required this.onReorder,
    required this.onTrackOrder,
    required this.onDelete,
    required this.onViewReceipt,
    required this.onRateOrder,
  });

  @override
  Widget build(BuildContext context) {
    final isCompleted = order['status'] == 'completed';
    final items = (order['items'] as List).cast<Map<String, dynamic>>();
    final orderDate = order['orderDate'] as DateTime;

    return Dismissible(
      key: Key(order['id']),
      background: _buildSwipeBackground(isLeft: false),
      secondaryBackground:
          isCompleted ? _buildSwipeBackground(isLeft: true) : null,
      confirmDismiss: (direction) async {
        if (direction == DismissDirection.startToEnd) {
          // Swipe right - Quick actions
          _showQuickActions(context);
          return false;
        } else if (direction == DismissDirection.endToStart && isCompleted) {
          // Swipe left - Delete (only for completed orders)
          return await _showDeleteConfirmation(context);
        }
        return false;
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 2.h),
        decoration: BoxDecoration(
          color: AppTheme.lightTheme.cardColor,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: AppTheme.lightTheme.colorScheme.shadow,
              blurRadius: 8,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: InkWell(
          onTap: () => _showOrderDetails(context),
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: EdgeInsets.all(4.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildOrderHeader(),
                SizedBox(height: 2.h),
                _buildOrderItems(items),
                SizedBox(height: 2.h),
                _buildOrderFooter(isCompleted),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSwipeBackground({required bool isLeft}) {
    return Container(
      margin: EdgeInsets.only(bottom: 2.h),
      decoration: BoxDecoration(
        color: isLeft
            ? AppTheme.lightTheme.colorScheme.error
            : AppTheme.lightTheme.colorScheme.primary,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Align(
        alignment: isLeft ? Alignment.centerRight : Alignment.centerLeft,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 6.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomIconWidget(
                iconName: isLeft ? 'delete' : 'more_horiz',
                color: Colors.white,
                size: 24,
              ),
              SizedBox(height: 0.5.h),
              Text(
                isLeft ? 'Delete' : 'Actions',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOrderHeader() {
    final orderDate = order['orderDate'] as DateTime;
    final timeString =
        '${orderDate.hour.toString().padLeft(2, '0')}:${orderDate.minute.toString().padLeft(2, '0')}';

    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                order['canteenName'],
                style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 0.5.h),
              Text(
                '$timeString • Token: ${order['tokenNumber']}',
                style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                  color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
        _buildStatusBadge(),
      ],
    );
  }

  Widget _buildStatusBadge() {
    final isCompleted = order['status'] == 'completed';
    final isPending = order['status'] == 'pending';

    Color backgroundColor;
    Color textColor;
    String statusText;

    if (isCompleted) {
      backgroundColor =
          AppTheme.lightTheme.colorScheme.secondary.withValues(alpha: 0.1);
      textColor = AppTheme.lightTheme.colorScheme.secondary;
      statusText = 'Completed';
    } else if (isPending) {
      backgroundColor =
          AppTheme.lightTheme.colorScheme.primary.withValues(alpha: 0.1);
      textColor = AppTheme.lightTheme.colorScheme.primary;
      statusText = 'Pending';
    } else {
      backgroundColor =
          AppTheme.lightTheme.colorScheme.error.withValues(alpha: 0.1);
      textColor = AppTheme.lightTheme.colorScheme.error;
      statusText = 'Cancelled';
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 0.5.h),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        statusText,
        style: AppTheme.lightTheme.textTheme.labelSmall?.copyWith(
          color: textColor,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildOrderItems(List<Map<String, dynamic>> items) {
    return Row(
      children: [
        // Item thumbnails
        SizedBox(
          height: 12.w,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: items.length > 3 ? 3 : items.length,
            itemBuilder: (context, index) {
              if (index == 2 && items.length > 3) {
                return Container(
                  width: 12.w,
                  height: 12.w,
                  margin: EdgeInsets.only(right: 2.w),
                  decoration: BoxDecoration(
                    color: AppTheme.lightTheme.colorScheme.primary
                        .withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text(
                      '+${items.length - 2}',
                      style: AppTheme.lightTheme.textTheme.labelSmall?.copyWith(
                        color: AppTheme.lightTheme.colorScheme.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                );
              }

              return Container(
                width: 12.w,
                height: 12.w,
                margin: EdgeInsets.only(right: 2.w),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: CustomImageWidget(
                    imageUrl: items[index]['image'],
                    width: 12.w,
                    height: 12.w,
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
          ),
        ),
        SizedBox(width: 3.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${items.length} item${items.length > 1 ? 's' : ''}',
                style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 0.5.h),
              Text(
                items.take(2).map((item) => item['name']).join(', ') +
                    (items.length > 2 ? '...' : ''),
                style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                  color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
        Text(
          order['totalAmount'],
          style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
            color: AppTheme.lightTheme.colorScheme.primary,
          ),
        ),
      ],
    );
  }

  Widget _buildOrderFooter(bool isCompleted) {
    return Row(
      children: [
        if (order['rating'] != null && isCompleted) ...[
          CustomIconWidget(
            iconName: 'star',
            color: Colors.amber,
            size: 16,
          ),
          SizedBox(width: 1.w),
          Text(
            order['rating'].toString(),
            style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
              color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
            ),
          ),
          SizedBox(width: 2.w),
        ],
        Text(
          'Pickup: ${order['pickupTime']}',
          style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
            color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
          ),
        ),
        Spacer(),
        if (isCompleted)
          OutlinedButton(
            onPressed: onReorder,
            style: OutlinedButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
              minimumSize: Size(0, 0),
            ),
            child: Text(
              'Reorder',
              style: AppTheme.lightTheme.textTheme.labelMedium,
            ),
          )
        else
          TextButton(
            onPressed: onTrackOrder,
            style: TextButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
              minimumSize: Size(0, 0),
            ),
            child: Text(
              'Track Order',
              style: AppTheme.lightTheme.textTheme.labelMedium,
            ),
          ),
      ],
    );
  }

  void _showQuickActions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: BoxDecoration(
          color: AppTheme.lightTheme.cardColor,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 12.w,
              height: 0.5.h,
              margin: EdgeInsets.symmetric(vertical: 2.h),
              decoration: BoxDecoration(
                color: AppTheme.lightTheme.colorScheme.onSurfaceVariant
                    .withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            ListTile(
              leading: CustomIconWidget(
                iconName: 'refresh',
                color: AppTheme.lightTheme.colorScheme.primary,
                size: 24,
              ),
              title: Text('Reorder All'),
              onTap: () {
                Navigator.pop(context);
                onReorder();
              },
            ),
            ListTile(
              leading: CustomIconWidget(
                iconName: 'receipt',
                color: AppTheme.lightTheme.colorScheme.onSurface,
                size: 24,
              ),
              title: Text('View Receipt'),
              onTap: () {
                Navigator.pop(context);
                onViewReceipt();
              },
            ),
            if (order['status'] == 'completed')
              ListTile(
                leading: CustomIconWidget(
                  iconName: 'star_rate',
                  color: Colors.amber,
                  size: 24,
                ),
                title: Text('Rate Order'),
                onTap: () {
                  Navigator.pop(context);
                  onRateOrder();
                },
              ),
            SizedBox(height: 2.h),
          ],
        ),
      ),
    );
  }

  Future<bool> _showDeleteConfirmation(BuildContext context) async {
    return await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Delete Order'),
            content: Text(
                'Are you sure you want to delete this order from your history?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () => Navigator.pop(context, true),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.lightTheme.colorScheme.error,
                ),
                child: Text('Delete'),
              ),
            ],
          ),
        ) ??
        false;
  }

  void _showOrderDetails(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.7,
        maxChildSize: 0.9,
        minChildSize: 0.5,
        builder: (context, scrollController) => Container(
          decoration: BoxDecoration(
            color: AppTheme.lightTheme.cardColor,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            children: [
              Container(
                width: 12.w,
                height: 0.5.h,
                margin: EdgeInsets.symmetric(vertical: 2.h),
                decoration: BoxDecoration(
                  color: AppTheme.lightTheme.colorScheme.onSurfaceVariant
                      .withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              Expanded(
                child: ListView(
                  controller: scrollController,
                  padding: EdgeInsets.all(4.w),
                  children: [
                    Text(
                      'Order Details',
                      style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    _buildOrderHeader(),
                    SizedBox(height: 3.h),
                    Text(
                      'Items Ordered',
                      style:
                          AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 1.h),
                    ...(order['items'] as List)
                        .map((item) => _buildDetailItem(item))
                        ,
                    SizedBox(height: 2.h),
                    Divider(),
                    SizedBox(height: 1.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total Amount',
                          style: AppTheme.lightTheme.textTheme.titleMedium
                              ?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          order['totalAmount'],
                          style: AppTheme.lightTheme.textTheme.titleMedium
                              ?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: AppTheme.lightTheme.colorScheme.primary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailItem(Map<String, dynamic> item) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 1.h),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: CustomImageWidget(
              imageUrl: item['image'],
              width: 15.w,
              height: 15.w,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: 3.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item['name'],
                  style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 0.5.h),
                Text(
                  'Qty: ${item['quantity']}',
                  style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                    color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          Text(
            item['price'],
            style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
