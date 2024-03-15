import 'package:get_storage/get_storage.dart';
import 'package:nexus_app/models/books_model.dart';

class GetStorageServices {

  final GetStorage _getStorage = GetStorage();

  Future<void> setBook(String key, Books book) async {
    // Map<String, dynamic> bookMap = book.toMap();
    // String bookString = bookMap.toString();
    List<Books>? books = _getStorage.read(key);
    books?.add(book);
    await _getStorage.write(key, books);
    print(book.chapterName.toString());
  }

  List<Books> getBookList(String key) {
    List<Books>? books = _getStorage.read(key);
    return books ?? [];
    // if (bookStrings == null) {
    //   return [];
    // }
    // return bookStrings.map((string) {
    //   Map<String, dynamic> map = {
    //     for (var item in string.substring(1, string.length - 1).split(', '))
    //       item.split(': ')[0]: item.split(': ')[1]
    //   };
    //   return Books.fromMap(map);
    // }).toList();
  }

  Future<void> removeBook(String key, String bookId) async {
    List<Books> bookList = getBookList(key);

    for (Books e in bookList) {
      if (e.id == bookId) {
        _getStorage.remove(key);
      }
    }
  }

  Future<void> remove(String key) => _getStorage.remove(key);
}
