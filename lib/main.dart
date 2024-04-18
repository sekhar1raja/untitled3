import 'package:flutter/material.dart';
import 'detailpage.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: JobListPage(title: 'Job Details'), // Pass the title here
    );
  }
}

class Job {
  final String title;
  final String location;
  final String description;
  final String photo;
  final double salary;

  Job({
    required this.title,
    required this.location,
    required this.description,
    required this.photo,
    required this.salary,
  });
}

class JobListPage extends StatelessWidget {
  final List<Job> jobs = [
    Job(
      title: 'Software Engineer',
      location: 'San Francisco, CA',
      description: 'Experienced software engineer needed for developing cutting-edge applications.',
      photo: 'assets/job1.jpg',
      salary: 100000,
    ),
    Job(
      title: 'Graphic Designer',
      location: 'New York, NY',
      description: 'Creative graphic designer needed for designing captivating visual content.',
      photo: 'assets/clay-elliot.jpg',
      salary: 80000,
    ),
    Job(
      title: 'Marketing Specialist',
      location: 'Chicago, IL',
      description: 'Skilled marketing specialist needed for planning and executing marketing campaigns.',
      photo: 'assets/job3.jpg',
      salary: 75000,
    ),
    Job(
      title: 'Data Analyst',
      location: 'Los Angeles, CA',
      description: 'Analytical data analyst needed for interpreting complex datasets and providing insights.',
      photo: 'assets/job4.jpg',
      salary: 85000,
    ),
    Job(
      title: 'UX/UI Designer',
      location: 'Seattle, WA',
      description: 'Talented UX/UI designer needed for creating intuitive and user-friendly interfaces.',
      photo: 'assets/job5.jpg',
      salary: 90000,
    ),
    Job(
      title: 'Project Manager',
      location: 'Austin, TX',
      description: 'Organized project manager needed for overseeing project timelines and deliverables.',
      photo: 'assets/job6.jpg',
      salary: 95000,
    ),
  ];

  final String title; // Add a title parameter

  JobListPage({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title), // Use the passed title here
      ),
      body: ListView.builder(
        itemCount: jobs.length,
        itemBuilder: (context, index) {
          final job = jobs[index];
          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => JobDetailPage(job: job),
                ),
              );
            },
            child: JobDetailCard(job: job),
          );
        },
      ),
    );
  }
}

class JobDetailCard extends StatefulWidget {
  final Job job;

  const JobDetailCard({Key? key, required this.job}) : super(key: key);

  @override
  _JobDetailCardState createState() => _JobDetailCardState();
}

class _JobDetailCardState extends State<JobDetailCard> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 200,
              child: HoverWidget(
                onHover: (value) {
                  setState(() {
                    _hovering = value;
                  });
                },
                child: Transform.scale(
                  scale: _hovering ? 1.1 : 1.0,
                  child: Image.asset(
                    widget.job.photo,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Title: ${widget.job.title}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Location: ${widget.job.location}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text(
              'Salary: \$${widget.job.salary.toString()}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text(
              'Description: ${widget.job.description}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

class HoverWidget extends StatefulWidget {
  final Widget child;
  final ValueChanged<bool> onHover;

  HoverWidget({required this.child, required this.onHover});

  @override
  _HoverWidgetState createState() => _HoverWidgetState();
}

class _HoverWidgetState extends State<HoverWidget> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (event) {
        widget.onHover(true);
        setState(() {
          _isHovered = true;
        });
      },
      onExit: (event) {
        widget.onHover(false);
        setState(() {
          _isHovered = false;
        });
      },
      child: widget.child,
    );
  }
}
