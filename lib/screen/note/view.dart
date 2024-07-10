import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:note_app/screen/auth/login_screen.dart';
import 'package:note_app/screen/note/add.dart';

import '../auth/home.dart';
import 'edit.dart';

class Noteview extends StatefulWidget {
  final categoriesId;
  final titleName;
  const Noteview(
      {Key? key, required this.categoriesId, this.titleName = 'Notes'});

  @override
  State<Noteview> createState() => _NoteviewState();
}

class _NoteviewState extends State<Noteview> {
  late User auth;
  late Future<List<QueryDocumentSnapshot>> data;
  String uId = FirebaseAuth.instance.currentUser!.uid;

  @override
  void initState() {
    super.initState();
    auth = FirebaseAuth.instance.currentUser!;
    data = getData();
  }

  Future<List<QueryDocumentSnapshot>> getData() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('categories')
        .doc(widget.categoriesId)
        .collection('note')
        .get();
    return querySnapshot.docs;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AddNote(
                        docId: widget.categoriesId,
                        name: widget.titleName,
                      )),
            );
          },
          backgroundColor: const Color.fromARGB(255, 182, 61, 132),
          child: const Icon(Icons.add),
        ),
        appBar: AppBar(
          title: Text(widget.titleName),
          actions: [
            IconButton(
              icon: const Icon(Icons.exit_to_app_outlined),
              onPressed: () async {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Login(),
                  ),
                  (route) => false,
                );
                await FirebaseAuth.instance.signOut();
              },
            )
          ],
        ),
        body: WillPopScope(
          child: FutureBuilder(
            future: data,
            builder:
                (context, AsyncSnapshot<List<QueryDocumentSnapshot>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                    child: CircularProgressIndicator(
                  color: Color.fromARGB(255, 182, 61, 132),
                ));
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                List<QueryDocumentSnapshot> data = snapshot.data!;
                return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisExtent: 160,
                  ),
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onLongPress: () {
                        AwesomeDialog(
                          btnOkText: 'Edit Note',
                          context: context,
                          dialogType: DialogType.warning,
                          animType: AnimType.rightSlide,
                          title: 'Edit Note',
                          desc: 'Choose an action to perform on Note..!',
                          btnCancelText: 'Delete',
                          btnOkOnPress: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => EditNote(categoriedocid:widget.categoriesId ,notedocId:data[index].id, oldText: data[index]['note'] ),));
                            print('Update');
                          },
                          btnCancelOnPress: () {
                            FirebaseFirestore.instance
                                .collection('categories')
                                .doc(widget.categoriesId)
                                .collection('note')
                                .doc(data[index].id)
                                .delete();
                            print('Delete');
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Noteview(
                                    categoriesId: widget.categoriesId,
                                    titleName: widget.titleName,
                                  ),
                                ));
                          },
                        ).show(); // Add this line to show the AwesomeDialog
                      },
                      child: Card(
                        child: Container(
                          padding: const EdgeInsets.all(15),
                          child: Column(
                            children: [
                              Text(
                                data[index]['note'].toString(),
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              }
            },
          ),
          onWillPop: () {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => Home(),
                ),
                (route) => false);
            return Future(() => false);
          },
        ));
  }
}
