import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:timbu_v2/util/constants/color_constants.dart';
import 'package:timbu_v2/util/widgets/search_box.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.neutralWhite,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              SizedBox(height: 32.h),
              const SearchBox(),
              const Expanded(
                child: Center(
                  child: Icon(
                    Icons.search_outlined,
                    color: ColorConstants.neutral400,
                    size: 40,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
