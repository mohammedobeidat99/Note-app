import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:note_app/screen/auth/login_screen.dart';
import 'package:note_app/screen/categories/add_page.dart';
import 'package:note_app/screen/note/view.dart';

import '../categories/update_page.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late User auth;
  late Future<List<QueryDocumentSnapshot>> data;
  String uId=FirebaseAuth.instance.currentUser!.uid;


  @override
  void initState() {
    super.initState();
    auth = FirebaseAuth.instance.currentUser!;
    data = getData();
  }
  

  Future<List<QueryDocumentSnapshot>> getData() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('categories').where('id' ,isEqualTo:uId ).get();
    return querySnapshot.docs;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddCategories()),
          );
        },
        backgroundColor: const Color.fromARGB(255, 182, 61, 132),
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: const Text('Home'),
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
      body: FutureBuilder(
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
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => Noteview(categoriesId: data[index].id,titleName: data[index]['name'], ),)),
                  onLongPress: () {
                    AwesomeDialog(
                        btnOkText: 'Update Name',
                        context: context,
                        dialogType: DialogType.warning,
                        animType: AnimType.rightSlide,
                        title: 'Edit Category',
                        desc: 'Choose an action to perform on ${data[index]['name']}',
                        btnCancelText: 'Delete',
                        btnOkOnPress: () async {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => UpdateName(docId: data[index].id,oldname:data[index]['name']),));
                          print('Update ');
                        },
                        btnCancelOnPress: ()async {
                          await FirebaseFirestore.instance
                              .collection('categories')
                              .doc(data[index].id)
                              .delete();
                              print('delete');
                              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const Home(),));
                        }).show();
                  },
                  child: Card(
                    child: Container(
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        children: [
                          Image.asset(
                            'assets/images/note.jpeg',
                            height: 100,
                          ),
                          Text(
                            data[index]['name'].toString(),
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
    );
  }
}
