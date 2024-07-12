import 'package:flutter/material.dart';
import 'package:timbu/model/product.dart';
import 'package:timbu/util/constants/color_constants.dart';

class ProductDetail extends StatelessWidget {
  final Product product;

  const ProductDetail({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: ColorConstants.lightGreyColor,
      appBar: AppBar(
        backgroundColor: ColorConstants.whiteColor,
        elevation: 0,
        title: Text(
          product.name,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: ColorConstants.primaryColor,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: size.width >= 600
            ? buildLargeScreenProductView(size)
            : buildSmallScreenProductView(size),
      ),
      bottomNavigationBar: buildBottomNavBar(context),
    );
  }

  Column buildSmallScreenProductView(Size size) {
    return Column(
      children: [
        Container(
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
        Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: ColorConstants.black50,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "NGN ${product.currentPrice.toString()}",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: ColorConstants.primaryColor,
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
          child: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(24),
                topRight: Radius.circular(24),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: ColorConstants.black50,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "NGN ${product.currentPrice.toString()}",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: ColorConstants.primaryColor,
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
          ),
        )
      ],
    );
  }

  Widget buildBottomNavBar(BuildContext context) {
    return BottomAppBar(
      // height: 70,
      color: ColorConstants.whiteColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Center(
          child: GestureDetector(
            onTap: () {
              addToCart(context);
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: ColorConstants.primaryColor,
              ),
              child: Text(
                "Add to cart",
                style: TextStyle(
                  color: ColorConstants.whiteColor,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
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
