import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Job.dart';
import 'main.dart';

class CreatePostScreen extends StatefulWidget {
  const CreatePostScreen({Key? key}) : super(key: key);

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class Feed {
  final String title;
  final String description;
  final String candidateId;

  Feed({
    required this.title,
    required this.description,
    required this.candidateId,
  });
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  int selectedOption = 0;
  final _formKey = GlobalKey<FormState>();
  final Map<String, dynamic> _formData = {};

  String? _message;

  void saveForm(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final data = Provider.of<Data>(context, listen: false);
      if (selectedOption == 0) {
        // Add job to the list
        Job newJob = Job(
          title: _formData['title'],
          location: _formData['location'],
          description: _formData['description'],
          photo: _formData['photo'],
          salary: _formData['salary'],
          id: '', // Assuming you have a field to store the ID of the job
        );
        data.posts.add(newJob); // Add newJob to the posts list
        setState(() {
          _message = "Job added";
        });
        Future.delayed(Duration(seconds: 2), () {
          setState(() {
            _message = null;
          });
        });
        Navigator.pop(context); // Go back to the previous screen
      } else {
        // Add feed to the list
        Feed newFeed = Feed(
          title: _formData['title'],
          description: _formData['description'],
          candidateId: '1',
        );
        data.posts.add(newFeed); // Add newFeed to the posts list
        setState(() {
          _message = "Feed added";
        });
        Future.delayed(Duration(seconds: 0), () {
          setState(() {
            _message = "form sumbitted";
          });
        });
        Navigator.pop(context); // Go back to the previous screen
      }
    }
  }


  void switchCategory(int? value) {
    setState(() {
      selectedOption = value!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create Post')),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Radio<int>(
                        value: 0,
                        groupValue: selectedOption,
                        onChanged: switchCategory,
                      ),
                      const Text("Job")
                    ],
                  ),
                  const SizedBox(width: 80),
                  Row(
                    children: [
                      Radio<int>(
                        value: 1,
                        groupValue: selectedOption,
                        onChanged: switchCategory,
                      ),
                      const Text("Post")
                    ],
                  )
                ],
              ),
              if (selectedOption == 0) ...[
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Title',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) =>
                    value!.isEmpty ? 'Please enter a title' : null,
                    onSaved: (newValue) => _formData['title'] = newValue,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Location',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) =>
                    value!.isEmpty ? 'Please enter a location' : null,
                    onSaved: (newValue) => _formData['location'] = newValue,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Description',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) => value!.isEmpty
                        ? 'Please enter a description'
                        : null,
                    onSaved: (newValue) =>
                    _formData['description'] = newValue,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Photo URL',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) =>
                    value!.isEmpty ? 'Please enter a photo URL' : null,
                    onSaved: (newValue) => _formData['photo'] = newValue,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Salary',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) =>
                    value!.isEmpty ? 'Please enter a salary' : null,
                    onSaved: (newValue) =>
                    _formData['salary'] = double.parse(newValue!),
                  ),
                ),
              ],
              if (selectedOption == 1) ...[
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Title',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) =>
                    value!.isEmpty ? 'Please enter a title' : null,
                    onSaved: (newValue) => _formData['title'] = newValue,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Description',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) => value!.isEmpty
                        ? 'Please enter a description'
                        : null,
                    onSaved: (newValue) =>
                    _formData['description'] = newValue,
                  ),
                ),
              ],
              ElevatedButton(
                onPressed: () => saveForm(context), // Pass context to saveForm
                child: const Text('ADD'),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}