import 'package:flutter/material.dart';
import 'package:timbu/model/product.dart';
import 'package:timbu/util/constants/color_constants.dart';

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
      child: Container(
        decoration: BoxDecoration(
          color: ColorConstants.backgroundColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: Colors.grey.withOpacity(0.3),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 200,
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Hero(
                tag: product.id,
                child: product.photos.isNotEmpty
                    ? Image.network(
                        product.photos.first,
                        fit: BoxFit.fitHeight,
                      )
                    : const Icon(
                        Icons.warning,
                        size: 50,
                        // color: ColorConstants.primaryColor,
                      ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                      color: ColorConstants.black50,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  // product price

                  Text(
                    product.currentPrice != null
                        ? "NGN ${product.currentPrice.toString()}"
                        : "price unavailable",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: ColorConstants.primaryColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
