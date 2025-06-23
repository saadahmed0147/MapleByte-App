import 'package:flutter/material.dart';
import 'package:maple_byte/Component/Appbar/curved_appbar.dart';
import 'package:maple_byte/Component/round_textfield.dart';
import 'package:maple_byte/Services/news_services.dart';
import 'package:maple_byte/Utils/app_colors.dart';
import 'package:maple_byte/main.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  final NewsService _newsService = NewsService();
  final TextEditingController _searchController = TextEditingController();

  String _category = 'general';
  String? _query;

  late Future<List<dynamic>> _articles;

  @override
  void initState() {
    super.initState();
    _loadNews();
  }

  void _loadNews() {
    setState(() {
      _articles = _newsService.fetchTopHeadlines(
        category: _category,
        query: _query,
      );
    });
  }

  void _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.inAppBrowserView)) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Could not open the link')));
    }
  }

  Widget _buildCategoryChips() {
    const categories = [
      'general',
      'business',
      'entertainment',
      'health',
      'science',
      'sports',
      'technology',
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Row(
        children: categories.map((cat) {
          final selected = _category == cat;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: ChoiceChip(
              label: Text(cat),
              selected: selected,
              onSelected: (_) {
                _category = cat;
                _query = null;
                _searchController.clear();
                _loadNews();
              },
            ),
          );
        }).toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CurvedAppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "News",
            style: TextStyle(
              fontFamily: "Inter",
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: _buildCategoryChips(),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: RoundTextField(
              label: 'Search',
              hint: 'Search',
              borderRadius: 30,
              bgColor: const Color(0xffEDF0FF),
              enabledBorderColor: const Color(0xffF8F9FE),
              focusedBorderColor: AppColors.greyColor,
              inputType: TextInputType.text,
              prefixIcon: Icons.search,
              textEditingController: _searchController,
              onFieldSubmitted: (value) {
                _query = value;
                _loadNews();
              },
            ),
          ),
          Expanded(
            child: FutureBuilder<List<dynamic>>(
              future: _articles,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError ||
                    !snapshot.hasData ||
                    snapshot.data!.isEmpty) {
                  return const Center(
                    child: Text(
                      "You don't have any news right now.",
                      style: TextStyle(
                        fontSize: 18,
                        color: AppColors.darkBlueColor,
                      ),
                    ),
                  );
                }

                final articles = snapshot.data!;
                return ListView.builder(
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    final article = articles[index];
                    return Card(
                      color: AppColors.lightBlueColor,
                      margin: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 6,
                      ),
                      child: SizedBox(
                        height:
                            mq.height * 0.15, // or any fixed height you prefer
                        child: Row(
                          children: [
                            // Image section
                            ClipRRect(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(12),
                                bottomLeft: Radius.circular(12),
                              ),
                              child: SizedBox(
                                width: mq.width * 0.35,
                                height: double.infinity,
                                child: article['urlToImage'] != null
                                    ? Image.network(
                                        article['urlToImage'],
                                        fit: BoxFit.cover,
                                        errorBuilder:
                                            (context, error, stackTrace) =>
                                                const Icon(Icons.broken_image),
                                      )
                                    : Container(
                                        color: Colors.white,
                                        child: const Icon(
                                          Icons.image_not_supported,
                                        ),
                                      ),
                              ),
                            ),

                            // Text section
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      article['title'] ?? 'No title',
                                      style: TextStyle(
                                        color: AppColors.whiteColor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      article['source']['name'] ?? '',
                                      style: TextStyle(
                                        color: AppColors.greyColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
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
