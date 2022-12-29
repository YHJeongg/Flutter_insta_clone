import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:insta_clone_app/src/components/image_data.dart';
import 'package:insta_clone_app/src/controller/upload_controller.dart';

class UploadDescription extends GetView<UploadController> {
  const UploadDescription({super.key});

  Widget _description() {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        children: [
          SizedBox(
            width: 60,
            height: 60,
            child: Image.file(
              controller.filteredImage!,
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            child: TextField(
              controller: controller.textEditingController,
              maxLines: null,
              decoration: const InputDecoration(
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                contentPadding: EdgeInsets.only(left: 15),
                hintText: '문구 입력...',
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget get line => const Divider(color: Colors.grey);

  Widget infoOne(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 15),
      child: Text(
        title,
        style: const TextStyle(fontSize: 17),
      ),
    );
  }

  Widget snsInfo() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Facebook',
                style: TextStyle(fontSize: 17),
              ),
              Switch(
                value: false,
                onChanged: (bool value) {},
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Twitter',
                style: TextStyle(fontSize: 17),
              ),
              Switch(
                value: false,
                onChanged: (bool value) {},
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Tumblr',
                style: TextStyle(fontSize: 17),
              ),
              Switch(
                value: false,
                onChanged: (bool value) {},
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          leading: GestureDetector(
            onTap: Get.back,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: ImageData(
                IconsPath.backBtnIcon,
                width: 50,
              ),
            ),
          ),
          title: const Text(
            '새 게시물',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          actions: [
            GestureDetector(
              onTap: controller.uploadPost,
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: ImageData(
                  IconsPath.uploadComplete,
                  width: 50,
                ),
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _description(),
              line,
              infoOne('사람 태그하기'),
              line,
              infoOne('위치 추가'),
              line,
              infoOne('다른 미디어에도 게시'),
              snsInfo(),
            ],
          ),
        ),
      ),
    );
  }
}
