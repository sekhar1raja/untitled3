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

  Candidate({
    required this.name,
    required this.location,
    required this.photo,
    required this.description,
    required this.salary,
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
    ),
    Candidate(
      name: 'John ',
      location: 'Los Angeles NY',
      photo: 'assets/job3.jpg',
      description: 'Creative graphic designer needed for designing captivating visual content.',
      salary: '150000',
    ),
    Candidate(
      name: 'Mark Smith',
      location: 'San Francisco, CA',
      photo: 'assets/job4.jpg',
      description: 'Skilled marketing specialist needed for planning and executing marketing campaigns.',
      salary: '140000',
    ),
    Candidate(
      name: 'Sam williams',
      location: 'Seattle, WA',
      photo: 'assets/job5.jpg',
      description: 'Talented UX/UI designer needed for creating intuitive and user-friendly interfaces.',
      salary: '99000',
    ),
    Candidate(
      name: 'Anna Doe',
      location: 'New York, NY',
      photo: 'assets/job6.jpg',
      description: 'Analytical data analyst needed for interpreting complex datasets and providing insights.',
      salary: '125000',
    ),
  ];

  final String title;

  CandidateListPage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: ListView(
        children: candidates.map((candidate) => CandidateCard(candidate: candidate)).toList(),
      ),
    );
  }
}

class CandidateCard extends StatelessWidget {
  final Candidate candidate;

  const CandidateCard({Key? key, required this.candidate}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
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
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 200,
                child: Image.asset(
                  candidate.photo,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Name: ${candidate.name}',
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
    );
  }
}

class CandidateDetailPage extends StatefulWidget {
  final Candidate candidate;

  const CandidateDetailPage({Key? key, required this.candidate}) : super(key: key);

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
              child: Image.asset(
                widget.candidate.photo,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Name: ${widget.candidate.name}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              'Description: ${widget.candidate.description}',
              style: const TextStyle(fontSize: 16,),
            ),
            const SizedBox(height: 8),
            Text(
              'Location: ${widget.candidate.location}',
              style: const TextStyle(fontSize: 16),
            ),
            Text(
              'Salary: ${widget.candidate.salary}',
              style: const TextStyle(fontSize: 16),
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
}


class ConnectButton extends StatefulWidget {
  final Candidate candidate;

  const ConnectButton({Key? key, required this.candidate}) : super(key: key);

  @override
  _ConnectButtonState createState() => _ConnectButtonState();
}

class _ConnectButtonState extends State<ConnectButton> {
  bool connected = false;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () {
        setState(() {
          connected = !connected;
        });
      },
      label: Text(connected ? 'Connected' : 'Connect'),
      icon: Icon(connected ? Icons.check : Icons.add),
      backgroundColor: connected ? Colors.green : Colors.blue,
    );
  }
}
