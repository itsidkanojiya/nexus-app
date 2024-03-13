import 'package:get/get.dart';
import 'package:lexus_app/models/books_model.dart';
import 'package:lexus_app/services/pref_services.dart';

class FavBooksController extends GetxController{
  SharedPreferencesManager? prefsManager;
  List<Books> favBookList = [];

 @override
  void onInit() {
    fetchData();
    super.onInit();
  }

  void fetchData() async {
    prefsManager = await SharedPreferencesManager.getInstance();
favBookList = prefsManager?.getBookList('fav_books') ?? [];

  }
}