class Boards {
  List<Board>? boards;

  Boards({this.boards});

  Boards.fromJson(Map<String, dynamic> json) {
    if (json['boards'] != null) {
      boards = <Board>[];
      json['boards'].forEach((v) {
        boards!.add(Board.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (boards != null) {
      data['boards'] = boards!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Board {
  int? id;
  String? name;
  String? coverLink;
  String? createdAt;
  String? updatedAt;
  dynamic deletedAt;

  Board(
      {this.id,
      this.name,
      this.coverLink,
      this.createdAt,
      this.updatedAt,
      this.deletedAt});

  Board.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    coverLink = json['cover_link'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['cover_link'] = coverLink;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    return data;
  }
}