import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testing_app/GeneratedModel.dart';

import 'Helper.dart';
import 'PostScreen.dart';

class StoryClass extends StatelessWidget {
  final _userController = TextEditingController();
  final _titleController = TextEditingController();
  final _bodyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    context.read<ApiHelper>().fetchData;
    return Scaffold(
      appBar: AppBar(
        title: Text('Api Example'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => createANewPost(context),
      ),
      body: RefreshIndicator(
        child: Consumer<ApiHelper>(
          builder: (context, value, child) {
            return value.map.length == 0 && !value.error
                ? Center(child: CircularProgressIndicator())
                : value.error
                    ? Center(child: Text(value.errorMessage))
                    : ListView.builder(
                        itemCount: value.map.length - 1,
                        itemBuilder: (context, index) {
                          return Card(
                              child: ListTile(
                            title: Text(
                              'Title : ${value.map[index].title}',
                              softWrap: true,
                              style: TextStyle(
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(
                              'Body : ${value.map[index].body}',
                              softWrap: true,
                              style: TextStyle(
                                  fontSize: 18.0, fontStyle: FontStyle.italic),
                            ),
                            trailing: Text('Id : ${value.map[index].id}'),
                          ));
                        });
          },
        ),
        onRefresh: () async {
          await context.read<ApiHelper>().fetchData;
        },
      ),
    );
  }

  createANewPost(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            actionsPadding: EdgeInsets.all(16.0),
            actions: [
              TextField(
                decoration: InputDecoration(hintText: 'UserId'),
                controller: _userController,
              ),
              TextField(
                decoration: InputDecoration(hintText: 'Title'),
                controller: _titleController,
              ),
              TextField(
                decoration: InputDecoration(hintText: 'Body'),
                controller: _bodyController,
              ),
              ElevatedButton(
                  onPressed: () async {
                    var userId = _userController.text;
                    var title = _titleController.text;
                    var body = _bodyController.text;

                    generatedModel response =
                        await Provider.of<ApiHelper>(context, listen: false)
                            .postData(
                      title,
                      body,
                      userId,
                    );
                    if (response != null) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MyHomePage(
                                    title:
                                        'New Data is created with id ${response.id}', myModel: response,

                                  )));
                    } else {print('No Data is created');}
                  },
                  child: Text('Add a new Post'))
            ],
          );
        });
  }
}
