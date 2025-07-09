class Hadith {
  final int id;
  final String title;
  final String content;
  final String narrator;
  final String category;
  final String grade;
  final bool isFavorite;
  final DateTime dateAdded;

  Hadith({
    required this.id,
    required this.title,
    required this.content,
    required this.narrator,
    required this.category,
    required this.grade,
    this.isFavorite = false,
    required this.dateAdded,
  });

  factory Hadith.fromJson(Map<String, dynamic> json) {
    return Hadith(
      id: json['id'],
      title: json['title'],
      content: json['content'],
      narrator: json['narrator'],
      category: json['category'],
      grade: json['grade'],
      isFavorite: json['isFavorite'] ?? false,
      dateAdded: DateTime.parse(json['dateAdded']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'narrator': narrator,
      'category': category,
      'grade': grade,
      'isFavorite': isFavorite,
      'dateAdded': dateAdded.toIso8601String(),
    };
  }

  Hadith copyWith({
    int? id,
    String? title,
    String? content,
    String? narrator,
    String? category,
    String? grade,
    bool? isFavorite,
    DateTime? dateAdded,
  }) {
    return Hadith(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      narrator: narrator ?? this.narrator,
      category: category ?? this.category,
      grade: grade ?? this.grade,
      isFavorite: isFavorite ?? this.isFavorite,
      dateAdded: dateAdded ?? this.dateAdded,
    );
  }
}
