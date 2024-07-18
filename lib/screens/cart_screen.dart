import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timbu_v2/model/cart_provider.dart';
import 'package:timbu_v2/model/product_provider.dart';
import 'package:timbu_v2/util/constants/color_constants.dart';

import '../util/widgets/empty_cart_screen.dart';
import '../util/widgets/not_empty_cart_screen.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.neutralWhite,
      body: SafeArea(
        child: Consumer<CartProvider>(
          builder: (context, value, child) {
            final cartList = value.getUserCartItems();
            final productProvider = Provider.of<ProductProvider>(context);

            final youMightLikeList = productProvider.getYouMightLike();
            final recenlyViewedList = productProvider.getRecentlyViewed();
            return cartList.isEmpty
                ? EmptyCartScreen(
                    recentlyViewedList: recenlyViewedList,
                  )
                : NotEmptyCartScreen(
                    cartList: cartList,
                    cartProvider: value,
                    youMightLikeList: youMightLikeList,
                  );
          },
        ),
      ),
    );
  }
}
