import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:photouploadingflutterapp/imageupload/image_upload.dart';
import 'package:photouploadingflutterapp/imageupload/show_upload.dart';
import 'package:photouploadingflutterapp/model/user_model.dart';

import 'login.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  // for fetch data 14 th line and 15 th line very important
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();

  @override
  void initState() {
    super.initState();
   FirebaseFirestore.instance
   .collection("users")
   .doc(user!.uid)
    .get()
    .then((value){
      this.loggedInUser = UserModel.formMap(value.data());
      setState(() {

      });
   });

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget> [
              SizedBox(
                height: 150,
                child: Image.asset("images/logo.png",fit: BoxFit.contain),
              ),
              Text(
                "Welcome Back",
                style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "${loggedInUser.firstName}${loggedInUser.secondName}",
                style: TextStyle(fontSize: 20,
                    color: Colors.black54,
                    fontWeight: FontWeight.w500
                )),
              Text(
                  "${loggedInUser.email}",
                  style: TextStyle(fontSize: 20,
                      color: Colors.black54,
                      fontWeight: FontWeight.w500
                  )),
              Text(
                  "${loggedInUser.uid}",
                  style: TextStyle(fontSize: 20,
                      color: Colors.black54,
                      fontWeight: FontWeight.w500
                  )),
              SizedBox(
                height: 15,
              ),
              ElevatedButton(onPressed: () {
                Navigator.push(context,
                MaterialPageRoute(builder: (context) => ImageUpload( userId: loggedInUser.uid)));
              }  ,
                  child: Text("Upload Images")),
              ElevatedButton(onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ShowUploads( userId: loggedInUser.uid)));
              }  , child: Text("Show Images ")),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> logout(BuildContext context)async
  {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context)=> LoginScreen()));
  }
  _appBar(){
    //getting the size of app bar
    // get height
    final appBarHeight = AppBar().preferredSize.height;
    return PreferredSize(
        child: AppBar (
          title : const Text("Profile"),
          actions: [
          IconButton(
          onPressed: () {
            logout(context);
          },
          icon: Icon(Icons.logout),)
    ],),
        preferredSize: Size.fromHeight(appBarHeight));
  }
}
