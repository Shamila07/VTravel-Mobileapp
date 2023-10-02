import 'package:flutter/material.dart';
import 'package:travel_app/nav_pages/profile.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:travel_app/widgets/app_text.dart';

class ContactUs extends StatefulWidget {
  const ContactUs({Key? key}) : super(key: key);

  @override
  State<ContactUs> createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Profile()),
                    );
                  },
                  child: const Icon(Icons.arrow_back, size: 30, color: Colors.black),
                ),
                const SizedBox(width: 10),
                AppText(
                  text: 'Contact Us',
                  size: 24,
                ),
              ],
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Fill out the form below to contact us:',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Your Name',
                    ),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Email',
                    ),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Message',
                    ),
                    maxLines: 5,
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () => _sendEmail(),
                    child: Text('Send Email'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _sendEmail() async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: 'nylonwarner@gmail.com', // Replace with your email address
      queryParameters: {
        'subject': 'Contact Us', // Replace with your desired subject
        'body': 'Hello,\n\nI have a question:', // Replace with your desired email body
      },
    );

    if (await canLaunch(emailUri.toString())) {
      await launch(emailUri.toString());
    } else {
      // Handle error
      throw 'Could not launch email';
    }
  }
}




