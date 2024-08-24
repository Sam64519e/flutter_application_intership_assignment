import 'package:flutter_bloc/flutter_bloc.dart';  
import '../../models/blog.dart';  
import '../../repositories/blog_repository.dart';  
import 'blog_event.dart';  
import 'blog_state.dart';  
  
class BlogBloc extends Bloc<BlogEvent, BlogState> {  
  final BlogRepository blogRepository;  
  
  BlogBloc({required this.blogRepository}) : super(BlogLoading()) {  
    on<FetchBlogs>(_onFetchBlogs);  
  }  
  
  void _onFetchBlogs(FetchBlogs event, Emitter<BlogState> emit) async {  
    emit(BlogLoading());  
    try {  
      final blogs = await blogRepository.fetchBlogs();  
      emit(BlogLoaded(blogs: blogs));  
    } catch (e) {  
      emit(BlogError(message: e.toString()));  
    }  
  }  
}  
