import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Import other necessary files
import 'Job.dart'; // Assuming you have this file
import 'package:untitled3/allPost.dart';
import 'candidatedetails.dart' show Candidate, CandidateDetailPage, CandidateListPage; // Assuming you have this file
import 'contactpage.dart'; // Assuming you have this file
import 'detailpage.dart'; // Assuming you have this file
import 'home.dart'; // Assuming you have this file

void main() => runApp(MyApp());

final List<Job> jobs = [
  // Define your list of jobs here
];

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Find Job',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: HomeScreen(
        jobPosts: jobs, // Pass job posts to HomeScreen
      ),
    );
  }
}



class HomeScreen extends StatefulWidget {
  final List<Job> jobPosts;

  const HomeScreen({Key? key, required this.jobPosts}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Post> generalPosts = [];

  // Function to update generalPosts list
  @override
  void initState() {
    super.initState();
    _loadStoredData();
  }
  Future<void> _loadStoredData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? title = prefs.getString('title');
    String? location = prefs.getString('location');
    double? salary = prefs.getDouble('salary');
    String? description = prefs.getString('description');
    String? imagePath = prefs.getString('imagePath');
    int? postTypeIndex = prefs.getInt('postType');

    if (title != null &&
        location != null &&
        salary != null &&
        description != null &&
        imagePath != null &&
        postTypeIndex != null) {
      PostType postType = PostType.values[postTypeIndex];
      Post storedPost = Post(
        title: title,
        location: location,
        salary: salary,
        description: description,
        imagePath: imagePath,
        type: postType,
      );

      setState(() {
        generalPosts.add(storedPost);
      });
    }
  }
  // Function to update generalPosts list
  void addPost(Post post) {
    setState(() {
      generalPosts.add(post);
    });
  }
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Find Job'),
          bottom: TabBar(
            tabs: [
              Tab(text: 'Jobs'),
              Tab(text: 'Posts'),
            ],
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.person),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CandidateListPage(title: 'Candidates'),
                  ),
                );
              },
            ),
          ],
        ),
        body: TabBarView(
          children: [
            JobsTab(jobPosts: widget.jobPosts),
            PostsTab(generalPosts: generalPosts),
          ],
        ),
        // Pass addPost function to PostForm widget

      ),
    );
  }
}

class PostsTab extends StatelessWidget {
  final List<Post> generalPosts;

  const PostsTab({Key? key, required this.generalPosts}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: generalPosts.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(generalPosts[index].title),
          subtitle: Text(generalPosts[index].description),

        );
      },
    );
  }
}
class JobsTab extends StatelessWidget {
  final List<Job> jobPosts;

  const JobsTab({Key? key, required this.jobPosts}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: jobPosts.length,
      itemBuilder: (context, index) {
        return JobDetailCard(job: jobPosts[index]);
      },
    );
  }
}

class JobDetailCard extends StatelessWidget {
  final Job job;

  const JobDetailCard({Key? key, required this.job}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => JobDetailPage(job: job),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 200,
                child: Image.asset(
                  job.photo,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Title: ${job.title}',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),
              ),
              SizedBox(height: 8),
              Text(
                'Location: ${job.location}',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 8),
              Text(
                'Salary: \$${job.salary.toString()}',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 8),
              Text(
                'Description: ${job.description}',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}



class CreatePostScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Post'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownButton<String>(
              items: [
                DropdownMenuItem(
                  child: Text('Job Listing'),
                  value: 'job',
                ),
                DropdownMenuItem(
                  child: Text('Post'),
                  value: 'post',
                ),
              ],
              onChanged: (String? value) {
                // Handle dropdown value change
              },
            ),
            // Add form fields for creating a post or job listing
          ],
        ),
      ),
    );
  }
}
//
class JobDetailPage extends StatelessWidget {
  final Job job;

  const JobDetailPage({Key? key, required this.job}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(job.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 200,
              child: Image.asset(
                job.photo,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Title: ${job.title}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),
            ),
            SizedBox(height: 8),
            Text(
              'Location: ${job.location}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 8),
            Text(
              'Salary: \$${job.salary.toString()}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 8),
            Text(
              'Description: ${job.description}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ApplyNowPage(job: job, id: job.id),
                  ),
                );
              },
              child: Text('Apply Now'),
            ),
          ],
        ),
      ),
    );
  }
}


// Other widget classes such as ApplyNowPage, JobDetailPage, etc.

class CustomPageRoute<T> extends PageRouteBuilder<T> {
  final WidgetBuilder builder;

  CustomPageRoute({required this.builder})
      : super(
    pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
      return builder(context);
    },
    transitionsBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
      return SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(1.0, 0.0),
          end: Offset.zero,
        ).animate(animation),
        child: child,
      );
    },
  );
}

// Other widget classes such as PostApp, ApplyNowPage, etc.
