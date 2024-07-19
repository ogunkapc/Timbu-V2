import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:timbu_v2/providers/cart_provider.dart';
import 'package:timbu_v2/model/product.dart';
import 'package:timbu_v2/screens/product_detail_screen.dart';
import 'package:timbu_v2/util/constants/color_constants.dart';
import 'package:timbu_v2/util/constants/image_constants.dart';
import 'package:timbu_v2/util/widgets/item_card.dart';

class NotEmptyCartScreen extends StatelessWidget {
  const NotEmptyCartScreen({
    super.key,
    required this.cartList,
    required this.cartProvider,
    required this.youMightLikeList,
  });

  final List<Product> cartList;
  final CartProvider cartProvider;
  final List<Product> youMightLikeList;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 32.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Image.asset(ImageConstants.backIcon),
                    ),
                    SizedBox(
                      width: 13.45.w,
                    ),
                    Text(
                      "Cart",
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: ColorConstants.baseBlack,
                      ),
                    )
                  ],
                ),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.asset(
                      ImageConstants.filledCart,
                      scale: 1,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 4.w,
                        ),
                        Center(
                          child: Text(
                            "${cartList.length}",
                            style: TextStyle(
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w700,
                              color: ColorConstants.baseWhite,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            const Divider(),
            SizedBox(
              height: 32.h,
            ),
            ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: cartList.length,
                itemBuilder: (context, index) {
                  final product = cartList[index];
                  return buildCartItem(product, cartProvider);
                }),
            const SizedBox(
              height: 48,
            ),
            buildCartSummary(cartProvider),
            SizedBox(
              height: 45.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "You might like",
                  style: GoogleFonts.lora(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                    color: ColorConstants.neutral800,
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    "View all",
                    style: GoogleFonts.inter(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: ColorConstants.neutral600,
                    ),
                  ),
                ),
              ],
            ),
            const Divider(),
            SizedBox(
              height: 230.h,
              child: ListView.builder(
                  itemCount: youMightLikeList.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    final product = youMightLikeList[index];
                    return Container(
                      margin: const EdgeInsets.only(right: 20),
                      child: ItemCard(
                        product: product,
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
                  }),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCartItem(Product product, CartProvider cartProvider) {
    int index = cartProvider.getUserCartItems().indexOf(product);
    int quantity = cartProvider.getQuantities()[index];
    return Container(
      height: 120.h,
      margin: EdgeInsets.symmetric(vertical: 10.h),
      child: Row(
        children: [
          Container(
            width: 87.w,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                  product.photos.first,
                ),
                fit: BoxFit.fill,
              ),
              borderRadius: BorderRadius.circular(3.42.r),
            ),
          ),
          SizedBox(
            width: 20.w,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.uniqueId,
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w300,
                      color: ColorConstants.grey700,
                      letterSpacing: (0.4 * 12).sp,
                    ),
                  ),
                  SizedBox(
                    width: 123.w,
                    child: Text(
                      product.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: ColorConstants.baseBlack,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Container(
                    height: 30.h,
                    width: 70.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(1.83.r),
                      border: Border.all(
                        color: ColorConstants.grey600,
                        width: 0.34.w,
                      ),
                    ),
                    child: Row(
                      children: [
                        //! decrement quantity
                        GestureDetector(
                          onTap: () {
                            cartProvider.decrementQuantity(product);
                          },
                          child: Container(
                            height: 24.31.h,
                            width: 26.25.w,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(1.83.r),
                              border: Border.symmetric(
                                horizontal: BorderSide(
                                  color: ColorConstants.neutral200,
                                  width: 0.3.w,
                                ),
                              ),
                            ),
                            child: Center(
                              child: Text(
                                "-",
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  color: ColorConstants.green,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 13.42.w,
                          child: Center(
                            child: Text(
                              quantity.toString(),
                              style: GoogleFonts.inter(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        //! increment quantity
                        GestureDetector(
                          onTap: () {
                            cartProvider.incrementQuantity(product);
                          },
                          child: Container(
                            height: 24.31.h,
                            width: 26.25.w,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(1.83.r),
                              border: Border.symmetric(
                                horizontal: BorderSide(
                                  color: ColorConstants.neutral200,
                                  width: 0.3.r,
                                ),
                              ),
                            ),
                            child: Center(
                              child: Text(
                                "+",
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  color: ColorConstants.green,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 6.75.w,
                  ),
                  //! remove from cart
                  GestureDetector(
                    onTap: () {
                      cartProvider.removeFromCart(product);
                    },
                    child: Container(
                      height: 30.h,
                      width: 30.73.w,
                      color: const Color(0xFFCC474E),
                      child: Image.asset(
                        ImageConstants.deleteIcon,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Unit price",
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                  color: ColorConstants.grey800,
                ),
              ),
              Text(
                "NGN ${product.currentPrice!.toStringAsFixed(0)}",
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: ColorConstants.neutral800,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildCartSummary(CartProvider cartProvider) {
    double deliveryFee = 2000;
    double subTotal = cartProvider.totalAmount;
    double totalAmount = subTotal + deliveryFee;
    return Container(
      height: 290.h,
      padding: EdgeInsets.symmetric(vertical: 30.h, horizontal: 7.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: ColorConstants.green),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Cart summary",
            style: GoogleFonts.lora(
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
              color: ColorConstants.baseBlack,
            ),
          ),
          SizedBox(
            height: 30.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  Text(
                    "Sub-total",
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: ColorConstants.grey700,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(
                    height: 22.h,
                  ),
                  Text(
                    "Delivery",
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: ColorConstants.grey700,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Text(
                    "NGN ${subTotal.toStringAsFixed(0)}",
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: ColorConstants.grey700,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    height: 22.h,
                  ),
                  Text(
                    "NGN ${deliveryFee.toStringAsFixed(0)}",
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: ColorConstants.grey700,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 30.h,
          ),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: ColorConstants.neutral200,
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //! cancel order and clear cart
                GestureDetector(
                  onTap: () {
                    cartProvider.clearCart();
                  },
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
                    decoration: BoxDecoration(
                      border: Border.all(color: ColorConstants.neutral800),
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                    child: Text(
                      "Cancel",
                      style: GoogleFonts.inter(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: ColorConstants.neutral800,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 13.w,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Total Amount",
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: ColorConstants.neutral600,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      "NGN ${totalAmount.toStringAsFixed(0)}",
                      style: TextStyle(
                        fontSize: 17.sp,
                        color: ColorConstants.neutral800,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: 13.w,
                ),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6.r),
                      color: ColorConstants.green,
                    ),
                    child: Text(
                      "Checkout",
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: ColorConstants.baseWhite,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
