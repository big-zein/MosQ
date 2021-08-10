import 'package:flutter/material.dart';
import 'package:mosq/services/auth.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        title: Text('MosQ'),
        backgroundColor: Colors.blue[400],
        actions: [
          TextButton.icon(
            onPressed: () async {
              await _auth.signOut();
            },
            icon: Icon(Icons.person),
            label: Text('Logout'),
          )
        ],
      ),
      body: Container(
        child: Column(
          children: [
            Text('home'),
            ElevatedButton(
              onPressed: () async {
                await _auth.signOut();
              },
              child: Text("Logout"),
            ),
          ],
        ),
      ),
    );
  }
}
