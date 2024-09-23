import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UploadImageToStorage extends StatefulWidget {
  const UploadImageToStorage({super.key});

  @override
  State<UploadImageToStorage> createState() => _UploadImageToStorageState();
}

class _UploadImageToStorageState extends State<UploadImageToStorage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String? imageUrl;
  final ImagePicker _imagePicker = ImagePicker();
  bool isLoading = false;

  Future<void> pickImage() async {
    try {
      XFile? res = await _imagePicker.pickImage(source: ImageSource.gallery);
      if (res != null) {
        uploadImageToFirebase(File(res.path));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Failed to Pick Image: $e"),
        backgroundColor: Colors.red,
      ));
    }
  }

  Future<void> uploadImageToFirebase(File image) async {
    setState(() {
      isLoading = true;
    });
    try {
      Reference ref = FirebaseStorage.instance
          .ref()
          .child("/images/${DateTime.now().microsecondsSinceEpoch}.png");
      await ref.putFile(image).whenComplete(() {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Uploaded Successfully!"),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 2),
        ));
      });
      imageUrl = await ref.getDownloadURL();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Failed to upload Image: $e"),
        backgroundColor: Colors.red,
      ));
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blue[200],
        appBar: AppBar(
          title: Text(
            "Upload Image to Storage!",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.blue,
          centerTitle: true,
        ),
        body: Center(
          child: Padding(
            padding: EdgeInsets.all(10),
            child: ListView(
              shrinkWrap: true,
              children: [
                Center(
                  child: Container(
                    height: 200,
                    width: 200,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        CircleAvatar(
                          radius: 100,
                          child: imageUrl == null
                              ? Icon(
                                  Icons.person,
                                  size: 170,
                                  color: Colors.grey,
                                )
                              : SizedBox(
                                  height: 200,
                                  child: ClipOval(
                                    child: Image.network(
                                      imageUrl!,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                        ),
                        if (isLoading)
                          Positioned(
                              top: 80,
                              right: 85,
                              child: Center(
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                              )),
                        Positioned(
                            right: 25,
                            top: 15,
                            child: GestureDetector(
                              onTap: () {
                                pickImage();
                              },
                              child: Icon(
                                Icons.camera_alt_sharp,
                                color: Colors.white,
                              ),
                            ))
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                    suffixIcon: Icon(Icons.person, color: Colors.blue),
                    hintText: "e.g ahsan.asghar010@gmail.com",
                    labelText: "Enter your Email!",
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: Colors.blue, width: 2),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: Colors.blue, width: 2),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: passwordController,
                  keyboardType: TextInputType.visiblePassword,
                  decoration: InputDecoration(
                    suffixIcon: Icon(
                      Icons.remove_red_eye_sharp,
                      color: Colors.blue,
                    ),
                    labelText: "Enter your Password!",
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: Colors.blue, width: 2),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: Colors.blue, width: 2),
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
