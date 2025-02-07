import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:timbu_v2/providers/cart_provider.dart';
import 'package:timbu_v2/model/product.dart';
import 'package:timbu_v2/util/constants/color_constants.dart';

class AddToCartButton extends StatelessWidget {
  final Product product;
  const AddToCartButton({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    return GestureDetector(
      onTap: () {
        cartProvider.addToCart(product);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: ColorConstants.neutralWhite,
            behavior: SnackBarBehavior.floating,
            width: 250.w,
            padding: EdgeInsets.all(15.w),
            duration: Durations.long2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.r),
              side: BorderSide(
                color: ColorConstants.grey600,
                width: 0.79.w,
              ),
            ),
            content: Center(
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "${product.name} ",
                      style: const TextStyle(
                        color: ColorConstants.green,
                      ),
                    ),
                    const TextSpan(
                      text: "added to cart",
                      style: TextStyle(
                        color: ColorConstants.neutral600,
                      ),
                    )
                  ],
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        );
      },
      child: Container(
        height: 24.h,
        width: 56.w,
        decoration: BoxDecoration(
          border: Border.all(color: ColorConstants.green, width: 0.79.w),
          borderRadius: BorderRadius.circular(2.37.r),
        ),
        child: Center(
          child: Text(
            "Add to Cart",
            style: TextStyle(
              fontSize: 7.1.sp,
              color: ColorConstants.green,
            ),
          ),
        ),
      ),
    );
  }
}
