import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/hadith_provider.dart';
import '../widgets/category_filter.dart';
import '../widgets/hadith_card.dart';
import '../widgets/search_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<HadithProvider>().loadInitialHadiths();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        title: const Text(
          'أحاديث نبوية',
          style: TextStyle(
            fontFamily: 'Cairo',
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(0xFF2E7D32),
        elevation: 0,
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite, color: Colors.white),
            onPressed: () {
              // Navigate to favorites screen
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Search Bar
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: CustomSearchBar(),
          ),

          // Category Filter
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: CategoryFilter(),
          ),

          // Hadiths List
          Expanded(
            child: Consumer<HadithProvider>(
              builder: (context, hadithProvider, child) {
                if (hadithProvider.isLoading) {
                  return const Center(
                    child: CircularProgressIndicator(color: Color(0xFF2E7D32)),
                  );
                }
                if (hadithProvider.error != null) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.error_outline,
                            size: 64, color: Colors.red),
                        const SizedBox(height: 16),
                        Text(
                          hadithProvider.error!,
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.red,
                            fontFamily: 'Cairo',
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () => hadithProvider.loadInitialHadiths(),
                          child: const Text('إعادة المحاولة'),
                        ),
                      ],
                    ),
                  );
                }
                final hadiths = hadithProvider.filteredHadiths;
                if (hadiths.isEmpty) {
                  return const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.search_off,
                          size: 64,
                          color: Colors.grey,
                        ),
                        SizedBox(height: 16),
                        Text(
                          'لا توجد أحاديث',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey,
                            fontFamily: 'Cairo',
                          ),
                        ),
                      ],
                    ),
                  );
                }
                return ListView.builder(
                  padding: const EdgeInsets.all(16.0),
                  itemCount: hadiths.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: HadithCard(hadith: hadiths[index]),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
