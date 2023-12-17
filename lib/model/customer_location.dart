class CustomerLocation {
  String? locId;
  String? cid;
  String? locAddress;
  String? startDate;
  int? areaByFoot;
  int? beds;
  int? occupants;
  String? zipcode;

  CustomerLocation(
      {this.locId,
      this.cid,
      this.locAddress,
      this.startDate,
      this.areaByFoot,
      this.beds,
      this.occupants,
      this.zipcode});

  CustomerLocation.fromJson(Map<String, dynamic> json) {
    if (json["loc_id"] is String) {
      locId = json["loc_id"];
    }
    if (json["cid"] is String) {
      cid = json["cid"];
    }
    if (json["loc_address"] is String) {
      locAddress = json["loc_address"];
    }
    if (json["start_date"] is String) {
      startDate = json["start_date"];
    }
    if (json["area_by_foot"] is int) {
      areaByFoot = json["area_by_foot"];
    }
    if (json["beds"] is int) {
      beds = json["beds"];
    }
    if (json["occupants"] is int) {
      occupants = json["occupants"];
    }
    if (json["zipcode"] is String) {
      zipcode = json["zipcode"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["loc_id"] = locId;
    _data["cid"] = cid;
    _data["loc_address"] = locAddress;
    _data["start_date"] = startDate;
    _data["area_by_foot"] = areaByFoot;
    _data["beds"] = beds;
    _data["occupants"] = occupants;
    _data["zipcode"] = zipcode;
    return _data;
  }
}
