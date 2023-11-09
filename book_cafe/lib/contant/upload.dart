import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyUpload());
}

class MyUpload extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final CollectionReference itemsCollection =
      FirebaseFirestore.instance.collection('table_coffee');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Firestore Example'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: itemsCollection.snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return CircularProgressIndicator();
          }
          final items = snapshot.data?.docs;

          return ListView.builder(
            itemCount: items?.length,
            itemBuilder: (context, index) {
              final item = items?[index].data() as Map<String, dynamic>;
              final itemName = item['name'] ?? 'No Name';
              final itemDescription = item['description'] ?? 'No Description';

              return ListTile(
                title: Text(itemName),
                subtitle: Text(itemDescription),
              );
            },
          );
        },
      ),
    );
  }
}
