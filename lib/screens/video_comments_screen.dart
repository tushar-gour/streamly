import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/comment_provider.dart';
import '../models/comment.dart';

class VideoCommentsScreen extends StatefulWidget {
  final String videoId;
  final String userId;
  final String accessToken;

  const VideoCommentsScreen({
    super.key,
    required this.videoId,
    required this.userId,
    required this.accessToken,
  });

  @override
  State<StatefulWidget> createState() {
    return _VideoCommentsScreenState();
  }
}

class _VideoCommentsScreenState extends State<VideoCommentsScreen> {
  final TextEditingController _commentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Provider.of<CommentProvider>(context, listen: false)
        .fetchComments(widget.videoId);
  }

  void _addComment() async {
    final content = _commentController.text.trim();
    if (content.isEmpty) return;

    final success = await Provider.of<CommentProvider>(context, listen: false)
        .addComment(widget.videoId, widget.userId, content, widget.accessToken);

    if (success) {
      _commentController.clear();
    } else {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to add comment')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Comments'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Consumer<CommentProvider>(
              builder: (context, commentProvider, child) {
                if (commentProvider.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (commentProvider.comments.isEmpty) {
                  return const Center(child: Text('No comments yet.'));
                }
                return ListView.builder(
                  itemCount: commentProvider.comments.length,
                  itemBuilder: (context, index) {
                    Comment comment = commentProvider.comments[index];
                    return ListTile(
                      title: Text(comment.content),
                      subtitle: const Text('User: \${comment.userId}'),
                    );
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _commentController,
                    decoration: const InputDecoration(
                      hintText: 'Add a comment...',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: _addComment,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
