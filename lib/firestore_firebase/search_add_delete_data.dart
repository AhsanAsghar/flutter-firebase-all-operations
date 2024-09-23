import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CRUDEOperation extends StatefulWidget {
  const CRUDEOperation({super.key});

  @override
  State<CRUDEOperation> createState() => _CRUDEOperationState();
}

class _CRUDEOperationState extends State<CRUDEOperation> {
  final CollectionReference myItems =
      FirebaseFirestore.instance.collection("CRUDEItems");
  TextEditingController nameController = TextEditingController();
  TextEditingController positionController = TextEditingController();
  TextEditingController _searchController = TextEditingController();
  bool isSearchClicked = false;
  String searchText = '';

  void onSearchChange(String value) {
    setState(() {
      searchText = value;
    });
  }

  Future<void> create() async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return myDialog(
              name: "Create Operation",
              condition: "create",
              onPressed: () {
                String name = nameController.text;
                String position = positionController.text;
                addMyItems(name, position);
                Navigator.pop(context);
              });
        });
  }

  Future<void> update(DocumentSnapshot documentSnapshot) async {
    nameController.text = documentSnapshot['name'];
    positionController.text = documentSnapshot['Position'];
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return myDialog(
              name: "Update your Data",
              condition: "update",
              onPressed: () async {
                String name = nameController.text;
                String position = positionController.text;
                await myItems.doc(documentSnapshot.id).update({
                  'name': name,
                  'position': position,
                });
                Navigator.pop(context);
              });
        });
  }

  Future<void> deleteOperation(DocumentSnapshot documentSnapshot) async {
    await myItems.doc(documentSnapshot.id).delete();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.red,
        duration: Duration(seconds: 2),
        content: Text(
          "Item deleted successfully!",
          style: TextStyle(color: Colors.white),
        )));
  }

  void addMyItems(String name, String position) {
    myItems.add({'name': name, 'Position': position});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.blue,
        title: isSearchClicked
            ? Container(
                height: 50,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)),
                child: TextField(
                  onChanged: onSearchChange,
                  controller: _searchController,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(16, 20, 16, 12),
                      hintText: "Search...",
                      border: InputBorder.none,
                      hintStyle: TextStyle(color: Colors.black)),
                ),
              )
            : Text(
                "Firestore CRUDE!",
                style: TextStyle(color: Colors.white),
              ),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  isSearchClicked = !isSearchClicked;
                });
              },
              icon: Icon(
                size: 30,
                isSearchClicked ? Icons.close : Icons.search,
                color: Colors.white,
              ))
        ],
      ),
      backgroundColor: Colors.blue.shade100,
      body: StreamBuilder(
          stream: myItems.snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
            if (streamSnapshot.hasData) {
              final List<DocumentSnapshot> items = streamSnapshot.data!.docs
                  .where((doc) => doc['name']
                      .toLowerCase()
                      .contains(searchText.toLowerCase()))
                  .toList();
              return ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    final DocumentSnapshot documentSnapshot = items[index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Material(
                        elevation: 5,
                        borderRadius: BorderRadius.circular(20),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(
                            title: Text(
                              documentSnapshot['name'],
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                            subtitle: Text(documentSnapshot['Position']),
                            trailing: SizedBox(
                              width: 100,
                              child: Row(
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        update(documentSnapshot);
                                      },
                                      icon: Icon(
                                        Icons.edit,
                                        color: Colors.blue,
                                      )),
                                  IconButton(
                                      onPressed: () {
                                        deleteOperation(documentSnapshot);
                                      },
                                      icon: Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                      ))
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  });
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: () {
          create();
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  Dialog myDialog(
          {required String name,
          required String condition,
          required VoidCallback onPressed}) =>
      Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(20)),
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(),
                  Text(
                    name,
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.close))
                ],
              ),
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: "Enter the name",
                  hintText: "e.g. Ahsan",
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                controller: positionController,
                decoration: InputDecoration(
                  labelText: "Enter the position",
                  hintText: "e.g. Developer",
                ),
              ),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: onPressed,
                child: Text(
                  condition,
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      );
}
