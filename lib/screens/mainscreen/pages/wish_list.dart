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
                    ? ListView.builder(
                        itemCount: wishList.length,
                        itemBuilder: (context, index) {
                          final product = wishList[index];
                          return Container(
                            padding: EdgeInsets.symmetric(
                              vertical: 10.h,
                            ),
                            child: ListTile(
                              title: Text(
                                product.name,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w600,
                                  color: ColorConstants.baseBlack,
                                ),
                              ),
                              subtitle: Text(
                                "NGN ${product.currentPrice!.toStringAsFixed(0)}",
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: ColorConstants.grey700,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              leading: Container(
                                height: 120.h,
                                width: 60.w,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(
                                      product.photos.first,
                                    ),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                              trailing: Column(
                                children: [
                                  BuyNowButton(product: product),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      cartProvider.removeFromWishlist(product);
                                    },
                                    child: Container(
                                      height: 24.h,
                                      width: 66.w,
                                      decoration: BoxDecoration(
                                        // color: const Color(0xFFCC474E),
                                        borderRadius:
                                            BorderRadius.circular(2.37.r),
                                      ),
                                      child: Row(
                                        children: [
                                          // Image.asset(
                                          //   ImageConstants.deleteIcon,
                                          // ),
                                          const Icon(
                                            Icons.delete,
                                            size: 15,
                                          ),
                                          Text(
                                            "Remove",
                                            style: TextStyle(
                                              fontSize: 10.sp,
                                              fontWeight: FontWeight.w600,
                                              color: ColorConstants.baseBlack,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ProductDetail(
                                      product: product,
                                    ),
                                  ),
                                );
                              },
                            ),
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
