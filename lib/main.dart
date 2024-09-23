import 'package:firebase/ecommerce_app_firebase/ecommerce_app.dart';
import 'package:firebase/firestore_firebase/fetch_data_firestore.dart';
import 'package:firebase/firestore_firebase/search_add_delete_data.dart';
import 'package:firebase/firestore_firebase/store_data_in_firestore.dart';
import 'package:firebase/firestore_firebase/upload_image_to_storage.dart';
import 'package:firebase/mynotesApp/note_home_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        title: Text(
          "Flutter Firebase Operations",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: SizedBox(
                width: 350,
                height: 63,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(200, 50),
                    backgroundColor: Colors.deepPurple, // Background color
                    foregroundColor: Colors.white, // Text color
                    padding: EdgeInsets.symmetric(
                        horizontal: 30, vertical: 15), // Padding
                    shape: RoundedRectangleBorder(
                      // Custom shape
                      borderRadius:
                          BorderRadius.circular(13), // Rounded corners
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EcommerceApp()));
                  },
                  child: Text(
                    "To Ecommerce App",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: SizedBox(
                width: 350,
                height: 63,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(200, 50),
                    backgroundColor: Colors.deepPurple, // Background color
                    foregroundColor: Colors.white, // Text color
                    padding: EdgeInsets.symmetric(
                        horizontal: 30, vertical: 15), // Padding
                    shape: RoundedRectangleBorder(
                      // Custom shape
                      borderRadius:
                          BorderRadius.circular(13), // Rounded corners
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => NoteHomeScreen()));
                  },
                  child: Text(
                    "To My-Notes App",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: SizedBox(
                width: 350,
                height: 63,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple, // Background color
                    foregroundColor: Colors.white, // Text color
                    padding: EdgeInsets.symmetric(
                        horizontal: 30, vertical: 15), // Padding
                    shape: RoundedRectangleBorder(
                      // Custom shape
                      borderRadius:
                          BorderRadius.circular(13), // Rounded corners
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CRUDEOperation()));
                  },
                  child: Text(
                    "Add, Delete, Search Operations",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
