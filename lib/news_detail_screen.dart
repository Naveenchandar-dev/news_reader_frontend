import 'package:flutter/material.dart';

class NewsDetailScreen extends StatelessWidget {
  final Map<String, dynamic> article;

  NewsDetailScreen({required this.article});

  @override
  Widget build(BuildContext context) {
    // Calculate half the screen height for the image
    double halfScreenHeight = MediaQuery.of(context).size.height * 0.5;

    return Scaffold(
      appBar: AppBar(title: Text('News Details')),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image with fallback if not available
            article['urlToImage'] != null && article['urlToImage'] != ''
                ? Image.network(
              article['urlToImage'],
              width: double.infinity,
              height: halfScreenHeight, // Set image to cover half the screen height
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return _buildFallbackImage(halfScreenHeight); // Fallback if image fails
              },
            )
                : _buildFallbackImage(halfScreenHeight), // Show fallback if URL is empty or null
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    article['title'] ?? '',
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.left,
                  ),
                  SizedBox(height: 10),
                  Text(
                    article['publishedAt'] ?? '',
                    style: TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                  SizedBox(height: 16),
                  Divider(),
                  // Full article content
                  Text(
                    article['content'] != null
                        ? article['content']
                        : article['description'] != null
                        ? article['description']
                        : 'No content available.',
                    style: TextStyle(fontSize: 16, height: 1.5),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Fallback image when image is not available or fails to load
  Widget _buildFallbackImage(double height) {
    return Container(
      width: double.infinity,
      height: height,
      color: Colors.grey[300],
      child: Center(
        child: Text(
          'Image not loaded',
          style: TextStyle(fontSize: 16, color: Colors.red),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
