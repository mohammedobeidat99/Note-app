import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FilteringPage extends StatefulWidget {
  FilteringPage({Key? key});

  @override
  State<FilteringPage> createState() => _FilteringPageState();
}

class _FilteringPageState extends State<FilteringPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Test Filtering '),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              var doc = snapshot.data!.docs[index];
              return Card(
                child: ListTile(
                  title: Text(doc['username']),
                  subtitle: Text(doc['phone']),
                  trailing: Text('Age: ${doc["age"]}'),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
