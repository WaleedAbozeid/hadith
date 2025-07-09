import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/hadith_provider.dart';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HadithProvider>(
      builder: (context, provider, child) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: TextField(
            onChanged: (value) {
              provider.setSearchQuery(value);
            },
            decoration: InputDecoration(
              hintText: 'ابحث في الأحاديث...',
              hintStyle: const TextStyle(
                fontFamily: 'Cairo',
                color: Colors.grey,
              ),
              prefixIcon: const Icon(
                Icons.search,
                color: Color(0xFF2E7D32),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
            ),
            style: const TextStyle(
              fontFamily: 'Cairo',
              fontSize: 16,
            ),
          ),
        );
      },
    );
  }
}
