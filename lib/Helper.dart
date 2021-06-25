import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:testing_app/GeneratedModel.dart';
import 'package:testing_app/ModelClass.dart';

import 'ConstClass.dart';

class ApiHelper with ChangeNotifier {
  var _myList = <GetMyPosts>[];
  bool _error = false;
  var _errorMessage = '';

  Future<void> get fetchData async {
    final response =
        await get(Uri.parse(Variables.myUrl), headers: Variables.headers);
    if (response.statusCode == 200) {
      try {
        _myList = getPostsFromJson(response.body);
        _error = false;
      } catch (e) {
        _error = true;
        _errorMessage = e.toString();
        _myList = [];
      }
    } else {
      _error = true;
      _errorMessage = 'Something went wrong';
      _myList = [];
    }
    notifyListeners();
  }

  void initVal() {
    _myList = [];
    _error = false;
    _errorMessage = '';
    notifyListeners();
  }

  List<GetMyPosts> get map => _myList;

  bool get error => _error;

  String get errorMessage => _errorMessage;

  Future<generatedModel> postData(String title, String body, String userId) async {
    // Map<String, dynamic> _map;
generatedModel myModel;
Map<String,dynamic> _map = {};
    final response = await post(
      Uri.parse(Variables.myUrl),
      body: ({'title': '$title', 'body': '$body', 'userId': userId}),
    );
    if (response.statusCode == 201) {
      try {
        _map = jsonDecode(response.body);
        _error = false;
        print(response.body);
      } catch (e) {
        print(e);
        _error = true;
        _errorMessage = e.toString();
        _myList = [];
      }
    } else {
      _error = true;
      _errorMessage = 'Something went wrong';
      _myList = [];
    }
    myModel = generatedModel.fromJson(_map);
    notifyListeners();
    return myModel;
  }

  Future<generatedModel> putData(int id, String title, String body, String userId) async {
    var putResponse;
    Map<String, dynamic> _map = {};
    generatedModel myModel;
    var _body = jsonEncode({'title': title, 'body': body, 'userId': userId});
    putResponse = await put(
        Uri.parse('https://jsonplaceholder.typicode.com/posts/101'),
        body: _body,
        headers: Variables.headers,
        encoding: Encoding.getByName("uft-8"));
    if (putResponse.statusCode == 201) {
      try {
       _map= json.decode(putResponse.body);
        // _myList.addAll(map.toList(growable: true));

        // print(_map.le);
        _error = false;
        print(_map.values);
      } catch (e) {
        print(e);
        _error = true;
        _errorMessage = e.toString();
      }
    } else {
      _error = true;
      _errorMessage = 'Something went wrong';
    }
    myModel = generatedModel.fromJson(_map);

    print(putResponse.body);
    notifyListeners();
    return myModel;
  }

  Future <generatedModel>deletePost() async {
    generatedModel myModel;
    Map<String, dynamic> _map = {};
    final response = await delete(
        Uri.parse('https://jsonplaceholder.typicode.com/posts/101'));

    if (response.statusCode == 200) {
      print('Data is removed sucessfully');
      try {
        _map= jsonDecode(response.body);
        _error = false;
        print(response.body);

      } catch (e) {
        _error = true;
        _errorMessage = e.toString();
        _map = {};
      }
    } else {
      print('Something went wrong');
      _error = true;
      _errorMessage = 'Something went Wrong';
      _map = {};
    }
    myModel = generatedModel.fromJson(_map);
    notifyListeners();
    return myModel;
  }
}
