import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:timbu_v2/model/cart_provider.dart';
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
        showModalBottomSheet(
          context: context,
          builder: (context) => Container(
              padding: const EdgeInsets.all(24),
              child: Text(
                "${product.name} has been added to cart",
                style: TextStyle(
                  color: ColorConstants.black50,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              )),
          backgroundColor: ColorConstants.backgroundColor,
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
