import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:travel_app/pages/login_page.dart';
import '../Components/my_text_field.dart';
import '../Components/my_button.dart';
import '../Components/square_button.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignupPage extends StatefulWidget {
  final VoidCallback? onLogin;
  const SignupPage({Key? key, this.onLogin}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final firstnameController = TextEditingController();
  final surnameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  Future<void> signUp() async {
    final String firstname = firstnameController.text.trim();
    final String surname = surnameController.text.trim();
    final String email = emailController.text.trim();
    final String password = passwordController.text.trim();
    final String confirmPassword = confirmPasswordController.text.trim();

    try {
      // Get a reference to the "users" collection in the "Vtravel" Firestore database
      CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');
      // Create a new document in the "users" collection with the user data
      await usersCollection.add({
        'firstname': firstname,
        'surname': surname,
        'email': email,
        'password': password,
        'confirmPassword': confirmPassword,
      });

      // Authenticate user
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Add user details to Firestore
      await addUserDetails(firstname, surname, email, password, confirmPassword);

      // Print success message
      print('User data added to Firestore successfully!');
    } catch (e) {
      // Print error message
      print('Error adding user data to Firestore: $e');
    }
  }


  Future<void> addUserDetails(
      String firstname, String surname, String email, String password, String confirmPassword) async {
    await FirebaseFirestore.instance.collection("users").add(
      {
        "firstname": firstname,
        "surname": surname,
        "email": email,
        "password": password,
        "confirmPassword": confirmPassword,
      },
    );
  }

  bool passwordConfirmed() {
    return passwordController.text.trim() == confirmPasswordController.text.trim();
  }

  void googleSignUp() async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn();
      final GoogleSignInAccount? googleAccount = await googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
      await googleAccount!.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential =
      await FirebaseAuth.instance.signInWithCredential(credential);

      final User? user = userCredential.user;

      // Get the user data
      final String firstname = user!.displayName ?? '';
      final String email = user.email ?? '';

      // Get a reference to the "users" collection in the Firestore database
      CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');

      // Create a new document in the "users" collection with the user data
      await usersCollection.doc(email).set({
        'firstname': firstname,
        'email': email,
      });

      // Print success message
      print('Google user data added to Firestore successfully!');
    } catch (e) {
      // Print error message
      print('Error adding Google user data to Firestore: $e');
    }
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed
    firstnameController.dispose();
    surnameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("lib/images/Welcome.jpg"),
            opacity: 0.4,
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 50),
              //logo
              Image.asset(
                "lib/images/Logo.png",
                width: 200,
                height: 80,
              ),
              const SizedBox(height: 50),
              Text(
                'Welcome to Vtravel',
                style: TextStyle(
                  color: Colors.blue.shade700,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              //username
              MyTextField(
                controller: firstnameController,
                hintText: 'Firstname',
                obscureText: false,
              ),
              const SizedBox(height: 20),
              //password
              MyTextField(
                controller: surnameController,
                hintText: 'Surname',
                obscureText: false,
              ),
              const SizedBox(height: 20),
              //password
              MyTextField(
                controller: emailController,
                hintText: 'email',
                obscureText: false,
              ),
              const SizedBox(height: 20),
              //password
              MyTextField(
                controller: passwordController,
                hintText: 'Password',
                obscureText: true,
              ),
              const SizedBox(height: 20),
              MyTextField(
                controller: confirmPasswordController,
                hintText: 'Confirm Password',
                obscureText: true,
              ),
              //forgot password!
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [],
                ),
              ),
              const SizedBox(height: 25),
              //sign in
              MyButton(
                onPressed: signUp,
                text: 'Sign Up',
              ),
              const SizedBox(height: 50),
              Row(
                children: [
                  Expanded(
                    child: Divider(
                      thickness: 0.5,
                      color: Colors.grey[700],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Text(
                      'Or sign up with',
                      style: TextStyle(color: Color(0xFF000040)),
                    ),
                  ),
                  Expanded(
                    child: Divider(
                      thickness: 0.5,
                      color: Colors.grey[400],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: googleSignUp,
                    child: SquareButton(
                      imagePath: 'lib/images/google.png',
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already have an account ?',
                    style: TextStyle(
                      color: Color(0xFF000040),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginPage(),
                        ),
                      );
                    },
                    child: Text(
                      'Login',
                      style: TextStyle(
                        color: Color(0xFF000040),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              //register now
            ],
          ),
        ),
      ),
    );
  }
}
