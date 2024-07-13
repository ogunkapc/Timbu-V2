import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:timbu_v2/model/product_provider.dart';
import 'package:timbu_v2/screens/mainscreen/pages/home_screen.dart';
import 'package:timbu_v2/util/constants/color_constants.dart';
import 'package:timbu_v2/util/constants/image_constants.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductProvider>(builder: (context, value, child) {
      final cartList = value.getUserCartItems();
      return cartList.isEmpty
          ? Scaffold(
              backgroundColor: ColorConstants.neutralWhite,
              // appBar: AppBar(
              //   backgroundColor: Colors.transparent,
              //   elevation: 0,
              //   leading: Row(
              //     children: [
              //       const SizedBox(
              //         width: 8,
              //       ),
              //       IconButton(
              //         onPressed: () {
              //           Navigator.pop(context);
              //         },
              //         icon: Image.asset(ImageConstants.backIcon),
              //       ),
              //     ],
              //   ),
              //   actions: [
              //     IconButton(
              //       onPressed: () {},
              //       icon: Image.asset(ImageConstants.cartIcon),
              //     ),
              //   ],
              // ),
              body: SafeArea(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 48, vertical: 32),
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
                          GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const CartScreen(),
                                  ),
                                );
                              },
                              child: Image.asset(ImageConstants.cartIcon)),
                        ],
                      ),
                      const Spacer(),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              Image.asset(ImageConstants.emptyCart),
                              const SizedBox(
                                height: 32,
                              ),
                              Text(
                                "Your Cart is empty",
                                style: GoogleFonts.lora(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18,
                                  color: ColorConstants.baseBlack,
                                ),
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              const Text(
                                "Explore our collections today and start your journey towards radiant beauty. Your skin will thank you",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: ColorConstants.grey600,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(
                                height: 32,
                              ),
                              GestureDetector(
                                onTap: () {},
                                child: Container(
                                  height: 48,
                                  width: 160,
                                  decoration: BoxDecoration(
                                    color: ColorConstants.green,
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "Start Shopping",
                                      style: GoogleFonts.inter(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: ColorConstants.neutralWhite,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 32,
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    "Recently Viewed",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w300,
                                      color: ColorConstants.baseBlack,
                                      letterSpacing: 0.31 * 14,
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {},
                                    child: const Text(
                                      "View all",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: ColorConstants.green,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const Divider(),
                              const SizedBox(
                                height: 48,
                              ),
                              SizedBox(
                                height: 225,
                                child: ListView(
                                    scrollDirection: Axis.horizontal,
                                    children: const [
                                      Item(),
                                    ]),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const Spacer(),
                    ],
                  ),
                ),
              ),
            )
          : const Scaffold(
              body: Column(
                children: [
                  Divider(),
                  SizedBox(
                    height: 32,
                  ),
                ],
              ),
            );
    });
  }
}
