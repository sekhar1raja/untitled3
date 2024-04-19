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

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Find Job',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: JobListPage(title: 'Find Job'),
    );
  }
}

final List<Job> jobs = [
  Job(
    id: '1',
    title: 'Software Engineer',
    location: 'San Francisco, CA',
    description: 'Experienced software engineer needed for developing cutting-edge applications.',
    photo: 'assets/soft.jpg',
    salary: 100000,
  ),
  Job(
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

class JobListPage extends StatelessWidget {
  final String title;

  const JobListPage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
          style: TextStyle(color: Colors.black),
        ),
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
                    child: Text(
                      "Jobs",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: SizedBox(
                  height: 50,
                  child: Center(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => PostApp()),
                        );
                      },
                      child: Text(
                        "Posts",
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: ListView(
              children: jobs.map((job) => JobDetailCard(job: job)).toList(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CandidateListPage(title: 'Candidates'),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white, backgroundColor: Colors.blue,
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.person),
                  SizedBox(width: 8),
                  Text('Candidate Details'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PostApp extends StatefulWidget {
  @override
  _PostAppState createState() => _PostAppState();
}

class _PostAppState extends State<PostApp> {
  String? title;
  String? location;
  double? salary;
  String? description;
  String? imagePath;

  @override
  void initState() {
    super.initState();
    // Retrieve data from shared preferences when the widget initializes
    _loadFormData();
  }

  // Function to load form data from shared preferences
  Future<void> _loadFormData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      title = prefs.getString('title');
      location = prefs.getString('location');
      salary = prefs.getDouble('salary');
      description = prefs.getString('description');
      imagePath = prefs.getString('imagePath');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Posts'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (title != null) Text('Title: $title'),
            if (location != null) Text('Location: $location'),
            if (salary != null) Text('Salary: $salary'),
            if (description != null) Text('Description: $description'),
            if (imagePath != null) Text('Image Path: $imagePath'),
          ],
        ),
      ),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
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
            ],
          ),
        ),
      ),
    );
  }
}
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
