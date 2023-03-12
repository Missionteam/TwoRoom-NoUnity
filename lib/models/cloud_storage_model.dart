import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io' as io;
import 'package:intl/intl.dart';

Future<void> uploadImages(BuildContext context, String fileName) async {
  final path = await select_icon(context);
  if (path == null) {
    return null;
  }
  return uploadFile(path,
      '${fileName}/${DateFormat('MMddHH:mm:ssSSS').format(Timestamp.now().toDate())}');
}

Future<String?> select_icon(BuildContext context) async {
  const String SELECT_ICON = "アイコンを選択";
  const List<String> SELECT_ICON_OPTIONS = ["写真から選択", "写真を撮影"];
  const int GALLERY = 0;
  const int CAMERA = 1;

  var _select_type = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: Text(SELECT_ICON),
          children: SELECT_ICON_OPTIONS.asMap().entries.map((e) {
            return SimpleDialogOption(
              child: ListTile(
                title: Text(e.value),
              ),
              onPressed: () => Navigator.of(context).pop(e.key),
            );
          }).toList(),
        );
      });

  final picker = ImagePicker();
  var _img_src;

  if (_select_type == null) {
    return null;
  }
  //カメラで撮影
  else if (_select_type == CAMERA) {
    _img_src = ImageSource.camera;
  }
  //ギャラリーから選択
  else if (_select_type == GALLERY) {
    _img_src = ImageSource.gallery;
  }

  final pickedFile = await picker.pickImage(source: _img_src);

  if (pickedFile == null) {
    return null;
  } else {
    return pickedFile.path;
  }
}

Future<void> uploadFile(String sourcePath, String uploadFileName) async {
  final FirebaseStorage storage = FirebaseStorage.instance;
  Reference ref = storage.ref().child("images"); //保存するフォルダ

  io.File file = io.File(sourcePath);
  UploadTask task = ref.child(uploadFileName).putFile(file);

  try {
    var snapshot = await task;
  } catch (FirebaseException) {
    //エラー処理
  }
}

final cloudStorageRefProvider = Provider<Reference>((ref) {
  return FirebaseStorage.instance.ref().child('images');
});

Future<Image?> getImage(String imgPathLocal, String imgPathRemote) async {
  bool existLocal = await io.File(imgPathLocal).exists();

  if (existLocal) {
    return Image.file(File(imgPathLocal));
  } else {
    if ((imgPathRemote != "") && (imgPathRemote != null)) {
      try {
        //ローカルに存在しない場合はリモートのデータをダウンロード
        final imgUrl = await FirebaseStorage.instance
            .ref()
            .child("images")
            .child(imgPathRemote)
            .getDownloadURL();
        return Image.network(imgUrl);
      } catch (FirebaseException) {
        return null;
      }
    } else {
      return null;
    }
  }
}

final imageOfPostProvider =
    FutureProvider.family((ref, String remotePath) async {
  if (remotePath == '') {
    return SizedBox();
  }
  final url = await ref
      .watch(cloudStorageRefProvider)
      .child(remotePath)
      .getDownloadURL();
  return (url != '') ? Image.network(url) : SizedBox();
});


// class ImageOfPost extends ConsumerStatefulWidget {
//   ImageOfPost({super.key, this.imgPathLocal = '', this.imgPathRemote = ''});
//   String imgPathLocal;
//   String imgPathRemote;

//   @override
//   ConsumerState<ConsumerStatefulWidget> createState() => _ImageOfPostState();
// }

// class _ImageOfPostState extends ConsumerState<ImageOfPost> {

//   @override
//   Widget build(BuildContext context) {
//     bool existLocal = await io.File(imgPathLocal).exists();

//     return ();
//   }
// }
