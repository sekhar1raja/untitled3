import 'package:flutter/material.dart';

class ConnectPage extends StatelessWidget {
  const ConnectPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Connect with Candidates'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Search functionality (you can replace this with your own search UI)
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search for candidates...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
            ),
          ),
          // List of candidates (you can replace this with your candidate list UI)
          Expanded(
            child: ListView.builder(
              itemCount: 3, // Example: replace with actual candidate data
              itemBuilder: (context, index) {
                // Example candidate tile
                return ListTile(
                  title: Text('Candidate Name'),
                  subtitle: Text('Job Title, Location'),
                  // Example: navigate to candidate profile
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CandidateProfile()),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// Example candidate profile page
class CandidateProfile extends StatelessWidget {
  const CandidateProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Candidate Profile'),
      ),
      body: Center(
        child: Text('Candidate Profile'),
      ),
    );
  }
}
