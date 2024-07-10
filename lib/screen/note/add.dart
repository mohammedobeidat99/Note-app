import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:note_app/screen/note/view.dart';

class AddNote extends StatefulWidget {
   AddNote({super.key, required this.docId ,required this.name});
  final String docId;
 final String ? name;

  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  GlobalKey<FormState> form = GlobalKey<FormState>();
  TextEditingController addNote = TextEditingController();

  AddNote() async {
    CollectionReference notecollection = FirebaseFirestore.instance
        .collection('categories')
        .doc(widget.docId)
        .collection('note');

    if (form.currentState!.validate()) {
      try {
        DocumentReference response =
            await notecollection.add({"note": addNote.text});
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Noteview(categoriesId: widget.docId ,titleName:widget.name , ),
            ));
           
        print('Note Added');
      } catch (e) {
        print('Error');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Add Note'),
        ),
        body: Form(
            key: form,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: TextFormField(
                    controller: addNote,
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
                      hintText: 'Write note here...',
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
                      AddNote();
                    },
                    child: const Text('Add Note'),
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
