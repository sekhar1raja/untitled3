import 'package:flutter/material.dart';

class ApplicationConfirmationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Delay navigation to the main page by 6 seconds
    Future.delayed(Duration(seconds: 6), () {
      Navigator.pop(context);
    });

    return Scaffold(
      appBar: AppBar(
        title: Text('Application Submitted'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.check_circle, size: 100, color: Colors.green),
            SizedBox(height: 20),
            Text(
              'Your application has been submitted successfully!',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
