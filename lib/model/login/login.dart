import 'dart:convert';

import 'data.dart';

class Login {
  String? id;
  int? code;
  String? message;
  Data? data;

  Login({this.id, this.code, this.message, this.data});

  factory Login.fromMap(Map<String, dynamic> data) => Login(
        id: data['\$id'] as String?,
        code: data['code'] as int?,
        message: data['message'] as String?,
        data: data['data'] == null
            ? null
            : Data.fromMap(data['data'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toMap() => {
        '\$id': id,
        'code': code,
        'message': message,
        'data': data?.toMap(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Login].
  factory Login.fromJson(String data) {
    return Login.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Login] to a JSON string.
  String toJson() => json.encode(toMap());
}
