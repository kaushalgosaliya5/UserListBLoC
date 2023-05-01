import 'dart:convert';

import 'package:flutter_first/model/user_model.dart';
import 'package:flutter_first/utils/constants.dart';
import 'package:http/http.dart';

class UserRepository {
  Future<List<UserModel>> getUsers() async {
    Response response = await get(Uri.parse(AppConstants.baseUrl));

    if (response.statusCode == 200) {
      final List result = jsonDecode(response.body)['data'];
      return result.map(((e) => UserModel.fromJson(e))).toList();
    } else {
      throw (Exception(response.reasonPhrase));
    }
  }
}
