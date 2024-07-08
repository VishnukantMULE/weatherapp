import 'dart:convert';

import 'package:http/http.dart' as http;

import '../model/SinglePostModel.dart';

class ApiService {
  Future<SinglePostModel?> getSinglePost() async {
    try {
      final response = await http
          .get(Uri.parse('https://jsonplaceholder.typicode.com/posts/1'));
      if (response.statusCode == 200) {
        SinglePostModel postmodel =
            SinglePostModel.fromJson(json.decode(response.body));
        return postmodel;
      }
    } catch (e) {
      print(e.toString());
    }
    return null;
  }

  // 2f058980b09849ac9e9b15b9b744575e

}
