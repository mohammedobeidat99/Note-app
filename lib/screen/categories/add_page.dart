import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:note_app/screen/auth/home.dart';

class AddCategories extends StatefulWidget {
  const AddCategories({super.key});

  @override
  State<AddCategories> createState() => _AddCategoriesState();
}

class _AddCategoriesState extends State<AddCategories> {

  GlobalKey<FormState> form = GlobalKey<FormState>();
  TextEditingController addName = TextEditingController();

  CollectionReference categories =
      FirebaseFirestore.instance.collection('categories');
      String uId=FirebaseAuth.instance.currentUser!.uid;
      
       

  //Future<void> addUser() {
  // Call the user's CollectionReference to add a new user
  // return categories
  //     .add({
  //       'fname': addName.text,

  //     })
  //     .then((value) => print("Name Added"))
  //     .catchError((error) => print("Failed to add Name: $error"));

  //}

  AddCategories() async {
    if (form.currentState!.validate()) {
      try {
        DocumentReference response =
            await categories.add({"name": addName.text, 'id':uId });
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Home(),), (route) => false);
            print('Name Added');
      } catch (e) {
        print('Error');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Add Categories'),
        ),
        body: Form(
            key: form,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: TextFormField(
                    controller: addName,
                    validator: (value) {
                      if (value == '') return "Category name can not be empty";
                      return null;
                    },
                    maxLines: null, // Allow multiline input
                    style: const TextStyle(
                      fontSize: 16.0,
                      color: Colors.black87,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Write name note here...',
                      hintStyle: const TextStyle(
                        fontSize: 16.0,
                        color: Colors.grey,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide(
                          color: Color.fromARGB(255, 182, 61, 132),
                          width: 2.0,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide(
                          color: Color.fromARGB(255, 182, 61, 132),
                          width: 2.0,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide(
                          color: Colors.grey,
                          width: 1.0,
                        ),
                      ),
                      contentPadding: const EdgeInsets.all(16.0),
                    ),
                  ),
                ),
                ElevatedButton(
                    onPressed: () async {
                     // addUser();
                     AddCategories();
                    },
                    child: const Text('Add'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 70.0), // Adjust padding for size

                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      backgroundColor: const Color.fromARGB(255, 182, 61, 132),
                    ))
              ],
            )));
  }
}
