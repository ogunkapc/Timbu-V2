import 'package:flutter/material.dart';
import 'package:timbu_v2/model/product.dart';
import 'package:timbu_v2/util/constants/color_constants.dart';

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
        height: 210,
        width: 160,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 150,
              width: 160,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.45),
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
                        // color: ColorConstants.primaryColor,
                      ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 80,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.name,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: ColorConstants.neutral600,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          product.currentPrice != null
                              ? "NGN ${product.currentPrice.toString()}"
                              : "price unavailable",
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: ColorConstants.neutral800,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 24,
                    width: 60,
                    decoration: BoxDecoration(
                      border:
                          Border.all(color: ColorConstants.green, width: 0.79),
                      borderRadius: BorderRadius.circular(2.37),
                    ),
                    child: const Center(
                      child: Text(
                        "Add to Cart",
                        style: TextStyle(
                          fontSize: 9,
                          color: ColorConstants.green,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
