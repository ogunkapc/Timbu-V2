import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:timbu_v2/screens/mainscreen/pages/home_screen.dart';
import 'package:timbu_v2/screens/mainscreen/pages/profile_screen.dart';
import 'package:timbu_v2/screens/mainscreen/pages/wish_list.dart';
import 'package:timbu_v2/screens/mainscreen/pages/search_screen.dart';
import 'package:timbu_v2/util/constants/color_constants.dart';
import 'package:timbu_v2/util/constants/image_constants.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  bool isConnected = true;

  int _selectedIndex = 0;
  final List _pages = [
    const HomeScreen(),
    const WishlistScreen(),
    const ProfileScreen(),
    const SearchScreen(),
  ];

  // function to update the selected index to enable page changes
  void _updateSelectedBottomNavIndex(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    checkConnectivity();
  }

  Future<void> checkConnectivity() async {
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      if (result == ConnectivityResult.none) {
        setState(() => isConnected = false);
      } else {
        setState(() => isConnected = true);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.neutralWhite,
      body: isConnected
          ? _pages[_selectedIndex]
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Icon(Icons.signal_wifi_off, size: 50),
                  Text(
                    "No Internet Connection",
                    style: TextStyle(fontSize: 24.sp),
                  ),
                ],
              ),
            ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: ColorConstants.neutralWhite,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        selectedItemColor: ColorConstants.neutral900,
        unselectedItemColor: ColorConstants.neutral400,
        unselectedLabelStyle: TextStyle(
          fontSize: 10.sp,
          fontWeight: FontWeight.w500,
        ),
        selectedLabelStyle: TextStyle(
          fontSize: 10.sp,
          fontWeight: FontWeight.w500,
        ),
        currentIndex: _selectedIndex,
        onTap: (index) {
          _updateSelectedBottomNavIndex(index);
        },
        items: [
          BottomNavigationBarItem(
            icon: Image.asset(ImageConstants.homeIcon,
                color: ColorConstants.neutral400),
            activeIcon: Image.asset(
              ImageConstants.homeIcon,
            ),
            label: "Home",
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border_outlined),
            label: "Wishlist",
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              ImageConstants.profileIcon,
              color: ColorConstants.neutral400,
            ),
            activeIcon: Image.asset(ImageConstants.profileIcon),
            label: "Profile",
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              ImageConstants.searchIcon,
              color: ColorConstants.neutral400,
            ),
            activeIcon: Image.asset(ImageConstants.searchIcon),
            label: "Search",
          ),
        ],
      ),
    );
  }
}
