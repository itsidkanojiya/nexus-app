class QuestionModel {
  int? id;
  String? board;
  String? subject;
  int? std;
  String? question;
  String? answer;
  String? solution;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  String? type;
  List<String>? options;

  QuestionModel({
    this.id,
    this.board,
    this.subject,
    this.std,
    this.question,
    this.answer,
    this.solution,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.type,
    this.options,
  });

  QuestionModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    board = json['board'];
    subject = json['subject'];
    std = json['std'];
    question = json['question'];
    answer = json['answer'];
    solution = json['solution'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    type = json['type'];
    options =
        json['options'] != null ? List<String>.from(json['options']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['board'] = board;
    data['subject'] = subject;
    data['std'] = std;
    data['question'] = question;
    data['answer'] = answer;
    data['solution'] = solution;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    data['type'] = type;
    data['options'] = options;
    return data;
  }
}
