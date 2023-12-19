class DeviceType {
  String dType = '';

  DeviceType({required this.dType});

  DeviceType.fromJson(Map<String, dynamic> json) {
    if (json["d_type"] is String) {
      dType = json["d_type"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["d_type"] = dType;
    return _data;
  }
}
