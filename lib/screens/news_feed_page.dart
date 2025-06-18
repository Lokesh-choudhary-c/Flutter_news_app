import 'package:flutter/material.dart';
import 'package:news/providers/news_provider.dart';
import 'package:news/utils/date_formatter.dart';
import 'package:news/utils/webview_page.dart';
import 'package:provider/provider.dart';

class NewsFeedPage extends StatefulWidget {
  final VoidCallback onBookmarkView;

  const NewsFeedPage({
    super.key,
    required this.onBookmarkView,
    required Null Function() onBookmarkViewPressed,
  });

  @override
  State<NewsFeedPage> createState() => _NewsFeedPageState();
}

class _NewsFeedPageState extends State<NewsFeedPage> {
  final TextEditingController _searchController = TextEditingController();
  String query = '';

  @override
  void initState() {
    super.initState();
    Provider.of<NewsProvider>(context, listen: false).fetchNews();
  }

  @override
  Widget build(BuildContext context) {
    final newsProvider = context.watch<NewsProvider>();
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final filteredArticles = newsProvider.articles.where((article) {
      final q = query.toLowerCase();
      return (article.title ?? '').toLowerCase().contains(q) ||
          (article.description ?? '').toLowerCase().contains(q);
    }).toList();

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: TextField(
            controller: _searchController,
            onChanged: (val) => setState(() => query = val),
            decoration: InputDecoration(
              hintText: 'Search news...',
              prefixIcon: const Icon(Icons.search),
              suffixIcon: query.isNotEmpty
                  ? IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        _searchController.clear();
                        setState(() => query = '');
                      },
                    )
                  : null,
              filled: true,
              fillColor: isDark ? Colors.grey[850] : Colors.grey[200],
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
                borderSide: BorderSide(
                  color: isDark ? Colors.grey[700]! : Colors.grey[400]!,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
                borderSide: BorderSide(
                  color: isDark ? Colors.grey[700]! : Colors.grey[400]!,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
                borderSide: BorderSide(
                  color: isDark ? Colors.blueGrey : Colors.blue,
                  width: 2,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: RefreshIndicator(
            onRefresh: () => newsProvider.fetchNews(),
            child: filteredArticles.isEmpty
                ? const Center(child: Text("No news found"))
                : ListView.builder(
                    itemCount: filteredArticles.length,
                    itemBuilder: (context, index) {
                      final article = filteredArticles[index];

                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => ArticleWebView(url: article.url!),
                            ),
                          );
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            color: isDark ? Colors.grey[900] : Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: isDark
                                ? []
                                : [const BoxShadow(color: Colors.black12, blurRadius: 8)],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (article.urlToImage != null)
                                ClipRRect(
                                  borderRadius: const BorderRadius.vertical(
                                      top: Radius.circular(16)),
                                  child: Image.network(
                                    article.urlToImage!,
                                    height: 160,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              Padding(
                                padding: const EdgeInsets.all(16),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            article.title ?? '',
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleLarge
                                                ?.copyWith(
                                                  color: isDark
                                                      ? Colors.white
                                                      : Colors.black,
                                                ),
                                          ),
                                          const SizedBox(height: 8),
                                          if (article.description != null)
                                            Text(
                                              article.description!,
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium
                                                  ?.copyWith(
                                                    color: isDark
                                                        ? Colors.grey[300]
                                                        : Colors.grey[700],
                                                  ),
                                            ),
                                        ],
                                      ),
                                    ),
                                    IconButton(
                                      icon: Icon(
                                        newsProvider.isBookmarked(article)
                                            ? Icons.bookmark
                                            : Icons.bookmark_border,
                                        color: newsProvider.isBookmarked(article)
                                            ? Colors.amber
                                            : Theme.of(context).iconTheme.color,
                                      ),
                                      onPressed: () {
                                        if (newsProvider.isBookmarked(article)) {
                                          newsProvider.removeBookmark(article);
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            const SnackBar(
                                              content: Text("Bookmark removed"),
                                            ),
                                          );
                                        } else {
                                          newsProvider.addBookmark(article);
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(
                                              content: const Text("Bookmarked"),
                                              action: SnackBarAction(
                                                label: "View",
                                                onPressed: widget.onBookmarkView,
                                              ),
                                            ),
                                          );
                                        }
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                                child: Text(
                                  '${article.sourceName ?? 'Unknown'} • ${formatDate(article.publishedAt)}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium
                                      ?.copyWith(
                                        color: isDark
                                            ? Colors.grey[400]
                                            : Colors.grey[800],
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
          ),
        ),
      ],
    );
  }
}

