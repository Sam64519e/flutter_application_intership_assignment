import 'package:hive/hive.dart';  
  
part 'blog.g.dart';  
  
@HiveType(typeId: 0)  
class Blog extends HiveObject {  
  @HiveField(0)  
  final String? id;  
  
  @HiveField(1)  
  final String? title;  
  
  @HiveField(2)  
  final String? imageUrl;  
  
  @HiveField(3)  
  final String? content;  
  
  Blog({  
    this.id,  
    this.title,  
    this.imageUrl,  
    this.content,  
  });  
  
  factory Blog.fromJson(Map<String, dynamic> json) {  
    return Blog(  
      id: json['id'] as String?,  
      title: json['title'] as String?,  
      imageUrl: json['image_url'] as String?,  
      content: json['content'] as String?,  
    );  
  }  
  
  Map<String, dynamic> toJson() => {  
    'id': id,  
    'title': title,  
    'image_url': imageUrl,  
    'content': content,  
  };  
}  
