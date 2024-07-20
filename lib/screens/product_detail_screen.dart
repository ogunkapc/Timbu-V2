import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:timbu_v2/providers/cart_provider.dart';
import 'package:timbu_v2/model/product.dart';
import 'package:timbu_v2/screens/cart_screen.dart';
import 'package:timbu_v2/util/constants/color_constants.dart';
import 'package:timbu_v2/util/constants/image_constants.dart';
import 'package:timbu_v2/util/widgets/add_to_wishlist_button.dart';

class ProductDetail extends StatelessWidget {
  final Product product;

  const ProductDetail({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final cartProvider = Provider.of<CartProvider>(context);

    return Scaffold(
      backgroundColor: ColorConstants.neutralWhite,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(
            children: [
              size.width >= 600
                  ? buildLargeScreenProductView(size, cartProvider, product)
                  : buildSmallScreenProductView(size, cartProvider, product),
              Padding(
                padding: const EdgeInsets.all(30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: CircleAvatar(
                        backgroundColor: ColorConstants.neutralWhite,
                        radius: 15.27.r,
                        child: Image.asset(ImageConstants.backIcon),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const CartScreen(),
                          ),
                        );
                      },
                      child: cartProvider.getUserCartItems().isEmpty
                          ? Image.asset(ImageConstants.cartIcon)
                          : Stack(
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
                                        "${cartProvider.getUserCartItems().length}",
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
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: buildBottomNavBar(context),
    );
  }

  Column buildSmallScreenProductView(
      Size size, CartProvider cartProvider, Product product) {
    final isInWishlist = cartProvider.isInWishlist(product);
    return Column(
      children: [
        SizedBox(
          height: (size.height * 0.5).h,
          child: product.photos.isNotEmpty
              ? Image.network(
                  product.photos.first,
                  fit: BoxFit.fill,
                )
              : const Center(
                  child: Text("No image available"),
                ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 30.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    product.uniqueId,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w300,
                      color: ColorConstants.grey700,
                      letterSpacing: (0.3 * 16).sp,
                    ),
                  ),
                  Text(
                    "In Stock",
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: ColorConstants.green,
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 30.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: (size.width * 0.6).w,
                    child: Text(
                      product.name,
                      style: TextStyle(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w600,
                        color: ColorConstants.baseBlack,
                      ),
                    ),
                  ),
                  AddToWishlistButton(
                    isInWishlist: isInWishlist,
                    cartProvider: cartProvider,
                    product: product,
                  )
                ],
              ),
              SizedBox(
                height: 32.h,
              ),
              Text(
                product.description,
                style: TextStyle(
                  fontSize: 14.sp,
                  color: ColorConstants.grey800,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  Row buildLargeScreenProductView(
      Size size, CartProvider cartProvider, Product product) {
    final isInWishlist = cartProvider.isInWishlist(product);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Container(
            // height: size.height * 0.5,
            padding: const EdgeInsets.all(10),
            child: Hero(
              tag: product.id,
              child: product.photos.isNotEmpty
                  ? Image.network(
                      product.photos.first,
                      fit: BoxFit.fitHeight,
                    )
                  : const Center(
                      child: Text("No image available"),
                    ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      product.uniqueId,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w300,
                        color: ColorConstants.grey700,
                        letterSpacing: (100).sp,
                      ),
                    ),
                    Text(
                      "In Stock",
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: ColorConstants.green,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 30.h,
                ),
                Row(
                  children: [
                    Text(
                      product.name,
                      maxLines: 3,
                      style: TextStyle(
                        fontSize: 23.sp,
                        fontWeight: FontWeight.w600,
                        color: ColorConstants.baseBlack,
                      ),
                    ),
                    AddToWishlistButton(
                      isInWishlist: isInWishlist,
                      cartProvider: cartProvider,
                      product: product,
                    )
                  ],
                ),
                SizedBox(
                  height: 32.h,
                ),
                Text(
                  product.description,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: ColorConstants.grey800,
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget buildBottomNavBar(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    final isInCart = cartProvider.getUserCartItems().contains(product);

    return BottomAppBar(
      height: 84.h,
      padding: EdgeInsets.symmetric(horizontal: 48.w, vertical: 12.h),
      color: isInCart ? const Color(0xFFE4F5E0) : ColorConstants.green,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: isInCart
            ? addedToCartNavBar(cartProvider, context)
            : notInCartNavBar(cartProvider, context),
      ),
    );
  }

  List<Widget> notInCartNavBar(
      CartProvider cartProvider, BuildContext context) {
    return [
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Sub",
            style: TextStyle(
              fontSize: 12.sp,
              color: ColorConstants.baseWhite,
            ),
          ),
          Text(
            "NGN ${product.currentPrice!.toStringAsFixed(0)}",
            style: GoogleFonts.lora(
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
              color: ColorConstants.baseWhite,
            ),
          ),
        ],
      ),
      GestureDetector(
        onTap: () {
          cartProvider.addToCart(product);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: ColorConstants.neutralWhite,
              behavior: SnackBarBehavior.floating,
              width: 250.w,
              padding: EdgeInsets.all(15.w),
              duration: Durations.long2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.r),
                side: BorderSide(
                  color: ColorConstants.grey600,
                  width: 0.79.w,
                ),
              ),
              content: Center(
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "${product.name} ",
                        style: const TextStyle(
                          color: ColorConstants.green,
                        ),
                      ),
                      const TextSpan(
                        text: "added to cart",
                        style: TextStyle(
                          color: ColorConstants.neutral600,
                        ),
                      )
                    ],
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          );
        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 12.5.h, horizontal: 43.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(3.82.r),
            border: Border.all(
              color: ColorConstants.baseWhite,
              width: 2.w,
            ),
          ),
          child: Text(
            "Add to cart",
            style: TextStyle(
              color: ColorConstants.baseWhite,
              fontSize: 11.45.sp,
              fontWeight: FontWeight.w400,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    ];
  }

  List<Widget> addedToCartNavBar(
      CartProvider cartProvider, BuildContext context) {
    return [
      GestureDetector(
        onTap: () {
          cartProvider.removeFromCart(product);
        },
        child: Container(
          width: 63.w,
          height: 48.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4.r),
            border: Border.all(
              width: 1.w,
              color: ColorConstants.neutral800,
            ),
          ),
          child: Center(
            child: Text(
              "Cancel",
              style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: ColorConstants.neutral800,
              ),
            ),
          ),
        ),
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Unit Price",
            style: TextStyle(
              fontSize: 16.sp,
              color: ColorConstants.neutral600,
            ),
          ),
          Text(
            "NGN ${product.currentPrice!.toStringAsFixed(0)}",
            style: GoogleFonts.inter(
              fontSize: 20.sp,
              fontWeight: FontWeight.w600,
              color: ColorConstants.neutral800,
            ),
          ),
        ],
      ),
      GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const CartScreen(),
            ),
          );
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.5.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6.r),
            color: ColorConstants.green,
          ),
          child: Text(
            "Checkout",
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w400,
              color: ColorConstants.baseWhite,
            ),
          ),
        ),
      ),
    ];
  }
}
