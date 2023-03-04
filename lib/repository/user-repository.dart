import 'dart:convert';

import 'package:app_http_users_with_pagination_infinite_scrolling/models/user.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

class UserRepository  with ChangeNotifier {
  int _page = 1; //0
  final List<User> _users = [];

  List<User> get users => _users;

  getUsers() async {
    final url = Uri.parse(//add pagination and quantity per page
        'https://randomuser.me/api/?page=$_page&results=20');

    final response = await http.get(url);

    if (response != null) {
      final results = jsonDecode(
          response.body)['results'];

      for (var i = 0; i < results.length; i++) {
        _users.add(User.fromMap(results[i]));
      }

      _page++;
      notifyListeners();
    }
  }
}
