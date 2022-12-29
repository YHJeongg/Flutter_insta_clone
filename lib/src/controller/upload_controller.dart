import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:image_picker/image_picker.dart';
import 'package:insta_clone_app/src/utils/data_util.dart';
import 'package:path/path.dart';
import 'package:image/image.dart' as imageLib;
import 'package:photo_manager/photo_manager.dart';
import 'package:photofilters/photofilters.dart';

import '../models/post.dart';
import '../pages/upload/upload_description.dart';
import 'auth_controller.dart';

class UploadController extends GetxController {
  var albums = <AssetPathEntity>[];
  RxString headerTitle = ''.obs;
  RxList<AssetEntity> imageList = <AssetEntity>[].obs;
  TextEditingController textEditingController = TextEditingController();
  Rx<AssetEntity> seletedImage = const AssetEntity(
    id: '0',
    typeInt: 0,
    width: 0,
    height: 0,
  ).obs;
  File? filteredImage;
  Post? post;

  @override
  void onInit() {
    super.onInit();
    // post = Post.init();
    _loadPhotos();
  }

  void _loadPhotos() async {
    var result = await PhotoManager.requestPermissionExtend();
    if (result.isAuth) {
      // 권한이 있을경우 실행
      albums = await PhotoManager.getAssetPathList(
        type: RequestType.image,
        filterOption: FilterOptionGroup(
          imageOption: const FilterOption(
            sizeConstraint: SizeConstraint(minHeight: 100, minWidth: 100),
          ),
          orders: [
            // 최신 사진순으로 정렬
            const OrderOption(type: OrderOptionType.createDate, asc: false),
          ],
        ),
      );
      _loadData();
    } else {
      // 권한이 없을경우 권한 요청

    }
  }

  void _loadData() async {
    changeAlbums(albums.first);
    // update();
  }

  // 앨범의 image 불러오기
  Future<void> _pagingPhotos(AssetPathEntity album) async {
    imageList.clear();
    var photos = await album.getAssetListPaged(page: 0, size: 30);
    imageList.addAll(photos);
    changeSelectedImage(imageList.first); // 첫번째 이미지가 기본 이미지
  }

  changeSelectedImage(AssetEntity image) {
    seletedImage(image);
  }

  void changeAlbums(AssetPathEntity album) async {
    headerTitle(album.name);
    await _pagingPhotos(album);
  }

  void gotoImageFilter() async {
    var file = await seletedImage.value.file;
    var fileName = basename(file!.path);
    var image = imageLib.decodeImage(await file.readAsBytes());
    image = imageLib.copyResize(image!, width: 1000);
    Map imagefile = await Navigator.push(
      Get.context!,
      MaterialPageRoute(
        builder: (context) => PhotoFilterSelector(
          title: const Text("Photo Filter Example"),
          image: image!,
          filters: presetFiltersList,
          filename: fileName,
          loader: const Center(child: CircularProgressIndicator()),
          fit: BoxFit.contain,
        ),
      ),
    );
    if (imagefile != null && imagefile.containsKey('image_filtered')) {
      filteredImage = imagefile['image_filtered'];
      Get.to(() => const UploadDescription());
    }
  }

  void unfocusKeyboard() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  void uploadPost() {
    unfocusKeyboard();
    String filename = DataUtil.makeFilePath();
    var task = uploadFile(
        filteredImage!, '/${AuthController.to.user.value.uid}/$filename');
    if (task != null) {
      task.snapshotEvents.listen(
        (event) {
          if (event.bytesTransferred == event.totalBytes &&
              event.state == TaskState.success) {
            var downloadUrl = event.ref.getDownloadURL();
          }
        },
      );
    }
  }

  UploadTask uploadFile(File file, String filename) {
    var ref = FirebaseStorage.instance.ref().child('instagram').child(filename);
    final metadata = SettableMetadata(
      contentType: 'image/jpeg',
      customMetadata: {'picked-file-path': file.path},
    );
    return ref.putFile(file, metadata);
  }
}
