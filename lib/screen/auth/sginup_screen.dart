/**
 * Author: Sudip Thapa  
 * profile: https://github.com/sudeepthapa
  */
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:note_app/screen/auth/login_screen.dart';

class Sginup extends StatefulWidget {
  static const String path = "lib/src/pages/login/login7.dart";

  const Sginup({super.key});
  @override
  _SginupState createState() => _SginupState();
}

class _SginupState extends State<Sginup> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController =
      TextEditingController(); // Add this controller
  GlobalKey<FormState> formstate = GlobalKey();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  bool passwordsMatch = true;

  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Form(
        key: formstate,
        child: ListView(
          children: <Widget>[
            Stack(
              children: <Widget>[
                ClipPath(
                  clipper: WaveClipper2(),
                  child: Container(
                    width: double.infinity,
                    height: 300,
                    decoration: const BoxDecoration(
                        gradient: LinearGradient(
                            colors: [Color(0x22ff3a5a), Color(0x22fe494d)])),
                    child: const Column(),
                  ),
                ),
                ClipPath(
                  clipper: WaveClipper3(),
                  child: Container(
                    width: double.infinity,
                    height: 300,
                    decoration: const BoxDecoration(
                        gradient: LinearGradient(
                            colors: [Color(0x44ff3a5a), Color(0x44fe494d)])),
                    child: const Column(),
                  ),
                ),
                ClipPath(
                  clipper: WaveClipper1(),
                  child: Container(
                    width: double.infinity,
                    height: 300,
                    decoration: const BoxDecoration(
                        gradient: LinearGradient(
                            colors: [Color(0xffff3a5a), Color(0xfffe494d)])),
                    child: const Column(
                      children: <Widget>[
                        SizedBox(
                          height: 40,
                        ),
                        Icon(
                          Icons.edit_note_outlined,
                          color: Colors.white,
                          size: 60,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "NoteWise",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 30),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 50),
              child: Text(
                'Sign Up',
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w700,
                    color: Colors.deepOrange),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Material(
                elevation: 2.0,
                borderRadius: const BorderRadius.all(Radius.circular(30)),
                child: TextFormField(
                  onChanged: (String value) {},
                  cursorColor: Colors.deepOrange,
                  decoration: const InputDecoration(
                      hintText: "Username",
                      prefixIcon: Material(
                        elevation: 0,
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        child: Icon(
                          Icons.person,
                          color: Colors.red,
                        ),
                      ),
                      border: InputBorder.none,
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 25, vertical: 13)),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Material(
                elevation: 2.0,
                borderRadius: const BorderRadius.all(Radius.circular(30)),
                child: TextFormField(
                  controller: emailController,
                  onChanged: (String value) {},
                  cursorColor: Colors.deepOrange,
                  decoration: const InputDecoration(
                      hintText: "Email",
                      prefixIcon: Material(
                        elevation: 0,
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        child: Icon(
                          Icons.email,
                          color: Colors.red,
                        ),
                      ),
                      border: InputBorder.none,
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 25, vertical: 13)),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Material(
                elevation: 2.0,
                borderRadius: const BorderRadius.all(Radius.circular(30)),
                child: TextFormField(
                  controller: passwordController,
                  onChanged: (String value) {
                    setState(() {
                      passwordsMatch = value == confirmPasswordController.text;
                    });
                  },
                  cursorColor: Colors.deepOrange,
                  decoration: InputDecoration(
                    hintText: "Password",
                    prefixIcon: Material(
                      elevation: 0,
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      child: Icon(
                        Icons.lock,
                        color: Colors.red,
                      ),
                    ),
                    border: InputBorder.none,
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 25, vertical: 13),
                    suffixIcon: (passwordController.text.isNotEmpty &&
                            confirmPasswordController.text.isNotEmpty)
                        ? Icon(
                            passwordsMatch ? Icons.check : Icons.error,
                            color: passwordsMatch ? Colors.green : Colors.red,
                          )
                        : null, // Show the icon only when both fields have input
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Material(
                elevation: 2.0,
                borderRadius: const BorderRadius.all(Radius.circular(30)),
                child: TextFormField(
                  controller: confirmPasswordController,
                  onChanged: (String value) {
                    setState(() {
                      passwordsMatch = value == passwordController.text;
                    });
                  },
                  cursorColor: Colors.deepOrange,
                  decoration: InputDecoration(
                    hintText: "Confirm Password",
                    prefixIcon: Material(
                      elevation: 0,
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      child: Icon(
                        Icons.lock,
                        color: Colors.red,
                      ),
                    ),
                    border: InputBorder.none,
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 25, vertical: 13),
                    suffixIcon: (passwordController.text.isNotEmpty &&
                            confirmPasswordController.text.isNotEmpty)
                        ? Icon(
                            passwordsMatch ? Icons.check : Icons.error,
                            color: passwordsMatch ? Colors.green : Colors.red,
                          )
                        : null, // Show the icon only when both fields have input
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(100)),
                  color: Colors.red,
                ),
                child: TextButton(
                  child: loading
                      ? CircularProgressIndicator(
                          color: Colors.white,
                        )
                      : Text(
                          "Sign Up",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 18,
                          ),
                        ),
                  onPressed: loading
                      ? null
                      : () async {
                          if (emailController.text.isEmpty ||
                              passwordController.text.isEmpty ||
                              confirmPasswordController.text.isEmpty) {
                            // Display an error message if any field is empty
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("Please fill in all fields."),
                              ),
                            );
                            return;
                          }

                          if (!passwordsMatch) {
                            // Display an error message if passwords do not match
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("Passwords do not match."),
                              ),
                            );
                            return;
                          }

                          setState(() {
                            loading = true;
                          });

                          try {
                            final credential = await FirebaseAuth.instance
                                .createUserWithEmailAndPassword(
                              email: emailController.text,
                              password: passwordController.text,
                            );
                            // Account creation successful
                            AwesomeDialog(
                              context: context,
                              dialogType: DialogType.success,
                              animType: AnimType.rightSlide,
                              title: 'Successfully',
                              desc:
                                  'The account has been created successfully.',
                              btnOkOnPress: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Login(),
                                  ),
                                );
                              },
                            )..show();
                          } on FirebaseAuthException catch (e) {
                            if (e.code == 'weak-password') {
                              print('The password provided is too weak.');
                            } else if (e.code == 'email-already-in-use') {
                              print(
                                  'The account already exists for that email.');
                            }
                          } catch (e) {
                            print(e);
                          } finally {
                            setState(() {
                              loading = false;
                            });
                          }
                        },
                ),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  "Do you already have an account ? ",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.normal),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Login ",
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                        // decoration: TextDecoration.underline
                      )),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class WaveClipper1 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0.0, size.height - 50);

    var firstEndPoint = Offset(size.width * 0.6, size.height - 29 - 50);
    var firstControlPoint = Offset(size.width * .25, size.height - 60 - 50);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);

    var secondEndPoint = Offset(size.width, size.height - 60);
    var secondControlPoint = Offset(size.width * 0.84, size.height - 50);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}

class WaveClipper3 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0.0, size.height - 50);

    var firstEndPoint = Offset(size.width * 0.6, size.height - 15 - 50);
    var firstControlPoint = Offset(size.width * .25, size.height - 60 - 50);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);

    var secondEndPoint = Offset(size.width, size.height - 40);
    var secondControlPoint = Offset(size.width * 0.84, size.height - 30);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}

class WaveClipper2 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0.0, size.height - 50);

    var firstEndPoint = Offset(size.width * .7, size.height - 40);
    var firstControlPoint = Offset(size.width * .25, size.height);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);

    var secondEndPoint = Offset(size.width, size.height - 45);
    var secondControlPoint = Offset(size.width * 0.84, size.height - 50);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
