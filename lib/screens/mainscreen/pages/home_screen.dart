import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:timbu_v2/providers/cart_provider.dart';
import 'package:timbu_v2/providers/product_provider.dart';
import 'package:timbu_v2/screens/cart_screen.dart';
import 'package:timbu_v2/screens/order_history.dart';
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
  final TextEditingController searchController = TextEditingController();

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
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final cartProvider = Provider.of<CartProvider>(context);

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
          final searchResults = value.filteredProductsList;
          final searchQuery = value.searchQuery;

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
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const OrderHistoryScreen(),
                                      ),
                                    );
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
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      color: ColorConstants
                                                          .baseWhite,
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
                        SearchBox(
                          controller: searchController,
                          onSearch: (query) {
                            if (query.isNotEmpty) {
                              value.searchProducts(query);
                            } else {
                              value.filteredProductsList = [];
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                  // const SizedBox(height: 48),
                  if (searchResults.isNotEmpty && searchQuery.isNotEmpty)
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 48.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 20.h),
                          Center(
                            child: Text(
                              "Search Results",
                              style: GoogleFonts.lora(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w600,
                                color: ColorConstants.neutral800,
                              ),
                            ),
                          ),
                          SizedBox(height: 10.h),
                          GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: size.width >= 500 ? 4 : 2,
                              crossAxisSpacing: size.width >= 500 ? 32.w : 15.w,
                              childAspectRatio: 0.6,
                            ),
                            itemCount: searchResults.length,
                            itemBuilder: (context, index) {
                              return ItemCard(
                                product: searchResults[index],
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ProductDetail(
                                        product: searchResults[index],
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  if (searchResults.isEmpty) ...[
                    Column(
                      children: [
                        Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 48.w, vertical: 48.h),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                              height: 230.h,
                              padding: EdgeInsets.only(left: 48.w),
                              child: justForYouList.isNotEmpty
                                  ? ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: justForYouList.length,
                                      itemBuilder: (context, index) {
                                        // print(justForYouList);
                                        return Container(
                                          margin:
                                              const EdgeInsets.only(right: 20),
                                          child: ItemCard(
                                            product: justForYouList[index],
                                            onTap: () {
                                              value.addToRecentlyViewedList(
                                                  justForYouList[index]);
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      ProductDetail(
                                                    product:
                                                        justForYouList[index],
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
                          padding: EdgeInsets.symmetric(
                              horizontal: 48.w, vertical: 40.h),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                              SizedBox(
                                height: 10.h,
                              ),
                              dealsList.isEmpty
                                  ? const Center(
                                      child: Text("No product found"),
                                    )
                                  : GridView.builder(
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount:
                                            size.width >= 500 ? 4 : 2,
                                        crossAxisSpacing:
                                            size.width >= 500 ? 32.w : 15.w,
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
                                                builder: (context) =>
                                                    ProductDetail(
                                                  product: dealsList[index],
                                                ),
                                              ),
                                            );
                                          },
                                        );
                                      },
                                    ),
                              SizedBox(height: 30.h),
                              Text(
                                "Our Collections",
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w300,
                                  letterSpacing: (0.31 * 16).sp,
                                  color: ColorConstants.baseBlack,
                                ),
                              ),
                              const Divider(),
                              SizedBox(
                                height: 10.h,
                              ),
                              ourCollectionsList.isEmpty
                                  ? const Center(
                                      child: Text("No product found"),
                                    )
                                  : GridView.builder(
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount:
                                            size.width >= 500 ? 4 : 2,
                                        crossAxisSpacing:
                                            size.width >= 500 ? 32.w : 15.w,
                                        mainAxisSpacing: 10.h,
                                        childAspectRatio: 0.8,
                                      ),
                                      itemCount: ourCollectionsList.length,
                                      itemBuilder: (context, index) {
                                        return CollectionsCard(
                                          product: ourCollectionsList[index],
                                          heroTag: "collection_$index",
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    ProductDetail(
                                                  product:
                                                      ourCollectionsList[index],
                                                ),
                                              ),
                                            );
                                          },
                                        );
                                      },
                                    ),
                              SizedBox(
                                height: 30.h,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount:
                                            size.width >= 500 ? 4 : 2,
                                        crossAxisSpacing:
                                            size.width >= 500 ? 32 : 15,
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
                                                  builder: (context) =>
                                                      ProductDetail(
                                                    product:
                                                        youMightLikeList[index],
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
                  ],
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
