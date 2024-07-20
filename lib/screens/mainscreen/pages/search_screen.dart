import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:timbu_v2/providers/product_provider.dart';
import 'package:timbu_v2/screens/product_detail_screen.dart';
import 'package:timbu_v2/util/constants/color_constants.dart';
import 'package:timbu_v2/util/widgets/item_card.dart';
import 'package:timbu_v2/util/widgets/search_box.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.clear();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    final filteredList = productProvider.filteredProductsList;
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: ColorConstants.neutralWhite,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.0.w),
          child: Column(
            children: [
              SizedBox(height: 32.h),
              SearchBox(
                controller: _searchController,
                onSearch: (query) {
                  if (query.isNotEmpty) {
                    productProvider.filterProductsBySearchQuery(query);
                  } else {
                    productProvider.filteredProductsList = [];
                  }
                },
              ),
              Expanded(
                child: productProvider.getIsLoading()
                    ? const Center(child: CircularProgressIndicator())
                    : filteredList.isEmpty
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.search_outlined,
                                color: ColorConstants.neutral400,
                                size: 40,
                              ),
                              Text(
                                'No products found',
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  color: ColorConstants.neutral600,
                                ),
                              ),
                            ],
                          )
                        : GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: size.width >= 500 ? 4 : 2,
                              crossAxisSpacing: size.width >= 500 ? 32.w : 15.w,
                              childAspectRatio: 0.6,
                            ),
                            itemCount: filteredList.length,
                            itemBuilder: (context, index) {
                              final product = filteredList[index];
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
      ),
    );
  }
}
