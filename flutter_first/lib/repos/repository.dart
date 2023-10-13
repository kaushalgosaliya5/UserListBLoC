import 'dart:convert';

import 'package:flutter_first/model/user_model.dart';
import 'package:flutter_first/utils/constants.dart';
import 'package:http/http.dart';
import 'package:welltested_annotation/welltested_annotation.dart';

@Welltested()
class UserRepository {
  Future<List<UserModel>?> getUsers() async {
    Response response = await get(Uri.parse(AppConstants.baseUrl));

    if (response.statusCode == 200) {
      final List result = jsonDecode(response.body)['data'];
      return result.map(((e) => UserModel.fromJson(e))).toList();
    } else {
      return null;
    }
  }
}
