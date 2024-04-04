import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:chat_phone_number/screens/home_screen.dart';

class userName extends StatefulWidget {
  @override
  _userNameState createState() => _userNameState();
}

class _userNameState extends State<userName> {
  var name = TextEditingController();
  CollectionReference user = FirebaseFirestore.instance.collection('users');
  void creatUser() {
    user
        .where('uid', isEqualTo: FirebaseAuth.instance.currentUser.uid)
        .limit(1)
        .get()
        .then((QuerySnapshot querySnapshot) {
      if (querySnapshot.docs.isEmpty) {
        user.add({
          'name': name.text,
          'phone': FirebaseAuth.instance.currentUser.phoneNumber,
          'status': 'Availabe',
          'uid': FirebaseAuth.instance.currentUser.uid
        });
      }
    }).onError((error, stackTrace) {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.blue,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 300,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 26),
                child: TextFormField(
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 20,
                  ),
                  controller: name,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      hintText: 'Enter Your Name',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      )),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              GestureDetector(
                onTap: () {
                  FirebaseAuth.instance.currentUser
                      .updateProfile(displayName: name.text);
                  creatUser();
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => HomeScreen()));
                },
                child: Container(
                  child: Text(
                    'Continue',
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w900,
                        color: Colors.white),
                  ),
                  alignment: AlignmentDirectional.center,
                  width: 150,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
