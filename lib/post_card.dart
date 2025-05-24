import 'package:flutter/material.dart';
import 'post.dart';

class DebatePostCard extends StatefulWidget {
  final Post post;

  DebatePostCard({required this.post});

  @override
  _DebatePostCardState createState() => _DebatePostCardState();
}

class _DebatePostCardState extends State<DebatePostCard> {
  final TextEditingController commentController = TextEditingController();
  String currentSection = 'Support';

  void addComment() {
    final text = commentController.text.trim();
    if (text.isEmpty) return;

    setState(() {
      if (currentSection == 'Support') {
        widget.post.supportComments.add(text);
      } else {
        widget.post.oppositionComments.add(text);
      }
      commentController.clear();
    });
  }

  Widget buildCommentList(List<String> comments) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: comments.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(comments[index]),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 12),
      elevation: 4,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.post.content,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            Text("Topic: ${widget.post.topic}",
                style: TextStyle(fontSize: 12, color: Colors.grey[600])),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ChoiceChip(
                  label: Text('Support'),
                  selected: currentSection == 'Support',
                  onSelected: (_) => setState(() => currentSection = 'Support'),
                  selectedColor: Colors.greenAccent,
                ),
                ChoiceChip(
                  label: Text('Opposition'),
                  selected: currentSection == 'Opposition',
                  onSelected: (_) => setState(() => currentSection = 'Opposition'),
                  selectedColor: Colors.redAccent,
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: commentController,
                    decoration: InputDecoration(
                      labelText: 'Enter your comment',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                ElevatedButton(
                  onPressed: addComment,
                  child: Text("Post"),
                ),
              ],
            ),
            SizedBox(height: 10),
            Text("Support Comments",
                style: TextStyle(fontWeight: FontWeight.bold)),
            buildCommentList(widget.post.supportComments),
            SizedBox(height: 10),
            Text("Opposition Comments",
                style: TextStyle(fontWeight: FontWeight.bold)),
            buildCommentList(widget.post.oppositionComments),
          ],
        ),
      ),
    );
  }
}
