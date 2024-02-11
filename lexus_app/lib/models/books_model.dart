class BookModel {
  int? id;
  String? name;
  int? std;
  String? board;
  int? chapterNo;
  String? chapterName;
  String? pdfLink;
  String? coverLink;
  String? createdAt;
  dynamic updatedAt;
  dynamic deletedAt;
  String? boardName;

  BookModel(
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

  BookModel.fromJson(Map<String, dynamic> json) {
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['std'] = this.std;
    data['board'] = this.board;
    data['chapter_no'] = this.chapterNo;
    data['chapter_name'] = this.chapterName;
    data['pdf_link'] = this.pdfLink;
    data['cover_link'] = this.coverLink;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    data['board_name'] = this.boardName;
    return data;
  }
}