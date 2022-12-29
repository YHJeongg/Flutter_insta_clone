import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:insta_clone_app/src/controller/auth_controller.dart';

import '../models/instagram_user.dart';

class SignupPage extends StatefulWidget {
  final String uid;
  const SignupPage({super.key, required this.uid});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  TextEditingController nicknameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  // 사진 선택을 위한 imagepicker
  final ImagePicker _picker = ImagePicker();
  XFile? thumbnailXFile;

  void update() => setState(() {});

  Widget _avatar() {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(100),
          child: SizedBox(
            width: 100,
            height: 100,
            child: thumbnailXFile != null
                ? Image.file(
                    File(thumbnailXFile!.path),
                    fit: BoxFit.cover,
                  )
                : Image.asset(
                    'assets/images/default_image.png',
                    fit: BoxFit.cover,
                  ),
          ),
        ),
        const SizedBox(height: 15),
        ElevatedButton(
          onPressed: () async {
            thumbnailXFile =
                await _picker.pickImage(source: ImageSource.gallery);
            update();
          },
          child: const Text('이미지 변경'),
        ),
      ],
    );
  }

  Widget _nickname() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50.0),
      child: TextField(
        controller: nicknameController,
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.all(10),
          hintText: '닉네임',
        ),
      ),
    );
  }

  Widget _description() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50.0),
      child: TextField(
        controller: descriptionController,
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.all(10),
          hintText: '설명',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: const Text(
          '회원가입',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 30),
            _avatar(),
            const SizedBox(height: 30),
            _nickname(),
            const SizedBox(height: 30),
            _description(),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 50),
        child: ElevatedButton(
          onPressed: () {
            // validation
            var signupUser = IUser(
              uid: widget.uid,
              nickname: nicknameController.text,
              description: descriptionController.text,
            );
            AuthController.to.signup(signupUser, thumbnailXFile);
          },
          child: const Text('회원가입'),
        ),
      ),
    );
  }
}
