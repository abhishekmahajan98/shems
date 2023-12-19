
class CustomerDetails {
  String? cId;
  String? firstName;
  String? lastName;
  String? phn;
  String? billingAddress;

  CustomerDetails({this.cId, this.firstName, this.lastName, this.phn, this.billingAddress});

  CustomerDetails.fromJson(Map<String, dynamic> json) {
    if(json["c_id"] is String) {
      cId = json["c_id"];
    }
    if(json["first_name"] is String) {
      firstName = json["first_name"];
    }
    if(json["last_name"] is String) {
      lastName = json["last_name"];
    }
    if(json["phn"] is String) {
      phn = json["phn"];
    }
    if(json["billing_address"] is String) {
      billingAddress = json["billing_address"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["c_id"] = cId;
    _data["first_name"] = firstName;
    _data["last_name"] = lastName;
    _data["phn"] = phn;
    _data["billing_address"] = billingAddress;
    return _data;
  }
}