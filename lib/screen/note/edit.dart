import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:note_app/screen/note/view.dart';

class EditNote extends StatefulWidget {
final String  ?notedocId;
final String?  categoriedocid;
final String oldText;
//final String noteName;
   const EditNote({super.key ,required this.notedocId ,required this.categoriedocid ,required  this.oldText }) : super();

  @override
  State<EditNote> createState() => _EditNoteState();
}

class _EditNoteState extends State<EditNote> {

  GlobalKey<FormState> form = GlobalKey<FormState>();
  TextEditingController noteEditing = TextEditingController();

  
      String uId=FirebaseAuth.instance.currentUser!.uid;
      
       

 

  EditNote() async {
    CollectionReference updatenote =
      FirebaseFirestore.instance.collection('categories').doc(widget.categoriedocid).collection('note');
    if (form.currentState!.validate()) {
      try {
        
            await updatenote.doc(widget.notedocId).update({"note":noteEditing.text});
            Navigator.pushReplacement(context,  MaterialPageRoute(builder: (context) =>  Noteview(categoriesId:widget.categoriedocid  ),));
            print('Name Updated');
      } catch (e) {
        print('Error');
      }
    }
  }
  

  @override
  void initState() {
    // TODO: implement initState
    noteEditing.text=widget.oldText;
    super.initState();
  }
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Edit Note'),
        ),
        body: Form(
            key: form,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: TextFormField(
                    controller: noteEditing,
                    validator: (value) {
                      if (value == '') return "Note can not be empty";
                      return null;
                    },
                    maxLines: null, // Allow multiline input
                    style: const TextStyle(
                      fontSize: 16.0,
                      color: Colors.black87,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Write Note Edit here...',
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
                     EditNote();
                    },
                    child: const Text('Save'),
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
