import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/dorar_hadith.dart';

class DorarApiService {
  static const String baseUrl = 'https://api.dorar.net/v2/hadith/search';

  /// البحث عن أحاديث في درر السنية
  static Future<List<DorarHadith>> searchHadiths({
    required String query,
    int page = 1,
    int limit = 20,
    String? rawi,
    String? grade,
    String? book,
  }) async {
    final params = {
      'q': query,
      'page': page.toString(),
      if (rawi != null && rawi.isNotEmpty) 'rawi': rawi,
      if (grade != null && grade.isNotEmpty) 'grade': grade,
      if (book != null && book.isNotEmpty) 'book': book,
    };
    final uri = Uri.parse(baseUrl).replace(queryParameters: params);
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List<dynamic> results = data['ahadith'] ?? [];
      return results
          .map((json) => DorarHadith(
                id: json['id'] ?? 0,
                title: json['title'] ?? '',
                content: json['hadith'] ?? '',
                narrator: json['rawi'] ?? '',
                book: json['book'] ?? '',
                chapter: json['section'] ?? '',
                grade: json['grade'] ?? '',
                explanation: json['explanation'] ?? '',
                keywords: [],
                dateAdded: null,
              ))
          .toList();
    } else {
      throw Exception('فشل في جلب الأحاديث من درر السنية');
    }
  }
}
