import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:timbu_v2/model/product.dart';
import 'package:timbu_v2/screens/mainscreen/main_screen.dart';
import 'package:timbu_v2/screens/product_detail_screen.dart';
import 'package:timbu_v2/util/constants/color_constants.dart';
import 'package:timbu_v2/util/constants/image_constants.dart';
import 'package:timbu_v2/util/widgets/item_card.dart';

class EmptyCartScreen extends StatelessWidget {
  const EmptyCartScreen({super.key, required this.recentlyViewedList});

  final List<Product> recentlyViewedList;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 48.w, vertical: 32.h),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Image.asset(ImageConstants.backIcon),
                ),
                Image.asset(ImageConstants.cartIcon),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Image.asset(ImageConstants.emptyCart),
                    SizedBox(
                      height: 32.h,
                    ),
                    Text(
                      "Your Cart is empty",
                      style: GoogleFonts.lora(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        color: ColorConstants.baseBlack,
                      ),
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    Text(
                      "Explore our collections today and start your journey towards radiant beauty. Your skin will thank you",
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: ColorConstants.grey600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 32.h,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const MainScreen(),
                          ),
                        );
                      },
                      child: Container(
                        height: 50.h,
                        width: 165.w,
                        padding: EdgeInsets.symmetric(
                          horizontal: 23.w,
                          vertical: 14.h,
                        ),
                        decoration: BoxDecoration(
                          color: ColorConstants.green,
                          borderRadius: BorderRadius.circular(6.r),
                        ),
                        child: Center(
                          child: Text(
                            "Start Shopping",
                            style: GoogleFonts.inter(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500,
                              color: ColorConstants.neutralWhite,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 80.h,
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Recently Viewed",
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w300,
                            color: ColorConstants.baseBlack,
                            letterSpacing: (0.31 * 14).w,
                          ),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            "View all",
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: ColorConstants.green,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Divider(),
                    SizedBox(
                      height: 48.h,
                    ),
                    SizedBox(
                      height: 225.h,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: recentlyViewedList.length,
                        itemBuilder: (context, index) => ItemCard(
                          product: recentlyViewedList[index],
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProductDetail(
                                  product: recentlyViewedList[index],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
