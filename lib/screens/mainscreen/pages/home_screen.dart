import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:timbu_v2/model/product_provider.dart';
import 'package:timbu_v2/screens/cart_screen.dart';
import 'package:timbu_v2/screens/product_detail_screen.dart';
import 'package:timbu_v2/util/constants/color_constants.dart';
import 'package:timbu_v2/util/constants/image_constants.dart';
import 'package:timbu_v2/util/widgets/item_card.dart';

import '../../../util/widgets/collections_card.dart';
import '../../../util/widgets/search_box.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      fetchProducts();
    });
  }

  void fetchProducts() {
    final productProvider =
        Provider.of<ProductProvider>(context, listen: false);
    productProvider.fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: ColorConstants.neutralWhite,
      body: Consumer<ProductProvider>(
        builder: (context, value, child) {
          if (value.getIsLoading()) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (value.errorMessage.isNotEmpty) {
            return Center(
              child: Text(
                "Error: ${value.errorMessage}",
                style: const TextStyle(
                  color: Colors.red,
                ),
                textAlign: TextAlign.center,
              ),
            );
          }
          final justForYouList = value.getJustForYou();
          final dealsList = value.getDeals();
          final ourCollectionsList = value.getOurCollections();
          final youMightLikeList = value.getYouMightLike();

          return SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 48.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Sharrie's Signature",
                              style: GoogleFonts.redressed(
                                fontSize: 24.sp,
                                fontWeight: FontWeight.w400,
                                color: ColorConstants.green,
                              ),
                            ),
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    // Navigator.push(
                                    //   context,
                                    //   MaterialPageRoute(
                                    //     builder: (context) => const CartScreen(),
                                    //   ),
                                    // );
                                  },
                                  child: const Icon(Icons.history),
                                ),
                                SizedBox(
                                  width: 10.w,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const CartScreen(),
                                      ),
                                    );
                                  },
                                  child: Image.asset(ImageConstants.cartIcon),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 43.h),
                        Text(
                          "Welcome, Jane",
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: ColorConstants.baseBlack,
                          ),
                        ),
                        SizedBox(height: 16.h),
                        const SearchBox(),
                      ],
                    ),
                  ),
                  // const SizedBox(height: 48),
                  Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 48.w, vertical: 48.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Just for you",
                              style: GoogleFonts.lora(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w600,
                                color: ColorConstants.neutral800,
                              ),
                            ),
                            Image.asset(ImageConstants.chevronDouble)
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 24.h,
                      ),
                      Container(
                        height: 225,
                        padding: EdgeInsets.only(left: 48.w),
                        child: justForYouList.isNotEmpty
                            ? ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: justForYouList.length,
                                itemBuilder: (context, index) {
                                  // print(justForYouList);
                                  return Container(
                                    margin: const EdgeInsets.only(right: 20),
                                    child: ItemCard(
                                      product: justForYouList[index],
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => ProductDetail(
                                              product: justForYouList[index],
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  );
                                },
                              )
                            : const Center(
                                child: Text("No product found"),
                              ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 35, vertical: 48),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Deals",
                              style: GoogleFonts.lora(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: ColorConstants.neutral800,
                              ),
                            ),
                            TextButton(
                              onPressed: () {},
                              child: Text(
                                "View all",
                                style: GoogleFonts.inter(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: ColorConstants.neutral600,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const Divider(),
                        const SizedBox(
                          height: 10,
                        ),
                        dealsList.isEmpty
                            ? const Center(
                                child: Text("No product found"),
                              )
                            : GridView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: size.width >= 500 ? 4 : 2,
                                  crossAxisSpacing: size.width >= 500 ? 32 : 15,
                                  childAspectRatio: 0.6,
                                ),
                                itemCount: dealsList.length,
                                itemBuilder: (context, index) {
                                  return ItemCard(
                                    product: dealsList[index],
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => ProductDetail(
                                            product: dealsList[index],
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                              ),
                        const SizedBox(height: 30),
                        const Text(
                          "Our Collections",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w300,
                            letterSpacing: 0.31 * 16,
                            color: ColorConstants.baseBlack,
                          ),
                        ),
                        const Divider(),
                        const SizedBox(
                          height: 10,
                        ),
                        ourCollectionsList.isEmpty
                            ? const Center(
                                child: Text("No product found"),
                              )
                            : GridView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount:
                                            size.width >= 500 ? 4 : 2,
                                        mainAxisSpacing: 16,
                                        crossAxisSpacing:
                                            size.width >= 500 ? 32 : 15,
                                        childAspectRatio: 0.6),
                                itemCount: ourCollectionsList.length,
                                itemBuilder: (context, index) {
                                  return CollectionsCard(
                                    product: ourCollectionsList[index],
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => ProductDetail(
                                            product: ourCollectionsList[index],
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                              ),
                        const SizedBox(
                          height: 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "You might like",
                              style: GoogleFonts.lora(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: ColorConstants.neutral800,
                              ),
                            ),
                            TextButton(
                              onPressed: () {},
                              child: Text(
                                "View all",
                                style: GoogleFonts.inter(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: ColorConstants.neutral600,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const Divider(),
                        const SizedBox(
                          height: 10,
                        ),
                        youMightLikeList.isEmpty
                            ? const Center(
                                child: Text("No product found"),
                              )
                            : GridView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: size.width >= 500 ? 4 : 2,
                                  crossAxisSpacing: size.width >= 500 ? 32 : 15,
                                  childAspectRatio: 0.6,
                                ),
                                itemCount: youMightLikeList.length,
                                itemBuilder: (context, index) {
                                  return ItemCard(
                                      product: youMightLikeList[index],
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => ProductDetail(
                                              product: youMightLikeList[index],
                                            ),
                                          ),
                                        );
                                      });
                                },
                              ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
