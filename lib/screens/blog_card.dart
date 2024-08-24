import 'package:flutter/material.dart';  
import '../models/blog.dart';  
  
class BlogCard extends StatelessWidget {  
  final Blog blog;  
  final VoidCallback onTap;  
  
  const BlogCard({Key? key, required this.blog, required this.onTap}) : super(key: key);  
  
  @override  
  Widget build(BuildContext context) {  
    return GestureDetector(  
      onTap: onTap,  
      child: Container(  
        margin: EdgeInsets.symmetric(vertical: 10),  
        padding: EdgeInsets.all(16),  
        decoration: BoxDecoration(  
          borderRadius: BorderRadius.circular(15),  
          color: Colors.white,  
          boxShadow: [  
            BoxShadow(  
              color: Colors.black12,  
              blurRadius: 5,  
              offset: Offset(0, 5),  
            ),  
          ],  
        ),  
        child: Row(  
          children: [  
            ClipRRect(  
              borderRadius: BorderRadius.circular(8),  
              child: blog.imageUrl != null  
                  ? Image.network(  
                      blog.imageUrl!,  
                      width: 70,  
                      height: 70,  
                      fit: BoxFit.cover,  
                    )  
                  : Container(  
                      width: 70,  
                      height: 70,  
                      color: Colors.grey,  
                      child: Center(child: Icon(Icons.image, color: Colors.white)),  
                    ),  
            ),  
            SizedBox(width: 16),  
            Expanded(  
              child: Column(  
                crossAxisAlignment: CrossAxisAlignment.start,  
                children: [  
                  Text(  
                    blog.title ?? 'No Title',  
                    style: TextStyle(  
                      color: Colors.black,  
                      fontSize: 16,  
                      fontWeight: FontWeight.bold,  
                    ),  
                  ),  
                  SizedBox(height: 8),  
                  Text(  
                    'Subtitle or description goes here',  
                    style: TextStyle(  
                      color: Colors.grey[600],  
                      fontSize: 14,  
                    ),  
                  ),  
                ],  
              ),  
            ),  
          ],  
        ),  
      ),  
    );  
  }  
}  
