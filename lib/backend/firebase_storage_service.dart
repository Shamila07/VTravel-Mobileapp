import 'package:get/get.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseStorageService extends GetxService {
  final Reference firebaseStorage = FirebaseStorage.instance.ref();

  Future<String?> getImage(String? imgName) async {
    if (imgName == null) {
      return null;
    }
    try {
      var urlRef = firebaseStorage.child("destinations").child('${imgName.toLowerCase()}.jpg');
      var imgUrl = await urlRef.getDownloadURL();
      return imgUrl != null ? imgUrl.toString() : null;
    } catch (e) {
      print(e);
      return null;
    }
  }
}
