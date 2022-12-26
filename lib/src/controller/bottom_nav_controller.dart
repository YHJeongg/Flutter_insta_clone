import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../components/message_popup.dart';
import '../pages/upload.dart';

// 선택된 페이지를 보기 쉽게 문자로 만듬
enum PageName { HOME, SEARCH, UPLOAD, ACTIVITY, MYPAGE }

class BottomNavController extends GetxController {
  // 현재 페이지 기본 0번
  RxInt pageIndex = 0.obs;

  List<int> bottomHistory = [0];

  // page 관리
  void changeBottomNav(int value, {bool hasGesture = true}) {
    var page = PageName.values[value];

    // bottom_nav에서 선택된 페이지로 이동
    switch (page) {
      case PageName.UPLOAD:
        Get.to(() => const Upload());
        break;
      case PageName.HOME:
      case PageName.SEARCH:
      case PageName.ACTIVITY:
      case PageName.MYPAGE:
        _changePage(value, hasGesture: hasGesture);
        break;
    }
  }

  void _changePage(int value, {bool hasGesture = true}) {
    // bottom_nav에서 클릭한 페이지로 번호 지정
    pageIndex(value);

    if (!hasGesture) return;
    if (bottomHistory.last != value) {
      bottomHistory.add(value);
    }
  }

  Future<bool> willPopAction() async {
    // 최초 상태, 기본이 1개있기 때문에 쌓여있는게 없는 상태
    if (bottomHistory.length == 1) {
      // 마지막 뒤로가기 클릭 시 앱종료 팝업
      showDialog(
        context: Get.context!,
        builder: (context) => MessagePopup(
          title: '시스템',
          message: '종료하시겠습니까?',
          okCallback: () {
            exit(0);
          },
          cancelCallback: Get.back,
        ),
      );
      return true;
    } else {
      // 뒤로가기 클릭시 List에 쌓여있는 value 하나씩 제거
      bottomHistory.removeLast();

      var index = bottomHistory.last;
      changeBottomNav(index);

      return false;
    }
  }
}