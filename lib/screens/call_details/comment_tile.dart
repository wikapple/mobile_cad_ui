import 'package:flutter/material.dart';

import '../../models/call_comment.dart';

// Displays a single comment tile in a listview of Call Comments.

class CommentTile extends StatelessWidget {
  const CommentTile({required this.comment, Key? key}) : super(key: key);
  final CallComment comment;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 15),
      child: Column(
        children: [
          // Show to time the comment was created:
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              "${comment.getFormattedTimeCreated()} :",
              style: TextStyle(
                color: Colors.grey[300],
                fontSize: 16,
              ),
            ),
          ),
          const SizedBox(height: 5),
          // Display the comment:
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              comment.comment.toString(),
              style: TextStyle(
                color: Colors.grey[300],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
