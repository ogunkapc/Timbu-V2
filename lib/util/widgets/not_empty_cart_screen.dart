import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:timbu_v2/model/cart_provider.dart';
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
        padding: EdgeInsets.symmetric(horizontal: 48.w, vertical: 32.h),
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
                Image.asset(ImageConstants.filledCart),
              ],
            ),
            const Divider(),
            SizedBox(
              height: 32.h,
            ),
            ListView.builder(
                shrinkWrap: true,
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
              height: 220.h,
              child: ListView.builder(
                  itemCount: youMightLikeList.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    final product = youMightLikeList[index];
                    return ItemCard(
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
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCartItem(Product product, CartProvider cartProvider) {
    return SizedBox(
      height: 120,
      child: Row(
        children: [
          Container(
            width: 87,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                  product.photos.first,
                ),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(3.42),
            ),
          ),
          const SizedBox(
            width: 23,
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
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w300,
                      color: ColorConstants.grey700,
                    ),
                  ),
                  Text(
                    product.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: ColorConstants.baseBlack,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Container(
                    height: 30,
                    width: 70,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(1.83),
                      border: Border.all(
                          color: ColorConstants.grey600, width: 0.34),
                    ),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            height: 24.31,
                            width: 26.25,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(1.83),
                              border: const Border.symmetric(
                                horizontal: BorderSide(
                                  color: ColorConstants.neutral200,
                                  width: 0.3,
                                ),
                              ),
                            ),
                            child: const Center(
                              child: Text(
                                "-",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: ColorConstants.green,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 13.42,
                          child: Center(
                            child: Text("1"),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            height: 24.31,
                            width: 26.25,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(1.83),
                              border: const Border.symmetric(
                                horizontal: BorderSide(
                                  color: ColorConstants.neutral200,
                                  width: 0.3,
                                ),
                              ),
                            ),
                            child: const Center(
                              child: Text(
                                "+",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: ColorConstants.green,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 6.75,
                  ),
                  Container(
                    height: 30,
                    width: 30.73,
                    color: const Color(0xFFCC474E),
                    child: Image.asset(
                      ImageConstants.deleteIcon,
                    ),
                  ),
                ],
              )
            ],
          ),
          const Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Unit price",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: ColorConstants.grey800,
                ),
              ),
              Text(
                product.currentPrice.toString(),
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: ColorConstants.neutral800,
                ),
              ),
            ],
          ),
          const SizedBox(
            width: 15,
          ),
        ],
      ),
    );
  }

  Widget buildCartSummary(CartProvider cartProvider) {
    double deliveryFee = 2.00;
    double subTotal = cartProvider.totalAmount;
    double totalAmount = subTotal + deliveryFee;
    return Container(
      height: 290,
      padding: const EdgeInsets.symmetric(vertical: 35, horizontal: 7.5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: ColorConstants.green),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Cart summary",
            style: GoogleFonts.lora(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: ColorConstants.baseBlack,
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Column(
                children: [
                  Text(
                    "Sub-total",
                    style: TextStyle(
                      fontSize: 14,
                      color: ColorConstants.grey700,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(
                    height: 22,
                  ),
                  Text(
                    "Delivery",
                    style: TextStyle(
                      fontSize: 14,
                      color: ColorConstants.grey700,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Text(
                    "NGN ${subTotal.toStringAsFixed(2)}",
                    style: const TextStyle(
                      fontSize: 14,
                      color: ColorConstants.grey700,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(
                    height: 22,
                  ),
                  Text(
                    "NGN ${deliveryFee.toStringAsFixed(20)}",
                    style: const TextStyle(
                      fontSize: 14,
                      color: ColorConstants.grey700,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 30,
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
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  decoration: BoxDecoration(
                    border: Border.all(color: ColorConstants.neutral800),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    "Cancel",
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: ColorConstants.neutral800,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Total Amount",
                      style: TextStyle(
                        fontSize: 14,
                        color: ColorConstants.neutral600,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      "NGN ${totalAmount.toStringAsFixed(2)}",
                      style: const TextStyle(
                        fontSize: 18,
                        color: ColorConstants.neutral800,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  width: 16,
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: ColorConstants.green,
                  ),
                  child: const Text(
                    "Checkout",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: ColorConstants.baseWhite,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
