import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:timbu_v2/providers/cart_provider.dart';
import 'package:timbu_v2/model/product.dart';
import 'package:timbu_v2/util/constants/color_constants.dart';
import 'package:timbu_v2/util/widgets/add_to_cart_button.dart';

class ItemCard extends StatelessWidget {
  final Product product;
  final void Function() onTap;

  const ItemCard({
    super.key,
    required this.product,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final isInWishlist = cartProvider.isInWishlist(product);

    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        height: 210.h,
        width: 160.w,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              children: [
                Container(
                  height: 140.h,
                  width: 160.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.65.r),
                  ),
                  child: product.photos.isNotEmpty
                      ? Image.network(
                          product.photos.first,
                          fit: BoxFit.contain,
                        )
                      : const Icon(
                          Icons.warning,
                          size: 50,
                        ),
                ),
                Positioned(
                  top: 8.h,
                  right: 8.w,
                  child: GestureDetector(
                    onTap: () {
                      if (isInWishlist) {
                        cartProvider.removeFromWishlist(product);
                      } else {
                        cartProvider.addToWishlist(product);
                      }
                    },
                    child: Icon(
                      isInWishlist ? Icons.favorite : Icons.favorite_border,
                      color: isInWishlist ? Colors.red : Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 80.w,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                          color: ColorConstants.neutral600,
                        ),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Text(
                        product.currentPrice != null
                            ? "NGN ${product.currentPrice!.toStringAsFixed(0)}"
                            : 10000.toStringAsFixed(0),
                        style: TextStyle(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w600,
                          color: ColorConstants.neutral800,
                        ),
                      ),
                    ],
                  ),
                ),
                AddToCartButton(product: product),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
