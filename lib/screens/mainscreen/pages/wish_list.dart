import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:timbu_v2/providers/cart_provider.dart';
import 'package:timbu_v2/screens/product_detail_screen.dart';
import 'package:timbu_v2/util/constants/color_constants.dart';
import 'package:timbu_v2/util/widgets/item_card.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final wishList = cartProvider.getUserWishlist();

    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: ColorConstants.neutralWhite,
      appBar: AppBar(
        title: Text(
          "Your WishList",
          style: GoogleFonts.lora(
            fontWeight: FontWeight.w600,
            color: ColorConstants.baseBlack,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 40.h, vertical: 10.h),
          child: Column(
            children: [
              Expanded(
                child: wishList.isNotEmpty
                    ? GridView.builder(
                        itemCount: wishList.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: size.width >= 500 ? 4 : 2,
                          crossAxisSpacing: size.width >= 500 ? 32.w : 15.w,
                          mainAxisSpacing: 10.h,
                          childAspectRatio: 0.7,
                        ),
                        itemBuilder: (context, index) {
                          return ItemCard(
                            product: wishList[index],
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ProductDetail(
                                    product: wishList[index],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      )
                    : const Center(
                        child: Text(
                          'No product added to wishlist',
                          style: TextStyle(
                            fontSize: 16,
                            color: ColorConstants.neutral600,
                          ),
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
