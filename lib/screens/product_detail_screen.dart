import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:timbu_v2/model/product.dart';
import 'package:timbu_v2/util/constants/color_constants.dart';
import 'package:timbu_v2/util/constants/image_constants.dart';

class ProductDetail extends StatelessWidget {
  final Product product;

  const ProductDetail({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: ColorConstants.neutralWhite,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(
            children: [
              size.width >= 600
                  ? buildLargeScreenProductView(size)
                  : buildSmallScreenProductView(size),
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
                    Image.asset(ImageConstants.cartIcon),
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

  Column buildSmallScreenProductView(Size size) {
    return Column(
      children: [
        Container(
          height: (size.height * 0.5).h,
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
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 30.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "uniqueId",
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w300,
                      color: ColorConstants.grey700,
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
              const SizedBox(
                height: 30,
              ),
              Text(
                product.name,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: ColorConstants.baseBlack,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                product.description,
                style: TextStyle(
                  fontSize: 14,
                  color: ColorConstants.black50,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  Row buildLargeScreenProductView(Size size) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Container(
            height: size.height * 0.5,
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
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "uniqueId",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w300,
                        color: ColorConstants.grey700,
                      ),
                    ),
                    Text(
                      "In Stock",
                      style: TextStyle(
                        fontSize: 14,
                        color: ColorConstants.green,
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Text(
                  product.name,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: ColorConstants.baseBlack,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  product.description,
                  style: TextStyle(
                    fontSize: 17.5,
                    color: ColorConstants.black50,
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
    return BottomAppBar(
      // height: 70,
      color: ColorConstants.neutralWhite,
      child: Row(
        children: [
          Text(
            "NGN ${product.currentPrice.toString()}",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: ColorConstants.primaryColor,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Center(
              child: GestureDetector(
                onTap: () {
                  addToCart(context);
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: ColorConstants.primaryColor,
                  ),
                  child: const Text(
                    "Add to cart",
                    style: TextStyle(
                      color: ColorConstants.neutralWhite,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void addToCart(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
          padding: const EdgeInsets.all(24),
          child: Text(
            "Item has been added to cart",
            style: TextStyle(
              color: ColorConstants.black50,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          )),
      backgroundColor: ColorConstants.backgroundColor,
    );
  }
}
