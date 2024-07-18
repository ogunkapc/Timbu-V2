import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:timbu_v2/util/constants/color_constants.dart';
import 'package:timbu_v2/util/constants/image_constants.dart';

class SearchBox extends StatelessWidget {
  const SearchBox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48.h,
      child: TextField(
        decoration: InputDecoration(
          hintText: "Search",
          hintStyle: GoogleFonts.inter(
            color: ColorConstants.neutral400,
            fontSize: 16.sp,
          ),
          prefixIcon: Image.asset(
            ImageConstants.searchIcon,
            color: ColorConstants.neutral400,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.r)),
            borderSide: const BorderSide(
              color: ColorConstants.neutral300,
            ),
          ),
        ),
      ),
    );
  }
}
