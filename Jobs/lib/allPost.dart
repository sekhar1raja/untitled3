import 'package:flutter/material.dart';

class Post {
  final String title;
  final String location;
  final double salary;
  final String description;
  final String imagePath;

  Post({
    required this.title,
    required this.location,
    required this.salary,
    required this.description,
    required this.imagePath,
  });
}

class PostForm extends StatefulWidget {
  final Post? candidate;

  PostForm({Key? key, this.candidate}) : super(key: key);

  @override
  _PostFormState createState() => _PostFormState();
}

class _PostFormState extends State<PostForm> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _titleController = TextEditingController();
  TextEditingController _locationController = TextEditingController();
  TextEditingController _salaryController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _imagePathController = TextEditingController();

  // Define lists to store form data
  List<String> titles = [];
  List<String> locations = [];
  List<double> salaries = [];
  List<String> descriptions = [];
  List<String> imagePaths = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Post Form'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: 'Title',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _locationController,
                decoration: InputDecoration(
                  labelText: 'Location',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a location';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _salaryController,
                decoration: InputDecoration(
                  labelText: 'Salary',
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a salary';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(
                  labelText: 'Description',
                ),
                maxLines: null,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _imagePathController,
                decoration: InputDecoration(
                  labelText: 'Image Path',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an image path';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    String title = _titleController.text;
                    String location = _locationController.text;
                    double salary = double.parse(_salaryController.text);
                    String description = _descriptionController.text;
                    String imagePath = _imagePathController.text;

                    setState(() {
                      titles.add(title);
                      locations.add(location);
                      salaries.add(salary);
                      descriptions.add(description);
                      imagePaths.add(imagePath);
                    });

                    Navigator.pop(context);
                  }
                },

                child: Text('Submit'),
              ),
              SizedBox(height: 16),
              _imagePathController.text.isNotEmpty
                  ? Image.asset(
                _imagePathController.text,
                height: 100,
                width: 100,
                fit: BoxFit.cover,
              )
                  : SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}