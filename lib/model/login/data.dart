import 'dart:convert';

class Data {
  String? id;
  int? id_;
  String? name;
  String? email;
  String? token;

  Data({this.id, this.id_, this.name, this.email, this.token});

  factory Data.fromMap(Map<String, dynamic> data) => Data(
        id: data['\$id'] as String?,
        id_: data['Id'] as int?,
        name: data['Name'] as String?,
        email: data['Email'] as String?,
        token: data['Token'] as String?,
      );

  Map<String, dynamic> toMap() => {
        '\$id': id,
        'Id': id_,
        'Name': name,
        'Email': email,
        'Token': token,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Data].
  factory Data.fromJson(String data) {
    return Data.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Data] to a JSON string.
  String toJson() => json.encode(toMap());
}
