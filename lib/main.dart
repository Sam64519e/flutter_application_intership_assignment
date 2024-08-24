import 'package:flutter/material.dart';  
import 'package:flutter_bloc/flutter_bloc.dart';  
import 'package:hive_flutter/hive_flutter.dart';  
import 'package:path_provider/path_provider.dart';  
import 'screens/blog_list_screen.dart';  
import 'blocs/blog/blog_bloc.dart';  
import 'repositories/blog_repository.dart';  
import 'models/blog.dart';  
import 'blocs/blog/blog_event.dart';
  
void main() async {  
  WidgetsFlutterBinding.ensureInitialized();  
  final appDocumentDir = await getApplicationDocumentsDirectory();  
  await Hive.initFlutter(appDocumentDir.path);  
  Hive.registerAdapter(BlogAdapter());  
  await Hive.openBox<Blog>('blogs');  
  
  runApp(MyApp());  
}  
  
class MyApp extends StatelessWidget {  
  @override  
  Widget build(BuildContext context) {  
    return MultiBlocProvider(  
      providers: [  
        BlocProvider<BlogBloc>(  
          create: (context) => BlogBloc(blogRepository: BlogRepository())..add(FetchBlogs()),  
        ),  
      ],  
      child: MaterialApp(  
        title: 'Blog Explorer',  
        theme: ThemeData(  
          primarySwatch: Colors.blue,  
          fontFamily: 'Roboto', // Custom font  
          scaffoldBackgroundColor: Colors.grey[100],  
        ),  
        home: BlogListScreen(),  
      ),  
    );  
  }  
}  
