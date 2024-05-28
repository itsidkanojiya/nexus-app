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
    // prefsManager = await SharedPreferencesManager.getInstance();
    getStorageServices = GetStorageServices();
    isLoading(true);
    print(isLoading.toString());

    subjectmodel = await BookRepository().getSubject();

    isLoading(false);

    print(isLoading.toString());
  }

  void getBooks(String subjet) async {
    isBookLoading(true);
    bookmodel = await BookRepository().getBooks(subjet);
    isBookLoading(false);

    print(isLoading.toString());
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
