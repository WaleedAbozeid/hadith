import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/hadith.dart';
import '../providers/hadith_provider.dart';
import '../screens/hadith_detail_screen.dart';

class HadithCard extends StatelessWidget {
  final Hadith hadith;

  const HadithCard({
    super.key,
    required this.hadith,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HadithDetailScreen(hadith: hadith),
          ),
        );
      },
      borderRadius: BorderRadius.circular(12),
      splashColor: const Color(0xFF2E7D32).withOpacity(0.1),
      highlightColor: const Color(0xFF2E7D32).withOpacity(0.05),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.white, Color(0xFFF0F8F0)],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header with title and favorite button
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        hadith.title,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Cairo',
                          color: Color(0xFF2E7D32),
                        ),
                      ),
                    ),
                    Consumer<HadithProvider>(
                      builder: (context, provider, child) {
                        return IconButton(
                          icon: Icon(
                            hadith.isFavorite
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: hadith.isFavorite ? Colors.red : Colors.grey,
                          ),
                          onPressed: () {
                            provider.toggleFavorite(hadith.id);
                          },
                        );
                      },
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                // Hadith content
                Text(
                  hadith.content,
                  style: const TextStyle(
                    fontSize: 16,
                    fontFamily: 'Cairo',
                    height: 1.5,
                    color: Colors.black87,
                  ),
                  textAlign: TextAlign.justify,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),

                const SizedBox(height: 16),

                // Footer with narrator and category
                Row(
                  children: [
                    // Narrator
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: const Color(0xFF2E7D32).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        'رواه: ${hadith.narrator}',
                        style: const TextStyle(
                          fontSize: 12,
                          fontFamily: 'Cairo',
                          color: Color(0xFF2E7D32),
                        ),
                      ),
                    ),

                    const SizedBox(width: 8),

                    // Category
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: const Color(0xFF4CAF50).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        hadith.category,
                        style: const TextStyle(
                          fontSize: 12,
                          fontFamily: 'Cairo',
                          color: Color(0xFF4CAF50),
                        ),
                      ),
                    ),

                    const Spacer(),

                    // Grade
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: _getGradeColor(hadith.grade).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        hadith.grade,
                        style: TextStyle(
                          fontSize: 12,
                          fontFamily: 'Cairo',
                          color: _getGradeColor(hadith.grade),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 8),

                // View more indicator
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'عرض التفاصيل',
                      style: TextStyle(
                        fontSize: 12,
                        fontFamily: 'Cairo',
                        color: const Color(0xFF2E7D32).withOpacity(0.7),
                      ),
                    ),
                    const SizedBox(width: 4),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 12,
                      color: const Color(0xFF2E7D32).withOpacity(0.7),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Color _getGradeColor(String grade) {
    switch (grade) {
      case 'صحيح':
        return Colors.green;
      case 'حسن':
        return Colors.orange;
      case 'ضعيف':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}
