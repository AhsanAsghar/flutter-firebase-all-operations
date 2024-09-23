import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FetchDataFirestore extends StatefulWidget {
  const FetchDataFirestore({super.key});

  @override
  State<FetchDataFirestore> createState() => _FetchDataFirestoreState();
}

class _FetchDataFirestoreState extends State<FetchDataFirestore> {
  final CollectionReference fetchData =
      FirebaseFirestore.instance.collection("Fetch Data");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade100,
      appBar: AppBar(
        title: Text(
          "Fetch Data from Firestore!",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: StreamBuilder(
          stream: fetchData.snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
            if (streamSnapshot.hasData) {
              return Padding(
                padding: const EdgeInsets.only(top: 12.0),
                child: ListView.builder(
                    itemCount: streamSnapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      final DocumentSnapshot documentSnapshot =
                          streamSnapshot.data!.docs[index];
                      return Padding(
                        padding:
                            const EdgeInsets.only(bottom: 8, right: 8, left: 8),
                        child: Material(
                          borderRadius: BorderRadius.circular(20),
                          child: ListTile(
                            title: Text(documentSnapshot['name'],
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20)),
                            subtitle: Text(documentSnapshot['definition']),
                          ),
                        ),
                      );
                    }),
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }
}
