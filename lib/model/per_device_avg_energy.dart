class PerDeviceAvgEnergy {
  List<StaticDeviceTypes>? deviceTypes;

  PerDeviceAvgEnergy({this.deviceTypes});

  PerDeviceAvgEnergy.fromJson(Map<String, dynamic> json) {
    if (json["deviceTypes"] is List) {
      deviceTypes = json["deviceTypes"] == null
          ? null
          : (json["deviceTypes"] as List)
              .map((e) => StaticDeviceTypes.fromJson(e))
              .toList();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    if (deviceTypes != null) {
      _data["deviceTypes"] = deviceTypes?.map((e) => e.toJson()).toList();
    }
    return _data;
  }
}

class StaticDeviceTypes {
  String? devicetype;
  int? avgmonthlyenergyconsumption;

  StaticDeviceTypes({this.devicetype, this.avgmonthlyenergyconsumption});

  StaticDeviceTypes.fromJson(Map<String, dynamic> json) {
    if (json["devicetype"] is String) {
      devicetype = json["devicetype"];
    }
    if (json["avgmonthlyenergyconsumption"] is int) {
      avgmonthlyenergyconsumption = json["avgmonthlyenergyconsumption"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["devicetype"] = devicetype;
    _data["avgmonthlyenergyconsumption"] = avgmonthlyenergyconsumption;
    return _data;
  }
}
