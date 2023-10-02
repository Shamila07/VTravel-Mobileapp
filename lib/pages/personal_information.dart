import 'package:flutter/material.dart';

class PersonalInformationPage extends StatefulWidget {
  final String firstname;
  final String surname;
  final String email;

  PersonalInformationPage({
    required this.firstname,
    required this.surname,
    required this.email,
  });

  @override
  _PersonalInformationPageState createState() => _PersonalInformationPageState();
}

class _PersonalInformationPageState extends State<PersonalInformationPage> {
  TextEditingController _firstnameController = TextEditingController();
  TextEditingController _surnameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _firstnameController.text = widget.firstname;
    _surnameController.text = widget.surname;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Information'),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: _firstnameController,
              decoration: InputDecoration(
                labelText: 'Firstname',
              ),
            ),
            TextFormField(
              controller: _surnameController,
              decoration: InputDecoration(
                labelText: 'Surname',
              ),
            ),
            Text('Email: ${widget.email}'),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // Perform the update operation here
                String updatedFirstname = _firstnameController.text.trim();
                String updatedSurname = _surnameController.text.trim();
                // Update the data in Firestore or any other storage
                // ...

                // Show a success message or perform any other action
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('User data updated successfully!'),
                  ),
                );
              },
              child: Text('Update'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _firstnameController.dispose();
    _surnameController.dispose();
    super.dispose();
  }
}
