import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timbu/model/product_provider.dart';
import 'package:timbu/screens/product_detail_screen.dart';
import 'package:timbu/util/constants/color_constants.dart';
import 'package:timbu/util/widgets/item_card.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
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
      backgroundColor: ColorConstants.whiteColor,
      body: Consumer<ProductProvider>(builder: (context, value, child) {
        final productList = value.getProductsList();
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
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              children: [
                Expanded(
                  child: productList.isNotEmpty
                      ? GridView.builder(
                          itemCount: productList.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: size.width >= 500 ? 4 : 2,
                            childAspectRatio: size.width >= 500 ? 0.54 : 0.54,
                            mainAxisSpacing: 20,
                            crossAxisSpacing: 20,
                          ),
                          itemBuilder: (context, index) {
                            return ItemCard(
                              product: productList[index],
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ProductDetail(
                                      product: productList[index],
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        )
                      : const Center(
                          child: Text('No products found'),
                        ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
