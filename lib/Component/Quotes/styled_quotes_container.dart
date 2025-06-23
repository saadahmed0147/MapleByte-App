import 'package:flutter/material.dart';
import 'package:maple_byte/Component/Quotes/quotes_clipper.dart';
import 'package:maple_byte/Utils/app_colors.dart';
import 'package:maple_byte/main.dart';

class CurvedQuoteCard extends StatelessWidget {
  final String quote;
  final String author;

  const CurvedQuoteCard({super.key, required this.quote, required this.author});

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: QuoteCardClipper(),
      child: Container(
        height: mq.height * 0.22,
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [AppColors.lightBlueColor, AppColors.darkBlueColor],
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '"$quote"',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontFamily: "Playfair",
                  fontWeight: FontWeight.w900,
                ),
                textAlign: TextAlign.center,
              ),
              Text(
                author,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontFamily: "Playfair",
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
