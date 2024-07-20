import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:timbu_v2/model/product.dart';
import 'package:timbu_v2/providers/cart_provider.dart';
import 'package:timbu_v2/util/constants/color_constants.dart';

class AddToWishlistButton extends StatelessWidget {
  const AddToWishlistButton({
    super.key,
    required this.isInWishlist,
    required this.cartProvider,
    required this.product,
  });

  final bool isInWishlist;
  final CartProvider cartProvider;
  final Product product;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (isInWishlist) {
          cartProvider.removeFromWishlist(product);
        } else {
          cartProvider.addToWishlist(product);
        }
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
                    TextSpan(
                      text: !isInWishlist
                          ? "added to wishlist"
                          : "removed from wishlist",
                      style: const TextStyle(
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
      child: Icon(
        isInWishlist ? Icons.favorite : Icons.favorite_border,
        color: isInWishlist ? Colors.red : Colors.grey,
      ),
    );
  }
}
