
class LocationDevices {
  String? dId;
  String? locId;
  String? mNum;
  String? mName;
  String? dType;
  String? mProps;

  LocationDevices({this.dId, this.locId, this.mNum, this.mName, this.dType, this.mProps});

  LocationDevices.fromJson(Map<String, dynamic> json) {
    if(json["d_id"] is String) {
      dId = json["d_id"];
    }
    if(json["loc_id"] is String) {
      locId = json["loc_id"];
    }
    if(json["m_num"] is String) {
      mNum = json["m_num"];
    }
    if(json["m_name"] is String) {
      mName = json["m_name"];
    }
    if(json["d_type"] is String) {
      dType = json["d_type"];
    }
    if(json["m_props"] is String) {
      mProps = json["m_props"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["d_id"] = dId;
    _data["loc_id"] = locId;
    _data["m_num"] = mNum;
    _data["m_name"] = mName;
    _data["d_type"] = dType;
    _data["m_props"] = mProps;
    return _data;
  }
}