import 'package:flutter/material.dart';
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
      },
      child: Container(
        height: 24,
        width: 60,
        decoration: BoxDecoration(
          border: Border.all(color: ColorConstants.green, width: 0.79),
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
      ),
    );
  }
}
