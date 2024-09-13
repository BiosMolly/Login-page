// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// class HomePage extends StatelessWidget {
//   const HomePage({super.key});

//   Future<void> logout(BuildContext context) async {
//     await FirebaseAuth.instance.signOut();
//     Navigator.pushReplacementNamed(context, '/login');
//   }

//   @override
//   Widget build(BuildContext context) {
//     // Get the current logged-in user
//     User? user = FirebaseAuth.instance.currentUser;

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Home Page'),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.logout),
//             onPressed: () {
//               logout(context); // Logout button
//             },
//           ),
//         ],
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               'Welcome, ${user?.email ?? 'User'}!',
//               style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () {
//                 logout(context); // Button to log out
//               },
//               child: const Text('Log Out'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
