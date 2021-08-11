import 'package:flutter/material.dart';
import 'package:mosq/services/auth.dart';

class Home extends StatelessWidget {
  final _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        title: Text('MosQ'),
        backgroundColor: Colors.blue[400],
        actions: [
          IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                          title: Text('Logout'),
                          actions: [
                            TextButton(
                              child: Text('Batal'),
                              onPressed: () => Navigator.pop(context),
                            ),
                            TextButton(
                              child: Text('Logout'),
                              onPressed: () async {
                                Navigator.pop(context);
                                await _auth.signOut();
                              },
                            ),
                          ],
                        ));
              },
              icon: Icon(Icons.logout))
        ],
      ),
      body: Container(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/inventaris/index');
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
