import 'package:flutter/material.dart';
import 'package:logging/login.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ShoeHomePage(),
    );
  }
}

class ShoeHomePage extends StatelessWidget {
  final List<Map<String, String>> shoes = [
    {
      'name': 'Sneaker X',
      'price': '\$120',
      'image': 'assets/images/shoe1.jpg'
    },
    {
      'name': 'Running Pro',
      'price': '\$150',
      'image': 'assets/images/shoe2.jpg'
    },
    {
      'name': 'Casual Kick',
      'price': '\$80',
      'image': 'assets/images/shoe3.png'
    },
  ];

  ShoeHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Image.asset(
              'assets/images/nike.jpg', 
              fit: BoxFit.cover,
            ),
          ),
          // Foreground content
          Center(
            child: Column(
              children: [
                AppBar(
                  title: const Text("My Shoes App",
                   style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                   ),
                  ),
                  backgroundColor: Color.fromARGB(167, 51, 214, 225),
                  elevation: 7,
                  shadowColor: const Color.fromARGB(255, 33, 47, 243),
                ),
                const SizedBox(height: 30,),
                Expanded(
                  child: ListView.builder(
                    itemCount: shoes.length,
                    itemBuilder: (context, index) {
                      final shoe = shoes[index];
                      return Card(
                        elevation: 5,
                        margin: const EdgeInsets.all(10),
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(10),
                          leading: Image.network(
                            shoe['image']!,
                            width: 80,
                            height: 80,
                            fit: BoxFit.cover,
                          ),
                          title: Text(shoe['name']!),
                          subtitle: Text(shoe['price']!),
                          trailing: Icon(Icons.arrow_forward_ios),
                        ),
                      );
                    },
                  ),
                ),
                 ElevatedButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: ((context) => const LoginPage())));
                    },
                    child: const Text('Logout'),
                  ),
              ]
            ),
          ),
        ],
      ),
    );
  }
}