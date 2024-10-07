import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'news_provider.dart';
import 'news_detail_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => NewsProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,  // Add this line
        title: 'Flutter News App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: NewsListScreen(),
      ),
    );
  }
}

class NewsListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final newsProvider = Provider.of<NewsProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text('News')),
      body: newsProvider.isLoading
          ? Center(child: CircularProgressIndicator())
          : newsProvider.errorMessage != null
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(newsProvider.errorMessage!),
            ElevatedButton(
              onPressed: () => newsProvider.fetchNews(),
              child: Text('Retry'),
            ),
          ],
        ),
      )
          : ListView.builder(
        itemCount: newsProvider.articles.length,
        itemBuilder: (context, index) {
          final article = newsProvider.articles[index];
          return Padding(
            padding: const EdgeInsets.all(10.0), // Add padding around each tile
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              elevation: 5, // Adds shadow for a clean, raised look
              child: ListTile(
                contentPadding: EdgeInsets.all(10), // Adds padding inside the ListTile
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(8), // Rounded corners for the image
                  child: article['urlToImage'] != null && article['urlToImage'] != ""
                      ? Image.network(
                    article['urlToImage'],
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return _buildFallbackImage();
                    },
                  )
                      : _buildFallbackImage(), // Fallback if image URL is null
                ),
                title: Text(
                  article['title'] ?? '',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis, // Handle long titles gracefully
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 5),
                    Text(
                      article['description'] ?? '',
                      style: TextStyle(fontSize: 14),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis, // Truncate long descriptions
                    ),
                    SizedBox(height: 8),
                    if (article['urlToImage'] == null || article['urlToImage'] == "")
                      Text(
                        'Image not loaded',
                        style: TextStyle(color: Colors.red, fontSize: 12),
                      ),
                    SizedBox(height: 8),
                    Text(
                      article['publishedAt'] ?? '',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NewsDetailScreen(article: article),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => newsProvider.fetchNews(),
        child: Icon(Icons.refresh),
      ),
    );
  }

  Widget _buildFallbackImage() {
    return Container(
      width: 100,
      height: 100,
      color: Colors.grey,
      child: Center(
        child: Text(
          'Image not loaded',
          style: TextStyle(fontSize: 10, color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
