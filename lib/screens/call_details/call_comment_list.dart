import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/call_comment.dart';
import '../../shared/shared_widgets/surface.dart';
import 'comment_tile.dart';

/* Lists all the call comments from the stream provider in call details screen
   into a listview.
 */
class CallCommentList extends StatefulWidget {
  const CallCommentList({Key? key}) : super(key: key);

  @override
  State<CallCommentList> createState() => _CallCommentListState();
}

class _CallCommentListState extends State<CallCommentList>
    with AutomaticKeepAliveClientMixin {
  // override for the AutomaticKeepAliveClientMixin forces widget to stay alive
  // even when it is scrolled out of screen view. Doing this prevents the
  // widget from having to be rebuilt when returning into view, which
  // causes the screen position to jump.
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    final comments = Provider.of<List<CallComment>>(context);
    return Surface(
      child: Column(
        children: [
          // Widget header:
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.comment,
                color: Colors.grey[300],
                size: 24,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                "Call Comments:",
                style: TextStyle(
                  color: Colors.grey[300],
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          // Call comments list:
          ListView.builder(
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              itemCount: comments.length,
              itemBuilder: (context, index) {
                return CommentTile(comment: comments[index]);
              }),
          // Display "None" if the comment list is empty:
          Text(
            comments.isEmpty ? "None" : "",
            style: const TextStyle(
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
