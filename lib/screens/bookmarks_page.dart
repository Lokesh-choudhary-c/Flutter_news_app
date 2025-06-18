import 'package:flutter/material.dart';
import 'package:news/providers/news_provider.dart';
import 'package:news/utils/date_formatter.dart';
import 'package:news/utils/webview_page.dart';
import 'package:provider/provider.dart';


class BookmarksPage extends StatelessWidget {
  const BookmarksPage({super.key});

  @override
  Widget build(BuildContext context) {
    final prov = context.watch<NewsProvider>();
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: prov.bookmarks.isEmpty
          ? const Center(child: Text("No bookmarks yet."))
          : ListView.builder(
              padding: const EdgeInsets.only(bottom: 16),
              itemCount: prov.bookmarks.length,
              itemBuilder: (context, i) {
                final a = prov.bookmarks[i];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => ArticleWebView(url: a.url!)),
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: isDark ? Colors.grey[900] : Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: isDark ? [] : [const BoxShadow(color: Colors.black12, blurRadius: 8)],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (a.urlToImage != null)
                          ClipRRect(
                            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                            child: Image.network(
                              a.urlToImage!,
                              height: 160,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  a.title ?? '',
                                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                        color: isDark ? Colors.white : Colors.black,
                                      ),
                                ),
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete_forever, color: Colors.redAccent),
                                onPressed: () {
                                  prov.removeBookmark(a);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: const Text("Removed from bookmarks"),
                                      action: SnackBarAction(
                                        label: "Undo",
                                        onPressed: () => prov.addBookmark(a),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                          child: Text(
                            '${a.sourceName ?? 'Unknown'} • ${formatDate(a.publishedAt)}',
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                  color: isDark ? Colors.grey[400] : Colors.grey[800],
                                ),
                          ),
                        ),
                        const SizedBox(height: 12),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}


