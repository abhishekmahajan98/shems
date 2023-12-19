class DeviceModelType {
  String? mName;
  String? dType;
  String? mNum;
  String? mProps;

  DeviceModelType({this.mName, this.dType, this.mNum, this.mProps});

  DeviceModelType.fromJson(Map<String, dynamic> json) {
    if (json["m_name"] is String) {
      mName = json["m_name"];
    }
    if (json["d_type"] is String) {
      dType = json["d_type"];
    }
    if (json["m_num"] is String) {
      mNum = json["m_num"];
    }
    if (json["m_props"] is String) {
      mProps = json["m_props"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["m_name"] = mName;
    _data["d_type"] = dType;
    _data["m_num"] = mNum;
    _data["m_props"] = mProps;
    return _data;
  }
}
