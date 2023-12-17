class LocationDevices {
  String? dId;
  String? locId;
  String? mNum;

  LocationDevices({this.dId, this.locId, this.mNum});

  LocationDevices.fromJson(Map<String, dynamic> json) {
    if (json["d_id"] is String) {
      dId = json["d_id"];
    }
    if (json["loc_id"] is String) {
      locId = json["loc_id"];
    }
    if (json["m_num"] is String) {
      mNum = json["m_num"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["d_id"] = dId;
    _data["loc_id"] = locId;
    _data["m_num"] = mNum;
    return _data;
  }
}
