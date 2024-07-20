import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:timbu_v2/util/constants/color_constants.dart';
import 'package:timbu_v2/util/constants/image_constants.dart';

class SearchBox extends StatefulWidget {
  final Function(String) onSearch;
  final TextEditingController controller;
  const SearchBox({
    super.key,
    required this.onSearch,
    required this.controller,
  });

  @override
  State<SearchBox> createState() => _SearchBoxState();
}

class _SearchBoxState extends State<SearchBox> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48.h,
      child: TextField(
        controller: widget.controller,
        onChanged: (query) {
          widget.onSearch(query);
        },
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
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.r)),
            borderSide: const BorderSide(
              color: ColorConstants.neutral300,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.r)),
            borderSide: const BorderSide(
              color: ColorConstants.neutral300,
            ),
          ),
          focusedBorder: OutlineInputBorder(
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
