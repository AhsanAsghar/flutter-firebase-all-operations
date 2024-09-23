import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DetailScreen extends StatefulWidget {
  final DocumentSnapshot<Object?> documentSnapshot;
  const DetailScreen({super.key, required this.documentSnapshot});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: ListView(
        children: [
          Stack(
            children: [
              Hero(
                tag: widget.documentSnapshot['imageurl'],
                child: Image.network(
                  widget.documentSnapshot['imageurl'],
                  height: 400,
                  width: double.infinity,
                  fit: BoxFit.fill,
                ),
              ),
              BackButton(
                color: Colors.black,
              )
            ],
          ),
          Padding(
            padding: EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      widget.documentSnapshot['name'],
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "\$${widget.documentSnapshot['price']}",
                      style: TextStyle(fontSize: 25),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Icon(
                      Icons.star,
                      color: Colors.amber.shade900,
                    ),
                    Text(
                      widget.documentSnapshot['rating'],
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      "${widget.documentSnapshot['review']}(Reviews)",
                      style: TextStyle(fontSize: 16),
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  widget.documentSnapshot['description'],
                  style: TextStyle(fontSize: 16),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 9,
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Container(
                      height: 75,
                      width: 80,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                            width: 2,
                            color: widget.documentSnapshot['isfavourite']
                                ? Colors.red
                                : Colors.black),
                      ),
                      child: Icon(
                        Icons.favorite,
                        size: 45,
                        color: widget.documentSnapshot['isfavourite']
                            ? Colors.red
                            : Colors.black,
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 75,
                          decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(20)),
                          child: Center(
                            child: Text(
                              "Add to Cart",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 20),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
