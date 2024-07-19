import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:timbu_v2/model/product.dart';

class CollectionsCard extends StatelessWidget {
  final Product product;
  final String heroTag;
  final void Function() onTap;
  const CollectionsCard({
    super.key,
    required this.product,
    required this.heroTag,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        height: 176,
        width: 160,
        child: Column(
          children: [
            Hero(
              tag: heroTag,
              child: Container(
                height: 142,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                      product.photos.first,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 5.h,
            ),
            Text(
              product.name,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
