import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../models/hadith.dart';

class HadithDetailScreen extends StatelessWidget {
  final Hadith hadith;

  const HadithDetailScreen({
    super.key,
    required this.hadith,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        title: Text(
          hadith.title,
          style: const TextStyle(
            fontFamily: 'Cairo',
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(0xFF2E7D32),
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.share, color: Colors.white),
            onPressed: () {
              // Share functionality
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hadith Content Card
            Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Colors.white, Color(0xFFF0F8F0)],
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title
                      Text(
                        hadith.title,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Cairo',
                          color: Color(0xFF2E7D32),
                        ),
                        textAlign: TextAlign.center,
                      ),

                      const SizedBox(height: 24),

                      // Hadith Text
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: const Color(0xFF2E7D32).withOpacity(0.2),
                            width: 2,
                          ),
                        ),
                        child: Text(
                          hadith.content,
                          style: const TextStyle(
                            fontSize: 18,
                            fontFamily: 'Cairo',
                            height: 1.8,
                            color: Colors.black87,
                          ),
                          textAlign: TextAlign.justify,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Details Section
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'تفاصيل الحديث',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Cairo',
                        color: Color(0xFF2E7D32),
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Grade
                    _buildDetailRow(
                      icon: Icons.verified,
                      title: 'درجة الحديث',
                      value: hadith.grade,
                      color: _getGradeColor(hadith.grade),
                    ),

                    const SizedBox(height: 12),

                    // Narrator
                    _buildDetailRow(
                      icon: Icons.person,
                      title: 'المصدر',
                      value: hadith.narrator,
                      color: const Color(0xFF2E7D32),
                    ),

                    const SizedBox(height: 12),

                    // Category
                    _buildDetailRow(
                      icon: Icons.category,
                      title: 'الفئة',
                      value: hadith.category,
                      color: const Color(0xFF4CAF50),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Additional Actions
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      _copyToClipboard(context);
                    },
                    icon: const Icon(Icons.copy),
                    label: const Text(
                      'نسخ الحديث',
                      style: TextStyle(fontFamily: 'Cairo'),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2E7D32),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      // Share functionality
                    },
                    icon: const Icon(Icons.share),
                    label: const Text(
                      'مشاركة',
                      style: TextStyle(fontFamily: 'Cairo'),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF4CAF50),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _copyToClipboard(BuildContext context) {
    final hadithText = '''
${hadith.title}

${hadith.content}

رواه: ${hadith.narrator}
درجة الحديث: ${hadith.grade}
الفئة: ${hadith.category}
''';

    Clipboard.setData(ClipboardData(text: hadithText));

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'تم نسخ الحديث إلى الحافظة',
          style: TextStyle(fontFamily: 'Cairo'),
        ),
        backgroundColor: Color(0xFF2E7D32),
        duration: Duration(seconds: 2),
      ),
    );
  }

  Widget _buildDetailRow({
    required IconData icon,
    required String title,
    required String value,
    required Color color,
  }) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            color: color,
            size: 20,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                  fontFamily: 'Cairo',
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Cairo',
                  color: color,
                ),
              ),
            ],
          ),
        ),
      ],
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
