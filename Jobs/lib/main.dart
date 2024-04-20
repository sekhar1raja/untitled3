import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Job.dart';
import 'allPost.dart';
import 'candidatedetails.dart';
import 'job_deatil_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Find Job',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: ChangeNotifierProvider(
        create: (context) => Data(),
        child: const HomeScreen(),
      ),
    );
  }
}



class Post {
  final String username;
  final String title;
  final String content;
  final String imagePath;

  Post({
    required this.username,
    required this.title,
    required this.content,
    required this.imagePath,
  });
}

class Data extends ChangeNotifier {
  List<dynamic> posts = [
    Post(
      username: 'user123',
      imagePath: "assets/job1.jpg",
      title: 'Exploring the Grand Canyon',
      content:
      'Had an amazing time hiking through the Grand Canyon. The views were breathtaking!',
    ),
    Post(
      username: 'foodlover',
      imagePath: "assets/job2.jpg",
      title: 'Delicious Food Festival',
      content:
      'Attended a food festival today and tried some incredible dishes from around the world.',
    ),
    Post(
      username: 'beachbum',
      imagePath: "assets/job3.jpg",
      title: 'Beach Day',
      content:
      'Spent the day relaxing on the beach, soaking up the sun and listening to the sound of the waves.',
    ),
    Post(
      username: 'adventurer',
      imagePath: "assets/job4.jpg",
      title: 'Road Trip Adventure',
      content:
      'Embarked on an epic road trip with friends, exploring new cities and making unforgettable memories.',
    ),
    Post(
      username: 'hiker123',
      imagePath: "assets/job5.jpg",
      title: 'Mountain Hiking',
      content:
      'Conquered a challenging mountain trail today. The view from the summit was absolutely worth it!',
    ),
    Post(
      username: 'naturelover',
      imagePath: "assets/job6.jpg",
      title: 'Camping Under the Stars',
      content:
      'Spent the night camping under the stars. Nothing beats the feeling of being surrounded by nature.',
    ),
    Post(
      username: 'cityexplorer',
      imagePath: "assets/job6.jpg",
      title: 'City Skyline',
      content:
      'Took a stroll through the city at night and admired the beautiful skyline.',
    ),
    Post(
      username: 'historybuff',
      imagePath: "assets/job7.jpg",
      title: 'Exploring Ancient Ruins',
      content:
      'Visited some ancient ruins today and learned about the fascinating history behind them.',
    ),



  ];
}

final List<Job> jobs = [

  Job(

    id: '1',

    title: 'Software Engineer',

    location: 'San Francisco, CA',

    description: 'Experienced software engineer needed for developing cutting-edge applications.',

    photo: 'assets/soft.jpg',

    salary: 100000,

  ), Job(

    id: '2',

    title: 'Graphic Designer',

    location: 'New York, NY',

    description: 'Creative graphic designer needed for designing captivating visual content.',

    photo: 'assets/gra.jpg',

    salary: 80000,

  ),

  Job(

    id: '3',

    title: 'Marketing Specialist',

    location: 'Chicago, IL',

    description: 'Skilled marketing specialist needed for planning and executing marketing campaigns.',

    photo: 'assets/market.jpg',

    salary: 75000,

  ),

  Job(

    id: '4',

    title: 'Data Analyst',

    location: 'Los Angeles, CA',

    description: 'Analytical data analyst needed for interpreting complex datasets and providing insights.',

    photo: 'assets/dt.jpg',

    salary: 85000,

  ),

  Job(

    id: '5',

    title: 'UX/UI Designer',

    location: 'Seattle, WA',

    description: 'Talented UX/UI designer needed for creating intuitive and user-friendly interfaces.',

    photo: 'assets/ui.png',

    salary: 90000,

  ),

  Job(

    id: '6',

    title: 'Project Manager',

    location: 'Austin, TX',

    description: 'Organized project manager needed for overseeing project timelines and deliverables.',

    photo: 'assets/prg.jpg',

    salary: 95000,

  ),

];

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    const PostsTab(),
    const CreatePost(),
    const JobDetailsTab(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Find Job'),
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CandidateListPage(title: ''),
                ),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.create),
            label: 'Create Post',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.work),
            label: 'Job Details',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}

class PostsTab extends StatelessWidget {
  const PostsTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var data = Provider.of<Data>(context);
    return ListView.builder(
      itemCount: data.posts.length,
      itemBuilder: (context, index) {
        final post = data.posts[index];
        if (post is Post) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Card(
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundImage: AssetImage(post.imagePath),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            post.username,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 5),
                          Text(
                            post.title,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 5),
                          Text(post.content),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
        return SizedBox.shrink();
      },
    );
  }
}



class JobDetailsTab extends StatelessWidget {
  const JobDetailsTab({Key? key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: jobs.length,
      itemBuilder: (context, index) {
        final job = jobs[index];
        return ListTile(
          leading: CircleAvatar(
            backgroundImage: AssetImage(job.photo), // Use 'photo' instead of 'image'
          ),
          title: Text(job.title),
          subtitle: Row(
            children: [
              Icon(Icons.location_on, size: 18, color: Colors.grey),
              SizedBox(width: 4),
              Text(job.location),
            ],
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => JobDetailPage(job: job),
              ),
            );
          },
        );
      },
    );
  }
}

class CreatePost extends StatelessWidget {
  const CreatePost({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CreatePostScreen(),
          ),
        );
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          Image.asset(
            'assets/job1.jpg',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Positioned(
            bottom: 40,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CreatePostScreen(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              ),
              child: Text(
                'Create Post',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Positioned(
            top: 20,
            left: 20,
            child: Text(
              'Create Your Post',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
