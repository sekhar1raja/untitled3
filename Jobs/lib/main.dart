import 'package:flutter/material.dart';

import 'Job.dart';
import 'allPost.dart';
import 'candidatedetails.dart' show Candidate, CandidateDetailPage, CandidateListPage;
import 'contactpage.dart';
import 'detailpage.dart';
import 'home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

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

  JobListPage({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          title,
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Expanded(
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
                          Fade(
                            builder: (context) => postApp(),
                          ),
                        );
                      },
                      child: const Text(
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
                foregroundColor: Colors.white, backgroundColor: Colors.blue, // Text color
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24), // Button padding
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8), // Button border radius
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.person), // Icon
                  SizedBox(width: 8), // Space between icon and text
                  Text('Candidate Details'), // Text
                ],
              ),
            ),

          ),
        ],
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
            CustomPageRoute(
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
              const SizedBox(height: 16),
              Text(
                'Title: ${job.title}',
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),
              ),
              const SizedBox(height: 8),
              Text(
                'Location: ${job.location}',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 8),
              Text(
                'Salary: \$${job.salary.toString()}',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 8),
              Text(
                'Description: ${job.description}',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 16),
              const SizedBox(height: 16),
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
                    child: const Text('Apply Now'),
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
