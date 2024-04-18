import 'package:flutter/material.dart';

import 'main.dart';

class Post {
  final String title;
  final String content;
  final String imagePath;

  Post({required this.title, required this.content, required this.imagePath});
}

List<Post> posts = [
  Post(imagePath: "assets/job1.jpg", title: 'Grace', content: 'This is the content of Post 1'),
  Post(imagePath: "assets/job1.jpg", title: 'Grace', content: 'This is the content of Post 2'),
  Post(imagePath: "assets/job1.jpg", title: 'Grace', content: 'This is the content of Post 3'),
  Post(imagePath: "assets/job1.jpg", title: 'Grace', content: 'This is the content of Post 3'),
  Post(imagePath: "assets/job1.jpg", title: 'Grace', content: 'This is the content of Post 3'),
  Post(imagePath: "assets/job1.jpg", title: 'Grace', content: 'This is the content of Post 3'),
  Post(imagePath: "assets/job1.jpg", title: 'Grace', content: 'This is the content of Post 3'),
  Post(imagePath: "assets/job1.jpg", title: 'Grace', content: 'This is the content of Post 3'),
];

void main() {
  runApp(postApp());
}

class postApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Feed Screen Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FeedScreen(),
    );
  }
}

class FeedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text('Posts', style: TextStyle(color: Colors.white)),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 50,
                  child: Center(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            Fade(
                              builder: (context) => MyApp(),
                            ),
                          );
                        },
                      child: const Text(
                        "Jobs",
                        style: TextStyle(fontSize: 18),
                      ),
                    )
                  ),
                  ),
                ),
              const Expanded(
                child: SizedBox(
                  height: 50,
                  child: Center(
                      child: Text(
                        "Posts",
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.blue,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: posts.length,
              itemBuilder: (context, index) {
                final post = posts[index];
                return PostCard(post: post);
              },
            ),
          ),
        ],
      ),
    );
  }
}


class PostCard extends StatelessWidget {
  final Post post;

  const PostCard({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: CircleAvatar(
                    radius: 25,
                    backgroundImage: AssetImage(post.imagePath),
                  ),
                ),
                Text(
                  post.title,
                  style: const TextStyle(
                    fontSize: 17.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            Text(
              post.content,
              style: const TextStyle(fontSize: 16.0),
            ),
          ],
        ),
      ),
    );
  }
}



class Fade<T> extends PageRouteBuilder<T> {
  final WidgetBuilder builder;

  Fade({required this.builder})
      : super(
    pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
      return builder(context);
    },
    transitionsBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
      return FadeTransition(
        opacity: animation,
        child: child,
      );
    },
  );
}