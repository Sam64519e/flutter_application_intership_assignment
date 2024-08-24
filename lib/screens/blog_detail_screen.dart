import 'package:flutter/material.dart';  
import '../models/blog.dart';  
  
class BlogDetailScreen extends StatelessWidget {  
  final Blog blog;  
  
  const BlogDetailScreen({Key? key, required this.blog}) : super(key: key);  
  
  @override  
  Widget build(BuildContext context) {  
    return Scaffold(  
      appBar: AppBar(title: Text(blog.title ?? 'No Title')),  
      body: Padding(  
        padding: const EdgeInsets.all(16.0),  
        child: Column(  
          crossAxisAlignment: CrossAxisAlignment.start,  
          children: [  
            blog.imageUrl != null  
                ? Image.network(blog.imageUrl!)  
                : Placeholder(  
                    fallbackHeight: 200,  
                    fallbackWidth: double.infinity,  
                  ),  
            SizedBox(height: 16),  
            Text(  
              blog.title ?? 'No Title',  
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),  
            ),  
            SizedBox(height: 16),  
            Text(blog.content ?? 'No Content'),  
          ],  
        ),  
      ),  
    );  
  }  
}  
