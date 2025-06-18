import 'package:flutter/material.dart';
import 'package:news/providers/theme_provider.dart';
import 'package:provider/provider.dart';
import 'news_feed_page.dart';
import 'bookmarks_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _idx = 0;

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();

    final tabs = [
      NewsFeedPage(onBookmarkView: () => setState(() => _idx = 1), onBookmarkViewPressed: () {  },),
      const BookmarksPage(),
    ];

    final titles = ["Latest News", "Bookmarks"];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          titles[_idx],
          style: Theme.of(context).appBarTheme.titleTextStyle ??
              const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: Icon(
              themeProvider.isDarkMode ? Icons.dark_mode : Icons.light_mode,
            ),
            onPressed: themeProvider.toggleTheme,
          ),
        ],
      ),
      body: SafeArea(child: tabs[_idx]),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _idx,
        onTap: (i) => setState(() => _idx = i),
        selectedItemColor: Theme.of(context).colorScheme.primary,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.featured_play_list),
            label: 'News',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark),
            label: 'Bookmarks',
          ),
        ],
      ),
    );
  }
}
