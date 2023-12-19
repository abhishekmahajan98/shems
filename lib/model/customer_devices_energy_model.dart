class CustomerDevicesEnergy {
  String? cId;
  int? totalEnergyUsage;
  List<DevicesEnergy>? devices;

  CustomerDevicesEnergy({this.cId, this.totalEnergyUsage, this.devices});

  CustomerDevicesEnergy.fromJson(Map<String, dynamic> json) {
    if (json["c_id"] is String) {
      cId = json["c_id"];
    }
    if (json["totalEnergyUsage"] is int) {
      totalEnergyUsage = json["totalEnergyUsage"];
    }
    if (json["devices"] is List) {
      devices = json["devices"] == null
          ? null
          : (json["devices"] as List)
              .map((e) => DevicesEnergy.fromJson(e))
              .toList();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["c_id"] = cId;
    _data["totalEnergyUsage"] = totalEnergyUsage;
    if (devices != null) {
      _data["devices"] = devices?.map((e) => e.toJson()).toList();
    }
    return _data;
  }
}

class DevicesEnergy {
  String? dId;
  String? dType;
  double? totalenergyusage;
  double? averageenergyusage;

  DevicesEnergy(
      {this.dId, this.dType, this.totalenergyusage, this.averageenergyusage});

  DevicesEnergy.fromJson(Map<String, dynamic> json) {
    if (json["d_id"] is String) {
      dId = json["d_id"];
    }
    if (json["d_type"] is String) {
      dType = json["d_type"];
    }
    if (json["totalenergyusage"] is double) {
      totalenergyusage = json["totalenergyusage"];
    }
    if (json["averageenergyusage"] is double) {
      averageenergyusage = json["averageenergyusage"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["d_id"] = dId;
    _data["d_type"] = dType;
    _data["totalenergyusage"] = totalenergyusage;
    _data["averageenergyusage"] = averageenergyusage;
    return _data;
  }
}
