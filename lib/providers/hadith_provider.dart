import 'package:flutter/material.dart';

import '../models/hadith.dart' as local;
import '../services/dorar_api_service.dart';

class HadithProvider extends ChangeNotifier {
  List<local.Hadith> _hadiths = [];
  final List<local.Hadith> _favorites = [];
  String _searchQuery = '';
  String _selectedCategory = 'الكل';
  bool _isLoading = false;
  String? _error;

  List<local.Hadith> get hadiths => _hadiths;
  List<local.Hadith> get favorites => _favorites;
  String get searchQuery => _searchQuery;
  String get selectedCategory => _selectedCategory;
  bool get isLoading => _isLoading;
  String? get error => _error;

  List<local.Hadith> get filteredHadiths {
    if (_searchQuery.isNotEmpty) {
      return _hadiths;
    }
    List<local.Hadith> filtered = _hadiths;
    if (_selectedCategory != 'الكل') {
      filtered = filtered
          .where((hadith) => hadith.category == _selectedCategory)
          .toList();
    }
    return filtered;
  }

  List<String> get categories {
    Set<String> categories =
        _hadiths.map((hadith) => hadith.category ?? '').toSet();
    categories.removeWhere((c) => c.isEmpty);
    categories.add('الكل');
    return categories.toList()..sort();
  }

  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
    fetchHadithsFromApi(query);
  }

  void setSelectedCategory(String category) {
    _selectedCategory = category;
    notifyListeners();
  }

  void toggleFavorite(int hadithId) {
    final index = _hadiths.indexWhere((hadith) => hadith.id == hadithId);
    if (index != -1) {
      _hadiths[index] =
          _hadiths[index].copyWith(isFavorite: !_hadiths[index].isFavorite);
      if (_hadiths[index].isFavorite) {
        _favorites.add(_hadiths[index]);
      } else {
        _favorites.removeWhere((hadith) => hadith.id == hadithId);
      }
      notifyListeners();
    }
  }

  Future<void> fetchHadithsFromApi(String query) async {
    if (query.trim().isEmpty) return;
    _isLoading = true;
    _error = null;
    notifyListeners();
    try {
      final results = await DorarApiService.searchHadiths(query: query);
      _hadiths = results.map((d) => d.toHadith() as local.Hadith).toList();
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _error = e.toString();
      notifyListeners();
    }
  }

  // عند أول تشغيل، جلب أحاديث افتراضية
  Future<void> loadInitialHadiths() async {
    await fetchHadithsFromApi('الإخلاص');
  }
}
