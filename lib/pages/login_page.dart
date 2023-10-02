import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../Components/my_text_field.dart';
import '../Components/my_button.dart';
import '../Components/square_button.dart';
import '../Components/loading.dart';
import 'home_page.dart';
import 'signup.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool loading = false;

  Future<void> signUserIn() async {
    final String username = emailController.text;
    final String password = passwordController.text;

    setState(() {
      loading = true;
    });

    try {
      // Sign in the user with Firebase Authentication
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: username,
        password: password,
      );

      // Print success message
      print('User signed in successfully!');

      // Navigate to the homepage
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(),
        ),
      );
    } catch (e) {
      // Print error message
      print('Error signing in: $e');
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Login Failed'),
          content: Text('Incorrect Email or  password .'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        ),
      );

    } finally {
      setState(() {
        loading = false;
      });
    }
  }

  Future<void> googleSignIn() async {
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

      // Print success message
      print('User signed in with Google successfully!');

      // Navigate to the homepage
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(),
        ),
      );
    } catch (e) {
      // Print error message
      print('Error signing in with Google: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    bool showError = false;
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
            const Text(
              'Welcome to VTravel',
              style: TextStyle(
                color: Color(0xFF000040),
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 25),
            //username
            MyTextField(
              controller: emailController,
              hintText: 'E-mail',
              obscureText: false,
            ),
            const SizedBox(height: 25),
            //password
            MyTextField(
              controller: passwordController,
              hintText: 'Password',
              obscureText: true,
            ),
            //forgot password!
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Forgot Password?',
                    style: TextStyle(
                      color: Color(0xFF000040),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 25),
            //sign in
            MyButton(
              onPressed: () {
                if ( emailController.text.isNotEmpty &&
                    passwordController.text.isNotEmpty) {
                  signUserIn();
                }
              },
              text: 'Sign In',
            ),
            const SizedBox(height: 50),


            Container(),
            const SizedBox(height: 50),
            Row(
              children: [
                Expanded(
                  child: Divider(
                    thickness: 0.5,
                    color: Colors.grey[200],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Text(
                    'Or sign in with',
                    style: TextStyle(color: Color(0xFF000040)),
                  ),
                ),
                Expanded(
                  child: Divider(
                    thickness: 0.5,
                    color: Colors.grey[800],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: googleSignIn,
                  child: SquareButton(imagePath: 'lib/images/google.png'),
                ),
                const SizedBox(width: 10),
              ],
            ),
            //register now
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Don\'t have an account?',
                  style: TextStyle(
                    color: Color(0xFF000040),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SignupPage(),
                      ),
                    );
                  },
                  child: Text(
                    'Register Now',
                    style: TextStyle(
                      color: Color(0xFF000040),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      ),
    );
  }
}
