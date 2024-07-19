import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:timbu_v2/model/order.dart';
import 'package:timbu_v2/providers/cart_provider.dart';
import 'package:timbu_v2/util/constants/color_constants.dart';

class OrderHistoryScreen extends StatelessWidget {
  const OrderHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final orderHistory = cartProvider.getOrderHistory();

    return Scaffold(
      backgroundColor: ColorConstants.neutralWhite,
      appBar: AppBar(
        backgroundColor: ColorConstants.neutralWhite,
        elevation: 0,
        title: Text(
          'Order History',
          style: GoogleFonts.lora(
            fontWeight: FontWeight.w600,
            color: ColorConstants.baseBlack,
          ),
        ),
        centerTitle: true,
      ),
      body: orderHistory.isEmpty
          ? const Center(
              child: Text(
                'No orders yet',
                style: TextStyle(
                  fontSize: 17,
                  color: ColorConstants.neutral800,
                ),
              ),
            )
          : ListView.builder(
              itemCount: orderHistory.length,
              itemBuilder: (context, index) {
                Order order = orderHistory[index];
                return OrderHistoryCard(order: order);
              },
            ),
    );
  }
}

class OrderHistoryCard extends StatelessWidget {
  const OrderHistoryCard({
    super.key,
    required this.order,
  });

  final Order order;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.green.shade50,
      margin: EdgeInsets.all(10.w),
      child: Padding(
        padding: EdgeInsets.all(10.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Order ID: ${order.id}',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 10.h),
            Text(
              'Date: ${order.date}',
              style: TextStyle(
                fontSize: 12.sp,
                color: ColorConstants.grey600,
              ),
            ),
            SizedBox(height: 10.h),
            Column(
              children: order.products
                  .asMap()
                  .entries
                  .map(
                    (entry) => Padding(
                      padding: EdgeInsets.symmetric(vertical: 5.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: 200.w,
                            child: Text(
                              entry.value.name,
                              style: GoogleFonts.inter(
                                fontSize: 14.sp,
                                color: ColorConstants.grey700,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Text(
                            "NGN ${entry.value.currentPrice!.toStringAsFixed(0)}",
                            style: GoogleFonts.inter(
                              fontSize: 14.sp,
                              color: ColorConstants.grey700,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            'x${order.quantities[entry.key]}',
                            style: GoogleFonts.inter(
                              fontSize: 14.sp,
                              color: ColorConstants.grey700,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                  .toList(),
            ),
            const Divider(),
            Text(
              'Total: NGN ${order.totalAmount.toStringAsFixed(0)}',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
