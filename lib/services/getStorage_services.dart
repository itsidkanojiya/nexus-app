import 'package:get_storage/get_storage.dart';
import 'package:nexus_app/models/books_model.dart';

class GetStorageServices {
  final GetStorage _getStorage = GetStorage();

  Future<void> setBook(String key, Books book) async {
    List<Books> books = getBookList(key);
    books.add(book);
    await _getStorage.write(key, books.map((e) => e.toJson()).toList());
    print(book.chapterName.toString());
    Map<String, dynamic> bookMap = book.toMap();
    String bookString = bookMap.toString();
    // List<Books>? books = _getStorage.read(key);
    // books?.add(book);
    await _getStorage.write(key, bookString);
    print(bookString);
  }

  List<Books> getBookList(String key) {
    List<dynamic>? booksJson = _getStorage.read<List<dynamic>>(key);
    if (booksJson == null) return [];
    return booksJson.map((json) => Books.fromJson(json)).toList();
  }

  Future<void> removeBook(String key, String bookId) async {
    List<Books> bookList = getBookList(key);
    bookList.removeWhere((book) => book.id == bookId);
    await _getStorage.write(key, bookList.map((e) => e.toJson()).toList());
  }

  Future<void> remove(String key) => _getStorage.remove(key);
}
