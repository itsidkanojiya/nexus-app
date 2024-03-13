import 'package:lexus_app/models/books_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesManager {
  static SharedPreferencesManager? _instance;
  late SharedPreferences _prefs;

  SharedPreferencesManager._internal();

  static Future<SharedPreferencesManager> getInstance() async {
    if (_instance == null) {
      _instance = SharedPreferencesManager._internal();
      await _instance!._init();
    }
    return _instance!;
  }

  Future<void> _init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // Get a preference value
  dynamic getValue(String key) {
    return _prefs.get(key);
  }

  // Set a preference value
  Future<void> setValue(String key, dynamic value) async {
    if (value is bool) {
      await _prefs.setBool(key, value);
    } else if (value is int) {
      await _prefs.setInt(key, value);
    } else if (value is double) {
      await _prefs.setDouble(key, value);
    } else if (value is String) {
      await _prefs.setString(key, value);
    } else if (value is List<String>) {
      await _prefs.setStringList(key, value);
    } else {
      throw Exception('Unsupported value type');
    }
  }

   Future<void> setBook(String key, Books book) async {
    Map<String, dynamic> bookMap = book.toMap();
    String bookString = bookMap.toString();
    await _prefs.setString(key, bookString);
  }

  List<Books> getBookList(String key) {
    List<String>? bookStrings = _prefs.getStringList(key);
    if (bookStrings == null) {
      return [];
    }
    return bookStrings.map((string) {
      Map<String, dynamic> map = { for (var item in string.substring(1, string.length - 1).split(', ')) item.split(': ')[0] : item.split(': ')[1] };
      return Books.fromMap(map);
    }).toList();
  }

  // Delete a preference
  Future<void> deleteValue(String key) async {
    await _prefs.remove(key);
  }
}