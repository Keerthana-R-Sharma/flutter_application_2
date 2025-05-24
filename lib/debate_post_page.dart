import 'package:flutter/material.dart';
import 'post.dart';
import 'post_card.dart';

class DebatePostPage extends StatefulWidget {
  @override
  _DebatePostPageState createState() => _DebatePostPageState();
}

class _DebatePostPageState extends State<DebatePostPage> {
  final List<Post> posts = [];
  final TextEditingController postController = TextEditingController();
  String newPostTopic = 'Politics';
  String selectedTopic = 'All Topics';

  final List<String> topics = [
    'All Topics',
    'Politics',
    'Sports',
    'Current Affairs',
    'Govt Updates',
    'Science & Tech'
  ];

  void addPost() {
    final text = postController.text.trim();
    if (text.isEmpty) return;

    setState(() {
      posts.add(Post(text, newPostTopic));
      postController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    final filteredPosts = selectedTopic == 'All Topics'
        ? posts
        : posts.where((p) => p.topic == selectedTopic).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text("DebateHub"),
        backgroundColor: Colors.deepPurple,
      ),
      body: Column(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
            child: Row(
              children: topics.map((topic) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  child: ChoiceChip(
                    label: Text(topic),
                    selected: selectedTopic == topic,
                    onSelected: (_) {
                      setState(() {
                        selectedTopic = topic;
                      });
                    },
                  ),
                );
              }).toList(),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(16),
              child: Column(
                children: filteredPosts
                    .map((post) => DebatePostCard(post: post))
                    .toList(),
              ),
            ),
          ),
          Container(
            color: Colors.grey[100],
            padding: EdgeInsets.all(10),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: postController,
                    decoration: InputDecoration(
                      labelText: 'Enter a new post',
                      border: OutlineInputBorder(),
                      suffixIcon: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: newPostTopic,
                          icon: Icon(Icons.arrow_drop_down),
                          onChanged: (String? value) {
                            if (value != null) {
                              setState(() {
                                newPostTopic = value;
                              });
                            }
                          },
                          items: topics
                              .where((t) => t != 'All Topics')
                              .map<DropdownMenuItem<String>>((String topic) {
                            return DropdownMenuItem<String>(
                              value: topic,
                              child: Text(topic),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                ElevatedButton(
                  onPressed: addPost,
                  child: Text("Add"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
