import 'package:get/get.dart';
import 'package:nexus_app/models/books_model.dart';
import 'package:nexus_app/services/getStorage_services.dart';

class FavBooksController extends GetxController {
  GetStorageServices? getStorage;
  List<Books> favBookList = [];

  @override
  void onInit() {
    fetchData();
    super.onInit();
  }

  void fetchData() async {
    favBookList = getStorage?.getBookList('fav_books') ?? [];
    print('${favBookList.length}____________________________');
  }
}
