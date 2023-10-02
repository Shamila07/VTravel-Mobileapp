import 'package:get/get.dart';

import 'firebase_storage_service.dart';

class DestinationController extends  GetxController {
  final allDestinationImages =<String>[].obs;
  @override
  void onReady (){
    getAllDestinations();
    super.onReady();
  }

  Future<void>getAllDestinations() async {
    List<String> imgName = [
      "Kandy",
      "Sigiriya",
      "baddagana",
      "galviharaya",

    ];
    try {
      for (var img in imgName){
       final imgUrl = await Get.find<FirebaseStorageService>().getImage(img);
        allDestinationImages.add(imgUrl!);
      }

    } catch (e) {
      print(e);

    }
  }
}