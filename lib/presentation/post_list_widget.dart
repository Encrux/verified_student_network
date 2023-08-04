import 'package:flutter/material.dart';
import 'package:verified_student_network/presentation/post_widget.dart';

class PostListScreen extends StatefulWidget {
  final int postsPerPage;
  final List<PostWidget> initialPosts;

  const PostListScreen({
    Key? key,
    this.postsPerPage = 20,
    required this.initialPosts,
  }) : super(key: key);

  @override
  PostListScreenState createState() => PostListScreenState();
}

class PostListScreenState extends State<PostListScreen> {
  final ScrollController _scrollController = ScrollController();
  final List<PostWidget> _posts = [];
  bool _isLoading = false;
  int _currentPage = 1;

  @override
  void initState() {
    super.initState();
    _loadMorePosts();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent) {
      _loadMorePosts();
    }
  }

  Future<void> _loadMorePosts() async {
    if (_isLoading) {
      return;
    }
    setState(() {
      _isLoading = true;
    });
    final startIndex = (_currentPage - 1) * widget.postsPerPage;
    final endIndex = startIndex + widget.postsPerPage;
    final postsToAdd = widget.initialPosts;
    await Future.delayed(const Duration(seconds: 1)); // Simulate loading delay
    setState(() {
      _posts.addAll(postsToAdd);
      _isLoading = false;
      _currentPage++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Post List'),
      ),
      body: ListView.builder(
        controller: _scrollController,
        itemCount: _posts.length + (_isLoading ? 1 : 0),
        itemBuilder: (context, index) {
          if (index == _posts.length) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          final post = _posts[index];
          return post;
        },
      ),
    );
  }
}
