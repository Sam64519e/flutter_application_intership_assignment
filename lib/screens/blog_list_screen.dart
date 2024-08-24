import 'package:flutter/material.dart';  
import 'package:flutter_bloc/flutter_bloc.dart';  
import '../blocs/blog/blog_bloc.dart';  
import '../blocs/blog/blog_event.dart';  
import '../blocs/blog/blog_state.dart';  
import 'blog_detail_screen.dart';  
import '../models/blog.dart';  
import 'blog_card.dart';  
  
class BlogListScreen extends StatefulWidget {  
  @override  
  _BlogListScreenState createState() => _BlogListScreenState();  
}  
  
class _BlogListScreenState extends State<BlogListScreen> {  
  TextEditingController searchController = TextEditingController();  
  List<Blog> filteredBlogs = [];  
  
  @override  
  void initState() {  
    super.initState();  
    searchController.addListener(_onSearchChanged);  
  }  
  
  @override  
  void dispose() {  
    searchController.removeListener(_onSearchChanged);  
    searchController.dispose();  
    super.dispose();  
  }  
  
  void _onSearchChanged() {  
    final query = searchController.text.toLowerCase();  
    final allBlogs = (context.read<BlogBloc>().state as BlogLoaded).blogs;  
    setState(() {  
      filteredBlogs = allBlogs.where((blog) {  
        final title = blog.title?.toLowerCase() ?? '';  
        return title.contains(query);  
      }).toList();  
    });  
  }  
  
  @override  
  Widget build(BuildContext context) {  
    return Scaffold(  
      appBar: AppBar(  
        backgroundColor: Colors.white,  
        elevation: 0,  
        title: Text('Top Writers', style: TextStyle(color: Colors.black)),  
        actions: [  
          IconButton(  
            icon: Icon(Icons.search, color: Colors.black),  
            onPressed: () {  
              // Show search bar  
              showSearch(context: context, delegate: BlogSearchDelegate());  
            },  
          ),  
          Builder(  
            builder: (context) => IconButton(  
              icon: Icon(Icons.menu, color: Colors.black),  
              onPressed: () {  
                Scaffold.of(context).openDrawer();  
              },  
            ),  
          ),  
        ],  
      ),  
      drawer: Drawer(  
        child: ListView(  
          padding: EdgeInsets.zero,  
          children: [  
            DrawerHeader(  
              decoration: BoxDecoration(  
                color: Colors.blue,  
              ),  
              child: Text(  
                'Menu',  
                style: TextStyle(  
                  color: Colors.white,  
                  fontSize: 24,  
                ),  
              ),  
            ),  
            ListTile(  
              leading: Icon(Icons.settings),  
              title: Text('Settings'),  
              onTap: () {  
                // Handle settings tap  
              },  
            ),  
            ListTile(  
              leading: Icon(Icons.info),  
              title: Text('About'),  
              onTap: () {  
                // Handle about tap  
              },  
            ),  
          ],  
        ),  
      ),  
      body: BlocBuilder<BlogBloc, BlogState>(  
        builder: (context, state) {  
          if (state is BlogLoading) {  
            return Center(child: CircularProgressIndicator());  
          } else if (state is BlogLoaded) {  
            final blogs = searchController.text.isEmpty ? state.blogs : filteredBlogs;  
            return ListView(  
              padding: EdgeInsets.all(16),  
              children: [  
                // Featured Blog Section  
                if (blogs.isNotEmpty) FeaturedBlog(blog: blogs.first),  
                SizedBox(height: 20),  
                // Recent Blogs Section  
                Row(  
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,  
                  children: [  
                    Text(  
                      'Recent',  
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),  
                    ),  
                    TextButton(  
                      onPressed: () {  
                        // Handle see all action  
                      },  
                      child: Text('See all'),  
                    ),  
                  ],  
                ),  
                ListView.builder(  
                  shrinkWrap: true,  
                  physics: NeverScrollableScrollPhysics(),  
                  itemCount: blogs.length,  
                  itemBuilder: (context, index) {  
                    final blog = blogs[index];  
                    return BlogCard(  
                      blog: blog,  
                      onTap: () {  
                        Navigator.push(  
                          context,  
                          MaterialPageRoute(  
                            builder: (context) => BlogDetailScreen(blog: blog),  
                          ),  
                        );  
                      },  
                    );  
                  },  
                ),  
              ],  
            );  
          } else if (state is BlogError) {  
            return Center(child: Text(state.message));  
          } else {  
            return Center(child: Text('Press the button to fetch blogs'));  
          }  
        },  
      ),  
      floatingActionButton: FloatingActionButton(  
        onPressed: () {  
          context.read<BlogBloc>().add(FetchBlogs());  
        },  
        child: Icon(Icons.refresh),  
      ),  
    );  
  }  
}  
  
