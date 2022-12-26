import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:insta_clone_app/src/components/image_data.dart';
import 'package:insta_clone_app/src/controller/bottom_nav_controller.dart';
import 'package:insta_clone_app/src/pages/home.dart';

import 'pages/search.dart';

class App extends GetView<BottomNavController> {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: controller.willPopAction,
      child: Obx(
        () => Scaffold(
          body: IndexedStack(
            index: controller.pageIndex.value, // 현재 페이지 확인
            children: [
              const Home(),
              const Search(),
              Container(
                child: const Center(child: Text('Upload')),
              ),
              Container(
                child: const Center(child: Text('Activity')),
              ),
              Container(
                child: const Center(child: Text('MyPage')),
              ),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            currentIndex: controller.pageIndex.value, // items의 몇번째 페이지인지 지정
            elevation: 0,
            onTap: controller.changeBottomNav,
            items: [
              BottomNavigationBarItem(
                icon: ImageData(IconsPath.homeOff),
                activeIcon: ImageData(IconsPath.homeOn),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: ImageData(IconsPath.searchOff),
                activeIcon: ImageData(IconsPath.searchOn),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: ImageData(IconsPath.uploadIcon),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: ImageData(IconsPath.activeOff),
                activeIcon: ImageData(IconsPath.activeOn),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Container(
                  width: 30,
                  height: 30,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey,
                  ),
                ),
                label: 'Home',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
