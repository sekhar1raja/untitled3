import 'package:flutter/material.dart';

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
  final String category;
  final List<String> skills;

  Candidate({
    required this.name,
    required this.location,
    required this.photo,
    required this.description,
    required this.salary,
    required this.category,
    required this.skills,
  });
}

class CandidateListPage extends StatelessWidget {
  final List<Candidate> candidates = [
    Candidate(
      name: 'Emma',
      location: 'Chicago, IL',
      photo: 'assets/job1.jpg',
      description: 'Experienced software engineer needed for developing cutting-edge applications.',
      salary: '250000',
      category: 'Software Developer',
      skills: ['Digital Marketing', 'SEO', 'Google Analytics'],
    ),
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

  CandidateListPage({required this.title});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text(title),
          actions: [
            IconButton(
              icon: Icon(Icons.person),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CandidateDetailPage(candidate: candidates[0]),
                  ),
                );
              },
            ),
          ],
          bottom: TabBar(
            tabs: [
              Tab(text: 'All'),
              Tab(text: 'UI/UX Design'),
              Tab(text: 'Software Developer'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            ListView(
              children: candidates.map((candidate) => CandidateCard(candidate: candidate)).toList(),
            ),
            ListView(
              children: candidates.where((candidate) => candidate.category == 'UI/UX Design').map((candidate) => CandidateCard(candidate: candidate)).toList(),
            ),
            ListView(
              children: candidates.where((candidate) => candidate.category == 'Software Developer').map((candidate) => CandidateCard(candidate: candidate)).toList(),
            ),
          ],
        ),
      ),
    );
  }
}

class CandidateCard extends StatelessWidget {
  final Candidate candidate;

  const CandidateCard({required this.candidate});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CandidateDetailPage(candidate: candidate),
            ),
          );
        },
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        candidate.name,
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Location: ${candidate.location}',
                        style: TextStyle(fontSize: 16),
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

class CandidateDetailPage extends StatelessWidget {
  final Candidate candidate;

  const CandidateDetailPage({required this.candidate});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(candidate.name),
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
                      candidate.photo,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    bottom: 10,
                    left: 10,
                    child: Text(
                      'Location: ${candidate.location}',
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
            SizedBox(height: 16),
            Text(
              candidate.description,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              'Skills:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Wrap(
              spacing: 8,
              children: candidate.skills.map((skill) {
                return Chip(
                  label: Text(skill),
                  backgroundColor: Colors.blue,
                  labelStyle: TextStyle(color: Colors.white),
                );
              }).toList(),
            ),
            SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PostForm(),
                  ),
                );
              },
              icon: Icon(Icons.bolt),
              label: Text('Post'),
            ),
          ],
        ),
      ),
    );
  }
}

class PostForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Post Form'),
      ),
      body: Center(
        child: Text('Post Form'),
      ),
    );
  }
}
