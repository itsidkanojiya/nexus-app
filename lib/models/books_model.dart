class BookModel {
  List<Books>? books;

  BookModel({this.books});

  BookModel.fromJson(Map<String, dynamic> json) {
    if (json['books'] != null) {
      books = <Books>[];
      json['books'].forEach((v) {
        books!.add(Books.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (books != null) {
      data['books'] = books!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Books {
  int? id;
  String? name;
  int? std;
  String? board;
  int? chapterNo;
  String? chapterName;
  String? pdfLink;
  String? coverLink;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  String? boardName;

  Books(
      {this.id,
      this.name,
      this.std,
      this.board,
      this.chapterNo,
      this.chapterName,
      this.pdfLink,
      this.coverLink,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.boardName});

  Books.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    std = json['std'];
    board = json['board'];
    chapterNo = json['chapter_no'];
    chapterName = json['chapter_name'];
    pdfLink = json['pdf_link'];
    coverLink = json['cover_link'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    boardName = json['board_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['std'] = std;
    data['board'] = board;
    data['chapter_no'] = chapterNo;
    data['chapter_name'] = chapterName;
    data['pdf_link'] = pdfLink;
    data['cover_link'] = coverLink;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    data['board_name'] = boardName;
    return data;
  }

    factory Books.fromMap(Map<String, dynamic> map) {
    return Books(
      id: map['id'],
      name: map['name'],
      std: map['std'],
      board: map['board'],
      chapterNo: map['chapter_no'],
      chapterName: map['chapter_name'],
      pdfLink: map['pdf_link'],
      coverLink: map['cover_link'],
      createdAt: map['created_at'],
      updatedAt: map['updated_at'],
      deletedAt: map['deleted_at'],
      boardName: map['board_name'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'std': std,
      'board': board,
      'chapter_no': chapterNo,
      'chapter_name': chapterName,
      'pdf_link': pdfLink,
      'cover_link': coverLink,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'deleted_at': deletedAt,
      'board_name': boardName,
    };
  }
}
