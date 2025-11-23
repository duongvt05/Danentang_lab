import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: const Color.fromARGB(255, 202, 206, 85),
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const CircleAvatar(
                radius: 70.0,
                backgroundImage: AssetImage('images/avatar.png'),
              ),

              const Text(
                'Võ Thùy Dương',
                style: TextStyle(
                  fontFamily: 'Pacifico',
                  fontSize: 40.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const Text(
                'Student',
                style: TextStyle(
                  fontFamily: 'Source Sans Pro',
                  color: Color.fromARGB(255, 2, 104, 94),
                  fontSize: 22.0,
                  letterSpacing: 2.5,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(
                height: 20.0,
                width: 150.0,
                child: Divider(color: Colors.teal),
              ),

              Card(
                margin: const EdgeInsets.symmetric(
                  vertical: 10.0,
                  horizontal: 25.0,
                ),
                child: const ListTile(
                  leading: Icon(
                    Icons.phone,
                    color: Color.fromARGB(255, 2, 104, 94),
                  ),
                  title: Text(
                    '+84 342214003',
                    style: TextStyle(
                      color: Color.fromARGB(255, 2, 104, 94),
                      fontFamily: 'Source Sans Pro',
                      fontSize: 20.0,
                    ),
                  ),
                ),
              ),

              Card(
                margin: const EdgeInsets.symmetric(
                  vertical: 10.0,
                  horizontal: 25.0,
                ),
                child: const ListTile(
                  leading: Icon(
                    Icons.email,
                    color: Color.fromARGB(255, 2, 104, 94),
                  ),
                  title: Text(
                    'thuyduong@gmail.com',
                    style: TextStyle(
                      color: Color.fromARGB(255, 2, 104, 94),
                      fontSize: 20.0,
                      fontFamily: 'Source Sans Pro',
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
