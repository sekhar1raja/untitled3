import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


enum PostType { JobListing, GeneralPost }

class Post {
  final String title;
  final String location;
  final double salary;
  final String description;
  final String imagePath;
  final PostType type;

  Post({
    required this.title,
    required this.location,
    required this.salary,
    required this.description,
    required this.imagePath,
    required this.type,
  });
}

class PostForm extends StatefulWidget {
  final Function(Post) onFormSubmit;

  PostForm({Key? key, required this.onFormSubmit}) : super(key: key);

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

  PostType _selectedPostType = PostType.JobListing;

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
              DropdownButtonFormField<PostType>(
                value: _selectedPostType,
                onChanged: (PostType? value) {
                  setState(() {
                    _selectedPostType = value!;
                  });
                },
                items: PostType.values.map((type) {
                  return DropdownMenuItem<PostType>(
                    value: type,
                    child: Text(type == PostType.JobListing ? 'Job Listing' : 'General Post'),
                  );
                }).toList(),
                decoration: InputDecoration(
                  labelText: 'Select Post Type',
                ),
              ),
              SizedBox(height: 16),
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
              if (_selectedPostType == PostType.JobListing)
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
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    String title = _titleController.text;
                    String location = _locationController.text;
                    double salary = _selectedPostType == PostType.JobListing ? double.parse(_salaryController.text) : 0.0;
                    String description = _descriptionController.text;
                    String imagePath = _imagePathController.text;

                    Post newPost = Post(
                      title: title,
                      location: location,
                      salary: salary,
                      description: description,
                      imagePath: imagePath,
                      type: _selectedPostType,
                    );

                    // Save the form data using shared preferences
                    SharedPreferences prefs = await SharedPreferences.getInstance();
                    await prefs.setString('title', title);
                    await prefs.setString('location', location);
                    await prefs.setDouble('salary', salary);
                    await prefs.setString('description', description);
                    await prefs.setString('imagePath', imagePath);
                    await prefs.setInt('postType', _selectedPostType.index);

                    // Call the onFormSubmit function provided by the parent widget
                    widget.onFormSubmit(newPost);

                    // Clear the form fields
                    _titleController.clear();
                    _locationController.clear();
                    _salaryController.clear();
                    _descriptionController.clear();
                    _imagePathController.clear();

                    // Navigate back to the previous screen
                    Navigator.pop(context);
                  }
                },
                child: Text('Submit'),
              ),
              // Image widget...
            ],
          ),
        ),
      ),
    );
  }
}