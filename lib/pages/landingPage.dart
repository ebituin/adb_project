import 'package:adb_project/pages/homePage.dart';
import 'package:flutter/material.dart';

class LandingPage extends StatefulWidget {
  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFf5effe),
      appBar: AppBar(
        title: Text("Landing Page"),
      ),
      body: Center(
        child: Column(
          children: [
            Text('Landing page'),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ShopListPage()));
                });
              },
              child: Text(
                'login'
              ))
          ],
        ),

      ),
    );
  }
}

