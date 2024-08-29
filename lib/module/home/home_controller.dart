import 'package:get/get.dart';
import 'package:nexus_app/models/books_model.dart';
import 'package:nexus_app/models/subject_model.dart';
import 'package:nexus_app/repository/book_repository.dart';
import 'package:nexus_app/services/getStorage_services.dart';

class HomeController extends GetxController {
  RxString selected = 'GSEB'.obs;
  BookModel? bookmodel;
  SubjectModel? subjectmodel;
  RxBool isLoading = false.obs;
  RxBool isBookLoading = false.obs;
  var selectedBook = Rx<Books?>(null);

  GetStorageServices? getStorageServices;

  @override
  void onInit() {
    fetchData();
    super.onInit();
  }

  void fetchData() async {
    getStorageServices = GetStorageServices();
    isLoading(true);

    subjectmodel = await BookRepository().getSubject();

    isLoading(false);
  }

  void getBooks(String subject) async {
    isBookLoading(true);
    bookmodel = await BookRepository().getBooks(subject);
    isBookLoading(false);
  }

  void setSelected(String value) {
    selected.value = value;
  }

  List<String> dropdownValues = [
    'GSEB',
    'NCERT',
    'MSHB',
  ];
}
