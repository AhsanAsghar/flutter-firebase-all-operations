import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/ecommerce_app_firebase/detail_screen_2.dart';
import 'package:flutter/material.dart';

class EcommerceApp extends StatefulWidget {
  const EcommerceApp({super.key});

  @override
  State<EcommerceApp> createState() => _EcommerceAppState();
}

class _EcommerceAppState extends State<EcommerceApp> {
  final CollectionReference ecommerceApp =
      FirebaseFirestore.instance.collection("ecommerce-app");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          backgroundColor: Colors.blue,
          centerTitle: true,
          title: Text(
            "Ecommerce App!",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          )),
      body: StreamBuilder(
          stream: ecommerceApp.snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
            if (streamSnapshot.hasData) {
              return GridView.builder(
                  itemCount: streamSnapshot.data!.docs.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: .80,
                      crossAxisCount: 2),
                  itemBuilder: (context, index) {
                    final DocumentSnapshot documentSnapshot =
                        streamSnapshot.data!.docs[index];
                    return ItemsDisplay(context, documentSnapshot);
                  });
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }

  GestureDetector ItemsDisplay(
      BuildContext context, DocumentSnapshot<Object?> documentSnapshot) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    DetailScreen(documentSnapshot: documentSnapshot)));
      },
      child: Material(
        elevation: 3,
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Hero(
                tag: documentSnapshot['imageurl'],
                child: Container(
                  height: 140,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                          fit: BoxFit.fill,
                          image: NetworkImage(documentSnapshot['imageurl']))),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                documentSnapshot['name'],
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
              SizedBox(
                height: 6,
              ),
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.blue),
                    child: Row(
                      children: [
                        Text(
                          documentSnapshot['rating'],
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 13),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Icon(
                          Icons.star,
                          color: Colors.yellow,
                          size: 18,
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Text(
                    "\$${documentSnapshot['price'].toString()}",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
