import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testing_app/Helper.dart';

import 'GeneratedModel.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title, required this.myModel})
      : super(key: key);

  final String title;
  generatedModel myModel;

  @override
  MyHomePageState createState() => MyHomePageState(myModel);
}

class MyHomePageState extends State<MyHomePage> {
  generatedModel myModel;
  var data;

  MyHomePageState(this.myModel);

  var _myUserIDController = TextEditingController();

  var _myTitleController = TextEditingController();

  var _myBodyController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _checkingData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          // ignore: deprecated_member_use
          FlatButton(
            onPressed: () async {
              var response =  await Provider.of<ApiHelper>(context, listen: false)
                  .deletePost();
              myModel =response;
              setState(() {
               data = '';
               _myUserIDController.text = '${myModel.userId}';
               _myBodyController.text = '${myModel.body}';
               _myTitleController.text = '${myModel.title}';

             });
            },
            child: Icon(Icons.delete),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TextField(
              controller: _myUserIDController,
              decoration: InputDecoration(labelText: 'UserId'),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              controller: _myTitleController,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              controller: _myBodyController,
              decoration: InputDecoration(labelText: 'Body'),
            ),
            ElevatedButton(
                onPressed: () async {
                  // myModel = await (generatedModel.fromJson(_map));


                },
                child: Icon(Icons.update)),
            Text(data)
          ],
        ),
      ),
    );
  }

  void _checkingData() {
    if (myModel != null) {
      _myTitleController.text = myModel.title!;
      _myBodyController.text = myModel.body!;
      _myUserIDController.text = myModel.userId!;
      data =
          'Title : ${myModel.title}\nBody : ${myModel.body}\nUserId : ${myModel.userId}\nId : ${myModel.id}';
    } else {
      print("No Data is avail");
    }
  }
}
