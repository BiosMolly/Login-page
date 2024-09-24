import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:responsive_builder/responsive_builder.dart';

class SignupPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();

  SignupPage({super.key});

  // Updated signup logic with Firebase Auth
  Future<void> signupUser(BuildContext context) async {
    try {
      // Create user using FirebaseAuth
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: emailController.text.trim(),
              password: passwordController.text.trim());

      // Update user display name
      await userCredential.user?.updateDisplayName(nameController.text.trim());

      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Signup successful')));
      
      // Redirect to the home page or login after successful signup
      Navigator.pushNamed(context, '/home');

    } on FirebaseAuthException catch (e) {
      String errorMessage;
      if (e.code == 'weak-password') {
        errorMessage = 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        errorMessage = 'The account already exists for that email.';
      } else {
        errorMessage = 'Signup failed. Please try again.';
      }
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(errorMessage)));
    } catch (e) {
      
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('An error occurred. Please try again.')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sign Up')),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/back2.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: ResponsiveBuilder(
          builder: (context, sizingInformation) {
            double padding = sizingInformation.isDesktop ? 200 : 20;
            return Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: padding),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Sign Up',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    // Name field
                    TextFormField(
                      controller: nameController,
                      decoration: InputDecoration(
                        labelText: 'Name',
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        filled: true,
                        fillColor: Colors.amberAccent,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                          borderSide: const BorderSide(
                            width: 0,
                            style: BorderStyle.none,
                          ),
                        ),
                      ),
                      maxLines: 1,
                      keyboardType: TextInputType.name,
                    ),
                    const SizedBox(height: 10),
                    // Email field
                    TextFormField(
                      controller: emailController,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        filled: true,
                        fillColor: Colors.amberAccent,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: const BorderSide(
                            width: 0,
                            style: BorderStyle.none,
                          ),
                        ),
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 10),
                    // Password field
                    TextFormField(
                      controller: passwordController,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        filled: true,
                        fillColor: Colors.amberAccent,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: const BorderSide(
                            width: 0,
                            style: BorderStyle.none,
                          ),
                        ),
                      ),
                      obscureText: true,
                    ),
                    const SizedBox(height: 20),
                    // Signup button
                    ElevatedButton(
                      onPressed: () {
                        signupUser(context);
                      },
                      child: const Text('Sign Up'),
                    ),
                    const SizedBox(height: 20),
                    // Redirect to login
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/login');
                      },
                      child: const Text(
                        'Already have an account? Login',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
