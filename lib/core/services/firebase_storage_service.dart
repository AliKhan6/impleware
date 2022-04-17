import 'dart:async';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/cupertino.dart';

class FirebaseStorageService {
  Future<String> uploadImage(File image, String folderName) async {
    var fileName = image.path.split("/").last;

    final reference = firebase_storage.FirebaseStorage.instance
        .ref()
        .child('$folderName/$fileName');
    firebase_storage.UploadTask uploadTask = reference.putFile(image);
    // final StreamSubscription<StorageTaskEvent> streamSubscription =
    uploadTask.snapshotEvents.listen((event) {});

    firebase_storage.TaskSnapshot snapshot = await uploadTask.whenComplete(() {
      debugPrint("Image upload Completed");
    });
    final imgUrl = await snapshot.ref.getDownloadURL();
    // streamSubscription.cancel();
    return imgUrl;
  }

  ///
  /// Get list of images urls
  Future<List<String>> uploadImagesList(
      List<File> images, String folderName) async {
    List<String> imagesUrl = [];
    for (int i = 0; i < images.length; i++) {
      var fileName = images[i].path.split("/").last;

      final reference = firebase_storage.FirebaseStorage.instance
          .ref()
          .child('$folderName/$fileName');
      firebase_storage.UploadTask uploadTask = reference.putFile(images[i]);
      // final StreamSubscription<StorageTaskEvent> streamSubscription =
      uploadTask.snapshotEvents.listen((event) {});
      firebase_storage.TaskSnapshot snapshot =
          await uploadTask.whenComplete(() {
        debugPrint("upload image $i completed");
      });
      final imgUrl = await snapshot.ref.getDownloadURL();
      imagesUrl.add(imgUrl);
      debugPrint('imageUrl[$i] =>  ${imagesUrl.length}');

      // streamSubscription.cancel();
    }
    // print(imagesUrl.length);
    return imagesUrl;
  }
}
