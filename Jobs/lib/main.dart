import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Job.dart';
import 'allPost.dart';
import 'candidatedetails.dart'; // Assuming CandidateListPage is defined in candidatedetails.dart
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

class Data extends ChangeNotifier {
  List<dynamic> posts = [
    Job(
      id: '7',
      title: 'Web Developer',
      location: 'Remote',
      description: 'Looking for a skilled web developer to join our team.',
      photo: 'assets/job1.jpg.jpg',
      salary: 85000,
    ),
    Job(
      id: '8',
      title: 'Html Developer',
      location: 'Remote',
      description: 'Looking for a skilled Frontedn developer to join our team.',
      photo: 'assets/job1.jpg.jpg',
      salary: 85000,
    ),

    Feed(
      title: 'Lifeguard- job post',
      description: 'H2O Lifeguard and Recreation Management',
      candidateId: '2',
    ),
    Feed(
      title: 'Looking for Roommate',
      description: 'I am looking for a roommate to share my apartment.',
      candidateId: '3',
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

  ), // Add other jobs here...

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
        if (post is Job) {
          return ListTile(
            title: Text(post.title),
            subtitle: Text(post.description),
          );
        } else if (post is Feed) {
          return ListTile(
            title: Text(post.title),
            subtitle: Text(post.description),
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
