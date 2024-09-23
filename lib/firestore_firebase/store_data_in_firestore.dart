import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class StoreDataInFirestore extends StatefulWidget {
  const StoreDataInFirestore({super.key});

  @override
  State<StoreDataInFirestore> createState() => _StoreDataInFirestoreState();
}

class _StoreDataInFirestoreState extends State<StoreDataInFirestore> {
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController positionController = TextEditingController();
  final CollectionReference myItems =
      FirebaseFirestore.instance.collection("Store Data");

  Future<void> storeData() async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return myDialogBox(
              context: context,
              onPressed: () async {
                String name = nameController.text;
                String address = addressController.text;
                String position = positionController.text;
                try {
                  await myItems.add({
                    'name': name,
                    'address': address,
                    'position': position,
                  });
                  Navigator.pop(context);
                } catch (ex) {
                  print('Failed to store data: $ex'); // Log the error message
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Error storing data: $ex')),
                  );
                }
              });
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Store Data in Firestore!',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: storeData,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: Colors.deepPurple,
      ),
    );
  }

  Dialog myDialogBox(
      {required BuildContext context, required VoidCallback onPressed}) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Store Data From User!',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.close,
                        color: Colors.deepPurple,
                      ))
                ],
              ),
              commonTextFields("e.g Ahsan", "Enter yout Name!", nameController),
              commonTextFields("e.g San Fransisco", "Enter your Address!",
                  addressController),
              commonTextFields(
                  "e.g AI Engineer", "Enter yout Postion!", positionController),
              ElevatedButton(
                  onPressed: onPressed,
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple),
                  child: Text(
                    "Store",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 18),
                  ))
            ],
          ),
        ),
      ),
    );
  }

  Padding commonTextFields(hint, label, controller) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hint,
          labelText: label,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: Colors.deepPurple, width: 2),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: Colors.grey, width: 2),
          ),
        ),
      ),
    );
  }
}
