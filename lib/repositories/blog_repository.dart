import 'dart:convert';  
import 'package:http/http.dart' as http;  
import 'package:hive/hive.dart';  
import '../models/blog.dart';  
  
class BlogRepository {  
  final String apiUrl = 'https://intent-kit-16.hasura.app/api/rest/blogs';  
  final String adminSecret = '32qR4KmXOIpsGPQKMqEJHGJS27G5s7HdSKO3gdtQd2kv5e852SiYwWNfxkZOBuQ6';  
  
  Future<List<Blog>> fetchBlogs() async {  
    try {  
      final response = await http.get(  
        Uri.parse(apiUrl),  
        headers: {'x-hasura-admin-secret': adminSecret},  
      );  
  
      if (response.statusCode == 200) {  
        final Map<String, dynamic> data = json.decode(response.body);  
        final List<dynamic> blogsJson = data['blogs'];  
        final List<Blog> blogs = blogsJson.map((json) => Blog.fromJson(json)).toList();  
  
        // have put this line to save for offline access  
        var box = await Hive.openBox<Blog>('blogs');  
        await box.clear();  
        await box.addAll(blogs);  
  
        return blogs;  
      } else {  
        throw Exception('Failed to load blogs');  
      }  
    } catch (e) {  
      // Fetch from Hive if fails 
      var box = await Hive.openBox<Blog>('blogs');  
      return box.values.toList();  
    }  
  }  
}  
