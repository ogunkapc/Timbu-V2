import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        height: 210.h,
        width: 160.w,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 160.h,
              width: 160.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.65.r),
              ),
              child: Hero(
                tag: product.id,
                child: product.photos.isNotEmpty
                    ? Image.network(
                        product.photos.first,
                        fit: BoxFit.fill,
                      )
                    : const Icon(
                        Icons.warning,
                        size: 50,
                      ),
              ),
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
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w400,
                          color: ColorConstants.neutral600,
                        ),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Text(
                        product.currentPrice != null
                            ? "NGN ${product.currentPrice.toString()}"
                            : 10000.toString(),
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
