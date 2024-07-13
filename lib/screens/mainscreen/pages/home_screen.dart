import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:timbu_v2/screens/mainscreen/pages/cart_screen.dart';
import 'package:timbu_v2/util/constants/color_constants.dart';
import 'package:timbu_v2/util/constants/image_constants.dart';

import '../../../util/widgets/search_box.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: ColorConstants.neutralWhite,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 35, vertical: 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Sharrie's Signature",
                          style: GoogleFonts.redressed(
                            fontSize: 24,
                            fontWeight: FontWeight.w400,
                            color: ColorConstants.green,
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
                            child: Image.asset(ImageConstants.cartIcon)),
                      ],
                    ),
                    const SizedBox(height: 43),
                    const Text(
                      "Welcome, Jane",
                      style: TextStyle(
                        fontSize: 16,
                        color: ColorConstants.baseBlack,
                      ),
                    ),
                    const SizedBox(height: 16),
                    const SearchBox(),
                    const SizedBox(height: 48),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Just for you",
                          style: GoogleFonts.lora(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: ColorConstants.neutral800,
                          ),
                        ),
                        Image.asset(ImageConstants.chevronDouble)
                      ],
                    )
                  ],
                ),
              ),
              Container(
                height: 225,
                padding: const EdgeInsets.only(left: 35),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    return const Item();
                  },
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 35, vertical: 48),
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
                      height: 47,
                    ),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: size.width >= 500 ? 4 : 2,
                        crossAxisSpacing: size.width >= 500 ? 32 : 15,
                        childAspectRatio: 0.7,
                      ),
                      itemCount: 6,
                      itemBuilder: (context, index) {
                        return const Item();
                      },
                    ),
                    const SizedBox(height: 48),
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
                      height: 20,
                    ),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: size.width >= 500 ? 4 : 2,
                        mainAxisSpacing: 16,
                        crossAxisSpacing: size.width >= 500 ? 32 : 15,
                      ),
                      itemCount: 4,
                      itemBuilder: (context, index) {
                        return CollectionsCard(
                          image: ImageConstants.cleanseAndPrep,
                          title: "Cleanse & Prep",
                        );
                      },
                    ),
                    const SizedBox(
                      height: 45,
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
                      height: 47,
                    ),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: size.width >= 500 ? 4 : 2,
                        crossAxisSpacing: size.width >= 500 ? 32 : 15,
                        childAspectRatio: 0.7,
                      ),
                      itemCount: 6,
                      itemBuilder: (context, index) {
                        return const Item();
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}

class CollectionsCard extends StatelessWidget {
  final String image, title;
  const CollectionsCard({
    super.key,
    required this.image,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 176,
      width: 160,
      child: Column(
        children: [
          Container(
            height: 142,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  image,
                ),
              ),
            ),
          ),
          Text(title),
        ],
      ),
    );
  }
}

class Item extends StatelessWidget {
  const Item({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      height: 210,
      margin: const EdgeInsets.only(right: 15),
      child: Column(
        children: [
          Container(
            height: 160,
            width: 160,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(ImageConstants.repairScrub),
              ),
              borderRadius: BorderRadius.circular(5.45),
            ),
          ),
          const SizedBox(
            height: 14,
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Repair Scrub",
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                      color: ColorConstants.neutral600,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "\$20",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: ColorConstants.neutral800,
                    ),
                  ),
                ],
              ),
              AddToCartButton()
            ],
          ),
        ],
      ),
    );
  }
}

class AddToCartButton extends StatelessWidget {
  const AddToCartButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 24,
      width: 60,
      decoration: BoxDecoration(
        border: Border.all(color: ColorConstants.green, width: 0.79),
        borderRadius: BorderRadius.circular(2.37),
      ),
      child: const Center(
        child: Text(
          "Add to Cart",
          style: TextStyle(
            fontSize: 9,
            color: ColorConstants.green,
          ),
        ),
      ),
    );
  }
}
