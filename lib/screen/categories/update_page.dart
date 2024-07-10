import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:note_app/screen/auth/home.dart';

class UpdateName extends StatefulWidget {
final String  ?docId;
final oldname;
   UpdateName({super.key ,required this.docId,required this.oldname});

  @override
  State<UpdateName> createState() => _UpdateNameState();
}

class _UpdateNameState extends State<UpdateName> {

  GlobalKey<FormState> form = GlobalKey<FormState>();
  TextEditingController updateName = TextEditingController();

  CollectionReference categories =
      FirebaseFirestore.instance.collection('categories');
      String uId=FirebaseAuth.instance.currentUser!.uid;
      
       

 

  UpdateCategories() async {
    if (form.currentState!.validate()) {
      try {
        
            await categories.doc(widget.docId).update({"name":updateName.text});
            Navigator.pushReplacement(context,  MaterialPageRoute(builder: (context) => const Home(),));
            print('Name Updated');
      } catch (e) {
        print('Error');
      }
    }
  }
  

  @override
  void initState() {
    // TODO: implement initState
    updateName.text=widget.oldname;
    super.initState();
  }
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Update'),
        ),
        body: Form(
            key: form,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: TextFormField(
                    controller: updateName,
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
                      hintText: 'Write name Update here...',
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
                     UpdateCategories();
                    },
                    child: const Text('Update'),
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
