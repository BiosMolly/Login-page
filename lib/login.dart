import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:logging/Home.dart';
import 'package:responsive_builder/responsive_builder.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String? errorMessage;

  Future<void> loginUser(BuildContext context) async {
    // Validate form before proceeding with login
    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        errorMessage = null;
      });

      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        );

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Login successful')),
        );

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => ShoeHomePage()),
        );
      } on FirebaseAuthException catch (e) {
        switch (e.code) {
          case 'invalid-email':
            setState(() {
              errorMessage = 'The email address is invalid.';
            });
            break;
          case 'user-not-found':
            setState(() {
              errorMessage = 'No user found with this email.';
            });
            break;
          case 'wrong-password':
            setState(() {
              errorMessage = 'Incorrect password. Please try again.';
            });
            break;
          case 'user-disabled':
            setState(() {
              errorMessage = 'This user account has been disabled.';
            });
            break;
          default:
            setState(() {
              errorMessage = 'An error occurred. Please try again.';
            });
        }
      } catch (e) {
        setState(() {
          errorMessage = 'An error occurred. Please try again later.';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/backk.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: ResponsiveBuilder(
          builder: (context, sizingInformation) {
            double padding = sizingInformation.isDesktop ? 250 : 20;
            return Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: padding),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Please Login',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 20),

                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: emailController,
                            decoration: InputDecoration(
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                              filled: true,
                              fillColor: Colors.amberAccent,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: const BorderSide(
                                    width: 0,
                                    style: BorderStyle.none,
                                  )),
                              labelText: 'Email',
                            ),
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Email is required'; // Validation: Required email
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 15),
                          TextFormField(
                            controller: passwordController,
                            decoration: InputDecoration(
                            labelText: 'Password',
                                 floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                              filled: true,
                              fillColor: Colors.amberAccent,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: const BorderSide(
                                    width: 0,
                                    style: BorderStyle.none,
                                  )),
                            
                            ),
                            obscureText: true,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Password is required'; // Validation: Required password
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Login button
                    ElevatedButton(
                      onPressed: () {
                        loginUser(context);
                      },
                      style: const ButtonStyle(
                      ),
                      child: const Text('Login',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20
                      ),
                      ),
                    ),

                    if (errorMessage != null) ...[
                      const SizedBox(height: 20),
                      Text(
                        errorMessage!,
                        style: const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                      ),
                    ],

                    const SizedBox(height: 60),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/signup');
                      },
                      child: const Text('Don\'t have an account? Sign Up',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/reset-password');
                      },
                      child: const Text('Forgot Password?',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.bold
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
