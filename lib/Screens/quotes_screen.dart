import 'package:flutter/material.dart';
import 'package:maple_byte/Component/Appbar/curved_appbar.dart';
import 'package:maple_byte/Component/Quotes/styled_quotes_container.dart';
import 'package:maple_byte/Services/quotes_services.dart';
import 'package:maple_byte/Utils/app_colors.dart';

class QuotesScreen extends StatefulWidget {
  const QuotesScreen({super.key});

  @override
  State<QuotesScreen> createState() => _QuotesScreenState();
}

class _QuotesScreenState extends State<QuotesScreen> {
  final QuoteService _quoteService = QuoteService();

  List<String> quotes = List.filled(4, '');
  List<String> authors = List.filled(4, '');
  List<bool> loading = List.filled(4, true);

  @override
  void initState() {
    super.initState();
    _fetchAllQuotes();
  }

  void _fetchAllQuotes() {
    for (int i = 0; i < 4; i++) {
      _fetchQuoteAt(i);
    }
  }

  void _fetchQuoteAt(int index) async {
    setState(() {
      loading[index] = true;
    });

    try {
      final data = await _quoteService.fetchQuote();
      setState(() {
        quotes[index] = data['quote']!;
        authors[index] = data['author']!;
        loading[index] = false;
      });
    } catch (_) {
      setState(() {
        quotes[index] = 'Something went wrong.';
        authors[index] = '';
        loading[index] = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CurvedAppBar(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: const Text(
              "Fuel Your Brand Ignite Your Vision",
              style: TextStyle(
                fontFamily: "Inter",
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
                fontSize: 18,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 10),
          CurvedQuoteCard(
            quote: 'The best way to predict the future is to create it.',
            author: 'Peter Drucker',
          ),
          SizedBox(height: 20),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: GridView.builder(
                itemCount: 4,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 16,
                  childAspectRatio: 1,
                ),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(),
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [
                            AppColors.lightBlueColor,
                            AppColors.darkBlueColor,
                          ],
                        ),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      padding: const EdgeInsets.all(8),
                      child: Center(
                        child: loading[index]
                            ? const CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              )
                            : Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    quotes[index],
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
