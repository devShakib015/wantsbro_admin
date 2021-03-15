import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:toast/toast.dart';
import 'dart:io';

import 'package:wantsbro_admin/constants.dart';

class StorageProvider extends ChangeNotifier {
  Future<String> uploadSingleImage(
      {String imageName, String folderName}) async {
    final _imagePicker = ImagePicker();

    PickedFile image = await _imagePicker.getImage(source: ImageSource.gallery);
    var file = File(image.path);

    if (file != null) {
      var snapshot = await firebaseStorage
          .ref()
          .child('$folderName/$imageName')
          .putFile(file);

      var downLoadUrl = await snapshot.ref.getDownloadURL();
      return downLoadUrl;
    }
    return null;
  }

  Future<String> saveImage(Asset asset, String folderName) async {
    ByteData byteData = await asset.getByteData();
    List<int> imageData = byteData.buffer.asUint8List();

    var uploadTask = await firebaseStorage
        .ref()
        .child('$folderName/${DateTime.now().millisecondsSinceEpoch}')
        .putData(imageData);

    return await uploadTask.ref.getDownloadURL();
  }

  Future<List<String>> uploadMultipleImages(BuildContext context,
      {String foldName, int maxNumberOfImages, String actionBarTitle}) async {
    List<Asset> images = [];
    List<Asset> resultList = [];
    List<String> urlList = [];

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: maxNumberOfImages,
        selectedAssets: images,
        materialOptions: MaterialOptions(
          actionBarColor: "#94030C",
          actionBarTitle: actionBarTitle,
          allViewTitle: "All Photos",
          useDetailsView: false,
          selectCircleStrokeColor: "#000000",
        ),
      );

      for (var i in resultList) {
        var url = await saveImage(i, foldName);
        urlList.add(url);
      }
      Toast.show("Images successfully uploaded", context,
          duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
      return urlList;
    } on Exception catch (e) {
      Toast.show("You didn't select any product.", context,
          duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
      return null;
    }
  }
}