class BlogSearchDelegate extends SearchDelegate {  
  @override  
  List<Widget>? buildActions(BuildContext context) {  
    return [  
      IconButton(  
        icon: Icon(Icons.clear),  
        onPressed: () {  
          query = '';  
        },  
      ),  
    ];  
  }  
  
  @override  
  Widget? buildLeading(BuildContext context) {  
    return IconButton(  
      icon: Icon(Icons.arrow_back),  
      onPressed: () {  
        close(context, null);  
      },  
    );  
  }  
  
  @override  
  Widget buildResults(BuildContext context) {  
    final allBlogs = (context.read<BlogBloc>().state as BlogLoaded).blogs;  
    final filteredBlogs = allBlogs.where((blog) {  
      final title = blog.title?.toLowerCase() ?? '';  
      return title.contains(query.toLowerCase());  
    }).toList();  
  
    return ListView.builder(  
      itemCount: filteredBlogs.length,  
      itemBuilder: (context, index) {  
        final blog = filteredBlogs[index];  
        return BlogCard(  
          blog: blog,  
          onTap: () {  
            Navigator.push(  
              context,  
              MaterialPageRoute(  
                builder: (context) => BlogDetailScreen(blog: blog),  
              ),  
            );  
          },  
        );  
      },  
    );  
  }  
  
  @override  
  Widget buildSuggestions(BuildContext context) {  
    final allBlogs = (context.read<BlogBloc>().state as BlogLoaded).blogs;  
    final filteredBlogs = allBlogs.where((blog) {  
      final title = blog.title?.toLowerCase() ?? '';  
      return title.contains(query.toLowerCase());  
    }).toList();  
  
    return ListView.builder(  
      itemCount: filteredBlogs.length,  
      itemBuilder: (context, index) {  
        final blog = filteredBlogs[index];  
        return BlogCard(  
          blog: blog,  
          onTap: () {  
            Navigator.push(  
              context,  
              MaterialPageRoute(  
                builder: (context) => BlogDetailScreen(blog: blog),  
              ),  
            );  
          },  
        );  
      },  
    );  
  }  
}  
  
class FeaturedBlog extends StatelessWidget {  
  final Blog blog;  
  
  const FeaturedBlog({Key? key, required this.blog}) : super(key: key);  
  
  @override  
  Widget build(BuildContext context) {  
    return Container(  
      margin: EdgeInsets.only(bottom: 16),  
      decoration: BoxDecoration(  
        borderRadius: BorderRadius.circular(15),  
        boxShadow: [  
          BoxShadow(  
            color: Colors.black26,  
            blurRadius: 10,  
            offset: Offset(0, 5),  
          ),  
        ],  
      ),  
      child: ClipRRect(  
        borderRadius: BorderRadius.circular(15),  
        child: Stack(  
          alignment: Alignment.bottomLeft,  
          children: [  
            blog.imageUrl != null  
                ? Image.network(  
                    blog.imageUrl!,  
                    height: 200,  
                    width: double.infinity,  
                    fit: BoxFit.cover,  
                  )  
                : Container(  
                    height: 200,  
                    color: Colors.grey,  
                    child: Center(child: Icon(Icons.image, color: Colors.white)),  
                  ),  
            Container(  
              padding: EdgeInsets.all(16),  
              color: Colors.black54,  
              width: double.infinity,  
              child: Column(  
                crossAxisAlignment: CrossAxisAlignment.start,  
                children: [  
                  Text(  
                    blog.title ?? 'No Title',  
                    style: TextStyle(  
                      color: Colors.white,  
                      fontSize: 18,  
                      fontWeight: FontWeight.bold,  
                    ),  
                  ),  
                  SizedBox(height: 4),  
                  Row(  
                    children: [  
                      Text(  
                        'Samsad Rashid',  
                        style: TextStyle(  
                          color: Colors.white,  
                          fontSize: 12,  
                        ),  
                      ),  
                      SizedBox(width: 10),  
                      Text(  
                        '43 sec ago',  
                        style: TextStyle(  
                          color: Colors.white,  
                          fontSize: 12,  
                        ),  
                      ),  
                    ],  
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
