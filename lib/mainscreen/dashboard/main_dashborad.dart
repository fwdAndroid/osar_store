import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:osar_store/widgets/global_variables.dart';

class MainDashboard extends StatefulWidget {
  const MainDashboard({Key? key}) : super(key: key);

  @override
  State<MainDashboard> createState() => _MainDashboardState();
}

class _MainDashboardState extends State<MainDashboard> {
  int _currentIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() => _currentIndex = index);
            },
            children: homeScreenItems),
      ),
      bottomNavigationBar: BottomNavyBar(
        itemCornerRadius: 10,
        selectedIndex: _currentIndex,
        onItemSelected: (index) {
          setState(() => _currentIndex = index);
          _pageController.jumpToPage(index);
        },
        items: <BottomNavyBarItem>[
          BottomNavyBarItem(
              title: Text(
                'Home',
                style: TextStyle(color: Colors.black),
              ),
              icon: Icon(
                Icons.home,
                color: Color(0xffFFBF00),
              )),
          BottomNavyBarItem(
              title: Text(
                'Order',
                style: TextStyle(color: Colors.black),
              ),
              icon: Icon(
                Icons.apps,
                color: Color(0xffFFBF00),
              )),
          BottomNavyBarItem(
              title: Text(
                'Chat',
                style: TextStyle(color: Colors.black),
              ),
              icon: Icon(
                Icons.message_sharp,
                color: Color(0xffFFBF00),
              )),
          BottomNavyBarItem(
              title: Text(
                'Profile',
                style: TextStyle(color: Colors.black),
              ),
              icon: Icon(
                Icons.person,
                color: Color(0xffFFBF00),
              )),
        ],
      ),
    );
  }
}
    // return Scaffold(
  
    //   bottomNavigationBar: BottomNavyBar(
    //     onTap: navigationTapped,
    //     items: [
    //       // backgroundColor: primaryColor,

    //       BottomNavyBarItem(
    //         icon: Image.asset(
    //           _page == 0 ? 'asset/homered.png' : "asset/home.png",
    //           width: 50,
    //           height: 30,
    //         ),
    //       ),
    //       BottomNavyBarItem(
    //         icon: Image.asset(
    //           _page == 1 ? 'asset/gridred.png' : "asset/grid.png",
    //           width: 50,
    //           height: 30,
    //         ),
    //       ),
    //       BottomNavyBarItem(
    //         icon: Image.asset(
    //           _page == 2 ? 'asset/chatred.png' : "asset/chat.png",
    //           width: 50,
    //           height: 30,
    //         ),
    //       ),
    //       BottomNavyBarItem(
    //         icon: Image.asset(
    //           _page == 3 ? 'asset/profile.png' : "asset/profile.png",
    //           width: 50,
    //           height: 30,
    //         ),
    //       ),
    //     ],
    //   ),
    // );
 