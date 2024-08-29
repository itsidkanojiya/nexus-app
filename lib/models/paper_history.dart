class HistoryModel {
  List<History>? history;

  HistoryModel({this.history});

  HistoryModel.fromJson(Map<String, dynamic> json) {
    if (json['history'] != null) {
      history = <History>[];
      json['history'].forEach((v) {
        history!.add(History.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (history != null) {
      data['history'] = history!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class History {
  int? id;
  int? uid;
  String? type;
  String? schoolName;
  int? std;
  String? timing;
  String? date;
  String? division;
  String? day;
  String? address;
  String? board;
  String? subject;
  String? logo;
  Questions? questions;

  History({
    this.id,
    this.uid,
    this.type,
    this.schoolName,
    this.std,
    this.timing,
    this.date,
    this.division,
    this.day,
    this.address,
    this.board,
    this.subject,
    this.logo,
    this.questions,
  });

  History.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uid = json['uid'];
    type = json['type'];
    schoolName = json['school_name'];
    std = json['std'];
    timing = json['timing'];
    date = json['date'];
    division = json['division'];
    day = json['day'];
    address = json['address'];
    board = json['board'];
    subject = json['subject'];
    logo = json['logo'];
    questions = json['questions'] != null
        ? Questions.fromJson(json['questions'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['uid'] = uid;
    data['type'] = type;
    data['school_name'] = schoolName;
    data['std'] = std;
    data['timing'] = timing;
    data['date'] = date;
    data['division'] = division;
    data['day'] = day;
    data['address'] = address;
    data['board'] = board;
    data['subject'] = subject;
    data['logo'] = logo;
    if (questions != null) {
      data['questions'] = questions!.toJson();
    }
    return data;
  }
}

class Questions {
  Mcq? mcq;
  Long? short;
  Long? long;
  Long? onetwo;
  Long? blanks;
  Long? true_false;

  Questions(
      {this.mcq,
      this.short,
      this.long,
      this.onetwo,
      this.blanks,
      this.true_false});

  Questions.fromJson(Map<String, dynamic> json) {
    mcq = json['mcq'] != null ? Mcq.fromJson(json['mcq']) : null;
    short = json['short'] != null ? Long.fromJson(json['short']) : null;
    long = json['long'] != null ? Long.fromJson(json['long']) : null;
    onetwo = json['onetwo'] != null ? Long.fromJson(json['onetwo']) : null;
    blanks = json['blanks'] != null ? Long.fromJson(json['blanks']) : null;
    true_false =
        json['true_false'] != null ? Long.fromJson(json['true_false']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (mcq != null) {
      data['mcq'] = mcq!.toJson();
    }
    if (short != null) {
      data['short'] = short!.toJson();
    }
    if (long != null) {
      data['long'] = long!.toJson();
    }
    if (onetwo != null) {
      data['onetwo'] = onetwo!.toJson();
    }
    if (blanks != null) {
      data['blanks'] = blanks!.toJson();
    }
    if (true_false != null) {
      data['true_false'] = true_false!.toJson();
    }
    return data;
  }
}

class Mcq {
  List<McqQuestion>? questions;
  int? marks;

  Mcq({this.questions, this.marks});

  Mcq.fromJson(Map<String, dynamic> json) {
    if (json['questions'] != null) {
      questions = <McqQuestion>[];
      json['questions'].forEach((v) {
        questions!.add(McqQuestion.fromJson(v));
      });
    }
    marks = json['marks'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (questions != null) {
      data['questions'] = questions!.map((v) => v.toJson()).toList();
    }
    data['marks'] = marks;
    return data;
  }
}

class McqQuestion {
  int? id;
  String? board;
  int? subject;
  int? std;
  String? question;
  String? answer;
  String? solution;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  String? type;
  List<String>? options;

  McqQuestion({
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

  McqQuestion.fromJson(Map<String, dynamic> json) {
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

class Long {
  List<McqQuestion>? questions;
  int? marks;

  Long({this.questions, this.marks});

  Long.fromJson(Map<String, dynamic> json) {
    if (json['questions'] != null) {
      questions = <McqQuestion>[];
      json['questions'].forEach((v) {
        questions!.add(McqQuestion.fromJson(v));
      });
    }
    marks = json['marks'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (questions != null) {
      data['questions'] = questions!.map((v) => v.toJson()).toList();
    }
    data['marks'] = marks;
    return data;
  }
}
