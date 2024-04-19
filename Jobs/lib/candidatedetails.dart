import 'package:flutter/material.dart';
import 'Job.dart';
import 'allPost.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CandidateListPage(title: 'Candidates'),
    );
  }
}

class Candidate {
  final String name;
  final String location;
  final String photo;
  final String description;
  final String salary;
  final String category; // Add category property
  final List<String> skills;

  Candidate({
    required this.name,
    required this.location,
    required this.photo,
    required this.description,
    required this.salary,
    required this.category, // Initialize category property
    required this.skills,
  });
}

class CandidateListPage extends StatelessWidget {
  final List<Candidate> candidates = [
    // Add candidates with categories
    Candidate(
      name: 'Emma',
      location: 'Chicago, IL',
      photo: 'assets/job1.jpg',
      description: 'Experienced software engineer needed for developing cutting-edge applications.',
      salary: '250000',
      category: 'Software Developer',
      skills: ['Digital Marketing', 'SEO', 'Google Analytics'],

    ),
    // Add other candidates with categories
    Candidate(
      name: 'John ',
      location: 'Los Angeles NY',
      photo: 'assets/job3.jpg',
      description: 'Creative graphic designer needed for designing captivating visual content.',
      salary: '150000',
      category: 'UI/UX Design',
      skills: ['Adobe Illustrator', 'Adobe Photoshop', 'Sketch'],

    ),
    Candidate(
      name: 'Mark Smith',
      location: 'San Francisco, CA',
      photo: 'assets/job4.jpg',
      description: 'Skilled marketing specialist needed for planning and executing marketing campaigns.',
      salary: '140000',
      category: 'Software Developer',
      skills: ['Data Analysis', 'SQL', 'Machine Learning'],
    ),
    Candidate(
      name: 'Sam williams',
      location: 'Seattle, WA',
      photo: 'assets/job5.jpg',
      description: 'Talented UX/UI designer needed for creating intuitive and user-friendly interfaces.',
      salary: '99000',
      category: 'UI/UX Design',
      skills: ['UI Design', 'UX Research', 'Wireframing'],
    ),
    Candidate(
      name: 'Anna Doe',
      location: 'New York, NY',
      photo: 'assets/job6.jpg',
      description: 'Analytical data analyst needed for interpreting complex datasets and providing insights.',
      salary: '125000',
      category: 'Software Developer',
      skills: ['Java', 'Python', 'Flutter'],
    ),
  ];

  final String title;

  CandidateListPage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3, // Number of tabs
      child: Scaffold(
        appBar: AppBar(
          title: Text(title),
          bottom: TabBar(
            tabs: [
              Tab(text: 'All'), // Add tabs for each category
              Tab(text: 'UI/UX Design'),
              Tab(text: 'Software Developer'),
              // Add tabs for other categories
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // Add views for each tab
            ListView(
              children: candidates
                  .map((candidate) => CandidateCard(candidate: candidate, onPostsUpdated: (jobPosts, generalPosts) {}))
                  .toList(),
            ),

            // Add views for other categories
            ListView(
              children: candidates
                  .where((candidate) => candidate.category == 'UI/UX Design')
                  .map((candidate) => CandidateCard(candidate: candidate, onPostsUpdated: (jobPosts, generalPosts) {}))
                  .toList(),
            ),
            ListView(
              children: candidates
                  .where((candidate) => candidate.category == 'Software Developer')
                  .map((candidate) => CandidateCard(candidate: candidate, onPostsUpdated: (jobPosts, generalPosts) {}))
                  .toList(),
            ),
            // Add views for other categories
          ],
        ),
      ),
    );
  }
}


class CandidateCard extends StatelessWidget {
  final Candidate candidate;
  final Function(List<Post>, List<Post>) onPostsUpdated; // Define the callback function here

  const CandidateCard({Key? key, required this.candidate, required this.onPostsUpdated}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CandidateDetailPage(candidate: candidate, onPostsUpdated: onPostsUpdated), // Pass the callback function here
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Column for the photo in a circle
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage(candidate.photo),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
              // Column for the name and location
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        candidate.name,
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Location: ${candidate.location}',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



class CandidateDetailPage extends StatefulWidget {
  final Candidate candidate;
  final Function(List<Post>, List<Post>) onPostsUpdated;

  const CandidateDetailPage({Key? key, required this.candidate, required this.onPostsUpdated}) : super(key: key);

  @override
  _CandidateDetailPageState createState() => _CandidateDetailPageState();
}



class _CandidateDetailPageState extends State<CandidateDetailPage> {
  bool connected = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.candidate.name),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 200,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Image.asset(
                      widget.candidate.photo,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    bottom: 10,
                    left: 10,
                    child: Text(
                      'Location: ${widget.candidate.location}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                widget.candidate.description,
                style: TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Skills:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Wrap(
                spacing: 8,
                children: _buildSkillChips(),
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Experience:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Add experience details here...', // Replace with actual experience details
                style: TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Education:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Add education details here...', // Replace with actual education details
                style: TextStyle(fontSize: 16),
              ),
            ),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PostForm(
                      onFormSubmit: (post) {
                        setState(() {
                          if (post.type == PostType.JobListing) {
                            widget.onPostsUpdated([post], []); // Update home screen with the new post
                          } else {
                            widget.onPostsUpdated([], [post]); // Update home screen with the new post
                          }
                        });
                      },
                    ),
                  ),
                );
              },
              icon: Icon(Icons.bolt),
              label: Text('Post'),
            ),


          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          setState(() {
            connected = !connected;
          });
        },
        label: Text(connected ? 'Connected' : 'Connect'),
        icon: Icon(connected ? Icons.check : Icons.add),
        backgroundColor: connected ? Colors.green : Colors.blue,
      ),
    );
  }

  List<Widget> _buildSkillChips() {
    return widget.candidate.skills.map((skill) {
      return Chip(
        label: Text(skill),
        backgroundColor: Colors.blue,
        labelStyle: TextStyle(color: Colors.white),
      );
    }).toList();
  }
}

