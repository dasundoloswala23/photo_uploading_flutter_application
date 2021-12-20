import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ShowUploads extends StatefulWidget {
  //getting the userid
  String? userId;

  ShowUploads({Key? key,this.userId}) : super(key: key);

  @override
  _ShowUploadsState createState() => _ShowUploadsState();
}

class _ShowUploadsState extends State<ShowUploads> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Your Images")),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("users").doc(widget.userId).collection("images").snapshots(),
        builder: (BuildContext context , AsyncSnapshot<QuerySnapshot> snapshot)
          {
            if(!snapshot.hasData)
              {
                return (const Center(child:Text("No image uploaded")));
              }
            else
              {
                return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                    itemBuilder: (BuildContext context,int index)
                {
                  String url = snapshot.data!.docs[index]['downloadURL'];
                  return Image.network(
                    url,
                    height: 300,
                    fit: BoxFit.cover,
                  );


                });
              }
          }
      ),

    );
  }
}
