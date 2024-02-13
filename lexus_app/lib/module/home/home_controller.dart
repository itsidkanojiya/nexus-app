import 'package:get/get.dart';
import 'package:lexus_app/models/books_model.dart';
import 'package:lexus_app/repository/book_repository.dart';

class HomeController extends GetxController {
  RxString selected = 'GSEB'.obs;
  BookModel? bookmodel;
  RxBool isLoading = true.obs;
  var selectedBook = Rx<Books?>(null);
  @override
  void onInit() {
    fetchData();
    super.onInit();
  }

  void fetchData() async {
    isLoading(true);
    bookmodel = await BookRepository().getBooks();

    isLoading(false);
  }

  void setSelected(String value) {
    selected.value = value;
  }

  List<String> dropdownValues = [
    'GSEB',
    'NCERT',
    'MSHB',
    // Add more options as needed
  ];
}
